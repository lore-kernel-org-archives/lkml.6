Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCE820856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2UrTct1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCE820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeGSKIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:08:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeGSKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/XzYF6OgunbOCgX1qSMgWlG2svJbh/a+gYsM8px3vOQ=; b=2UrTct1TTh99ANKw7NpiSZmc+
        0NZS3UQ6cBIcbHNb4sN2U+yetfGdkVYM0uRe9VyDSKvu+927ANZXnZBiX/GXDa04DwqA2tqTRncD/
        xdHZzyQEwEYW/DUCzBD7mf1mAJXwp1szVCkqCLUg6tHzhv++zvnmjWxYOmpXUroolyDMtQg4+oinU
        iLLnhysu4TV6jUByFlkrOYUbE/lsL9VbH1f7BQOYcRGy+75PWgQI+DAeMQsKZbOUqwZBCdShBagdy
        LqMslZdDXEK1K+/QaB3kq1Quhtnt7uOQeZ7yWYM8PGxK/wVNZrqxvAP6gKUzex5zLwSqgIZPGio6S
        6badXPe3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg5CR-00023M-Jm; Thu, 19 Jul 2018 09:26:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E7BD20289330; Thu, 19 Jul 2018 11:26:14 +0200 (CEST)
Date:   Thu, 19 Jul 2018 11:26:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180719092614.GY2512@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718120318.GC2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:

> Leaving us just 5 bytes short of needing a single cacheline :/
> 
> struct ponies {
>         unsigned int               tasks[3];                                             /*     0    12 */
>         unsigned int               cpu_state:2;                                          /*    12:30  4 */
>         unsigned int               io_state:2;                                           /*    12:28  4 */
>         unsigned int               mem_state:2;                                          /*    12:26  4 */
> 
>         /* XXX 26 bits hole, try to pack */
> 
>         /* typedef u64 */ long long unsigned int     last_time;                          /*    16     8 */
>         /* typedef u64 */ long long unsigned int     some_time[3];                       /*    24    24 */
>         /* typedef u64 */ long long unsigned int     full_time[2];                       /*    48    16 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         /* typedef u64 */ long long unsigned int     nonidle_time;                       /*    64     8 */
> 
>         /* size: 72, cachelines: 2, members: 8 */
>         /* bit holes: 1, sum bit holes: 26 bits */
>         /* last cacheline: 8 bytes */
> };
> 
> ARGGH!

It _might_ be possible to use curr->se.exec_start for last_time if you
very carefully audit and place the hooks. I've not gone through it in
detail, but it might just work.
