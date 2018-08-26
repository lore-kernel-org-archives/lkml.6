Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB022C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E5120A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 10:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E5120A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeHZOHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 10:07:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeHZOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 10:07:34 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ftsER-000384-HF; Sun, 26 Aug 2018 12:25:19 +0200
Date:   Sun, 26 Aug 2018 12:25:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com,
        mingo@redhat.com
Subject: Re: [PATCH v2 2/2] x86/pae: use 64 bit atomic xchg function in
 native_ptep_get_and_clear
In-Reply-To: <20180821153755.30462-3-jgross@suse.com>
Message-ID: <alpine.DEB.2.21.1808261224440.1195@nanos.tec.linutronix.de>
References: <20180821153755.30462-1-jgross@suse.com> <20180821153755.30462-3-jgross@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018, Juergen Gross wrote:

> Using only 32-bit writes for the pte will result in an intermediate
> L1TF vulnerable PTE. When running as a Xen PV guest this will at once
> switch the guest to shadow mode resulting in a loss of performance.
> 
> Use arch_atomic64_xchg() instead which will perform the requested
> operation atomically with all 64 bits.
> 
> Some performance considerations according to:
> 
> https://software.intel.com/sites/default/files/managed/ad/dc/Intel-Xeon-Scalable-Processor-throughput-latency.pdf
> 
> The main number should be the latency, as there is no tight loop around
> native_ptep_get_and_clear().
> 
> "lock cmpxchg8b" has a latency of 20 cycles, while "lock xchg" (with a
> memory operand) isn't mentioned in that document. "lock xadd" (with xadd
> having 3 cycles less latency than xchg) has a latency of 11, so we can
> assume a latency of 14 for "lock xchg".
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
