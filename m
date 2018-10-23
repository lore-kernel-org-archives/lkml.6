Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1CCC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F8020665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="H7Q48GXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F8020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeJXAoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:44:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33177 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeJXAoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:44:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id u1-v6so2405262wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zT817g2oIrxNANIjVULKW73wCFjcX1rTerDmutYDQpg=;
        b=H7Q48GXnMWQLaPw+6Is8cmRjtIEVjcxmEhcjCK3sG4FmVIx7YkJfbydyyKcCD/CfXP
         5nt88DX6yTvxJjzjfxuRqZg0xBZOFCwcp5+riiYsUMfye+Kl5bOd/Uq8PaG8MRuNXJW5
         s/1H+WIsRmRpn8AOSqcKgvj38HEHlDopi2OB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zT817g2oIrxNANIjVULKW73wCFjcX1rTerDmutYDQpg=;
        b=Gg3BY7uANFzMqSALXPHtzXO25Y55BL3UPIlaNZL7bvLtTgTRzIlI0z0Hwj7xnBZXuV
         9w5UujaT8d5UTADJmOIkIEw8vL9kD+Pd0svDSY5WvHIWPKGo989oUlDMURRsoiNZWuuf
         IRgOcb2G6ZKKFFrvaRrogeZBzZu6HXfF6a419gDenJShAYmPSS7HoUtgwazb0NRUjdNY
         hELScJOWd9PWiQ8o/580K3ca67W+twbNDBV+tTzXTJrstqPYMMVeOV/mBQ6hsU75ZcB8
         KooPAfeVE1UC+zTOUWpDXqiSF3ao4J4LCyxneKOmOJdUyJN0uZSkpnQfOkfZuLlExgL7
         Pk5Q==
X-Gm-Message-State: AGRZ1gIt1tRz9uYJZlP9oiRVtx21GwQYUT1hJtG+n0yMt5f0byor8EEb
        Fk86icy7N5bHlxbymOrnV0Xa1EVVA9hTEw==
X-Google-Smtp-Source: AJdET5e8dnkoJk+zOAeNsjawaf98VqJaqIyVdjASsj5eWD1RSjQOevUFjsoM14rBksB9ct6tg3krSA==
X-Received: by 2002:adf:e807:: with SMTP id o7-v6mr8269798wrm.112.1540311611618;
        Tue, 23 Oct 2018 09:20:11 -0700 (PDT)
Received: from [10.101.219.227] ([185.7.230.215])
        by smtp.gmail.com with ESMTPSA id h78-v6sm2471779wmd.4.2018.10.23.09.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 09:20:10 -0700 (PDT)
Subject: Re: [PATCH 2/3] staging: greybus: loopback.c: do insertion in O(n)
 instead of O(n lg n)
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
 <20181005142826.26108-2-linux@rasmusvillemoes.dk>
 <b59cc4bf-3c43-8d35-8d1c-0700f6b4c604@nexus-software.ie>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8578bb51-70b4-08c2-99b0-4cb95e3dd832@rasmusvillemoes.dk>
Date:   Tue, 23 Oct 2018 18:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b59cc4bf-3c43-8d35-8d1c-0700f6b4c604@nexus-software.ie>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-11 01:03, Bryan O'Donoghue wrote:
> On 05/10/2018 15:28, Rasmus Villemoes wrote:
>> Signed-off-by: Rasmus Villemoes<linux@rasmusvillemoes.dk>
>> ---
>> I have no idea if the performance matters (it probably doesn't). Feel
>> free to ignore this and the followup cleanup.
> 
> What's the problem you're fixing here ?
> 
> Is it tested ?

I got curious why one would want to keep a linked list sorted in the
first place (it can't be for doing binary searches). But it seems that
gb_loopback_device::list is unused, along with the list_op_async. Given
that the below compiles, doesn't that prove that the code is
dead/unused, or what am I missing?

diff --git a/drivers/staging/greybus/loopback.c
b/drivers/staging/greybus/loopback.c
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
@@ -987,37 +984,6 @@ static const struct file_operations
gb_loopback_debugfs_latency_ops = {
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

@@ -1169,7 +1134,6 @@ static void gb_loopback_disconnect(struct
gb_bundle *bundle)

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

