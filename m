Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA4CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 06:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7F8206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 06:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544856634;
	bh=hcjGhDXo8HTX/r5g4t9PxkeLsrHvsVTtARGUpazXx+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x+wkj49FsolK9xawnemATD8U7xOUg57s1wHYW3KekGsUiqKujAeiOMnTCuptFH3VQ
	 dKJz6RgaIAvj9jumyyRfwNf90LEEGT/915/oC3JD0T15g+JYXty1kcTG7e7JV+6ApB
	 AELdmxnRGWF29sGmW/bHVDiBtK/dGwGDKZ72yrKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbeLOGud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 01:50:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53045 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbeLOGud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 01:50:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so7597726wml.2;
        Fri, 14 Dec 2018 22:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcjGhDXo8HTX/r5g4t9PxkeLsrHvsVTtARGUpazXx+0=;
        b=RL/7NtQqiJTGSuPjv4MuU8YuxybWQ20+xRr+QaaytYDxRf8w8yP/Qa1wqvxiyGbCfd
         8pPUHrd4955Rv2b4CBIvpuSGgtFuJW8PFwBofnzKRtjeEIAJ3x+cTafI7Kiwf8iWitPs
         JIy+wxwwBSXpgHKs0l3hkF/8m/hCIRFnHkXujg2dGkRSqY06Hhs+NPGcwn4y2dShApo8
         zMPmvmlFNf9dPEwzEmvZgI318I2TQm1chCojn8b1GVq1i3U+XtoYF6CzRt9Wu5ptJgmc
         iF49iPKs3woTMGb0/Qlcf+WHW3AeX+IZAmFkr1KQcRfO8EX9/PvbLu8uBmJDy5lPdEZB
         IAZA==
X-Gm-Message-State: AA+aEWbexFDJPne3NoXwp6w7muN8/UUMenejryK6jQ4O2twoSuu9s11S
        4nlaazSNBmebBo5b/lbhIdakRWlEWTwZp/VslNA=
X-Google-Smtp-Source: AFSGD/W6ywc63dYfasAlh5FbSW6C9+r8RTeoVOXkue1nQP2dH81YSzqI7q9dfCjYL/8mkb4ML8AAY38orvRrBgPBwOQ=
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr5255648wmb.30.1544856631117;
 Fri, 14 Dec 2018 22:50:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
 <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
 <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org> <1544808561.10497.15.camel@kernel.org>
In-Reply-To: <1544808561.10497.15.camel@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 15 Dec 2018 15:50:18 +0900
Message-ID: <CAM9d7ciW3cHVFLeuP+pdC-+1fnGMkRnfwGsbeKX_Zj30f-r4hA@mail.gmail.com>
Subject: Re: [PATCH v8 20/22] tracing: Use hist trigger's var_ref array to
 destroy var_refs
To:     zanussi@kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, vedang.patel@intel.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        julia@ni.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom and Masami,

On Sat, Dec 15, 2018 at 2:29 AM Tom Zanussi <zanussi@kernel.org> wrote:
>
> Hi Masami,
>
> On Sat, 2018-12-15 at 01:31 +0900, Masami Hiramatsu wrote:
> > On Mon, 10 Dec 2018 18:01:34 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> >
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > >
> > > Since every var ref for a trigger has an entry in the var_ref[]
> > > array,
> > > use that to destroy the var_refs, instead of piecemeal via the
> > > field
> > > expressions.
> > >
> > > This allows us to avoid having to keep and treat differently
> > > separate
> > > lists for the action-related references, which future patches will
> > > remove.
> >
> > I'm not so sure, but this seems a bugfix... if so, please move this
> > at
> > the top of this series.
> >
>
> No, none of these are bugfixes - patches 17-22 are just some additional
> cleanup that try to make the code easier to follow after Namhyung's
> comments that things were confusing here.
>
> Actually, what I should probably do is make these a separate series..

Agreed, I also think it's getting bigger and having these cleanups
before the actual change would make things little bit easier IMHO.

Thanks,
Namhyung
