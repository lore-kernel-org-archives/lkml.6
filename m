Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6957524972
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A0qxcz1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6957524972
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeGCTJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:09:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47978 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeGCTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fe29SZXhV+BNP5WJCZUXh2Sqj3iWVvEHm5489ryOvPY=; b=A0qxcz1kufOFXuPCdsP2siV1K
        nx8jJ0cWQ15cHZSC1giAW+jQmcdHC3TytYlw9quIxQMEtGOdArhVwdjjcvFBOwlBsoIqyHfbF/JIz
        CfSHiqD5iLG1TtD4hW64eR7mTseXdulkWII3oGJHW4cLGoPMj27shIR8snSD+yMxIviYoJcyDmmI3
        U6NF32hk1NaKHGgMIlvCVRJEC6FkbFfJiLtn557gXyH5ngwR5ihjZyfMb8UjSzsp0fKLn2UrtiJIS
        ljp7q/7baQTo0OUa89C7uNaLMl2J0NHD9nU+53fYKEXHToOHVRNCKhXtIsMZ2E4jktNOClQaSlBnD
        lcP63Mn/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faQfA-0005Io-Ej; Tue, 03 Jul 2018 19:08:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40D1320298BAE; Tue,  3 Jul 2018 21:08:31 +0200 (CEST)
Date:   Tue, 3 Jul 2018 21:08:31 +0200
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
Message-ID: <20180703190831.GJ2458@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <20180703173451.GX2494@hirez.programming.kicks-ass.net>
 <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com>
 <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
 <1048940999.11846.1530640717837.JavaMail.zimbra@efficios.com>
 <20180703181143.GB2494@hirez.programming.kicks-ass.net>
 <1708848118.11868.1530641734202.JavaMail.zimbra@efficios.com>
 <20180703182837.GC2494@hirez.programming.kicks-ass.net>
 <1368400582.11897.1530643261772.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368400582.11897.1530643261772.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 02:41:01PM -0400, Mathieu Desnoyers wrote:

> User-space won't ever want to read cpu_id_start and cpu_id from a single
> u64 load, it serves no purpose to do so. So I'm OK with keeping those as
> is and defining a local union for the __put_user() update.

So I think previously we had the sequence number and cpuid in there
together, and in that case it did want to load them both. But since you
made that sequence number dissapear....
