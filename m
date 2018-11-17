Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3150C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 09:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7910C2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 09:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7910C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeKQTQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 14:16:10 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:49957 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbeKQTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 14:16:09 -0500
Received: from [IPv6:2001:983:e9a7:1:b167:1e29:5b51:e4fb] ([IPv6:2001:983:e9a7:1:b167:1e29:5b51:e4fb])
        by smtp-cloud7.xs4all.net with ESMTPA
        id NwSTgvJQjg8oMNwSUg7Sy8; Sat, 17 Nov 2018 10:00:08 +0100
Subject: Re: [PATCH] media: videobuf2-core: fix use after free in vb2_mmap
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <20181116234227.27255-1-sudipm.mukherjee@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d2057e4d-d011-c73a-f615-f853db6b3e67@xs4all.nl>
Date:   Sat, 17 Nov 2018 10:00:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181116234227.27255-1-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNOCurMU55xuff+5Uck6JV8+eoOFfox4+32u/KmiLfehNtyhMGsIhbTw6UFNc/5SFJHfb3dHA00/MNLIiRtiMiLxfPaa3giWPmdtRCM5YGPuRNhgWZ3x
 yNeCPYZurzeZsKQNoBmBuYwxEi+M6/2muW89aSfRQ5JEyjjAq3fxgvPm/cAQwlvYdRrddtfyO4JcgKj2eXTd4OlAFFXmeST0EiRL/p88fh6t3rjZNBxNzHiQ
 p3HNPwhQZO0xa8LKPfGc7XJkYG2FzJV7Pu/at9x/EAL3f9NrIMIZX2izqbnlCLxQVRuxif9UKieOE11gagc7uytPUouNvHkzgizBIUzav6W3M/Cm/AiUq1hA
 hm8bMaq8Kti/Wa9ngGJoziltLEuryQISBkzxsAX/NgCLhI1Ba8JwA3dFfQXD4A4cgikOL2KN5nVkpcn7Rm0BpPwIdOpxlpwG/bSxFgAvYLKUshyMPO4fQvsP
 y7Grz03z2uHE8L8ArsxQ87oqQqoDuR9vFCxiEo93PPfwdr4idc+yjDusz8I6BiGkTnx/ccvLzfYYW6Np
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same patch was already posted and is waiting to be merged:

https://patchwork.linuxtv.org/patch/52944/

Regards,

	Hans

On 11/17/2018 12:42 AM, Sudip Mukherjee wrote:
> When we are using __find_plane_by_offset() to find the matching plane
> number and the buffer, the queue is not locked. So, after we have
> calculated the buffer number and assigned the pointer to vb, it can get
> freed. And if that happens then we get a use-after-free when we try to
> use this for the mmap and get the following calltrace:
> 
> [   30.623259] Call Trace:
> [   30.623531]  dump_stack+0x244/0x39d
> [   30.623914]  ? dump_stack_print_info.cold.1+0x20/0x20
> [   30.624439]  ? printk+0xa7/0xcf
> [   30.624777]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
> [   30.625265]  print_address_description.cold.7+0x9/0x1ff
> [   30.625809]  kasan_report.cold.8+0x242/0x309
> [   30.626263]  ? vb2_mmap+0x712/0x790
> [   30.626637]  __asan_report_load8_noabort+0x14/0x20
> [   30.627201]  vb2_mmap+0x712/0x790
> [   30.627642]  ? vb2_poll+0x1d0/0x1d0
> [   30.628060]  vb2_fop_mmap+0x4b/0x70
> [   30.628458]  v4l2_mmap+0x153/0x200
> [   30.628929]  mmap_region+0xe85/0x1cd0
> 
> Lock the queue before we start finding the matching plane and buffer so
> that there is no chance of the memory being freed while we are about
> to use it.
> 
> Reported-by: syzbot+be93025dd45dccd8923c@syzkaller.appspotmail.com
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 975ff5669f72..a81320566e02 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -2125,9 +2125,12 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>  	/*
>  	 * Find the plane corresponding to the offset passed by userspace.
>  	 */
> +	mutex_lock(&q->mmap_lock);
>  	ret = __find_plane_by_offset(q, off, &buffer, &plane);
> -	if (ret)
> +	if (ret) {
> +		mutex_unlock(&q->mmap_lock);
>  		return ret;
> +	}
>  
>  	vb = q->bufs[buffer];
>  
> @@ -2138,12 +2141,12 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>  	 */
>  	length = PAGE_ALIGN(vb->planes[plane].length);
>  	if (length < (vma->vm_end - vma->vm_start)) {
> +		mutex_unlock(&q->mmap_lock);
>  		dprintk(1,
>  			"MMAP invalid, as it would overflow buffer length\n");
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(&q->mmap_lock);
>  	ret = call_memop(vb, mmap, vb->planes[plane].mem_priv, vma);
>  	mutex_unlock(&q->mmap_lock);
>  	if (ret)
> 

