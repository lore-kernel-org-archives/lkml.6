Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40026C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085E62177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MJJyO7cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfBSKQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:16:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37232 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfBSKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:16:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so9930787pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HcWnveyX59Aoh23MLFkWFXW8JP4cDi5U2jCwuHjwxt8=;
        b=MJJyO7cW/1LSyG2sv2FzHPT5anm5oX4UEssmrk1MQwxs70asjXSocBrDs0UkU4OcPg
         9MI7ra8NJrGrJ6PucJYwlWieqTW7hmxRNV5UHbLXn+CW6805TT8ahxJbpy7CvlcJ3yAZ
         kK3nRuThHbKbV7GLSeSqz4eXNw5HbwNOEtyWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HcWnveyX59Aoh23MLFkWFXW8JP4cDi5U2jCwuHjwxt8=;
        b=kX/zbMir3R+1ldeopdtG0iLERX4TEmCgXd3r3EtndJrEPMFUZU5p0fsUBJa1NOD982
         x/6h2hHcMmtg2sU5R21Xz0/HCoRYxx4TSwD1000nHzboHvtOX1Q3zHcO9z2yU5pc8/H7
         oTeWuP++kjK0KtpWUIF6eT20B5hBtPYUwSw0qHGlmvYQRDyT3oGcm+egSUbdP6ToKi/c
         3bKv2sPLTu0yLjVmlJVYD18oiE7LdXObNgOnSpSQuOol1LwCKqUWHdpTbDFCZBxjmwW0
         S0emRk4glX51hsYf81DrpbzgDp/Jj0lycXd581tVeHFOLsZ7oEQKVfNynQprGpWVDKeT
         CVCQ==
X-Gm-Message-State: AHQUAuYOdaZbYvy6SiljvdIzFI2pfXdyKrKRYkO1WVgASkY42ZErUBfH
        rMF6wrVSkCzz/ghh17c9xTmRSw==
X-Google-Smtp-Source: AHgI3IaYhHdpjGUsRYdu/vTUvHRHRYMpXuqbkTC1y9wQD7zwIe2rT/9hoUTG6egcS2w547EPtbrWpA==
X-Received: by 2002:a62:e086:: with SMTP id d6mr28820855pfm.247.1550571401475;
        Tue, 19 Feb 2019 02:16:41 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id g10sm21324011pgo.64.2019.02.19.02.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:16:40 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 0/4]  input: touchscreen: Add goodix GT5553 CTP support
Date:   Tue, 19 Feb 2019 15:46:25 +0530
Message-Id: <20190219101629.15977-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v6 patchset for supporting goodix GT5553 CTP. Here is the
previous version[1]

Changes for v5:
- document bindings for required regulators, which are need during
  power-on sequence
- enable, disable required regulators as described in power-on sequence
  using normal regulator calls
- update the proper commi messages
Changes for v4:
- document AVDD22, DVDD12, VDDIO as optional properties
- use regulator bulk calls, for get, enable and disable functionalities
Changes for v4:
- devm_add_action_or_reset for disabling regulator
Changes for v3:
- add cover-letter
- s/ADVV28/AVDD28 on commit head
- fix few typo
Changes for v2:
- Rename vcc-supply with AVDD28-supply
- disable regulator in remove
- fix to setup regulator in probe code
- add chipdata
- drop example node in dt-bindings

[1] https://patchwork.kernel.org/cover/10816901/

Jagan Teki (4):
  dt-bindings: input: touchscreen: goodix: Document regulator properties
  Input: goodix - Add regulators suppot
  dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
  Input: goodix - Add GT5663 CTP support

 .../bindings/input/touchscreen/goodix.txt     |  3 +
 drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.18.0.321.gffc6fa0e3

