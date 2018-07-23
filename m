Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47107ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BBD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFaN895m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BBD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeGWOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40073 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388007AbeGWOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so687682wrn.7;
        Mon, 23 Jul 2018 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fSmEWRwUYnjsGHoSChUGuM8ZsNJS4DVqQW7Vxtno9sU=;
        b=AFaN895m7TYCRdHGAcgqQzkrKHb2IxQKZQhx35Bb2A78ZJGTDMXeNfbp45b9TYl/LC
         naOkSEPJ1KDcWh4THTNmxpPbOoBMnzuetIW4c38Bd9nBgzAT/OdVcoDZe+27PVJWL2AY
         E/zBdcAQOv5jTtkIpZcE5Tk5pwi0rdcGQfnCzqHqDLGqVUOFsG9C4hrpgMX+Nr4WSJBN
         myNYWJP8r70BaSRFjLSKfmiP00iyP66zt4+iM81yFgrbACJCl5szJPqHCmVrsD/Hg01p
         jvAUx8+3+N2pYOX8xiDesFhCzgfikXwXpwqg+idhjV4QSdLAXr515BPA1jSpIUdK1jAm
         9HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fSmEWRwUYnjsGHoSChUGuM8ZsNJS4DVqQW7Vxtno9sU=;
        b=G9S1wf6lkBt4iUuiukrSaEHREKjiAuhtgv6b75FVkjIjZg8ecIY6BnSreNeaZfSyqi
         zcE3vwfTLqoCyh0MpQgxXwU4YIXwK2FOc9kUH2wQ/d7poiBjNc1TM3Gev6eOIROl0nHo
         TfIoGQVA6hu6Zu2VHfRQE9qcBrk779DVEJ3gdQT29KMbSQtzJYYdutMyTP/eH/4m4AfY
         MyuqYnhuM8pg2tLKhp0f/mychw/EgeSZXRRQjtPD4zQiML9Og0DBj+f3suFXe6egAW3y
         4EGHgwjRNHmLAdMXeB4Kb75edfbXHwkaR+SxbAMmfrpvb9mWedCUE3j7VEZt4ybd7ygH
         6xAQ==
X-Gm-Message-State: AOUpUlHvG8xU4wNnWJbYG7fnf2ro2A6AKnYDpiJ1eHnlM3zr2zh0LXxj
        /14Ttdcdu+mYaq+hYzTYkF07sJ4v09Ugrqvb
X-Google-Smtp-Source: AAOMgpci+IKGmFY5lORjI6dHx8vRyCygltj5jxKsOog3hRh7OZ5cEWq80xeD/4kvjWXiofGIU/AFtA==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr8869047wre.12.1532352023125;
        Mon, 23 Jul 2018 06:20:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:22 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] touchscreen: mc13783: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:22 +0530
Message-Id: <20180723131954.30739-6-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
+module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/mc13783_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index ef64f36c5ffc..4e33349f101e 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -25,9 +25,9 @@
 #define DEFAULT_SAMPLE_TOLERANCE 300
 
 static unsigned int sample_tolerance = DEFAULT_SAMPLE_TOLERANCE;
-module_param(sample_tolerance, uint, S_IRUGO | S_IWUSR);
+module_param(sample_tolerance, uint, 0644);
 MODULE_PARM_DESC(sample_tolerance,
-		"If the minimal and maximal value read out for one axis (out "
+		"If the minimal and maximum value read out for one axis (out "
 		"of three) differ by this value (default: "
 		__stringify(DEFAULT_SAMPLE_TOLERANCE) ") or more, the reading "
 		"is supposed to be wrong and is discarded.  Set to 0 to "
-- 
2.17.1

