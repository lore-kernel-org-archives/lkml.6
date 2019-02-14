Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D212177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394907AbfBNL3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:29:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfBNL3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:29:40 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guFCp-0004PT-GM; Thu, 14 Feb 2019 12:29:27 +0100
Date:   Thu, 14 Feb 2019 12:29:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
In-Reply-To: <20190213023748.6614-2-aubrey.li@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902141212400.1561@nanos.tec.linutronix.de>
References: <20190213023748.6614-1-aubrey.li@linux.intel.com> <20190213023748.6614-2-aubrey.li@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019, Aubrey Li wrote:

> AVX-512 components use could cause core turbo frequency drop. So
> it's useful to expose AVX-512 usage elapsed time as a heuristic hint
> for the user space job scheduler to cluster the AVX-512 using tasks
> together.
> 
> Example:
> $ cat /proc/pid/status | grep AVX512_elapsed_ms
> AVX512_elapsed_ms:      1020
> 
> The number '1020' denotes 1020 millisecond elapsed since last time
> context switch the off-CPU task using AVX-512 components, thus the

I know what you are trying to say, but this sentence does not parse. So
what you want to say is:

  This means that 1020 milliseconds have elapsed since the AVX512 usage of
  the task was detected when the task was scheduled out.

Aside of that 1020ms is hardly evidence for real AVX512 usage, so you want
to come up with a better example than that.

But that makes me think about the usefulness of this hint in general.

A AVX512 using task which runs alone on a CPU, is going to have either no
AVX512 usage recorded at all or the time elapsed since the last recording
is absurdly long. IOW, this needs crystal ball magic to decode because
there is no correlation between that elapsed time and the time when the
last context switch happened simply because that time is not available in
/proc/$PID/status. Sure you can oracle it out from /proc/$PID/stat with
even more crystal ball magic, but there is no explanation at all.

There may be use case scenarios where this crystal ball prediction is
actually useful, but the inaccuracy of that information and the possible
pitfalls for any user space application which uses it need to be documented
in detail. Without that, this is going to cause more trouble and confusion
than benefit.

Thanks,

	tglx
