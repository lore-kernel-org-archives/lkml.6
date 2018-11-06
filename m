Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1399C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761382086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNdAIDjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761382086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbeKGCBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:01:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45350 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbeKGCBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:01:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id o19-v6so6438824pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DdzvoSy2h2u5B6dtluZVRVLXIvWmyO3wmCU9GEAMkSM=;
        b=gNdAIDjUgEk0J/V+ZzUawg2xno7kGvH2+uL520CKi2f+CTfbgdC0TEroPk3naDdk2/
         GF1uF/hGvZxMv5ARQuLF0YN4UJF0US+ipfg5Qr+9PmBUCmX4VfhqfcmPLbizNiWQUX+X
         CC22ULHw5tuf+YlPYlf44/+94Ne2jIWwh3RFJ/vIDOsPBEDpBMhEwkPJ4lq/3pkryLXp
         voKm0+GZ6ZZIF8NgrZLnFgDdFoCCRAD3ymMsIr3c/Fm4oB0AwOdGs2k193WKQomrId/O
         rgFVC47mon0swj/yf5byAKIVYwyEIh5itShfbeei9b+xGnwL8wlzA+uwqRQVYqhYo+kt
         S+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DdzvoSy2h2u5B6dtluZVRVLXIvWmyO3wmCU9GEAMkSM=;
        b=Rboo8RaV42P1UKz3FkplpmfAVnuqkaF/WF6t5ghogWK5JcCrRqpDRizY33FKXl2xgE
         vfhmRfkLb+1xJhzB0v+O+8ugh03OFcgWUJwYw5KPkdHSmf2bCQMg+V2pgfLDL3fuxmfx
         IbLpwzYNgaSZeYOjicUgyTMOtJRNSDUrkNT1ZTc6uxwOzf+STNGbiju1wrh7Y6ArSFfk
         vADzIETpZTgwzWZnQgZMjkcofjv2BbKLHA71Ssk7LNFKWEBRY47wbMucI8tpaS+4J2IW
         s+F4z5qn4asK6azr1NCm9BjNkiUnNtFWCeZNWOsZAM6eytkkOKmxJF4Avf0tNp4nhQtR
         J9hg==
X-Gm-Message-State: AGRZ1gIRu8TPmpvsIrl+B4H8FLlfnhwsZuXz57tv5cmUA2XAktWlBIyD
        m/+nntcJCmSVIM6UZ0XfCdU=
X-Google-Smtp-Source: AJdET5di4dERSI9lLmnFBH8liblMeJocemM2khJbrL6GAMu8EPgjrGUPl7dqryfbKKsyuE/figNeUA==
X-Received: by 2002:a17:902:b943:: with SMTP id h3-v6mr25557646pls.124.1541522110933;
        Tue, 06 Nov 2018 08:35:10 -0800 (PST)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id t77-v6sm39005730pfj.79.2018.11.06.08.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 08:35:10 -0800 (PST)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, smuchun@gmail.com,
        pilgrimtao@163.com, Kaitao cheng <pilgrimtao@gmail.com>
Subject: [PATCH] driver core: Replace simple_strto{l,ul} by kstrtou{l,ul}
Date:   Tue,  6 Nov 2018 08:34:54 -0800
Message-Id: <1541522094-5113-1-git-send-email-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao cheng <pilgrimtao@gmail.com>

The simple_strto{l,ul} are deprecated, use kstrtou{l,ul} instead.

Signed-off-by: Kaitao cheng <pilgrimtao@gmail.com>
---
 drivers/base/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd7..ed145fb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -794,10 +794,12 @@ ssize_t device_store_ulong(struct device *dev,
 			   const char *buf, size_t size)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	char *end;
-	unsigned long new = simple_strtoul(buf, &end, 0);
-	if (end == buf)
-		return -EINVAL;
+	int ret;
+	unsigned long new;
+
+	ret = kstrtoul(buf, 0, &new);
+	if (ret)
+		return ret;
 	*(unsigned long *)(ea->var) = new;
 	/* Always return full write size even if we didn't consume all */
 	return size;
@@ -818,9 +820,14 @@ ssize_t device_store_int(struct device *dev,
 			 const char *buf, size_t size)
 {
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
-	char *end;
-	long new = simple_strtol(buf, &end, 0);
-	if (end == buf || new > INT_MAX || new < INT_MIN)
+	int ret;
+	long new;
+
+	ret = kstrtol(buf, 0, &new);
+	if (ret)
+		return ret;
+
+	if (new > INT_MAX || new < INT_MIN)
 		return -EINVAL;
 	*(int *)(ea->var) = new;
 	/* Always return full write size even if we didn't consume all */
-- 
2.7.4

