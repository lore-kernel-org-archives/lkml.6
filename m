Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC7ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007472150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OIxgDhHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007472150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJQSI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:08:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44948 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJQSI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:08:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so12956805pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cC/01CYnU4eCV09wqICajD0UyDpnS446Kr0hex3xitk=;
        b=OIxgDhHBuQh2ggxEbIHTvtu44/G2RkHyQpt4KnKulZsbZUBcBrcXE9MU7eeAmFwDlz
         5odO7QXxKfrr4HkMrCF+DKvD0hM2g8XXjKNtR2GcCsFasxbjZ35WKiHmp9Lhkuc0USJ5
         JnZ8zXyEXOAXspx7km1ZmtvhP54ABv22Dbwa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cC/01CYnU4eCV09wqICajD0UyDpnS446Kr0hex3xitk=;
        b=dQtUBTRaGYEG171BWV+aFTzxIvKr/VumMEUqoVmPdrGEaXf2DnBBJvHWeJTG2Ni/4m
         a8bdzJyw2SQtYqYkKPqTTXik+2Ueu0ija0KoJqJ66NbjcZWgFARGmUhTt7OH9mhTSuND
         Woie1ulP02YivxUZoKiSjTGYrwf1YzXnZbv9494V+vCWeGIJ5D92JyX0sNXXkme0OKS0
         0X6ae/xJQjw7w6M8lMpv0WLVy9IP4AGIo9RNbhOmJrCUxtShNe+7VMfC6lZndLifaVqq
         saBYicmBTazL4ZoCtu3jv7b6SKlXdOfj4dFpdF+3in/LDJb/hRghyIVTGFPbbhTkdd3P
         2yWg==
X-Gm-Message-State: ABuFfogn/dK1mfy/QRnmOVmjfKgT09hGiXX2fqV7FUq7G3UxPUx92hWu
        LjjGTdd/10qXZGsUdoXalLzgDw==
X-Google-Smtp-Source: ACcGV6326wBameac7xn3xrkwGcsPTpVi/PE01AnqMgBjYf08ktqrqIrtq6mPM2GKo0VTsB5CKSR7XQ==
X-Received: by 2002:a62:5103:: with SMTP id f3-v6mr25797667pfb.107.1539771237770;
        Wed, 17 Oct 2018 03:13:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g87-v6sm15819023pfj.34.2018.10.17.03.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 03:13:56 -0700 (PDT)
Date:   Wed, 17 Oct 2018 03:13:55 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Message-ID: <20181017101355.GA230639@joelaf.mtv.corp.google.com>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Tue, Oct 16, 2018 at 10:02:53AM -0700, Kees Cook wrote:
> On Tue, Oct 16, 2018 at 8:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 16 Oct 2018 17:08:25 +0530
> > Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> >> One more thing is for pstore dmesg-ramoops, I had to change
> >> late_initcall to postcore_initcall which brings the question as to why
> >> we changed to late_initcall?
> >> Simple git blame shows to support crypto compress api, but is it really
> >> helpful? A lot of boottime issues can be caught with pstore enabled at
> >> postcore_initcall rather than late_initcall, this backtrace
> >> is just one example. Is there any way we could change this?
> >
> > Does it break if the crypto is not initialized? Perhaps add a command
> > line flag to have it happen earlier:
> >
> >  ramoops=earlyinit
> >
> > and add a postcore_initcall that checks if that flag is set, and if so,
> > it does the work then, and the late_initcall() will do nothing.
> >
> > That way, you can still have unmodified kernels use pstore when it
> > crashes at boot up.
> 
> Even better, if we could find a way to make it work with a late
> initialization of compression (i.e. postcore_initcall() by default
> means anything caught would be uncompressed, but anything after
> late_initcall() would be compressed). I'd be very happy to review
> patches for that!

What do you think about the (untested) patch below? It seems to me that it
should solve the issue of missing early crash dumps, but I have not tested it
yet. Sai, would you mind trying it out and let me know if you can see the
early crash dumps properly now?

----8<---
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC] pstore: allocate compression during late_initcall

ramoop's pstore registration (using pstore_register) has to run during
late_initcall because crypto backend may not be ready during
postcore_initcall. This causes missing of dmesg crash dumps which could
have been caught by pstore.

Instead, lets allow ramoops pstore registration earlier, and once crypto
is ready we can initialize the compression.

Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/platform.c | 13 +++++++++++++
 fs/pstore/ram.c      |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 15e99d5a681d..f09066db2d4d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -780,6 +780,19 @@ void __init pstore_choose_compression(void)
 	}
 }
 
+static int __init pstore_compression_late_init(void)
+{
+	/*
+	 * Check if any pstore backends registered earlier but did not allocate
+	 * for compression because crypto was not ready, if so then initialize
+	 * compression.
+	 */
+	if (psinfo && !tfm)
+		allocate_buf_for_compression();
+	return 0;
+}
+late_initcall(pstore_compression_late_init);
+
 module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "Pstore compression to use");
 
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bbd1e357c23d..98e48d1a9776 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -940,7 +940,7 @@ static int __init ramoops_init(void)
 	ramoops_register_dummy();
 	return platform_driver_register(&ramoops_driver);
 }
-late_initcall(ramoops_init);
+postcore_initcall(ramoops_init);
 
 static void __exit ramoops_exit(void)
 {
-- 
2.19.1.331.ge82ca0e54c-goog

