Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4796C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A434208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544033306;
	bh=AdxxxPnOcjREvb9W8NYtxBz4JkZjT/OIdHruqqVzkbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YKzQTT1wnZXooqf+kX7yd5TGPlsnf0lO6F69TYsCY5ucGkA39Q0fEb5HRz0nYb3Y8
	 kWdgVmIXHiMnsTydBmq0S5M0HXF3FSY1vegdBa4DcSPrasg6N1BqN8TYXcdG0RbJp8
	 IR6jfAw+QQzGfNrglyN+ds7CpnKFmwiLDOLc0fAk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A434208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeLESIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:08:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35681 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLESIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:08:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so10401305pfi.2;
        Wed, 05 Dec 2018 10:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Ja7hW5IOKOjyKwPtVqxuCHI1rWJCEkmX/08bAhWFFk=;
        b=EHJa+4N3aFKDvWborfIOss70kTRfLI0BNU11yQaBLrmFKUxXYX1WHYSrs1Fa2wtFBd
         2r20wSorDOIs+UhNSMvJIdrgoWJ5O8anmHmbuyiPYi3h1HlEct84Vu6gnCHkI8wIAXQF
         tsS5Bn0vl40vEgRLrJpkxFASGJF8MJIdP3+CwN01Pjvrhyxm5hd207Aox3QWZLfkVO9F
         +Wp8ozPGlYZ9Kt2CWjuHr2dQvEHFIZiue0jJd44rLlLMfAklzKBkHJzspQI1J1mH58XO
         XCVxtxDRxxiHXj6LjWsWlPTHYna5DrE062SxY6T92BSI5QI2PTUZ3PB2pcdLjVaOZH/n
         5+cA==
X-Gm-Message-State: AA+aEWY2ILflV8HD8RPO9Gzq3R/AeodjK5bfuj+e+wgQmcS7mZJcWMKf
        J+IgI4sySQDrFZ1sDvOfQ+A=
X-Google-Smtp-Source: AFSGD/UW7yRICIpZP8dETtYacB2ohjCKrFK85VBHVjV6gYwUbihfILWxzT7Db4W5l2xqYvMgwTmxvQ==
X-Received: by 2002:a62:8f8c:: with SMTP id n134mr25784507pfd.137.1544033303359;
        Wed, 05 Dec 2018 10:08:23 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id n66sm45373122pfk.19.2018.12.05.10.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 10:08:22 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Wed, 05 Dec 2018 10:08:18 -0800
Date:   Wed, 5 Dec 2018 10:08:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     cheng.lin130@zte.com.cn
Cc:     keescook@chromium.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn
Subject: Re: Re: Re: [PATCH] proc/sysctl: fix return error
 forproc_doulongvec_minmax
Message-ID: <20181205180818.GA28501@garbanzo.do-not-panic.com>
References: <20181203201436.GO28501@garbanzo.do-not-panic.com>
 <201812051510071985717@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812051510071985717@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 03:10:07PM +0800, cheng.lin130@zte.com.cn wrote:
> > On Mon, Dec 03, 2018 at 01:12:39PM +0800, cheng.lin130@zte.com.cn wrote:
> > > >Cheng, thanks for the patch!
> > > >
> > > >On Fri, Nov 30, 2018 at 02:35:17PM +0800, Cheng Lin wrote:
> > > >> If the number of input parameters is less than the total
> > > >> parameters, an INVAL error will be returned.
> > > >
> > > >Do you mean EINVAL?
> > > >
> > > Yes, it's EINVAL.
> > 
> > Please adjust the commit log.
> > 
> > > >> This patch ensure no error returned in this condition, just
> > > >> like other interfaces do.
> > > >
> > > >Have an actual example to reproduce?
> > > >
> > > >Luis
> > > >
> > > We use proc_doulongvec_minmax to pass up to two parameters with kern_table.
> > > e.g.
> >         {
> > >                 .procname       = "monitor_signals",
> > >                 .data           = &monitor_sigs,
> > >                 .maxlen         = 2*sizeof(unsigned long),
> > >                 .mode           = 0644,
> > >                 .proc_handler   = proc_doulongvec_minmax,
> > >         },
> > >
> > > Reproduce:
> > > When passing two parameters, it's work normal. But passing only one parameter, an error "Invalid argument"(EINVAL) is returned.
> > > [root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
> > > [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> > > 1       2
> > > [root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
> > > -bash: echo: write error: Invalid argument
> > > [root@cl150 ~]# echo $?
> > > 1
> > > [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> > > 3       2
> > > [root@cl150 ~]#
> > >
> > > The following is the result after apply this patch. No error is returned when the number of input parameters is less than the total parameters.
> > > [root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
> > > [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> > > 1       2
> > > [root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
> > > [root@cl150 ~]# echo $?
> > > 0
> > > [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> > > 3       2
> > > [root@cl150 ~]#
> > 
> > This would be good to have in the commit log as well. But your patch
> > only addresses one of the proc users, there are a few other checks like
> > this that would also need to be expanded for this. So please expand
> > your patch to cover the other cases as well.
> 
> I have done the check for the interfaces exported in kernel/sysctl.c.
> EXPORT_SYMBOL(proc_dointvec);
> EXPORT_SYMBOL(proc_douintvec);
> EXPORT_SYMBOL(proc_dointvec_jiffies);
> EXPORT_SYMBOL(proc_dointvec_minmax);
> EXPORT_SYMBOL_GPL(proc_douintvec_minmax);
> EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
> EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
> EXPORT_SYMBOL(proc_dostring);
> EXPORT_SYMBOL(proc_doulongvec_minmax);
> EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
> 
> The function call relationship is as follows. There are three processing functions dealing with digital parameters, __do_proc_dointvec/__do_proc_douintvec/__do_proc_doulongvec_minmax.
> 
> proc_dointvec------------------------------|
> proc_dointvec_jiffies----------------------|
> proc_dointvec_minmax------------------|
> proc_dointvec_userhz_jiffies------------|
> proc_dointvec_ms_jiffies-----------------|-> do_proc_dointvec----|-> __do_proc_dointvec
> 
> proc_douintvec-----------------------------|
> proc_douintvec_minmax-----------------|-> do_proc_douintvec---|->	__do_proc_douintvec
> 
> proc_doulongvec_minmax---------------|
> proc_doulongvec_ms_jiffies_minmax--|-> do_proc_doulongvec_minmax----|-> __do_proc_doulongvec_minmax

OK

> This patch deals with  __do_proc_doulongvec_minmax, just as
> __do_proc_dointvec does, adding a check for parameters 'left'. In
> __do_proc_douintvec, its code implementation explicitly does not
> support multiple inputs.  static int __do_proc_douintvec(...){
> 		...
>         /*
>          * Arrays are not supported, keep this simple. *Do not* add
>          * support for them.
>          */
>         if (vleft != 1) {
>                 *lenp = 0;
>                 return -EINVAL;
> 		...
> 		}
> 
> 		
> So, just __do_proc_doulongvec_minmax has the problem.  And most use of
> proc_doulongvec_minmax/proc_doulongvec_ms_jiffies_minmax just have one
> parameter.

The above text, up to my OK, is useful information for the commit log,
please add that.

> It's well hidden.

You mean that the issue is not widely spread? If so please add that
comment to the commit log, and resubmit a v2.

  Luis

> Typical multi-parameter applications for
> proc_dointvec, such as /proc/sys/kernel/printk.
