Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2263C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACED2206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550933338;
	bh=iglcbKS5NTULXRq/WapoeaKRwlnoPTqOgMISBK4srjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dGUVpVSIS7uu7cMNtIbL/SqW7P7nm6XDfG0K1W31GOyy8i5geFYwQiZe+zrrI2jcf
	 1W0xqcHZe0OmyuHCVco5WEsDap1NX75ghgERElxvuzIjTKsMpuuLoPQ22TWV9c2vKT
	 PNlQYUlSiFuGPmEMNluWcUElzbF4lR/OuLVREoIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfBWOs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 09:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWOs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 09:48:56 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A298620665;
        Sat, 23 Feb 2019 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550933335;
        bh=iglcbKS5NTULXRq/WapoeaKRwlnoPTqOgMISBK4srjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PypviNtiC89kNNGocLqhFShzyUELgismwtA74WTUWqKn/xXSPpEf0ebUmGhGQLhCX
         2AqtpbHEeRLK4bqFRSsKrRBJ1namzEd5RAgTXDqr7NCxmfZWsUIpkdndgYKs2KLUfc
         7NlPV6UND4oDXGgWrR4Z0g9zNFRp6TF+ucO0IlXo=
Date:   Sat, 23 Feb 2019 23:48:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-Id: <20190223234852.1a1df1b93ca6045b94c69b26@kernel.org>
In-Reply-To: <20190221165252.4a9033b3348f30f9d973dbc4@kernel.org>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <20190221165252.4a9033b3348f30f9d973dbc4@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Feb 2019 16:52:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > ---
> >  kernel/trace/trace_kprobe.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index d5fb09ebba8b..9eaf07f99212 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -861,22 +861,14 @@ static const struct file_operations kprobe_profile_ops = {
> >  static nokprobe_inline int
> >  fetch_store_strlen(unsigned long addr)
> >  {
> > -	mm_segment_t old_fs;
> >  	int ret, len = 0;
> >  	u8 c;
> >  
> > -	old_fs = get_fs();
> > -	set_fs(KERNEL_DS);
> > -	pagefault_disable();
> > -

BTW, compared with probe_kernel_read() implementation, this function
lacks current->kernel_uaccess_faults_ok modification here.

I would like to know whether we can avoid this issue if we tweak this flag.

Thank you,

> >  	do {
> > -		ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
> > +		ret = probe_mem_read(&c, (u8 *)addr + len, 1);
> >  		len++;
> >  	} while (c && ret == 0 && len < MAX_STRING_SIZE);
> >  
> > -	pagefault_enable();
> > -	set_fs(old_fs);
> > -
> >  	return (ret < 0) ? ret : len;
> >  }
> >  
> > -- 
> > 2.20.1
> > 
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
