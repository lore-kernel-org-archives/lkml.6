Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4746ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993CA21526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="QeBdeoc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993CA21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbeITTvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:51:12 -0400
Received: from out002.mailprotect.be ([83.217.72.86]:37797 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbeITTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        reply-to:sender:bcc; bh=qwLsYwFxr5EzT7YxFaHewGdEoEJNzrrqhjBEbMh+Haw=; b=QeBde
        oc9vs5HfV+BU+G8rKMcHDcjF/MBXq3raa/25m/pP6CWIlW3Qe4tz2vFciy7fOPaLiov4iIMDerOSN
        1r3Jz78ERV9LW9xExrIILIleBcUBRpKc7gjZfHwi9tinKBIC2QY1z/Zl1+b8aGdmu77v5aLro6+fE
        Qm5mAY3obHr6y34Z165CDZnwsxn0LbUG9sQ9B4CTt1cVAlRW0A5k9r7RAox7afqscnYYigh3XAZrO
        O9cNyo4yodkB/xDvVszcolrmn6FwEcKXZ83RKvkXydvztCCQVQ0JVm9XbfdfhXTpTdfjEi0sbYop+
        J/bityvyamg3Fr3XYyhmiBkRwtX2w==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1g2zc4-000GqF-Kf; Thu, 20 Sep 2018 16:07:30 +0200
Received: from asus.site (c-174-62-111-89.hsd1.ca.comcast.net [174.62.111.89])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 7BB20C07DE;
        Thu, 20 Sep 2018 16:07:20 +0200 (CEST)
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c5acf280-b3e3-51b3-da98-0809d9d76cc4@acm.org>
Date:   Thu, 20 Sep 2018 07:07:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5r7gx6mzFEBS9q0lvCqkmel602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO9c1faIe+c43eeeX4flj+Kg/lfRz5bVRX7pE+lVUPc6eRTQ9hJDgl4NEbD3cs4zwpE+i
 f+7a6uLFdH6k61UqitQ2O24/YaG/nlJIwhP0Sqqcg+/XiR+3CihIoUiIOqv0vbhOT+PiyelM3Zr3
 lFd9tU+L0shJd6TJ50Ase9k7Zb8pFKlgjVEMRkSVyytYMMobj3pOB42CBFdUI+0AUbv2BWnCRPlN
 wQ4dZk+/yIr3L/mvSf3b4UwdzuAIW0rfPTMTq//JybeqiXgY7pT0jWgSF5jiibqEHMYzUui+v5ht
 nGfVS5/54zeXko+dun95C2GNU1ACebqPfeW0LvKvG9erIeWrTpYqPd59Mhw9p0EeDscCxcGQv6Co
 AueoQ7SMl/O39O02aVNKOvoUCRKCg0yj44ZD5BnWuaJVFzicyW7ZMqVig8CBO1Snvm6qXHQp7O9k
 dWbSnoABiDiz3fvuXEJ2N5Uj7+wzNacd7RWdqc1NFtZr4w4VqtpdZL4ymfOgEYLo51Ehrz2bH62S
 O2U6OIitzKb8O9tzDHeFEASn1LPDpj0a+p7EL8UqasFVCrdvYJM4HeNP6ZtKGi7qGS0KWhO9M5nS
 dtLuOCq/t29IqrGiM0ggcR8g1rYEf90tuG42Fu4fp0RSlYOCt6fQfitDUooavLHQlmEsLzU6vCHj
 Ig2ZBlHqXsUbLgDfGPAG/3cafyXHHKQBJ7TPMihJUfmPOEFZaWMblip6VbQvqsZsM9/BhAb5MJo6
 dhH57XueYpczLiJSej+XZHjj/tq30M/WtDx7p1sX9h/PtnBZEWkkdCeZVsYktFnbEoIgSEksi7JJ
 5AcqRadNl6pz3hK5n9w8ot0u9fa7GRP27nWrOq+O9f21u1Nl4O3+8PI8tRc3Ygsed0LiHLB5qPrm
 LnSSifG4ucd7W6WkUwuePJRTBm+vh2M1hIGxw7c2nWqBdqt0/FRLPOFFaFLyPBha1npUVO6vAlhE
 7ytQvy23SZXSfMZ7RzHGH1l2NHuicMJX5X0GMakScrZVluLMo9v/bmk1m4RaFitdqPRsL68TGimK
 D366s12OGtj6NW/f5CSbLl3cMbAEzugLhIG+HVmJOHA8sIBAkDNohxoH9o7jLqF6yGY7PKlJSORB
 tgZkcRkCnoMzps1w8ZlyWjbLETj4IwgadgrpoRFN1Cqd+FmECdyZDE3/qsN8Mfj+ZyCgxZHINA6A
 5+7T9o6byzK7mSe8p5ii+ZcI3OoKs87RO5FD56LSbWj1pJCj/TAxbYyXussTUB3pHNlsmBsqAjEv
 uGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/18 2:15 AM, Ming Lei wrote:
> Hi Guys,
> 
> Some storage controllers have DMA alignment limit, which is often set via
> blk_queue_dma_alignment(), such as 512-byte alignment for IO buffer.
> 
> Block layer now only checks if this limit is respected for buffer of
> pass-through request,
> see blk_rq_map_user_iov(), bio_map_user_iov().
> 
> The userspace buffer for direct IO is checked in dio path, see
> do_blockdev_direct_IO().
> IO buffer from page cache should be fine wrt. this limit too.
> 
> However, some file systems, such as XFS, may allocate single sector IO buffer
> via slab. Usually I guess kmalloc-512 should be fine to return
> 512-aligned buffer.
> But once KASAN or other slab debug options are enabled, looks this
> isn't true any
> more, kmalloc-512 may not return 512-aligned buffer. Then data corruption
> can be observed because the IO buffer from fs layer doesn't respect the DMA
> alignment limit any more.
> 
> Follows several related questions:
> 
> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
> yes, is it a stable rule?
> 
> 2) If it is a rule for kmalloc-N slab to return N-byte aligned buffer,
> seems KASAN violates this
> rule?
> 
> 3) If slab can't guarantee to return 512-aligned buffer, how to fix
> this data corruption issue?

I don't think that (1) is correct, especially if N is not a power of 
two. In the skd driver I addressed this problem by using 
kmem_cache_create() and kmem_cache_alloc() instead of kmalloc(). 
kmem_cache_create() allows to specify the alignment explicitly.

Bart.
