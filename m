Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BD3C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81888276AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81888276AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935687AbeF1QqY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:46:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50300 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932809AbeF1QqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:46:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0091529;
        Thu, 28 Jun 2018 09:46:23 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DC423F318;
        Thu, 28 Jun 2018 09:46:23 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 58BEF1AE540D; Thu, 28 Jun 2018 17:47:01 +0100 (BST)
Date:   Thu, 28 Jun 2018 17:47:01 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        peter maydell <peter.maydell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] rseq/selftests: Add support for arm64
Message-ID: <20180628164700.GD10751@arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
 <1529949285-11013-4-git-send-email-will.deacon@arm.com>
 <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com>
 <20180626151427.GF23375@arm.com>
 <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Tue, Jun 26, 2018 at 12:11:52PM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 26, 2018, at 11:14 AM, Will Deacon will.deacon@arm.com wrote:
> > On Mon, Jun 25, 2018 at 02:10:10PM -0400, Mathieu Desnoyers wrote:
> >> I notice you are using the instructions
> >> 
> >>   adrp
> >>   add
> >>   str
> >> 
> >> to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
> >> performance-wise with an approach using a literal pool
> >> near the instruction pointer like I did on arm32 ?
> > 
> > I didn't, no. Do you have a benchmark to hand so I can give this a go?
> 
> see tools/testing/selftests/rseq/param_test_benchmark --help
> 
> It's a stripped-down version of param_test, without all the code for
> delay loops and testing checks.
> 
> Example use for counter increment with 4 threads, doing 5G counter
> increments per thread:
> 
> time ./param_test_benchmark -T i -t 4 -r 5000000000

Thanks. I ran that on a few arm64 systems I have access to, with three
configurations of the selftest:

1. As I posted
2. With the abort signature and branch in-lined, so as to avoid the CBNZ
   address limitations in large codebases
3. With both the abort handler and the table inlined (i.e. the same thing
   as 32-bit).

There isn't a reliably measurable difference between (1) and (2), but I take
between 12% and 27% hit between (2) and (3).

So I'll post a v2 based on (2).

Will
