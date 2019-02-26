Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B65C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77EA217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551156134;
	bh=0J4V7itq+DRpqfvf3JElH4LSeJqHQWShzM2xVMGz5NI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CxTxV8ZClCX/ebzTwRUBgmvNKZ2fQCMx3LfQxu6Fwxx0bDO8RBpT9PwTOR4j+6G0j
	 zCORjox3HZgPje1mfDZIKGzyuh+sOgRVK/VTj9RB1xGBVek7AbvL9Su75FykE9dicC
	 QWsmx621VFh7C/AhqauDF7FzsV5oXNRoXmgW+3oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfBZEmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:42:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39696 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfBZEmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 23:42:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id p27so9586833edc.6;
        Mon, 25 Feb 2019 20:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuQlt9L8qlW7r7nNzDBXWdjkl9tQ/HGk4NOC4kHPowQ=;
        b=JCcc2ca7QSjjq7BB8x/OFlcOGzHHbvsfnd8PmTgnfkmnKxj25p6APC+d3sQlkD6LWy
         uJt7pEtTk4yN0IA3QNg4m7plujlF1ncbEVqqfTbQm378i2S79hXwn1TBrMya2xWwT1sP
         EBFdpNkibqLD+fjX2SxChs4fueXUcHDw0kuSCPwMZsgemno1U2XtlGu0A7cyiu02F1JS
         MuAQ70vC5jwIY69sb/MsTcRD0B9j2Kju8j+/sPR4Ze8ZMeDylxqI0Hg4GTMIsZnDeTjq
         9f9XELoOmyHgFd7U1EWcyxyz78Rs8gDvAxJ0Fc79bq0Dw8ZL8CBjhiHGgmCytq+cWmjh
         MZIA==
X-Gm-Message-State: AHQUAuYtY5LPx748zO1PM3bvzYcW45rboA/Plt4JE4Yttvd/rll12Qt+
        MmsV5wW9Ge+XhIaxIsZWjU93Nb3Drn7ECjd5Q5E=
X-Google-Smtp-Source: AHgI3Iaammfhw2TPkQh/Vjye8gcRDiDw+EmTP98RiuGtWUe6HgbpaBGUkOS02/aEHQNj2z6uERSG+eBc8y98WxBeNnk=
X-Received: by 2002:a50:91d6:: with SMTP id h22mr269654eda.296.1551156130365;
 Mon, 25 Feb 2019 20:42:10 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
 <20190220110200.GD17969@hirez.programming.kicks-ass.net> <CAJvTdKnpOdDiCaW9ntkNof+Ji7+HPaQqEk=ou-hWnw-BJxMGTQ@mail.gmail.com>
In-Reply-To: <CAJvTdKnpOdDiCaW9ntkNof+Ji7+HPaQqEk=ou-hWnw-BJxMGTQ@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 25 Feb 2019 23:41:58 -0500
Message-ID: <CAJvTdKnCSPzpr7NqqaKLTaBc5LuXjd0mwR7WhEkUK=pPuzTGaA@mail.gmail.com>
Subject: Re: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:44 AM Len Brown <lenb@kernel.org> wrote:
>
> On Wed, Feb 20, 2019 at 6:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > >       list_for_each_entry(rp, &rapl_packages, plist) {
> > > @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
> > >  /* called from CPU hotplug notifier, hotplug lock held */
> > >  static struct rapl_package *rapl_add_package(int cpu)
> > >  {
> > > -     int id = topology_physical_package_id(cpu);
> > > +     int id = topology_unique_die_id(cpu);
> > >       struct rapl_package *rp;
> > >       int ret;
> >
> > And now your new function names are misnomers.
>
> That is fair.
>
> Seems that a subsequent re-name-only patch is appropriate.

I'm not sure that re-naming these functions is a good idea.

Fundamentally, the reason stems from the SDM being in-consistent.
And the reason that the SDM is inconsistent is for compatibility.

ie. the PACKAGE MSRs in the SDM are still called PACKAGE MSRs,
even though on a multi-die system, they are DIE scoped.
There is no plan to re-name all of those MSRs.

And so what do you call a routine that parses a PACKAGE_RAPL domain?
Well, it is still called PACKAGE MSR, even though the code is smart enough
to know that on a multi-die system, its scope is die-scoped, not package-scoped.

And yes, just to confuse things, there WILL be PACKAGE scope MSRs
in the future that span multiple die on multi-die systems.  No, it will not
be a surprise when they appear -- by definition, they will be different
and incompatible with previous PACKAGE MSRs.  We will need to update
some software to be smart about handling them -- no blind assumptions
on using the word "package" in this context.

So unless Rui disagrees, I'm inclined to leave these routine names alone.

thanks,
Len Brown, Intel Open Source Technology Center
