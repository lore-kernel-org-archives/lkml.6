Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0B0C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328792084C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHB0y0Ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328792084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeKCT4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:56:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35040 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeKCT4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:56:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id q12-v6so3844777wmq.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YmQq90FRkqBQp0/v6HvhwKCbNPsiefsFk4oklN2EcKs=;
        b=MHB0y0YaXByvjwLMoonMq5QIjx9CsU+rAU+j5poaVTafUlBxWYiuUEF8m8kd6fUby4
         QmIDj233bXRVK/YHOYnKiwKvCqqeDu+b+pcNNyGTzoUDVA4Y5GFMOGiovxZt7wz4jmyt
         xJjWXL3cZPHkutGq/DuKCnwo4rBDuc8nFlcaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YmQq90FRkqBQp0/v6HvhwKCbNPsiefsFk4oklN2EcKs=;
        b=swtXKW26EaT/AsaStrUW2UZMu3sWl8iO4Wd9aSnRselvIEluZmVoHw2S/FO86rRf7g
         Bs/kBglGz5B0HWaKiLk9RrMTkUAj5xGPKjzHHFtk1STDpKWHMNLLPYKMqvaQiGIIEB+n
         bFBSHzZdEORD+IGNxxt8NrQZpmdeSrgr2ZHh3ALOqVxhqwmytXx7Xwpao42g7fL0Hju7
         /3DCtWKQWbuhpb82dZtPWZ+33rY3H2CeNa+R+xEtNDpZLGXua67pNsIt8EuZypqKGtFQ
         0O723bq44iaCuiDFcQoygzTh7OS/C0TWhoRcMi1j7zZKCzbk6NxaMSvVg/J/6bptXLpl
         6HYw==
X-Gm-Message-State: AGRZ1gI5va3c8h4jZOfJx7dYF9S9pPu0Ya9rkpftUZo4G+CEi/fRTX88
        dC/ise5uhITPxE82v3FGa6WzJQ==
X-Google-Smtp-Source: AJdET5ffk8gt8qQ1YuVWXJvRkvWY6hwLLFRlaE0/rLpCJJIwLmN6I0KvCp4FDHXIC/Svzn3L0Yykkg==
X-Received: by 2002:a1c:2283:: with SMTP id i125-v6mr601230wmi.42.1541241914508;
        Sat, 03 Nov 2018 03:45:14 -0700 (PDT)
Received: from holly.lan (82-132-212-57.dab.02.net. [82.132.212.57])
        by smtp.gmail.com with ESMTPSA id o9-v6sm44092322wra.42.2018.11.03.03.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 03:45:13 -0700 (PDT)
Date:   Sat, 3 Nov 2018 10:45:03 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, dalias@libc.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>, paulus@samba.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com,
        LKML <linux-kernel@vger.kernel.org>, rkuo@codeaurora.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181103104503.eftn5btx7otgufro@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031184050.sd5opni3mznaapkv@holly.lan>
 <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:41:14PM -0700, Doug Anderson wrote:
> > As mentioned in another part of the thread we can also add robustness
> > by skipping a cpu where csd->flags != 0 (and adding an appropriately
> > large comment regarding why). Doing the check directly is abusing
> > internal knowledge that smp.c normally keeps to itself so an accessor
> > of some kind would be needed.
> 
> Sure.  I could add smp_async_func_finished() that just looked like:
> 
> int smp_async_func_finished(call_single_data_t *csd)
> {
>   return !(csd->flags & CSD_FLAG_LOCK);
> }
> 
> My understanding of all the mutual exclusion / memory barrier concepts
> employed by smp.c is pretty weak, though.  I'm hoping that it's safe
> to just access the structure and check the bit directly.
> 
> ...but do you think adding a generic accessor like this is better than
> just keeping track of this in kgdb directly?  I could avoid the
> accessor by adding a "rounding_up" member to "struct
> debuggerinfo_struct" and doing something like this in roundup:
> 
>   /* If it didn't round up last time, don't try again */
>   if (kgdb_info[cpu].rounding_up)
>     continue
> 
>   kgdb_info[cpu].rounding_up = true
>   smp_call_function_single_async(cpu, csd);
> 
> ...and then in kgdb_nmicallback() I could just add:
> 
>   kgdb_info[cpu].rounding_up = false
> 
> In that case we're not adding a generic accessor to smp.c that most
> people should never use.

Whilst it is very tempting to make a sarcastic reply here ("Of course! What
kgdb really needs is yet another set of condition variables") I can't
because I actually agree with the proposal. I don't really want kgdb to
be too "special" especially when it doesn't need to be.

Only thing to note is that rounding_up will not be manipulated within a
common spin lock so you might have to invest a bit of thought to make
sure any races between the master and slave as the slave CPU clears the
flag are benign.


Daniel.
