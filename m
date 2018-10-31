Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02714C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA46320830
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcTmkgLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA46320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeKACAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:00:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45907 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbeKACAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:00:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so17277207wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7PRsslQ+AmlGw6ESJEAEIN3Ju+lMTMOAAXzG79p0Hk=;
        b=LcTmkgLaTJl5aqBKxMqvydqj6P3/DffuXvVPbAUygeibeDLzwTIQqXfR4uds2rIZYM
         XhmMGb7KngDWan146d22FCM9UQ9Ko/QDf54C0Fdt16LXoigKyLTLkNkKnhAaTuALlKv5
         25xBM+L683GMsxPWlmbZaDfh6fxO/3dRfQFIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7PRsslQ+AmlGw6ESJEAEIN3Ju+lMTMOAAXzG79p0Hk=;
        b=o/6enO7Z6F+wj+HEpqgMFLv8SdUHXyDc3wxpKlzIFAYK+/nQ/npgcv9QYpRahGX3om
         zVcW1v0jdIx7/9syDtVCtBvBe0qRFrnJ0hQx47Tf5eDBdpvd3hR2WjE3cqfRs8VZfesd
         sbvK4YEHhJCrn+8QRw+bxTd35UD1cvlRN0JCMinIfdwT+WwpRrrKiUIa5qdeda8T4DTa
         l++wpX/iGZZHVVFRC7NF++OKyn14BLwLju8QPpK0f1uv1Ge8U+vzJNZ/LDFOvBQXsdkh
         P4u9NVc928RHLbKW2FpzAOxBBkx3sn+IsopvusDiuqE8dvHh/5UN2oWV9r6tT8dgCB/6
         DBOQ==
X-Gm-Message-State: AGRZ1gJvOa6XBBsmYoku7Ztd8bJ1qM0w3GubdXKfGC75EnNirB3neblj
        J44QM72+se8caj2S5qEP8dNL9w==
X-Google-Smtp-Source: AJdET5fF9/fl4K36p+e42OouXFrTlfI2G2yyDuiZgaKxA4I7kOc22/Zb6DjVFjwUnDDuT1saAKtLCQ==
X-Received: by 2002:adf:aa05:: with SMTP id p5-v6mr3828856wrd.56.1541005300354;
        Wed, 31 Oct 2018 10:01:40 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t77-v6sm39633264wme.18.2018.10.31.10.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 10:01:39 -0700 (PDT)
Date:   Wed, 31 Oct 2018 17:01:36 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Rich Felker <dalias@libc.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181031170136.s3ids6tm4rxxlpma@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031134926.GB13237@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031134926.GB13237@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:49:26PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> > Looking closely at it, it seems like a really bad idea to be calling
> > local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> > like it could violate spinlock semantics and cause a deadlock.
> > 
> > Instead, let's use a private csd alongside
> > smp_call_function_single_async() to round up the other CPUs.  Using
> > smp_call_function_single_async() doesn't require interrupts to be
> > enabled so we can remove the offending bit of code.
> 
> You might want to mention that the only reason this isn't a deadlock
> itself is because there is a timeout on waiting for the slaves to
> check-in.

dbg_master_lock must be owned to call kgdb_roundup_cpus() so
the calls to smp_call_function_single_async() should never deadlock the
calling CPU unless there has been a previous failure to round up (e.g.
cores that cannot react to the round up signal).

When there is a failure to round up when we resume, there is a window (before
whatever locks that prevented the IPI being serviced are released) during which
the system will deadlock if the debugger is re entered.

I don't think there is any point trying to round up a CPU that did not
previously respond... it should still have an IPI pending. The deadlock
can be eliminated by getting the round up code to avoid CPUs whose csd->flags
are non-zero either by checking the flag in the kgdb code or adding something
like smp_trycall_function_single_async().


Daniel.
