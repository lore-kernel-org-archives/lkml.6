Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E36208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QXPltvLf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QXPltvLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E36208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJRMlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:41:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJRMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:41:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE145612EE; Thu, 18 Oct 2018 04:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539837727;
        bh=4XlsK3cmdN3AtQsjcNJQ/wnce6q4O587RBK4aboYSHk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QXPltvLf/nxw1e6ot0tVEW4guFulcE3kFUMULyZxZWR8/4JC8uzZOWNf8UIiRWHml
         uWmEv8QOfL+yNdYPXjeGXxGbA0mralmG8mht1cVxfdjcR+kjjS/PO4fSAE6EZkSxz2
         q/ldi7MlsSLDujV9zyv4u1r9g0DLOHqs+KMGWGn0=
Received: from [10.79.129.10] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1DDF604BE;
        Thu, 18 Oct 2018 04:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539837727;
        bh=4XlsK3cmdN3AtQsjcNJQ/wnce6q4O587RBK4aboYSHk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QXPltvLf/nxw1e6ot0tVEW4guFulcE3kFUMULyZxZWR8/4JC8uzZOWNf8UIiRWHml
         uWmEv8QOfL+yNdYPXjeGXxGbA0mralmG8mht1cVxfdjcR+kjjS/PO4fSAE6EZkSxz2
         q/ldi7MlsSLDujV9zyv4u1r9g0DLOHqs+KMGWGn0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1DDF604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] pstore: Refactor compression initialization
To:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
References: <20181017214124.GA8239@beast>
 <20181018013001.GA99677@joelaf.mtv.corp.google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <9ebe40c0-5acc-70e1-587d-ba3f0edf2e7b@codeaurora.org>
Date:   Thu, 18 Oct 2018 10:12:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018013001.GA99677@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 7:00 AM, Joel Fernandes wrote:
On Wed, Oct 17, 2018 at 02:41:24PM -0700, Kees Cook wrote:
>> With compression initialization now separated from pstore_register(),
>> there is no longer a good reason to do compression method selection
>> during fs init. Instead, merge everything together into the late init.
>> Additionally cleans up the reporting to be more clear.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> This patch goes on top of Joel's. I'll have both in linux-next shortly...
>> ---
>>   fs/pstore/inode.c    |  2 --
>>   fs/pstore/internal.h |  3 --
>>   fs/pstore/platform.c | 65 ++++++++++++++++++++++++++++----------------
>>   3 files changed, 41 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
>> index 5fcb845b9fec..d814723fb27d 100644
>> --- a/fs/pstore/inode.c
>> +++ b/fs/pstore/inode.c
>> @@ -486,8 +486,6 @@ static int __init init_pstore_fs(void)
>>   {
>>   	int err;
>>   
>> -	pstore_choose_compression();
>> -
>>   	/* Create a convenient mount point for people to access pstore */
>>   	err = sysfs_create_mount_point(fs_kobj, "pstore");
>>   	if (err)
>> diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
>> index fb767e28aeb2..c029314478fa 100644
>> --- a/fs/pstore/internal.h
>> +++ b/fs/pstore/internal.h
>> @@ -37,7 +37,4 @@ extern bool	pstore_is_mounted(void);
>>   extern void	pstore_record_init(struct pstore_record *record,
>>   				   struct pstore_info *psi);
>>   
>> -/* Called during module_init() */
>> -extern void __init pstore_choose_compression(void);
>> -
>>   #endif
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> index f09066db2d4d..e4737a5fa68c 100644
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -274,36 +274,56 @@ static int pstore_decompress(void *in, void *out,
>>   
>>   static void allocate_buf_for_compression(void)
>>   {
>> +	struct crypto_comp *ctx;
>> +	int size;
>> +	char *buf;
>> +
>> +	/* Skip if not built-in or compression backend not selected yet. */
>>   	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
>>   		return;
>>   
>> +	/* Skip if no pstore backend yet or compression init already done. */
>> +	if (!psinfo || tfm)
>> +		return;
>> +
>>   	if (!crypto_has_comp(zbackend->name, 0, 0)) {
>> -		pr_err("No %s compression\n", zbackend->name);
>> +		pr_err("Unknown compression: %s\n", zbackend->name);
>>   		return;
>>   	}
>>   
>> -	big_oops_buf_sz = zbackend->zbufsize(psinfo->bufsize);
>> -	if (big_oops_buf_sz <= 0)
>> +	size = zbackend->zbufsize(psinfo->bufsize);
>> +	if (size <= 0) {
>> +		pr_err("Invalid compression size for %s: %d\n",
>> +		       zbackend->name, size);
>>   		return;
>> +	}
>>   
>> -	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
>> -	if (!big_oops_buf) {
>> -		pr_err("allocate compression buffer error!\n");
>> +	buf = kmalloc(size, GFP_KERNEL);
>> +	if (!buf) {
>> +		pr_err("Failed %d byte compression buffer allocation for: %s\n",
>> +		       size, zbackend->name);
>>   		return;
>>   	}
>>   
>> -	tfm = crypto_alloc_comp(zbackend->name, 0, 0);
>> -	if (IS_ERR_OR_NULL(tfm)) {
>> -		kfree(big_oops_buf);
>> -		big_oops_buf = NULL;
>> -		pr_err("crypto_alloc_comp() failed!\n");
>> +	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
>> +	if (IS_ERR_OR_NULL(ctx)) {
>> +		kfree(buf);
>> +		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
>> +		       PTR_ERR(ctx));
>>   		return;
>>   	}
>> +
>> +	/* A non-NULL big_oops_buf indicates compression is available. */
>> +	tfm = ctx;
>> +	big_oops_buf_sz = size;
>> +	big_oops_buf = buf;
>> +
>> +	pr_info("Using compression: %s\n", zbackend->name);
>>   }
>>   
>>   static void free_buf_for_compression(void)
>>   {
>> -	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && !IS_ERR_OR_NULL(tfm))
>> +	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm)
>>   		crypto_free_comp(tfm);
>>   	kfree(big_oops_buf);
>>   	big_oops_buf = NULL;
>> @@ -764,31 +784,28 @@ static void pstore_timefunc(struct timer_list *unused)
>>   			  jiffies + msecs_to_jiffies(pstore_update_ms));
>>   }
>>   
>> -void __init pstore_choose_compression(void)
>> +static int __init pstore_compression_late_init(void)
>>   {
>>   	const struct pstore_zbackend *step;
>>   
>>   	if (!compress)
>> -		return;
>> +		return 0;
>>   
>> +	/* Locate desired compression method. */
>>   	for (step = zbackends; step->name; step++) {
>>   		if (!strcmp(compress, step->name)) {
>>   			zbackend = step;
>> -			pr_info("using %s compression\n", zbackend->name);
>> -			return;
>> +			break;
>>   		}
>>   	}
>> -}
>>   
>> -static int __init pstore_compression_late_init(void)
>> -{
>>   	/*
>> -	 * Check if any pstore backends registered earlier but did not allocate
>> -	 * for compression because crypto was not ready, if so then initialize
>> -	 * compression.
>> +	 * Check if any pstore backends registered earlier but did not
>> +	 * initialize compression because crypto was not ready. If so,
>> +	 * then initialize compression now.
>>   	 */
>> -	if (psinfo && !tfm)
>> -		allocate_buf_for_compression();
>> +	allocate_buf_for_compression();
> 
> We can also get rid of the 'zbackend' global variable since choosing the
> compression backend and allocating the buffers are done at the same time?
> 
> Otherwise looks good to me,
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 

Tested this on top of Joel's patch, works fine on getting early crash 
pstore dmesg logs, thanks.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
