Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550FEECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AC62148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AC62148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeJTDUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:20:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeJTDUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:20:32 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDaCW-0004t8-Sb; Fri, 19 Oct 2018 21:12:49 +0200
Date:   Fri, 19 Oct 2018 21:12:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 07/13] x86/process Add arch_set_dumpable
In-Reply-To: <c8bb3ea2-d060-5cad-1544-ae5ff5f8fd3b@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810192100130.1651@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <6c8538c428d6335efae926c1e6a6fd26a3f9a1b8.1539798901.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1810181522230.1647@nanos.tec.linutronix.de>
 <c8bb3ea2-d060-5cad-1544-ae5ff5f8fd3b@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Tim Chen wrote:
> On 10/18/2018 06:28 AM, Thomas Gleixner wrote:
> > 
> > So now the obvious question. set_dumpable() operates on tsk->mm. i.e. it's
> > a process wide operation. But arch_set_dumpable() operates on the task
> > itself. What about the other tasks of that process?
> 
> I missed this part.
> 
> Fixing this is tricky as I don't see an easy way to
> reverse map mm back to all tasks that use the same mm
> to update their STIBP flags.

task is known and handed in to the function. So why do you want to reverse
map mm?

for_each_thread(task, ...) is what you want. The only thing to verify is
whether you can lock the tasks sighand lock there. And then it's enough to
set/clear the TIF bit and let it take effect at the next context switch.

Thanks,

	tglx




