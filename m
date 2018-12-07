Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10171C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C33208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C33208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbeLGJdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:33:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54344 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeLGJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:33:11 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gVCVN-0003n7-N1; Fri, 07 Dec 2018 10:33:05 +0100
Date:   Fri, 7 Dec 2018 10:33:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/2] x86/speculation: switch_to_cond_stibp on is the
 likely case
In-Reply-To: <20181207085209.GB2237@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1812071032270.3743@nanos.tec.linutronix.de>
References: <1544039368-9009-1-git-send-email-longman@redhat.com> <1544039368-9009-2-git-send-email-longman@redhat.com> <20181206084141.GA13538@hirez.programming.kicks-ass.net> <3732de84-a14f-e32a-61de-29c5965dd405@redhat.com>
 <20181207085209.GB2237@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1747069377-1544175185=:3743"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1747069377-1544175185=:3743
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 7 Dec 2018, Peter Zijlstra wrote:
> On Thu, Dec 06, 2018 at 10:38:00AM -0500, Waiman Long wrote:
> > On 12/06/2018 03:41 AM, Peter Zijlstra wrote:
> > > On Wed, Dec 05, 2018 at 02:49:28PM -0500, Waiman Long wrote:
> > >> Since conditional STIBP is the default, it should be treated as
> > >> the likely case. Changes the use of static_branch_unlikely() to
> > >> static_branch_likely() for switch_to_cond_stibp.
> > > So now you're making kernels on 'fixed' or unaffected hardware slower.
> > 
> > Good point.
> > 
> > The reason I sent out this patch is because of the inconsistency in the
> > use of likely/unlikely hints.
> > 
> > arch/x86/kernel/cpu/bugs.c:156:        if
> > (static_branch_unlikely(&switch_to_cond_stibp))
> > arch/x86/kernel/process.c:440:       
> > static_branch_unlikely(&switch_to_cond_stibp)) {
> > arch/x86/kernel/process.h:26:        if
> > (!static_branch_likely(&switch_to_cond_stibp)) {
> > 
> > So if we are aiming to optimize for "fixed" or unaffected hardware,
> > maybe we should modify the likely hint to unlikely then.
> 
> Right, I think that makes sense, Thomas?

Yeah, I probably got that wrong in some places. Let me look.

Thanks,

	Thomas

--8323329-1747069377-1544175185=:3743--
