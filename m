Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D66C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB8B21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfA1Nf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:35:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1Nf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:35:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7F9A8666E;
        Mon, 28 Jan 2019 13:35:57 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76AEC1852C;
        Mon, 28 Jan 2019 13:35:56 +0000 (UTC)
Date:   Mon, 28 Jan 2019 14:35:54 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joe Mario <jmario@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: cpu/hotplug: broken sibling thread hotplug
Message-ID: <20190128143554.4e043691@redhat.com>
In-Reply-To: <20190128125252.6xf4bulvd7ni4mi4@treble>
References: <20190124165713.2b0b37ed@redhat.com>
        <20190125163657.rqbykfn7ebpclc2z@treble>
        <20190125170203.2o2l27d2sytw44nl@treble>
        <20190128111304.0df37a8a@redhat.com>
        <20190128125252.6xf4bulvd7ni4mi4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 28 Jan 2019 13:35:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 06:52:52 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Jan 28, 2019 at 11:13:04AM +0100, Igor Mammedov wrote:
> > On Fri, 25 Jan 2019 11:02:03 -0600
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >   
> > > On Fri, Jan 25, 2019 at 10:36:57AM -0600, Josh Poimboeuf wrote:  
> > > > How about this patch?  It's just a revert of 73d5e2b47264 and
> > > > bc2d8d262cba, plus the 1-line vmx_vm_init() change.  If it looks ok to
> > > > you, I can clean it up and submit an official version.    
> > > 
> > > This one actually compiles...  
> > 
> > Looks good to me,
> > (one small question below)
> > 
> >  
> > [...]  
> > >  static inline bool cpu_smt_allowed(unsigned int cpu)
> > >  {
> > > -	if (topology_is_primary_thread(cpu))
> > > +	if (cpu_smt_control == CPU_SMT_ENABLED)
> > >  		return true;
> > >  
> > > -	/*
> > > -	 * If the CPU is not a 'primary' thread and the booted_once bit is
> > > -	 * set then the processor has SMT support. Store this information
> > > -	 * for the late check of SMT support in cpu_smt_check_topology().
> > > -	 */
> > > -	if (per_cpu(cpuhp_state, cpu).booted_once)
> > > -		cpu_smt_available = true;
> > > -
> > > -	if (cpu_smt_control == CPU_SMT_ENABLED)
> > > +	if (topology_is_primary_thread(cpu))
> > >  		return true;  
> > why did you swap cpu_smt_control and topology_is_primary_thread checks?  
> 
> That's just the revert of bc2d8d262cba5.
ok. waiting for formal patch
pls, CC kvm@vger.kernel.org so Paolo could have a chance to review
(pick it up if Thomas is ok with approach) 

