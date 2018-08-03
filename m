Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FD4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221EB2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221EB2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeHCNl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:41:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39651 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeHCNl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:41:59 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flYWF-0007RQ-7M; Fri, 03 Aug 2018 13:45:19 +0200
Date:   Fri, 3 Aug 2018 13:45:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/7] x86/intel_rdt: Restoration of Cache Pseudo-Locked
 regions
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1808031343020.1745@nanos.tec.linutronix.de>
References: <cover.1532463771.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Reinette Chatre wrote:

> Dear Maintainers,
> 
> A Cache Pseudo-Locked region is vulnerable to certain instructions (INVD,
> WBINVD, CLFLUSH) or deeper C-states (that could shrink or power off the
> cache) evicting the pseudo-locked memory. The current support for
> pseudo-locked regions already restrict deeper C-states on cores associated
> with the pseudo-locked regions, but the vulnerability to some instructions
> remain.
> 
> This work does not prevent the instructions to which Cache Pseudo-Locked
> regions are vulnerable, instead, this work support the restoration of
> Cache Pseudo-Locked regions that can be triggered manually by the user
> or automatically after the WBINVD instruction has been issued.
> 
> A new debugfs file "pseudo_lock_restore" is associated with each
> pseudo-locked region and can be used to manually trigger the memory
> associated with the region to be pseudo-locked to cache again.

I'm not seeing how that should be used. What's the indication for an
operator to write to that file?

> The system-wide "native_wbinvd()" is modified to trigger the restoration of
> all Cache Pseudo-Locked regions after the WBINVD instruction returns and
> effort is made to avoid any unnecessary work in this flow.
> 
> Within the kernel two locations with direct invocations of the WBINVD
> instruction are coverted to native_wbinvd() and compile tested. Neither
> location is likely to be used on the platforms supporting Cache Pseudo-Locking.

Can we just get rid of WBINVD?

Thanks,

	tglx
