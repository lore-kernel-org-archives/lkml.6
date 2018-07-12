Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813BAC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1D120C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1D120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeGLEum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:50:42 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:35656 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbeGLEum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:50:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A54A718000BE7;
        Thu, 12 Jul 2018 04:42:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pail81_53a39c761f709
X-Filterd-Recvd-Size: 2964
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Jul 2018 04:42:54 +0000 (UTC)
Message-ID: <86e887cec9ce67b4ea55eec7ffca4cd902a84068.camel@perches.com>
Subject: Re: [PATCH] ring_buffer: Update logging to use single line output
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Jul 2018 21:42:53 -0700
In-Reply-To: <20180711225745.6e66c10f@vmware.local.home>
References: <cover.1525964381.git.joe@perches.com>
         <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
         <20180510122843.0b69b41a@gandalf.local.home>
         <24f146a8726f391736bc79306e64b204435eb4ec.camel@perches.com>
         <20180711225745.6e66c10f@vmware.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 22:57 -0400, Steven Rostedt wrote:
> On Fri, 11 May 2018 14:39:18 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > With a possible change to pr_fmt coming, the logging output can
> > become unbalanced when an initial line has a prefix and subsequent
> > lines do not when a multiple line pr_<level> is emitted.
> > 
> > Fix it by emitting a single line.
> > 
> >  	Miscellanea:
> > 
> > o Convert consecutive tests of total_lost and !total_lost to if/else
> 
> I just noticed this patch. Please don't send patches Cc'd to other
> threads. They need to start a new thread, otherwise, like this one, it
> will most likely be lost.
> 
> If you want this applied still, please resend it properly.

An email sent directly to you should not be lost by you.


> -- Steve
> 
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  kernel/trace/ring_buffer.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index c9cb9767d49b..ee74494a2da3 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -5132,10 +5132,9 @@ static __init int test_ringbuffer(void)
> >  		pr_info("        total events:   %ld\n", total_lost + total_read);
> >  		pr_info("  recorded len bytes:   %ld\n", total_len);
> >  		pr_info(" recorded size bytes:   %ld\n", total_size);
> > -		if (total_lost)
> > -			pr_info(" With dropped events, record len and size may not match\n"
> > -				" alloced and written from above\n");
> > -		if (!total_lost) {
> > +		if (total_lost) {
> > +			pr_info(" With dropped events, record len and size may not match alloced and written from above\n");
> > +		} else {
> >  			if (RB_WARN_ON(buffer, total_len != total_alloc ||
> >  				       total_size != total_written))
> >  				break;
> 
> 
