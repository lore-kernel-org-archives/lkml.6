Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAB6C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D172086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D172086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeLLH50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:57:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbeLLH5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:57:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF88940216E5;
        Wed, 12 Dec 2018 07:57:22 +0000 (UTC)
Received: from localhost (unknown [10.64.242.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFB2C170E4;
        Wed, 12 Dec 2018 07:57:21 +0000 (UTC)
Date:   Wed, 12 Dec 2018 16:57:20 +0900 (JST)
Message-Id: <20181212.165720.1203400724538830403.yamato@redhat.com>
To:     serge@hallyn.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] eventfd: make eventfd files distinguishable in
 /proc/$PID/fd
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20181211230914.GA2677@mail.hallyn.com>
References: <20181209183546.5550-1-yamato@redhat.com>
        <20181211230914.GA2677@mail.hallyn.com>
Organization: Red Hat Japan, Inc.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Dec 2018 07:57:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Dec 2018 07:57:22 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:09:14 -0600, "Serge E. Hallyn" <serge@hallyn.com> wrote:
> On Mon, Dec 10, 2018 at 03:35:46AM +0900, Masatake YAMATO wrote:
>> Finding endpoints of an IPC channel is one of essential task to
>> understand how a user program works. Procfs and netlink socket provide
>> enough hints to find endpoints for IPC channels like pipes, unix
>> sockets, and pseudo terminals. However, there is no simple way to find
>> endpoints for an eventfd file from userland. An inode number doesn't
>> hint. Unlike pipe, all eventfd files shares one inode object.
>> 
>> To provide the way to find endpoints of an eventfd file, this patch
>> adds eventfd identifiers to the output of 'ls -l /proc/$pid/fd' like:
>> 
>>   ...
>>   lrwx------. 1 qemu qemu 64 May 20 04:49 93 -> 'anon_inode:[eventfd:130]'
>>   lrwx------. 1 qemu qemu 64 May 20 04:49 94 -> 'anon_inode:[eventfd:131]'
>>   ...
>> 
>> Here "130" and "131" are added as identifiers newly added.
>> In the case that ida_simple_get returns an error, this change doesn't add
>> an identifier; just use "[eventfd]" as before.
>> 
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> 
> I'm going to love this when I need it :)  Thanks.
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
>

Thank you for replying.
This is the first time getting replying since my first post,
Mon, 21 May 2018 05:18:23 +0900.

Can I expect my patch is merged to the mainline?
Or should I do something more?

Masatake YAMATO

>> ---
>>  fs/eventfd.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/eventfd.c b/fs/eventfd.c
>> index 08d3bd602f73..c18952948110 100644
>> --- a/fs/eventfd.c
>> +++ b/fs/eventfd.c
>> @@ -21,6 +21,11 @@
>>  #include <linux/eventfd.h>
>>  #include <linux/proc_fs.h>
>>  #include <linux/seq_file.h>
>> +#include <linux/idr.h>
>> +
>> +/* Worst case buffer size needed for holding an integer. */
>> +#define ITOA_MAX_LEN 12
>> +DEFINE_IDA(eventfd_ida);
>>  
>>  struct eventfd_ctx {
>>  	struct kref kref;
>> @@ -35,6 +40,7 @@ struct eventfd_ctx {
>>  	 */
>>  	__u64 count;
>>  	unsigned int flags;
>> +	int id;
>>  };
>>  
>>  /**
>> @@ -69,6 +75,8 @@ EXPORT_SYMBOL_GPL(eventfd_signal);
>>  
>>  static void eventfd_free_ctx(struct eventfd_ctx *ctx)
>>  {
>> +	if (ctx->id >= 0)
>> +		ida_simple_remove(&eventfd_ida, ctx->id);
>>  	kfree(ctx);
>>  }
>>  
>> @@ -384,6 +392,7 @@ static int do_eventfd(unsigned int count, int flags)
>>  {
>>  	struct eventfd_ctx *ctx;
>>  	int fd;
>> +	char name[1 + 8 + ITOA_MAX_LEN + 1 + 1] = "[eventfd]";
>>  
>>  	/* Check the EFD_* constants for consistency.  */
>>  	BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
>> @@ -400,8 +409,11 @@ static int do_eventfd(unsigned int count, int flags)
>>  	init_waitqueue_head(&ctx->wqh);
>>  	ctx->count = count;
>>  	ctx->flags = flags;
>> +	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
>>  
>> -	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
>> +	if (ctx->id >= 0)
>> +		snprintf(name, sizeof(name), "[eventfd:%d]", ctx->id);
>> +	fd = anon_inode_getfd(name, &eventfd_fops, ctx,
>>  			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
>>  	if (fd < 0)
>>  		eventfd_free_ctx(ctx);
>> -- 
>> 2.17.0
