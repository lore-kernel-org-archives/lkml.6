Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91525C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F14220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFazb3c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F14220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbeKGKiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:38:04 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44247 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeKGKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:38:04 -0500
Received: by mail-ua1-f65.google.com with SMTP id d19so3998509uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=;
        b=eFazb3c7zMawmEuLNjfsk/It40P/kZA634ojboNSO3So2qlyJ29LyFhO0/QW48NaB8
         kbrri3Yn351FGwvXfSV9Lfr6DEeUttVtBJgkrVmcocs0A5GwSrzSsyI2B3buzW3FuyJ/
         hyabXtsc8ANcHIyckTZ0GHWNuBf8WD4smIyJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=;
        b=JmYMxUEEg6zY6OaUK8/YDeu6cxccvjazcEgRjjWEjH+ayMoviF1DmImadrfUUZnJXh
         ZymURmSxz3JUMSkQWCdzjz6VSGWfeGEOmE8CU+CtVvI655+wk+K8PL6qzQcNdFbJgiZx
         qyVAS3nkbAK/jvlg+PkiMkCyASJHId1X8CI+RXzF+24YrklzK/AiAT26RjM2O/dN8Fq0
         TsM50B3eGnyTBg+/sGuCtsNdYYMQek3XW8LF3YhQh7hyQhlqDEDHC8LjDczeJ0D/Ma6I
         4vmMVclN4GM4bumYQUsVY7Tig8s7f8nojLng7AOP13BX1JEtGRxVwiaNnMfTkixL/SQC
         wuVg==
X-Gm-Message-State: AGRZ1gKuweKmwPtHjG6NlomXEbZAIQ/KwMFossjA15HDQwX19v3O0BL+
        bQh2IUalOWaKsw/YZ99r74sP6XKYoxk=
X-Google-Smtp-Source: AJdET5fqPy/UkXWQf+FhgGvs9dk91EI5uj3F7Yh89klpeNEhOERTarrIIgU4lk7aA93AHHI/0pHlYg==
X-Received: by 2002:ab0:26cb:: with SMTP id b11mr12305804uap.112.1541553000386;
        Tue, 06 Nov 2018 17:10:00 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id o19sm637109vkd.14.2018.11.06.17.10.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 17:10:00 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id x3so5271628ual.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:10:00 -0800 (PST)
X-Received: by 2002:a9f:386c:: with SMTP id q41mr3848271uad.27.1541552692505;
 Tue, 06 Nov 2018 17:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org> <20181031184050.sd5opni3mznaapkv@holly.lan>
 <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com> <20181103104503.eftn5btx7otgufro@holly.lan>
In-Reply-To: <20181103104503.eftn5btx7otgufro@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Nov 2018 17:04:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XbSm48ttzXvvhTir9ViKA9T7Huiho3CNuzprqAVpHyJg@mail.gmail.com>
Message-ID: <CAD=FV=XbSm48ttzXvvhTir9ViKA9T7Huiho3CNuzprqAVpHyJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     Daniel Thompson <daniel.thompson@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 3, 2018 at 3:45 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Oct 31, 2018 at 02:41:14PM -0700, Doug Anderson wrote:
> > > As mentioned in another part of the thread we can also add robustness
> > > by skipping a cpu where csd->flags != 0 (and adding an appropriately
> > > large comment regarding why). Doing the check directly is abusing
> > > internal knowledge that smp.c normally keeps to itself so an accessor
> > > of some kind would be needed.
> >
> > Sure.  I could add smp_async_func_finished() that just looked like:
> >
> > int smp_async_func_finished(call_single_data_t *csd)
> > {
> >   return !(csd->flags & CSD_FLAG_LOCK);
> > }
> >
> > My understanding of all the mutual exclusion / memory barrier concepts
> > employed by smp.c is pretty weak, though.  I'm hoping that it's safe
> > to just access the structure and check the bit directly.
> >
> > ...but do you think adding a generic accessor like this is better than
> > just keeping track of this in kgdb directly?  I could avoid the
> > accessor by adding a "rounding_up" member to "struct
> > debuggerinfo_struct" and doing something like this in roundup:
> >
> >   /* If it didn't round up last time, don't try again */
> >   if (kgdb_info[cpu].rounding_up)
> >     continue
> >
> >   kgdb_info[cpu].rounding_up = true
> >   smp_call_function_single_async(cpu, csd);
> >
> > ...and then in kgdb_nmicallback() I could just add:
> >
> >   kgdb_info[cpu].rounding_up = false
> >
> > In that case we're not adding a generic accessor to smp.c that most
> > people should never use.
>
> Whilst it is very tempting to make a sarcastic reply here ("Of course! What
> kgdb really needs is yet another set of condition variables") I can't
> because I actually agree with the proposal. I don't really want kgdb to
> be too "special" especially when it doesn't need to be.
>
> Only thing to note is that rounding_up will not be manipulated within a
> common spin lock so you might have to invest a bit of thought to make
> sure any races between the master and slave as the slave CPU clears the
> flag are benign.

OK, so I've hopefully got all this thought through and posted v3.
I've put most of my thoughts in the patch descriptions themselves so
let's continue the discussion there.

-Doug
