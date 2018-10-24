Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43322C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C988A207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="jQWj3S94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C988A207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeJXTQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:16:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35218 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXTQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:16:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so5057946wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2jdHf836N0jlAXC3NKgKeCrs7l764z2sQXr89dOVNA=;
        b=jQWj3S94vbjykU/bJekq6t9QMJIfpd5meQA2D+nzXlYSvi8/Xe2v1jpf1vujmsn3JG
         qJsiMyR39NyCtvsdbxAg6AUfJe4emAsj00WqzIsKGXXfQxap7rLX/iy/iddeyhYUSCPM
         95bkh59i0/KNHah+b+kd7x1FMEuZVXKxf16zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2jdHf836N0jlAXC3NKgKeCrs7l764z2sQXr89dOVNA=;
        b=WyOms9HP5vSU4k1mr6R/CEDLlQhbgTRv1DmM2AXA67yNba9IezpJXBm2wK65bnN0Ea
         0U/Cmsg+J5sKoVLgHdYBj7XjmGgNukdnNHByHWJVPeE0JEHwnJNzmEV9bzapQZ1lBPkS
         Q2C7USdXiiBsZvSEfeyRDwwAz0FbBV2vzWo4Drsi3ImVwb/d8FgXstAUSo0NFDRv7ZkS
         ZYm3gsWprC6tbl7Vg0x+rvzVYDXNQQvUVhNDUk/BWQcOdK0/+HCS/77tx7S7q1unK0IL
         uRaiRGq0gdJjgjhTiSTHbjTRK1qVKm33o1gdxb8HiVYhPCaFfXzSV04QmG69tVy/fZJE
         fhLQ==
X-Gm-Message-State: AGRZ1gKtcmQQIsvXa4jCZgOFz8xvsrxWcMjiqXqKi3fq4tdS9CmKo9wP
        AvRFWkwJhvoGmgFgLs/BX/j85g==
X-Google-Smtp-Source: AJdET5ec1Xh2NDM6xazDj0TJHnjstmsXTAu6U8HTb6kDGQLOOHNrSR36vRv/VU8LUphHN2d6OZnWNw==
X-Received: by 2002:adf:93e6:: with SMTP id 93-v6mr2287057wrp.81.1540378108594;
        Wed, 24 Oct 2018 03:48:28 -0700 (PDT)
Received: from prevas-ravi.event.pylonone.net ([185.7.230.213])
        by smtp.gmail.com with ESMTPSA id 125-v6sm4639814wmm.25.2018.10.24.03.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 03:48:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: greybus: loopback.c: remove unused lists
Date:   Wed, 24 Oct 2018 11:48:20 +0100
Message-Id: <20181024104820.20298-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
References: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gb_loopback_device::list_op_async is never used except for the
LIST_INIT. The ::list field appears to have a few more uses, but on
closer inspection the linked list of struct gb_loopbacks that it heads
is never used for anything, so there's no reason to maintain it, much
less to keep it sorted.

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Sending as a proper patch. Marked v2 since this replaces earlier 2/3
and 3/3 patches. Applies on top of
b4fc4e8340784e000030c5a59bf0791f9c3ce15e (staging: greybus:
loopback.c: remove unused gb_loopback::lbid).

 drivers/staging/greybus/loopback.c | 38 ------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 7080294f705c..e4d42c1dc284 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -47,8 +47,6 @@ struct gb_loopback_device {
 
 	/* We need to take a lock in atomic context */
 	spinlock_t lock;
-	struct list_head list;
-	struct list_head list_op_async;
 	wait_queue_head_t wq;
 };
 
@@ -68,7 +66,6 @@ struct gb_loopback {
 	struct kfifo kfifo_lat;
 	struct mutex mutex;
 	struct task_struct *task;
-	struct list_head entry;
 	struct device *dev;
 	wait_queue_head_t wq;
 	wait_queue_head_t wq_completion;
@@ -987,37 +984,6 @@ static const struct file_operations gb_loopback_debugfs_latency_ops = {
 	.release	= single_release,
 };
 
-static int gb_loopback_bus_id_compare(void *priv, struct list_head *lha,
-				      struct list_head *lhb)
-{
-	struct gb_loopback *a = list_entry(lha, struct gb_loopback, entry);
-	struct gb_loopback *b = list_entry(lhb, struct gb_loopback, entry);
-	struct gb_connection *ca = a->connection;
-	struct gb_connection *cb = b->connection;
-
-	if (ca->bundle->intf->interface_id < cb->bundle->intf->interface_id)
-		return -1;
-	if (cb->bundle->intf->interface_id < ca->bundle->intf->interface_id)
-		return 1;
-	if (ca->bundle->id < cb->bundle->id)
-		return -1;
-	if (cb->bundle->id < ca->bundle->id)
-		return 1;
-	if (ca->intf_cport_id < cb->intf_cport_id)
-		return -1;
-	else if (cb->intf_cport_id < ca->intf_cport_id)
-		return 1;
-
-	return 0;
-}
-
-static void gb_loopback_insert_id(struct gb_loopback *gb)
-{
-	/* perform an insertion sort */
-	list_add_tail(&gb->entry, &gb_dev.list);
-	list_sort(NULL, &gb_dev.list, gb_loopback_bus_id_compare);
-}
-
 #define DEBUGFS_NAMELEN 32
 
 static int gb_loopback_probe(struct gb_bundle *bundle,
@@ -1113,7 +1079,6 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
 	}
 
 	spin_lock_irqsave(&gb_dev.lock, flags);
-	gb_loopback_insert_id(gb);
 	gb_dev.count++;
 	spin_unlock_irqrestore(&gb_dev.lock, flags);
 
@@ -1169,7 +1134,6 @@ static void gb_loopback_disconnect(struct gb_bundle *bundle)
 
 	spin_lock_irqsave(&gb_dev.lock, flags);
 	gb_dev.count--;
-	list_del(&gb->entry);
 	spin_unlock_irqrestore(&gb_dev.lock, flags);
 
 	device_unregister(gb->dev);
@@ -1196,8 +1160,6 @@ static int loopback_init(void)
 {
 	int retval;
 
-	INIT_LIST_HEAD(&gb_dev.list);
-	INIT_LIST_HEAD(&gb_dev.list_op_async);
 	spin_lock_init(&gb_dev.lock);
 	gb_dev.root = debugfs_create_dir("gb_loopback", NULL);
 
-- 
2.19.1.6.gbde171bbf5

