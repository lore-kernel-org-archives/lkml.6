Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA8B2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FYfsDMQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA8B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLFU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:58:00 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41469 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFU57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:57:59 -0500
Received: by mail-yb1-f195.google.com with SMTP id n134so1420346ybf.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKVZaCD9ZtZ0SJxFxgVDNC1lXzqQAhGwc41Mmvh5cwQ=;
        b=FYfsDMQqy0Teb7YhaLy8vQ5hd8iM+SBZt7LcK0chS2e7o4sZd323pLhYF1BK+OH5Rh
         mB3Xv1TMY2NpEJUNAL4CXO9ajl2spep7AnyMbUKFqIm0lNKklKU/cMVU7FttQzF0zxnI
         AOjd2Dryd1Xvordm+7ysqJIa322ZSWULVmC0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKVZaCD9ZtZ0SJxFxgVDNC1lXzqQAhGwc41Mmvh5cwQ=;
        b=YMDqN+D2lwXoDy+x1L9tGOGZ2ddhtc2yZQCV/L0hO1SvZkR32WiGfSzpsFwjqJh4Ms
         Efwx5Qxx0Ue+rqva73gnq4dDS6KThs6s5Ejoi0jRTJ2IwWELDXPtwyhR0dQfrFhhTeIC
         gTG5bNWSR4r4lGCRjXi9MJAQaTbma7FP51D8CpVFwpf1EsS/P1C2AgAyv07wzQZixqOz
         vpTx8rFiWRfP7Q1eYUhATONPTaqDrB7qkJ4hzh+zR/2McuVeFH3rg1tqAEvQUnYqV1Ep
         hneo0y8t+cl5Yotgdu3D2TWYJ7v/bJRFaEX5lAN7mm4jZkKBGm0rbLAPt/hDarOMlyrx
         wmYg==
X-Gm-Message-State: AA+aEWZ21mo510nvRE+45VJFURkN3J9wt/Njcb9HU3DfmlVebNAX5bhe
        Y6LId0n4/cqb3l4PPIYM2WBubpp1MDs=
X-Google-Smtp-Source: AFSGD/UdBsSTh8LpGlR5sG+2394aAAHu94LvhBdWdPOQJGiWWoFOOSMN8aGgNndcXhk581GYZ4yGhw==
X-Received: by 2002:a25:5e43:: with SMTP id s64mr18773492ybb.242.1544129877333;
        Thu, 06 Dec 2018 12:57:57 -0800 (PST)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id i13sm357479ywe.53.2018.12.06.12.57.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 12:57:55 -0800 (PST)
Received: by mail-yw1-f48.google.com with SMTP id j6so164487ywj.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:57:55 -0800 (PST)
X-Received: by 2002:a81:28c7:: with SMTP id o190mr30827025ywo.288.1544129874790;
 Thu, 06 Dec 2018 12:57:54 -0800 (PST)
MIME-Version: 1.0
References: <1544081775-15720-1-git-send-email-cheng.lin130@zte.com.cn> <20181206085242.GG28501@garbanzo.do-not-panic.com>
In-Reply-To: <20181206085242.GG28501@garbanzo.do-not-panic.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 12:57:43 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLDT99hc67TQx0Hsrh9NMHt1mYN6BNgMvx9b43zfdU5oQ@mail.gmail.com>
Message-ID: <CAGXu5jLDT99hc67TQx0Hsrh9NMHt1mYN6BNgMvx9b43zfdU5oQ@mail.gmail.com>
Subject: Re: [PATCH] proc/sysctl: fix return error for proc_doulongvec_minmax
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     cheng.lin130@zte.com.cn, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        zhong.weidong@zte.com.cn, wang.yi59@zte.com.cn,
        Alexander.Levin@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 12:52 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Dec 06, 2018 at 03:36:15PM +0800, Cheng Lin wrote:
> > If the number of input parameters is less than the total
> > parameters, an EINVAL error will be returned.
> >
> > e.g.
> > We use proc_doulongvec_minmax to pass up to two parameters
> > with kern_table.
> >
> > {
> >       .procname       = "monitor_signals",
> >       .data           = &monitor_sigs,
> >       .maxlen         = 2*sizeof(unsigned long),
> >       .mode           = 0644,
> >       .proc_handler   = proc_doulongvec_minmax,
> > },
> >
> > Reproduce:
> > When passing two parameters, it's work normal. But passing
> > only one parameter, an error "Invalid argument"(EINVAL) is
> > returned.
> >
> > [root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
> > [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> > 1       2
> > [root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
> > -bash: echo: write error: Invalid argument
> > [root@cl150 ~]# echo $?
> > 1
> > [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> > 3       2
> > [root@cl150 ~]#
> >
> > The following is the result after apply this patch. No error
> > is returned when the number of input parameters is less than
> > the total parameters.
> >
> > [root@cl150 ~]# echo 1 2 > /proc/sys/kernel/monitor_signals
> > [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> > 1       2
> > [root@cl150 ~]# echo 3 > /proc/sys/kernel/monitor_signals
> > [root@cl150 ~]# echo $?
> > 0
> > [root@cl150 ~]# cat /proc/sys/kernel/monitor_signals
> > 3       2
> > [root@cl150 ~]#
> >
> > There are three processing functions dealing with digital parameters,
> > __do_proc_dointvec/__do_proc_douintvec/__do_proc_doulongvec_minmax.
> >
> > This patch deals with __do_proc_doulongvec_minmax, just as
> > __do_proc_dointvec does, adding a check for parameters 'left'. In
> > __do_proc_douintvec, its code implementation explicitly does not
> > support multiple inputs.
> >
> > static int __do_proc_douintvec(...){
> >          ...
> >          /*
> >           * Arrays are not supported, keep this simple. *Do not* add
> >           * support for them.
> >           */
> >          if (vleft != 1) {
> >                  *lenp = 0;
> >                  return -EINVAL;
> >          }
> >          ...
> > }
> >
> > So, just __do_proc_doulongvec_minmax has the problem. And most use of
> > proc_doulongvec_minmax/proc_doulongvec_ms_jiffies_minmax just have one
> > parameter.
> >
> > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
>
> Thanks for fixing up the commit log.
>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> I think we can live with this outside of stable. So stable is not
> needed. But I would not be surprised if autosel algorithm will end
> up picking it up. And if so.. well, it cannot hurt.
>
>   Luis



-- 
Kees Cook
