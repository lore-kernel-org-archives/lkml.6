Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF2ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA99214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA99214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbeITWPQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbeITWPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:15:16 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34269214C2;
        Thu, 20 Sep 2018 16:30:58 +0000 (UTC)
Date:   Thu, 20 Sep 2018 12:30:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180920123056.27b2cf18@gandalf.local.home>
In-Reply-To: <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
        <20180919015030.GA423@jagdpanzerIV>
        <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
        <20180919023932.GA14090@jagdpanzerIV>
        <20180918224312.6e9aef50@vmware.local.home>
        <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 00:16:50 +0800
He Zhe <zhe.he@windriver.com> wrote:

> On 2018年09月19日 10:43, Steven Rostedt wrote:
> > On Wed, 19 Sep 2018 11:39:32 +0900
> > Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >  
> >> On (09/19/18 10:27), He Zhe wrote:  
> >>> On 2018年09月19日 09:50, Sergey Senozhatsky wrote:    
> >>>> On (09/19/18 01:17), zhe.he@windriver.com wrote:    
> >>>>> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
> >>>>>  /* save requested log_buf_len since it's too early to process it */
> >>>>>  static int __init log_buf_len_setup(char *str)
> >>>>>  {
> >>>>> -	unsigned size = memparse(str, &str);
> >>>>> +	unsigned size;    
> >>>> 	unsigned int size;    
> >>> This is in v1 but then Steven suggested that it should be split out
> >>> and only keep the pure fix part here.    
> >> Ah, I see.
> >>
> >> Hmm... memparse() returns u64 value. A user *probably* can ask the kernel
> >> to allocate log_buf larger than 'unsigned int'.
> >>
> >> So may be I'd do two fixes here:
> >>
> >>  First  - switch to u64 size.
> >>  Second - check for NULL str.
> >>
> >>
> >> Steven, Petr, what do you think?
> >>  
> > I think I would switch it around. Check for NULL first, and then switch
> > to u64. It was always an int, do we need to backport converting it to
> > u64 to stable? The NULL check is a definite, the overflow of int
> > shouldn't crash anything.  
> 

Hi Zhe,

> To switch to u64, several variables need to be adjusted to new type to aligned
> with new_log_buf_len. And currently new_log_buf_len is passed to
> memblock_virt_alloc(phys_addr_t, phys_addr_t). So we can't simply define
> new_log_buf_len as u64. We need to define it as phys_addr_t tomake it work
> well for both 32bit and 64bit arches, since a 32-bit architecture can set
> ARCH_PHYS_ADDR_T_64BIT if it needs a 64-bit phys_addr_t.

The above explanation verifies more that the NULL pointer check needs
to be first, and that the change in size should not be backported to
stable because it has a high risk to doing the change as compared to it
being a problem for older kernels.

> 
> What do you think?

Sounds good to me.

What do others think?

-- Steve
