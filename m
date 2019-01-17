Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D8120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAQO6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:58:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:41068 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQO6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:58:23 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0HEqabh031907;
        Thu, 17 Jan 2019 08:52:36 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x0HEqYcN031906;
        Thu, 17 Jan 2019 08:52:34 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 17 Jan 2019 08:52:33 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
        Torsten Duwe <duwe@lst.de>, live-patching@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190117145233.GQ14180@gate.crashing.org>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com> <20190112010914.GB10427@350D> <20190112084541.GK14180@gate.crashing.org> <20190113123356.GA26056@350D>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113123356.GA26056@350D>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 11:33:56PM +1100, Balbir Singh wrote:
> On Sat, Jan 12, 2019 at 02:45:41AM -0600, Segher Boessenkool wrote:
> > On Sat, Jan 12, 2019 at 12:09:14PM +1100, Balbir Singh wrote:
> > > Could you please define interesting frame on top a bit more? Usually
> > > the topmost return address is in LR
> > 
> > There is no reliable way (other than DWARF unwind info) to find out where
> > the value of LR at function entry currently lives (if anywhere). It may or
> > may not be still available in LR, it may or may not be saved to the return
> > stack slot.  It can also live in some GPR, or in some other stack slot.
> > 
> > (The same is true for all other registers).
> > 
> > The only thing the ABI guarantees you is that you can find all stack frames
> > via the back chain.  If you want more you can use some heuristics and do
> > some heroics (like GDB does), but this is not fully reliable.  Using DWARF
> > unwind info is, but that requires big tables.
> >
> 
> Thanks, so are you suggesting that a reliable stack is not possible on
> ppc64le? Even with the restricted scope of the kernel?

It depends on what you mean with "reliable stack unwinder".  You can unwind
the stack reliably on Power, but you want more, you want to know where some
state local to functions is kept on the stack.


Segher
