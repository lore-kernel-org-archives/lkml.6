Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4597AECDE46
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E96D2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="vHKPBFWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E96D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeJ2LvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:51:24 -0400
Received: from nag.0l.de ([207.154.252.120]:44462 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbeJ2LvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:51:23 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/m6KP46Yk6eUV9CHSUSvYcHezicTnCRuUeHQX2j2y0=;
        b=vHKPBFWYsxHVBWea+CvyJCBP4IEvhDQeDBWWIUQzAXIIKDEjvqXFZzo4LXKkRpe21fNx0/
        f5OrmuAkRjEJTWcDTVgmEIeY3YkLTgM00C8mvam8/0D0synxHTRyIwKm+m8Yqw7jRFFoBc
        f0Dn7caS/H1+tSbyIr+JCbCUJaUBoAbe31kycBXg3SJsvr4/lfp/7vTFr9dIG6vtp2M99s
        TvNfERi0fZITz74P/H79TTFfH2MIYkklG6aEpIMkHNPsb50XvTdLCVElPN+V+wU8VZ1OGu
        8MY4ZIaDlDMgsXEw55M2w3VOkKsVRUzk6y9owkn9H5tGVNk9c8pyJ7WXzil+BA==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 05/12] w1: use octal numbers instead of macros for file mode
Date:   Mon, 29 Oct 2018 04:03:35 +0100
Message-Id: <b8ec4f6d391437ca290d418a2b084ef0f5f3a1c8.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/m6KP46Yk6eUV9CHSUSvYcHezicTnCRuUeHQX2j2y0=;
        b=HGc37+ARcJgYyw4uN9D+6Kvcki4RvNm7Mcvb0BhXziPiDyNcWhsxqEK7F+cT3+8qYY0+Bw
        rhCewPxzpIx/+tLRsjFM1BsV99//FIGV818C6wXDxZFZINWzn5emcUecOwwXC9+6HpIH7L
        SyGOpku94zLzRSmxxOO0S/IXAkHyhBwqpUXAbeMhSl1GX7S8XjWjpuo7fE7CtIPvEind32
        jVbtgKo9lG1WBBE9wNCNZeGphl6zbR5VWlbVEe2hbSq3m6I0hwOBuTCGdLSLaNBhYRFkIv
        Ijn6V/THCN2dKKNMYjP6Cy2+e3bCqKxFCXaMpM3aTz6BgtOpkpvwuSTLwe65+Q==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782276; a=rsa-sha256;
        cv=none;
        b=hz9XIiTxgNsdUloh/N31Z7AUY3RPYLHA21//aYp84wbRSJ9IEh2F+QQa2ceTxsT3D+WXQ459uHxm2f6f02SELg+TCh98FeEI5lNfpBP1n4r0FrO/cxVzJH2jH9ExgHjK2figF7qJJyXcW6PbB2Dt+5WM3OnoyZTYzyQdq4fOmF2OzDe7+e1QH7dFAyvsFpWGlsRTYTruAmyD0ND6XDuk3ongJ9cyZpI4JeqHjj67g4mRJ+pscyoxIy7gwyn4xOwQEM7jDLUpGKvNZzC14vJe+6hx1VvwS9DJWIeff0tKc/LkjZ3Wxcxe8Cs8RGJ/uG+tOVAdZFFkDdK7V/ykWk2WIw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This satifies a warning raised by the checkpatch tool.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 184df1fe216b..a8ead2350521 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -563,18 +563,18 @@ static ssize_t w1_master_attribute_store_remove(struct device *dev,
 		       w1_master_attribute_show_##_name,	\
 		       w1_master_attribute_store_##_name)
 
-static W1_MASTER_ATTR_RO(name, S_IRUGO);
-static W1_MASTER_ATTR_RO(slaves, S_IRUGO);
-static W1_MASTER_ATTR_RO(slave_count, S_IRUGO);
-static W1_MASTER_ATTR_RW(max_slave_count, S_IRUGO | S_IWUSR | S_IWGRP);
-static W1_MASTER_ATTR_RO(attempts, S_IRUGO);
-static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
-static W1_MASTER_ATTR_RO(timeout_us, S_IRUGO);
-static W1_MASTER_ATTR_RO(pointer, S_IRUGO);
-static W1_MASTER_ATTR_RW(search, S_IRUGO | S_IWUSR | S_IWGRP);
-static W1_MASTER_ATTR_RW(pullup, S_IRUGO | S_IWUSR | S_IWGRP);
-static W1_MASTER_ATTR_RW(add, S_IRUGO | S_IWUSR | S_IWGRP);
-static W1_MASTER_ATTR_RW(remove, S_IRUGO | S_IWUSR | S_IWGRP);
+static W1_MASTER_ATTR_RO(name, 0444);
+static W1_MASTER_ATTR_RO(slaves, 0444);
+static W1_MASTER_ATTR_RO(slave_count, 0444);
+static W1_MASTER_ATTR_RW(max_slave_count, 0664);
+static W1_MASTER_ATTR_RO(attempts, 0444);
+static W1_MASTER_ATTR_RO(timeout, 0444);
+static W1_MASTER_ATTR_RO(timeout_us, 0444);
+static W1_MASTER_ATTR_RO(pointer, 0444);
+static W1_MASTER_ATTR_RW(search, 0664);
+static W1_MASTER_ATTR_RW(pullup, 0664);
+static W1_MASTER_ATTR_RW(add, 0664);
+static W1_MASTER_ATTR_RW(remove, 0664);
 
 static struct attribute *w1_master_default_attrs[] = {
 	&w1_master_attribute_name.attr,
-- 
2.11.0

