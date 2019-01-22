Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9984BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6026320870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548141008;
	bh=ONxvKsRJZ3ftkN9Wpqn7v/0lEharAm5PlVPUM8Ih9sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ghMPghadHJN7C9utKUuegTnfV1odj2j2FKOAIt5zuwCoZNbZ3ES/U7rQBj4pS9vjj
	 +4CwQ6NQb9S2I7RuK2jX6W94PWN5NmtG+v0PHzMBsxJcODC2HVScfUGqmfRHguwN4r
	 zEc/HID0feSipw+gCUpYShwzLv9ATzwc3RlwRbko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfAVHKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfAVHKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:10:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D344C20854;
        Tue, 22 Jan 2019 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548141005;
        bh=ONxvKsRJZ3ftkN9Wpqn7v/0lEharAm5PlVPUM8Ih9sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0okYTXhbkHWT2q7hh/VlrY3uR0W714XmFNa20Yi/L9BxrkJ8BsecAr+S38oFuHe+
         TrSbjFOHFBvNP4wtbVN57P2y5w8CBBN82Z0XYOfzWbs0ktafIEaaXLISEqc1T0T9PR
         l/pjYQZ4+1cfGECTEWTBe4So0HKWclt1pgZD2dQM=
Date:   Tue, 22 Jan 2019 08:10:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Lei Chen <chenl.lei@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, tglx@linutronix.de
Subject: Re: /proc/<pid>/status: incorrect format breaks userland tool
Message-ID: <20190122071003.GA5582@kroah.com>
References: <CAB5AJuWz2NgwixCDh3hr4uv8qECfE2m0q49E_5GfecTnGPuXuQ@mail.gmail.com>
 <20190122053108.GA14185@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122053108.GA14185@char.us.oracle.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:31:08AM -0500, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 22, 2019 at 11:29:16AM +0800, Lei Chen wrote:
> > Hi Konrad,
> 
> Hi,
> 
> CC-ing stable,Greg,and LKML. Pls see attached and inline patch and explanation
> at bottom.
> 
> > I'm running kernel 4.4.153. When running iotop, I got such failure:
> >  # iotop -P
> > Traceback (most recent call last):
> >   File "/sbin/iotop", line 17, in <module>
> >     main()
> >   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 620, in main
> >     main_loop()
> >   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 610, in <lambda>
> >     main_loop = lambda: run_iotop(options)
> >   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 508, in
> > run_iotop
> >     return curses.wrapper(run_iotop_window, options)
> >   File "/usr/lib/python2.7/curses/wrapper.py", line 43, in wrapper
> >     return func(stdscr, *args, **kwds)
> >   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 501, in
> > run_iotop_window
> >     ui.run()
> >   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 155, in run
> >     self.process_list.duration)
> >   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 434, in
> > refresh_display
> >     lines = self.get_data()
> >   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 415, in get_data
> >     return list(map(format, processes))
> >   File "/usr/lib/python2.7/site-packages/iotop/ui.py", line 388, in format
> >     cmdline = p.get_cmdline()
> >   File "/usr/lib/python2.7/site-packages/iotop/data.py", line 292, in
> > get_cmdline
> >     proc_status = parse_proc_pid_status(self.pid)
> >   File "/usr/lib/python2.7/site-packages/iotop/data.py", line 196, in
> > parse_proc_pid_status
> >     key, value = line.split(':\t', 1)
> > ValueError: need more than 1 value to unpack
> > 
> > Having a little further debug, I found this error is caused by the
> > unexpected blank line in /proc/<pid>/status file, like below:
> > 
> > CapBnd: 0000003fffffffff
> > CapAmb: 0000000000000000
> > 
> > Speculation_Store_Bypass:       vulnerable
> > Cpus_allowed:   ff
> > 
> > Checking the git history, I see you touched the line "seq_printf(m,
> > "\nSpeculation_Store_Bypass:\t");". Do you think this additional blank line
> > is caused by the leading "\n" of "Speculation_Store_Bypass"?
> 
> That is correct.
> It looks that the backport missed the change. The v4.4 has:
> 
> static inline void task_seccomp(struct seq_file *m, struct task_struct *p)         
> {                                                                                  
> #ifdef CONFIG_SECCOMP                                                              
>         seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);                          
> #endif                                                                             
>         seq_printf(m, "\nSpeculation_Store_Bypass:\t");      
> 
> Upstream has:
> 
> tatic inline void task_seccomp(struct seq_file *m, struct task_struct *p)         
> {                                                                                  
>         seq_put_decimal_ull(m, "NoNewPrivs:\t", task_no_new_privs(p));             
> #ifdef CONFIG_SECCOMP                                                              
>         seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);                   
> #endif                                                                             
>         seq_printf(m, "\nSpeculation_Store_Bypass:\t");                         
> 
> The af884cd4a5ae6 is the one that removed the '\n' from the end and put it in the
> front of 'Seccomp '.
> 
> Greg, I am not sure how one would fix this in a stable tree. But the fix is simple
> (hadn't tested it..)
> 
> >From 9e1909f29e1162f2fba190dbab88d1bbcaf0365d Mon Sep 17 00:00:00 2001
> From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Date: Tue, 22 Jan 2019 00:27:55 -0500
> Subject: [PATCH] Fix: proc: Use underscores for SSBD in 'status'
> 
> Upstream af884cd4a5ae6 (not backported) added a '\n' in front
> of 'Seccomp' but we have the old format with '\n' at the end.
> This causes mayhem with 'Speculation_Store_Bypass' adding an extra
> newline breaking tools.
> 
> Reported-by:Lei Chen <chenl.lei@gmail.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  fs/proc/array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index cb71cbae606d..60cbaa821164 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -333,7 +333,7 @@ static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
>  #ifdef CONFIG_SECCOMP
>  	seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);
>  #endif
> -	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
> +	seq_printf(m, "Speculation_Store_Bypass:\t");
>  	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
>  	case -EINVAL:
>  		seq_printf(m, "unknown");
> -- 
> 2.13.4
> 
> 
> > 
> > Thanks,
> > Lei Chen

> >From 9e1909f29e1162f2fba190dbab88d1bbcaf0365d Mon Sep 17 00:00:00 2001
> From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Date: Tue, 22 Jan 2019 00:27:55 -0500
> Subject: [PATCH] Fix: proc: Use underscores for SSBD in 'status'
> 
> Upstream af884cd4a5ae6 (not backported) added a '\n' in front
> of 'Seccomp' but we have the old format with '\n' at the end.
> This causes mayhem with 'Speculation_Store_Bypass' adding an extra
> newline breaking tools.
> 
> Reported-by:Lei Chen <chenl.lei@gmail.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  fs/proc/array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index cb71cbae606d..60cbaa821164 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -333,7 +333,7 @@ static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
>  #ifdef CONFIG_SECCOMP
>  	seq_printf(m, "Seccomp:\t%d\n", p->seccomp.mode);
>  #endif
> -	seq_printf(m, "\nSpeculation_Store_Bypass:\t");
> +	seq_printf(m, "Speculation_Store_Bypass:\t");
>  	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
>  	case -EINVAL:
>  		seq_printf(m, "unknown");


This is already in the latest 4.9-rc release and in the 4.4.y stable
queue, as others reported it last week, so it will be fixed in the next
releases of those trees.

thanks,

greg k-h
