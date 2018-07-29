Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF15FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E536E20870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2p/qOK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E536E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeG2NMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:12:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36291 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeG2NMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:12:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so9674067wro.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5TEwJEEuNKYLrO5ycdoH4rlkO0Wiru6BmO7QlGteK4=;
        b=H2p/qOK/ZxiouzgqHbOseAGopcR6+/qq+izk1C91DxwsCoESuPdBRlhtb2YKdctW9A
         x2dlaVLcPeWM12NTg9uWuNggX0PV3+uxgzQKhRSTleG3PgFH+w/HapigPScXKwlQenmg
         tgYfT9pJRYuolLyRNFG+rmB8gCd4yA+i7Y1Pi5jq6ymI8qrcRgtz68YWVSSms4MyF5Y6
         quXli2eWG3ryHwegI1hZ/vh/eFXXsyd4G18JT2xxMxVmPJlXujU7JKprm0N5omQkMRcH
         nl1WMFtDMuimeiLzhByUn+LWeAfr3aOsOB66zKI3a4ELgx3qN5UBBR7uBgZVBY7XQQAF
         1Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p5TEwJEEuNKYLrO5ycdoH4rlkO0Wiru6BmO7QlGteK4=;
        b=W7yK05OzNtugAJzJ1AWyCA61m6gJPlsXapR9NVhBKW5msmUCJjJVO+GnfKzKJzsjp0
         cia3eJtzycdGQ8xzVfuCJtGCeQJzC9BfmsDD/sa7o7+aZZ6KPUyjDCOY4L15vT96BUSG
         s9iqZvV3pLx/EIkLVoNaxAJcs2z8K9u1OgtwY/2Lz9ypSaAV68rzFi3T77WfHdHARmi3
         7GqMoQgLlEzdotZv7Y4X2Exjqb2/Q9rwYMXK+NkZEfcpW2s8gGFrTlwbx9EYmHtMkee+
         xKqx0xua8FAGjjXssmEcMSJy1WKwAzE4NgArucoGFIM0swpfae45DEfuxhAzEasODwtu
         Ui8Q==
X-Gm-Message-State: AOUpUlH42FKhQ4yhVdJaGHi1P2gakspEXFzfupRTAACl1uW+vpCRPJvY
        dMwspy83yWlbRMGHtYkwpN4=
X-Google-Smtp-Source: AAOMgpcPX1OFf8Yk2cHmnXVh90GWOGdI5Hzrl3xdATovNb+eujc35X6qhzJLdbtLhP/gr6K0VlyF9g==
X-Received: by 2002:adf:820a:: with SMTP id 10-v6mr12838730wrb.144.1532864525095;
        Sun, 29 Jul 2018 04:42:05 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id q188-v6sm14635087wmd.36.2018.07.29.04.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 04:42:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 5302A6403C9;
        Sun, 29 Jul 2018 14:42:03 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A3X4help2ULi; Sun, 29 Jul 2018 14:42:02 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id E58A46408D2; Sun, 29 Jul 2018 14:42:02 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] Staging: octeon-usb: Breaks down cvmx_usb_poll_channel()
Date:   Sun, 29 Jul 2018 14:41:52 +0300
Message-Id: <cover.1532864059.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <3b90173dc3a8ce12ef7f4896f05673140ac3b4d7.camel@perches.com>
References: <3b90173dc3a8ce12ef7f4896f05673140ac3b4d7.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed the function in order to use only values instead passing unions
i think its better than passing pointers there.

Georgios Tsotsos (1):
  Staging: octeon-usb: Breaks down cvmx_usb_poll_channel().

 drivers/staging/octeon-usb/octeon-hcd.c | 81 +++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 28 deletions(-)

-- 
2.16.4
