Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF8FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080AF2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hk+CQw7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfAKFHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:07:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47095 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfAKFHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:07:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so6212427ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 21:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d+QCZEbb8I1PHoVx1anwFEcq7OTA/n96FjbWbIsWIQs=;
        b=hk+CQw7bIhYF2+jOMM5aGzpthfCADKnB876xC4uS+fNuyxhe1EtzvDzr5I4mic0tr1
         JpaQGZ/GAhto9PWQvmzN3ViO2dsb3qwJKT+0EysX5xKedSusxdLi7xSTvIMxVnrKX17C
         dGpwkj4J23Qfs+Xws9kT3gnHqfp4nfU497VUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d+QCZEbb8I1PHoVx1anwFEcq7OTA/n96FjbWbIsWIQs=;
        b=m2KRUptphJf1xIoQ775z+kCqiaeIPN3AR2gZvyu7L96uX0brceTT6PGroQqzZ118wg
         +wceW/RBWvLCbYPg0SrnjTodTtj8WQGCfqCLfw5DL47e+2VMHWRx4X7iVabQuvU3l3hI
         p1WQzdz2g72N+5uC+/yCr/6mwN2eAThWuCv0Jrdl2Y/oj3CjX6RVUo63289rlp6y8/Iw
         cOeHXPaqVpNvTw2ANjiWUaqaJ+nLGWq9yXCSWdCLdtGnZ18OVFVI4nY/96LPzh1jeKuF
         HzbTpL76hVPwwDUXYIffXAZPrMmmWWKtcrDfycw+YA7Ar5p8xRVKibXuC7ndXSTkN6Be
         DVEQ==
X-Gm-Message-State: AJcUukeklbZlArQ1zaGxjIr1g8Q6vy+DUcXmrlrijYBMIV/luql1OndD
        PFQCaWQ26s05WHUeyOUpj2Kzvw==
X-Google-Smtp-Source: ALg8bN45s+bPDvyOCgB9CxmMRC4mFauieOw/UCho6hq/LQpte4pdFtR3/pf74SiGGfmNWiXx9PNlXQ==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1mr13107725pli.64.1547183263085;
        Thu, 10 Jan 2019 21:07:43 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d6sm107520893pgc.89.2019.01.10.21.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 21:07:42 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH INTERNAL V3 0/3] Add support for PWM Configure and stablize for PWM kona
Date:   Fri, 11 Jan 2019 10:38:01 +0530
Message-Id: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This patchset contain support to make PWM changes configure
	and stablize
	Following are brief changes done
	a. Add support for version2 compatible string
	b. Change PWM config and stablize delay in PWM Kona

Praveen Kumar B (3):
  dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
  drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
  ARM: dts: cygnus: Change pwm compatible to new version

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
 drivers/pwm/pwm-bcm-kona.c                         | 128 ++++++++++++++++-----
 3 files changed, 100 insertions(+), 32 deletions(-)

-- 
1.9.1

