Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9199BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD4B20842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfBUP0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfBUP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:26:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFF82083E;
        Thu, 21 Feb 2019 15:26:17 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:26:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 5/9] x86/alternative: Split text_poke_bp() into tree
 steps
Message-ID: <20190221102616.586d8552@gandalf.local.home>
In-Reply-To: <e4bf9378-411f-82d2-db5f-7159b16971ee@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
        <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
        <20190207191552.0782a29d@gandalf.local.home>
        <e4bf9378-411f-82d2-db5f-7159b16971ee@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 13:47:16 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 2/8/19 1:15 AM, Steven Rostedt wrote:
> > On Mon,  4 Feb 2019 20:58:58 +0100
> > Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> >   
> >>  
> >> +static void text_poke_bp_set_handler(void *addr, void *handler,
> >> +				     unsigned char int3)
> >> +{
> >> +	bp_int3_handler = handler;
> >> +	bp_int3_addr = (u8 *)addr + sizeof(int3);
> >> +	text_poke(addr, &int3, sizeof(int3));
> >> +}
> >> +
> >> +
> >> +static void patch_first_byte(void *addr, const void *opcode, unsigned char int3)
> >> +{
> >> +	/* patch the first byte */
> >> +	text_poke(addr, opcode, sizeof(int3));
> >> +}  
> > Hmm, perhaps get rid of the first function entirely, and just do...
> > (although why have the "int3" here anyway?)
> >   
> 
> These helpers were created because they were used twice in the first versions of
> this patch set. But with the change suggested by Masami, they are called only in
> the text_poke_bp_batch() now, so I am thinking to get rid of them all (removing
> this patch).
> 
> Thoughts?
> 

Go ahead.

-- Steve
