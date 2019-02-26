Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1780E213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfBZGzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:55:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:36819 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfBZGzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:55:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 22:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="141670234"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.193.24])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2019 22:55:32 -0800
Message-ID: <1551164131.1900.50.camel@intel.com>
Subject: Re: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
From:   Zhang Rui <rui.zhang@intel.com>
To:     Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Tue, 26 Feb 2019 14:55:31 +0800
In-Reply-To: <CAJvTdKnCSPzpr7NqqaKLTaBc5LuXjd0mwR7WhEkUK=pPuzTGaA@mail.gmail.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
         <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
         <20190220110200.GD17969@hirez.programming.kicks-ass.net>
         <CAJvTdKnpOdDiCaW9ntkNof+Ji7+HPaQqEk=ou-hWnw-BJxMGTQ@mail.gmail.com>
         <CAJvTdKnCSPzpr7NqqaKLTaBc5LuXjd0mwR7WhEkUK=pPuzTGaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2019-02-25 at 23:41 -0500, Len Brown wrote:
> On Thu, Feb 21, 2019 at 12:44 AM Len Brown <lenb@kernel.org> wrote:
> > 
> > 
> > On Wed, Feb 20, 2019 at 6:02 AM Peter Zijlstra <peterz@infradead.or
> > g> wrote:
> > 
> > > 
> > > > 
> > > >       list_for_each_entry(rp, &rapl_packages, plist) {
> > > > @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct
> > > > rapl_package *rp)
> > > >  /* called from CPU hotplug notifier, hotplug lock held */
> > > >  static struct rapl_package *rapl_add_package(int cpu)
> > > >  {
> > > > -     int id = topology_physical_package_id(cpu);
> > > > +     int id = topology_unique_die_id(cpu);
> > > >       struct rapl_package *rp;
> > > >       int ret;
> > > And now your new function names are misnomers.
> > That is fair.
> > 
> > Seems that a subsequent re-name-only patch is appropriate.
> I'm not sure that re-naming these functions is a good idea.
> 
> Fundamentally, the reason stems from the SDM being in-consistent.
> And the reason that the SDM is inconsistent is for compatibility.
> 
> ie. the PACKAGE MSRs in the SDM are still called PACKAGE MSRs,
> even though on a multi-die system, they are DIE scoped.
> There is no plan to re-name all of those MSRs.
> 
> And so what do you call a routine that parses a PACKAGE_RAPL domain?
> Well, it is still called PACKAGE MSR, even though the code is smart
> enough
> to know that on a multi-die system, its scope is die-scoped, not
> package-scoped.
> 
Agreed.

rapl_add_package() actually adds a package RAPL domain, and "package
RAPL domain" comes from SDM, which is used to describe the RAPL domain
that uses the package MSRs.

IMO, we can keep using "package RAPL domain" as the name of this
certain kind of RAPL domains, but just stop aligning it with the cpu
physical package.
Actually, my next patch fixes the places that had this assumption.
In short, "package domain foo" is okay, but "domain for package X"
should be avoided.

thanks,
rui

> And yes, just to confuse things, there WILL be PACKAGE scope MSRs
> in the future that span multiple die on multi-die systems.  No, it
> will not
> be a surprise when they appear -- by definition, they will be
> different
> and incompatible with previous PACKAGE MSRs.  We will need to update
> some software to be smart about handling them -- no blind assumptions
> on using the word "package" in this context.
> 
> So unless Rui disagrees, I'm inclined to leave these routine names
> alone.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
