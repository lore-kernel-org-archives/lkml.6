Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5334AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F1E217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZVn18iM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfB0P6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:58:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39848 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0P6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:58:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so7650093pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QeE5nYpPs1Ol1pY6rvvjluKGEFRECl7dQ16/aqfqKU=;
        b=oZVn18iMTHiLfs0oTsESYxSC1yY50xQYwBOYh6sVBAfI+9TPWO7L2k7WF/jOEx74Wd
         ThmtHU7/630HpVOoFkssyI/+j8gwXIGKVDiGUrrzQsvofrJ3GmUG8Xda+S2KTk6krM1I
         u9CvkvS3SajBDQFQ8HEeMsCsofY40O56vbuimmpTHb3/kCkQ4kzV/TTGDJqoogTSwzmy
         vv0eHpwNlcWBHvRwDm9M482OfqZT8TA9zs8fp1JaLYhQLfglS2MjBmrb1GPjM1ag7+cV
         ZniH2zXwsVzL7kmO4OAYaut7oHRuRBh1pao+wQQBcuiMx3CHte/AkgNJkHrIh/FNbImT
         WCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9QeE5nYpPs1Ol1pY6rvvjluKGEFRECl7dQ16/aqfqKU=;
        b=a/hfAV1xXjzywP7wXz61YvZzZ5qAJ2kodFQVScJqulvXPLoxKwH+C2fcd/rryNq71/
         hoElcND++/kRecnfWjr0lThFVsH+e+IhI7dDxn37jNqp+Tw/SbN3ReSo/pZiwq3lo8c5
         HdugO7auNs69XHL9pr5YZ5q1vfwv5nArnGBZIAcPnMm6xnvqkNgqadOVG5/VZ98DO+zt
         slAHSIwm+3DPYBfPsJImmdwzpZVeVfbJEGtTOzC53r7zM29H5uwCLvsdrHPlG99daBE7
         H0KLJWCDWMCLT9tsfGmJU/O6msA5TzxBPsllNy15CNPqOQz4Q4rMEchkfEQyo1b8cDeJ
         SGPA==
X-Gm-Message-State: AHQUAuYqyb5FQkLHVz3daTRM0WmOjAnekJcjcUahqYLiMz20OVgypRvv
        XXfa7ami4CEhZ+IlwIz6RXM=
X-Google-Smtp-Source: AHgI3IaSl8iJIV9YAx8+Vo63NxCn77Re8pswM38cIOhMYaeMG6t/y5PskTeyx2aDCPjcG8IlD0lucA==
X-Received: by 2002:a62:17d4:: with SMTP id 203mr2297211pfx.244.1551283111296;
        Wed, 27 Feb 2019 07:58:31 -0800 (PST)
Received: from localhost.localdomain ([49.207.50.127])
        by smtp.googlemail.com with ESMTPSA id l64sm46250707pga.87.2019.02.27.07.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 07:58:30 -0800 (PST)
From:   Prashanth Kumar KR <prashanthkr8@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Prashanth Kumar KR <prashanthkr8@gmail.com>
Subject: [PATCH] staging: rtl8712: Fix indentation issue
Date:   Wed, 27 Feb 2019 21:28:18 +0530
Message-Id: <20190227155818.11151-1-prashanthkr8@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation warning reported by checkpatch

Signed-off-by: Prashanth Kumar KR <prashanthkr8@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 0271ccf25f25..28f736913292 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -404,7 +404,7 @@ static sint ap2sta_data_frame(struct _adapter *adapter,
 		if (bmcast)
 			*psta = r8712_get_bcmc_stainfo(adapter);
 		else
-		       *psta = r8712_get_stainfo(pstapriv, pattrib->bssid);
+			*psta = r8712_get_stainfo(pstapriv, pattrib->bssid);
 		if (*psta == NULL)
 			return _FAIL;
 	} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE) &&
-- 
2.20.1

