Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF6C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C0F2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="sITEjFwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C0F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeJ2HGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:06:00 -0400
Received: from nag.0l.de ([207.154.252.120]:33462 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeJ2HGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:06:00 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49J2ZOVVtpT4UmNVIX2a3k5h8zr7CBOWKdZpbeeICYY=;
        b=sITEjFwcspVXi58qVLbzFxDLfVAjIdexjTkPEkPrP2oHqGNRbJU9vxRgSX8hxVy/97j041
        Ezo0cMbPxM9Vb0ZnmcJ+3APvH5hzCq8IyS/QvCIvqx6ZPktTDMUsBbnz8BXIMDhlTiNW0i
        Jggxc7NHpR5LgbP4ogEQzrQklBXy0vxnh25YlAlFZvc4wUcARJYXDpqgPwt7Vwh4K88T0v
        0dlNIJN7UFV3qPI1umvcbSfbQfikTKg8/wXgV2ERE8k3ZHuUDmkqmBqOTx1tDo1FAtBG/J
        CaG/YqXBpNvMUsTIGEKbctsO8+k3pr5AyjiFk20/GdUyLfeJKDJJHPsDSS8Bvw==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH 5/9] w1: use octal numbers instead of macros for file mode
Date:   Sun, 28 Oct 2018 23:09:24 +0100
Message-Id: <20181028220927.56227-6-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49J2ZOVVtpT4UmNVIX2a3k5h8zr7CBOWKdZpbeeICYY=;
        b=TJTVKLOs0uBzZ9yxtfZb40rDmXLm4NVlbTbDczb4OxkXiQ5dhY3apNwnS6tO5TE0NhBTYX
        IU2Rei+2BZhJ7Q86vgabompx9mKINeoozuGPQTYEuFkkkxmps4XdKjf5+8GwoiAvnUjMoW
        Z7+Wh0qFRQ6BDgAERtJOgPjpkQdiq0JerphvMWoQ8he6HeZxSc0ieWkh2+7KzdDsD3uVjr
        /Ve3/pj+njf0y3u9JfAo0LeikGpsD5d+AZXjVUK4dbwENRKa3edzeU49HPCT8YotHrFAiU
        hhPQtgaoIZDfcl7rXjuDEB2K2fw52iiUf+yNcvTTunMZ1SXUKIbxtamcEYQXIA==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764601; a=rsa-sha256;
        cv=none;
        b=FtSAEHbARMJaFRwFUCoCwlIAJONsQpJXbeENlw+Q5DF31mAt3yLck5KiT9WIFM0uwPXnbPyD39L1aSQhvKQ4NR9nCATDAaxX8RvCjZw5uiziQnoaXZS2UZ6I7t0HPbH1ajcXtjjqeE8gUjr/tDUaUwKkmFoHU7dmhxOQq1YbvXpapQgeoei6UlgUhyp9qMffI7i2bxII3GeNkB54ROOrFPn75gJQ7VRMGHk7+Z/cWpAKgUaJAptDyBFdsA5adIYc8tTUnJNIs5LFlpzVWHzqetbQ1BGp8q5UCN3+ec3qN4IWtO3URWQvHEgW7yfRr6Xy+mozhj9xA/XenJcLK9sEnA==
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
index f64da16dbec9..bad2ee26cd4e 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -554,18 +554,18 @@ static ssize_t w1_master_attribute_store_remove(struct device *dev,
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

