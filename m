Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1580C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D94924687
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hnGgmjXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D94924687
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934516AbeGCSMK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:12:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934297AbeGCSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G/oLndHP7j198cI5Rzcb/xHmcxUrCWYa7MSZMRLsnMw=; b=hnGgmjXW/pGqevavie7kbVi+2
        NlHQQzyeeiPs5FEHxRUNjSFIoCfu0C2LbDXXlqcHhEjRfWBQyH2EEYpz2dIkh7xTIy7PX0547+Jb5
        W+BcyR/e+7Rdrsn2pUDfB4WyC6fsr8zlKuMe0/jSsqxzEB6rpfsop2Jx4woC3TltXz30GqM+evsaB
        2q8Ct9ygXBxr9jZcrXNw3d/Y3bbj0LUJI4OFFn002/0bngUBM16hVPGGpi8mzARM2T/x/x3ZkVgQM
        y06Qmepx0IqwawzyxOolMX0lOIa/cDVxTG2TkPMJ4BVAYVayLdMHRSwB/xwrhJLU+kNvGkybd8wy/
        7kQpE4m4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faPmC-0003fh-OL; Tue, 03 Jul 2018 18:11:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 423C020289CE4; Tue,  3 Jul 2018 20:11:43 +0200 (CEST)
Date:   Tue, 3 Jul 2018 20:11:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        schwidefsky <schwidefsky@de.ibm.com>, gor <gor@linux.ibm.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
Message-ID: <20180703181143.GB2494@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <20180703085546.GJ3704@osiris>
 <20180703092113.GV2494@hirez.programming.kicks-ass.net>
 <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
 <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
 <20180703173451.GX2494@hirez.programming.kicks-ass.net>
 <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com>
 <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
 <1048940999.11846.1530640717837.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048940999.11846.1530640717837.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:58:37PM -0400, Mathieu Desnoyers wrote:
> I can modify the ABI to put the cpu_id_start and cpu_id fields inside
> a union, and update it with a single store.
> 
> Thoughts ?

Let's keep them for now, we can always frob this later, they are aligned
and proper, no need to expose that union to userspace.
