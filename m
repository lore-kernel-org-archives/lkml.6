Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F6F20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kX0nYqi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfAKJxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:53:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfAKJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+17v+jxBm1x8sixfNK5SLtJ10oyWZzXTOZvCnrCbUEs=; b=kX0nYqi6gqleGRYqlev8OeFm7G
        q7WVNYMdFaNo3tjhCUymn1JywpMmFoXCx9/+ZjMVMUKd+T91my6bij3VYImPey6S9Gsfdw3ec5QWj
        OwNYKghD14S1upeS+7ispiPvz6BInMXsHYN3n9L3skUYbFr1N5dhkaIb9yO0VcIxhO5lmTE0Iwz7r
        DqTWJv2bjOaXUXO+zcV+yHhxRtDgSy1DXQiDVIUXOGxLyyfg1o8stpNtoSvpaYQCxLBZrFGn/Nrbr
        8KkQ0QcX+0/Q7UrvFIwmk1e7fBfMt0pMBTa5bL1UplqKE7oO8sOrqGbWj+FhQIhGCY9yGEllfOxXb
        1FWXSfZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghtVG-00087o-5N; Fri, 11 Jan 2019 09:53:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2521A2080968D; Fri, 11 Jan 2019 10:53:23 +0100 (CET)
Date:   Fri, 11 Jan 2019 10:53:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, willy@infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-doc@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC LKMM 5/7] docs/memory-barriers.txt: Enforce heavy
 ordering for port I/O accesses
Message-ID: <20190111095323.GO1900@hirez.programming.kicks-ass.net>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-5-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109210748.29074-5-paulmck@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi PeterA,

The Cover leter has this:

> 5.	Update memory-barriers.txt on enforcing heavy ordering for
>	port-I/O accesses, courtesy of Will Deacon.  This one needs
>	an ack, preferably by someone from Intel.  Matthew Wilcox
>	posted some feedback from an Intel manual here, which might
>	be considered to be a close substitute, but...  ;-)
>
>	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org

which in turn has:

> Here's a quote from Section 18.6 of volume 1 of the Software Developer
> Manual, November 2018 edition:
> 
> When the I/O address space is used instead of memory-mapped I/O, the
> situation is different in two respects:
> • The processor never buffers I/O writes. Therefore, strict ordering of
> I/O operations is enforced by the processor. (As with memory-mapped I/O,
> it is possible for a chip set to post writes in certain I/O ranges.)
> • The processor synchronizes I/O instruction execution with external
> bus activity (see Table 18-1).
> 
> Table 18-1 says that in* delays execution of the current instruction until
> completion of pending stores, and out* delays execution of the _next_
> instruction until completion of both pending stores and the current store.

Can we give an Intel ACK on the below patch?

On Wed, Jan 09, 2019 at 01:07:46PM -0800, Paul E. McKenney wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> David Laight explains:
> 
>   | A long time ago there was a document from Intel that said that
>   | inb/outb weren't necessarily synchronised wrt memory accesses.
>   | (Might be P-pro era). However no processors actually behaved that
>   | way and more recent docs say that inb/outb are fully ordered.
> 
> This also reflects the situation on other architectures, the the port
> accessor macros tend to be implemented in terms of readX/writeX.
> 
> Update Documentation/memory-barriers.txt to reflect reality.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <linux-arch@vger.kernel.org>
> Cc: <linux-doc@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  Documentation/memory-barriers.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 1c22b21ae922..a70104e2a087 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -2619,10 +2619,8 @@ functions:
>       intermediary bridges (such as the PCI host bridge) may not fully honour
>       that.
>  
> -     They are guaranteed to be fully ordered with respect to each other.
> -
> -     They are not guaranteed to be fully ordered with respect to other types of
> -     memory and I/O operation.
> +     They are guaranteed to be fully ordered with respect to each other and
> +     also with respect to other types of memory and I/O operation.
>  
>   (*) readX(), writeX():
>  
> -- 
> 2.17.1
> 
