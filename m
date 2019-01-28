Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75172148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AL3jkz1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfA1VH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:07:29 -0500
Received: from mail.efficios.com ([167.114.142.138]:46928 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfA1VH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:07:28 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C9F3BB409D;
        Mon, 28 Jan 2019 16:07:26 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id QD0zpNd8DmNE; Mon, 28 Jan 2019 16:07:26 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5CD56B4096;
        Mon, 28 Jan 2019 16:07:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5CD56B4096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548709646;
        bh=7mAjXKongGpxybKtanLxt98Oal/+0YDIRxY/2xq9Rwg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AL3jkz1ilr/wiHMBbJMWIjS7SJgtHnYR2R+5HRoX470V3tc3s92ujkLPM1JBbikTb
         vNwqO34GSuDRszCAiAndEp+kI0gkC/RhX5AjlrKpsOZQk0VKFD3lH5F49MSVv9UPmL
         7zan9rmKroCTOzpnvs10U8TrTnPe1DiNFOMZ8OwiWyGLrJJXEQPpkc7P2zQZbwge/1
         p8HgI6yvwSKqdw6C5CQrjFS2Zy9Qxbn/oxyKZFt412hBfErw2QNKUUkLdlkrDL5Kb/
         5KfVDLes2V8XwES6Ti1KbgkXF+8iKIU98NnpS6ekrXOlYiwXvbRp2YM5RRweRb3wHK
         JKS/njOAiDgFQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 1JfnYT4_8lyy; Mon, 28 Jan 2019 16:07:26 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3414DB408C;
        Mon, 28 Jan 2019 16:07:26 -0500 (EST)
Date:   Mon, 28 Jan 2019 16:07:26 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        maged michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        stable <stable@vger.kernel.org>
Message-ID: <231707440.2765.1548709646123.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190128204611.GB4240@linux.ibm.com>
References: <20190128182636.18420-1-mathieu.desnoyers@efficios.com> <CAHk-=wjmpfXak0pQVu8dZrk2Oma3OxtEoBHfwCAruu0xpSMN4A@mail.gmail.com> <20190128204611.GB4240@linux.ibm.com>
Subject: Re: [RFC PATCH] Fix: membarrier: racy access to p->mm in
 membarrier_global_expedited()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: membarrier: racy access to p->mm in membarrier_global_expedited()
Thread-Index: SeWnv/2FAEUABsrWMNQZxuxO0V9zyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 28, 2019, at 3:46 PM, paulmck paulmck@linux.ibm.com wrote:

> On Mon, Jan 28, 2019 at 12:27:03PM -0800, Linus Torvalds wrote:
>> On Mon, Jan 28, 2019 at 10:27 AM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>> >
>> > Jann Horn identified a racy access to p->mm in the global expedited
>> > command of the membarrier system call.
>> >
>> > The suggested fix is to hold the task_lock() around the accesses to
>> > p->mm and to the mm_struct membarrier_state field to guarantee the
>> > existence of the mm_struct.
>> 
>> Hmm. I think this is right. You shouldn't access another threads mm
>> pointer without proper locking.
>> 
>> That said, we *could* make the mm_cachep be SLAB_TYPESAFE_BY_RCU,
>> which would allow speculatively reading data off the mm pointer under
>> RCU. It might not be the *right* mm if somebody just did an exit, but
>> for things like this it shouldn't matter.
> 
> That sounds much simpler and more effective than the contention-reduction
> approach that I suggested.  ;-)

I'd be tempted to stick to the locking approach for a fix, and implement
Linus' type-safe mm_cachep idea if anyone complains about the overhead
of membarrier GLOBAL_EXPEDITED (and submit for a future merge window).

I tested the KASAN splat reproducer from Jann locally, and confirmed that
my patch fixes the issue it reproduces.

Please let me know if the task_lock() approach is OK as a fix for now.

I'm also awaiting a Tested-by from Jann before submitting this for real.

Thanks,

Mathieu

> 
>							Thanx, Paul
> 
>> But if this is the only case that might care, it sounds like just
>> doing the proper locking is the right approach.
>> 
>>            Linus

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
