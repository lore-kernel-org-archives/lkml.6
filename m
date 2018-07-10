Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714EC20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="DomTgXcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714EC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeGJHB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:01:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42254 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeGJHBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:01:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id l9-v6so3811836pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 00:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=bbcSW9edDTogeZNygdVdZSEJzYXRItslYzel96nodnU=;
        b=DomTgXcwX3uDLV8UcGHHTlaw1DMqi46G11AciUx3TFECjAtM6L1ORgpvCQV1w74N1j
         U2I4h7JQvnbK37oQmNy0Cona41AOTsRH9OMW5LdZfgr9wjkW1LOU9ve/aPxwmuHCslC7
         ABzAFLvwuwyUdObk4ksLP0vlXXHDW0v2DBNu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bbcSW9edDTogeZNygdVdZSEJzYXRItslYzel96nodnU=;
        b=OZlHuRNYSDgDBaJtKOa5rrmHzGvLeVfGAX9rsHMG6q4gAN5I27+l4xpqd+xF4so9Pf
         qzah/4O5DkkUF5Vac/jEHxbvyCeImV5ncIZe9oZcVNEl7Gr4A3x3/kDSQtvRY0tWFCIU
         WWYfIYtkT2kDFh2oGIUGNlCQfeOAvmfayxjuLSc9VsMJ84ly0hQ7FxCm5ULQAUFrxtnz
         NoEJCkRtDaUsta6GZHPYG06RirYZ4CCvBRx0I2x1p8tumayWL0KfYqd4HM7lX+SQ/6mB
         GC8hVK8yskX722Lj5EKAVX5NE3uIQsZla1Zhv6TKBx1/O9pN6Z0PKB0NaOK7mAim8KRI
         oSBw==
X-Gm-Message-State: APt69E1hCr47rVIDNOoYBwAXEwyg8mccOQ36QZUFul1NMhkqxpzay5cf
        lSC4I1s9rYGdqZzF7SiL0WLY5g==
X-Google-Smtp-Source: AAOMgpc1012Dhz774pQkPDUE6e3VJw3VlRRaKBxelTbEyxc+wqGLy+AHosL22AdGP/m0kPezQhvdhA==
X-Received: by 2002:a62:9042:: with SMTP id a63-v6mr24553665pfe.52.1531206084561;
        Tue, 10 Jul 2018 00:01:24 -0700 (PDT)
Received: from localhost ([202.169.114.131])
        by smtp.gmail.com with ESMTPSA id n5-v6sm13766516pgr.24.2018.07.10.00.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 00:01:23 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     NeilBrown <neilb@suse.com>, David Howells <dhowells@redhat.com>,
        linux-cachefs@redhat.com
Cc:     kiran.modukuri@gmail.com, carmark.dlut@gmail.com,
        vegard.nossum@gmail.com, linux-kernel@vger.kernel.org,
        aderobertis@metrics.net, dhowells@redhat.com
Subject: Re: [PATCH 1/4] cachefiles: Fix assertion "6 == 5 is false" at fs/fscache/operation.c:494
In-Reply-To: <87601tz1oz.fsf@notabene.neil.brown.name>
References: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk> <87601tz1oz.fsf@notabene.neil.brown.name>
Date:   Tue, 10 Jul 2018 17:01:19 +1000
Message-ID: <87d0vvefr4.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.com> writes:

> On Thu, Jul 05 2018, David Howells wrote:
>
>> From: kiran modukuri <kiran.modukuri@gmail.com>
>>
>> There is a potential race in fscache operation enqueuing for reading and
>> copying multiple pages from cachefiles to netfs.
>> Under some heavy load system, it will happen very often.
>>
>> If this race occurs, an oops similar to the following is seen:
>>
>>  kernel BUG at fs/fscache/operation.c:69!
>>  invalid opcode: 0000 [#1] SMP
>>  ...
>>  #0 [ffff883fff0838d8] machine_kexec at ffffffff81051beb
>>  #1 [ffff883fff083938] crash_kexec at ffffffff810f2542
>>  #2 [ffff883fff083a08] oops_end at ffffffff8163e1a8
>>  #3 [ffff883fff083a30] die at ffffffff8101859b
>>  #4 [ffff883fff083a60] do_trap at ffffffff8163d860
>>  #5 [ffff883fff083ab0] do_invalid_op at ffffffff81015204
>>  #6 [ffff883fff083b60] invalid_op at ffffffff8164701e
>>     [exception RIP: fscache_enqueue_operation+246]
>>     RIP: ffffffffa0b793c6  RSP: ffff883fff083c18  RFLAGS: 00010046
>>     RAX: 0000000000000019  RBX: ffff8832ed1a9ec0  RCX: 0000000000000006
>>     RDX: 0000000000000000  RSI: 0000000000000046  RDI: 0000000000000046
>>     RBP: ffff883fff083c20   R8: 0000000000000086   R9: 000000000000178f
>>     R10: ffffffff816aeb00  R11: ffff883fff08392e  R12: ffff8802f0525620
>>     R13: ffff88407ffc01d8  R14: 0000000000000000  R15: 0000000000000003
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>>  #7 [ffff883fff083c10] fscache_enqueue_operation at ffffffffa0b793c6
>>  #8 [ffff883fff083c28] cachefiles_read_waiter at ffffffffa0b15a48
>>  #9 [ffff883fff083c48] __wake_up_common at ffffffff810af028
>>
>> Reported-by: Lei Xue <carmark.dlut@gmail.com>
>> Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
>> Reported-by: Anthony DeRobertis <aderobertis@metrics.net>
>> Reported-by: NeilBrown <neilb@suse.com>
>> Reported-by: Daniel Axtens <dja@axtens.net>
>> Reported-by: KiranKumar Modukuri <kiran.modukuri@gmail.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> ---
>>
>>  fs/cachefiles/rdwr.c   |   17 ++++++++++++-----
>>  fs/fscache/operation.c |    6 ++++--
>>  2 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
>> index 5082c8a49686..40f7595aad10 100644
>> --- a/fs/cachefiles/rdwr.c
>> +++ b/fs/cachefiles/rdwr.c
>> @@ -27,6 +27,7 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
>>  	struct cachefiles_one_read *monitor =
>>  		container_of(wait, struct cachefiles_one_read, monitor);
>>  	struct cachefiles_object *object;
>> +	struct fscache_retrieval *op = monitor->op;
>>  	struct wait_bit_key *key = _key;
>>  	struct page *page = wait->private;
>>  
>> @@ -51,16 +52,22 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
>>  	list_del(&wait->entry);
>>  
>>  	/* move onto the action list and queue for FS-Cache thread pool */
>> -	ASSERT(monitor->op);
>> +	ASSERT(op);
>>  
>> -	object = container_of(monitor->op->op.object,
>> -			      struct cachefiles_object, fscache);
>> +	/* We need to temporarily bump the usage count as we don't own a ref
>> +	 * here otherwise cachefiles_read_copier() may free the op between the
>> +	 * monitor being enqueued on the op->to_do list and the op getting
>> +	 * enqueued on the work queue.
>> +	 */
>> +	fscache_get_retrieval(op);
>>  
>> +	object = container_of(op->op.object, struct cachefiles_object, fscache);
>>  	spin_lock(&object->work_lock);
>> -	list_add_tail(&monitor->op_link, &monitor->op->to_do);
>> +	list_add_tail(&monitor->op_link, &op->to_do);
>>  	spin_unlock(&object->work_lock);
>>  
>> -	fscache_enqueue_retrieval(monitor->op);
>> +	fscache_enqueue_retrieval(op);
>> +	fscache_put_retrieval(op);
>>  	return 0;
>>  }
>
> Thanks - I like this approach.  Taking the extra reference makes it a
> lot more clear what is happening and why.

I personally preferred the other approach, but I looked at this
approach in great detail and am confident that it is correct.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

>
> Thanks,
> NeilBrown
>
>
>>  
>> diff --git a/fs/fscache/operation.c b/fs/fscache/operation.c
>> index e30c5975ea58..8d265790374c 100644
>> --- a/fs/fscache/operation.c
>> +++ b/fs/fscache/operation.c
>> @@ -70,7 +70,8 @@ void fscache_enqueue_operation(struct fscache_operation *op)
>>  	ASSERT(op->processor != NULL);
>>  	ASSERT(fscache_object_is_available(op->object));
>>  	ASSERTCMP(atomic_read(&op->usage), >, 0);
>> -	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_IN_PROGRESS);
>> +	ASSERTIFCMP(op->state != FSCACHE_OP_ST_IN_PROGRESS,
>> +		    op->state, ==,  FSCACHE_OP_ST_CANCELLED);
>>  
>>  	fscache_stat(&fscache_n_op_enqueue);
>>  	switch (op->flags & FSCACHE_OP_TYPE) {
>> @@ -499,7 +500,8 @@ void fscache_put_operation(struct fscache_operation *op)
>>  	struct fscache_cache *cache;
>>  
>>  	_enter("{OBJ%x OP%x,%d}",
>> -	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
>> +	       op->object ? op->object->debug_id : 0,
>> +	       op->debug_id, atomic_read(&op->usage));
>>  
>>  	ASSERTCMP(atomic_read(&op->usage), >, 0);
>>  
