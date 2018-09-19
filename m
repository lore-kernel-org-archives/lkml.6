Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2247CECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0F3214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0F3214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbeISVM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:12:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:43389 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbeISVM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:12:27 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8JEWjVu029929;
        Wed, 19 Sep 2018 09:32:46 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w8JEWhug029928;
        Wed, 19 Sep 2018 09:32:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 19 Sep 2018 09:32:43 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/32: add stack protector support
Message-ID: <20180919143243.GY23155@gate.crashing.org>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr> <ef8fcc7933d56db6f5f7251cb982ca7131f7408d.1537355312.git.christophe.leroy@c-s.fr> <20180919132618.GX23155@gate.crashing.org> <3f5d1937-393c-1105-30a0-72d568a1c190@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f5d1937-393c-1105-30a0-72d568a1c190@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 04:22:52PM +0200, Christophe LEROY wrote:
> >It looks like it will be easy to enable on 64 bit as well.
> 
> Will it ? It seems that PPC64 doesn't have r2 pointing to current task 
> struct, but instead it has r13 pointing to the paca struct. Which means 
> we should add a canary in the paca struct, and populate it at task 
> switch from current->stack_canary. Or am I missing something ?

No, I am just forgetting things :-)

> >>+	/* Try to get a semi random initial value. */
> >>+	get_random_bytes(&canary, sizeof(canary));
> >>+	canary ^= mftb();
> >>+	canary ^= LINUX_VERSION_CODE;
> >
> >These last two lines are useless (or worse, they may give people the idea
> >that they are not!)
> 
> Well, the last line is in all arches except x86
> The mftb() was suggested by Michael to add some entropy.
> x86 does the same sort of thing with their rdtsc()
> 
> >
> >You should use wait_for_random_bytes I think.
> 
> On the 8xx, it takes several minutes before crnd_is_ready(), while 
> boot_init_stack_canary() is called quite early in start_kernel()

If you do not provide real entropy to the canary, the canary doesn't help
providing protection as much as you may hope.


Segher
