Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E411C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA042175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfBES7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:59:18 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:39052 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfBES7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:59:18 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-69-76-nat.elisa-mobile.fi [85.76.69.76])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 985E730150;
        Tue,  5 Feb 2019 20:59:14 +0200 (EET)
Date:   Tue, 5 Feb 2019 20:59:14 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tom Li <tomli@tomli.me>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Cc:     ak@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-mips@vger.kernel.org
Subject: Re: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API
 in terms of RCU for Tree RCU PREEMPT builds")
Message-ID: <20190205185914.GB16356@darkstar.musicnaut.iki.fi>
References: <20181113135453.GW9144@intel.com>
 <20181113151037.GG4170@linux.ibm.com>
 <20181114202013.GA27603@linux.ibm.com>
 <20181126220122.GA6345@linux.ibm.com>
 <20190205050700.GA31571@localhost.localdomain>
 <20190205095809.GA16356@darkstar.musicnaut.iki.fi>
 <20190205130559.GA12858@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205130559.GA12858@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 05, 2019 at 09:05:59PM +0800, Tom Li wrote:
> On Tue, Feb 05, 2019 at 11:58:09AM +0200, Aaro Koskinen wrote:
> > Can you try below fix? It works on my Loongson.
> 
> Hello Aaro, thanks for your response. But in case you've missed
> the original thread, please check it at:
> 
> https://lkml.org/lkml/2018/11/13/857

OK, thanks. This looks slightly different from the Loongson problem:

- In Loongson, we don't get stuck in RCU, but in
  cpufreq_dbs_governor_stop -> irq_work_sync(). 

- I run non-preemptible kernel, and my system still gets stuck.

What is common is that it's UP with i8259 PIC.

> My problem is NOT about how to fix the problem on Loongson (or
> x86): the patch in the original thread (only has one-line-of-code,
> simply changes timing of cpufreq_core_init), or your patch, is
> indeed working. But they are workarounds, the real issue is the race
> condition in cpufreq.

Looking at irq_work_sync(), I cannot think how it could work on UP
machine with interrupts disabled.

A.
