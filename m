Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C001C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A41F2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A41F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeISISx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbeISISx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:18:53 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5232086E;
        Wed, 19 Sep 2018 02:43:14 +0000 (UTC)
Date:   Tue, 18 Sep 2018 22:43:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     He Zhe <zhe.he@windriver.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180918224312.6e9aef50@vmware.local.home>
In-Reply-To: <20180919023932.GA14090@jagdpanzerIV>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
        <20180919015030.GA423@jagdpanzerIV>
        <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
        <20180919023932.GA14090@jagdpanzerIV>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 11:39:32 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (09/19/18 10:27), He Zhe wrote:
> > On 2018年09月19日 09:50, Sergey Senozhatsky wrote:  
> > > On (09/19/18 01:17), zhe.he@windriver.com wrote:  
> > >> @@ -1048,7 +1048,14 @@ static void __init log_buf_len_update(unsigned size)
> > >>  /* save requested log_buf_len since it's too early to process it */
> > >>  static int __init log_buf_len_setup(char *str)
> > >>  {
> > >> -	unsigned size = memparse(str, &str);
> > >> +	unsigned size;  
> > > 	unsigned int size;  
> > 
> > This is in v1 but then Steven suggested that it should be split out
> > and only keep the pure fix part here.  
> 
> Ah, I see.
> 
> Hmm... memparse() returns u64 value. A user *probably* can ask the kernel
> to allocate log_buf larger than 'unsigned int'.
> 
> So may be I'd do two fixes here:
> 
>  First  - switch to u64 size.
>  Second - check for NULL str.
> 
> 
> Steven, Petr, what do you think?
> 

I think I would switch it around. Check for NULL first, and then switch
to u64. It was always an int, do we need to backport converting it to
u64 to stable? The NULL check is a definite, the overflow of int
shouldn't crash anything.

-- Steve
