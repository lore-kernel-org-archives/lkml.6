Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B238DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574C521531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574C521531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbeIUNZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:25:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbeIUNZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:25:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77188AF58;
        Fri, 21 Sep 2018 07:37:54 +0000 (UTC)
Date:   Fri, 21 Sep 2018 09:37:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     He Zhe <zhe.he@windriver.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920123056.27b2cf18@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-09-20 12:30:56, Steven Rostedt wrote:
> On Fri, 21 Sep 2018 00:16:50 +0800
> He Zhe <zhe.he@windriver.com> wrote:
> 
> > On 2018年09月19日 10:43, Steven Rostedt wrote:
> > > On Wed, 19 Sep 2018 11:39:32 +0900
> > > Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > >  
> > >> On (09/19/18 10:27), He Zhe wrote:  
> > >>> On 2018年09月19日 09:50, Sergey Senozhatsky wrote:    
> > >>>> On (09/19/18 01:17), zhe.he@windriver.com wrote:    
> > >>>>> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
> > >>>>>  /* save requested log_buf_len since it's too early to process it */
> > >>>>>  static int __init log_buf_len_setup(char *str)
> > >>>>>  {
> > >>>>> -	unsigned size = memparse(str, &str);
> > >>>>> +	unsigned size;    
> > >>>> 	unsigned int size;    
> > >>> This is in v1 but then Steven suggested that it should be split out
> > >>> and only keep the pure fix part here.    
> > >> Ah, I see.
> > >>
> > >> Hmm... memparse() returns u64 value. A user *probably* can ask the kernel
> > >> to allocate log_buf larger than 'unsigned int'.
> > >>
> > >> So may be I'd do two fixes here:
> > >>
> > >>  First  - switch to u64 size.
> > >>  Second - check for NULL str.
> > >>
> > >>
> > >> Steven, Petr, what do you think?
> > >>  
> > > I think I would switch it around. Check for NULL first, and then switch
> > > to u64. It was always an int, do we need to backport converting it to
> > > u64 to stable? The NULL check is a definite, the overflow of int
> > > shouldn't crash anything.  
> > 
> 
> Hi Zhe,
> 
> > To switch to u64, several variables need to be adjusted to new type to aligned
> > with new_log_buf_len. And currently new_log_buf_len is passed to
> > memblock_virt_alloc(phys_addr_t, phys_addr_t). So we can't simply define
> > new_log_buf_len as u64. We need to define it as phys_addr_t tomake it work
> > well for both 32bit and 64bit arches, since a 32-bit architecture can set
> > ARCH_PHYS_ADDR_T_64BIT if it needs a 64-bit phys_addr_t.
> 
> The above explanation verifies more that the NULL pointer check needs
> to be first, and that the change in size should not be backported to
> stable because it has a high risk to doing the change as compared to it
> being a problem for older kernels.

I agree that the NULL check should go first.

I would personally keep the size as unsigned int. IMHO, a support
for a log buffer bigger than 4GB is not worth the complexity.

Best Regards,
Petr
