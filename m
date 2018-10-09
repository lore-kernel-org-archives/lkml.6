Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D6C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F35213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F35213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJIKJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 06:09:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbeJIKJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 06:09:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35B6A3082A2E;
        Tue,  9 Oct 2018 02:55:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD0A46DAEA;
        Tue,  9 Oct 2018 02:54:55 +0000 (UTC)
Subject: Re: [tip:x86/mm] kdump, proc/vmcore: Enable kdumping encrypted memory
 with SME enabled
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
References: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
 <tip-992b649a3f013465d8128da02e5449def662a4c3@git.kernel.org>
 <21eab36e-d113-cf88-e497-7dd620981544@redhat.com>
 <20181007084742.GA30797@zn.tnic>
 <58270f3f-f17c-8996-09cd-6da3481beb40@redhat.com>
 <20181008053714.GA6490@zn.tnic>
 <710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com>
 <20181008080013.GB6490@zn.tnic>
 <8147597a-f8e0-7f1a-bd2b-e914b18c5c74@redhat.com>
 <20181008085909.GC6490@zn.tnic> <20181008134359.GF6490@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <0cecda76-0c1b-c11a-08be-f99cf7214d12@redhat.com>
Date:   Tue, 9 Oct 2018 10:54:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008134359.GF6490@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 09 Oct 2018 02:55:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月08日 21:43, Borislav Petkov 写道:
> On Mon, Oct 08, 2018 at 10:59:09AM +0200, Borislav Petkov wrote:
>> On Mon, Oct 08, 2018 at 04:47:34PM +0800, lijiang wrote:
>>> It looks like a good way to avoid the 'ifdefined', and it's also good enough for i386.
>>>
>>> But for other architectures, such as POWERPC/ARM..., we will also have to add the same 
>>> function for every architecture. Otherwise, i guess that they also have a same compile
>>> error on other architectures.
>>
>> Yap, just realized that and looking at the rest of fs/proc/vmcore.c -
>> such functions are defined with the __weak attribute. Lemme see if that
>> works better.
> 
> Seems so. I'll hammer on it more today:
> 
Great! Thank you, Borislav.

Regards,
Lianbo
> ---
>  fs/proc/vmcore.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 42c32d06f7da..91ae16fbd7d5 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -187,6 +187,16 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
>  	return remap_pfn_range(vma, from, pfn, size, prot);
>  }
>  
> +/*
> + * Architectures which support memory encryption override this.
> + */
> +ssize_t __weak
> +copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
> +			   unsigned long offset, int userbuf)
> +{
> +	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
> +}
> +
>  /*
>   * Copy to either kernel or user space
>   */
> 
