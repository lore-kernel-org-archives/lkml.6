Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4F6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EEE2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EEE2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeHUL6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:58:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbeHUL6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:58:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1EE4AD6D;
        Tue, 21 Aug 2018 08:39:06 +0000 (UTC)
Date:   Tue, 21 Aug 2018 10:39:11 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: SEV guest regression in 4.18
Message-ID: <20180821083911.GF24940@nazgul.tnic>
References: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 05:11:53PM -0500, Brijesh Singh wrote:
> Hi All,
> 
> The following commit
> 
> "
> x86/kvmclock: Remove memblock dependency
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=368a540e0232ad446931f5a4e8a5e06f69f21343
> 
> "
> broke the SEV support in 4.18.
> 
> Since the guest physical address holding the wall_clock and
> vcpu_time_info are shared with the hypervisor  it must be mapped
> as "decrypted" when SEV is active. To clear the C-bit we use
> kernel_physical_mapping_init() to split the large pages into 4K before
> changing the C-bit. Now the kernel_physical_mapping_init() is failing to
> allocate the memory because its called very early.
> 
> [    0.000000] Call Trace:
> [    0.000000]  ? dump_stack+0x5c/0x80
> [    0.000000]  ? panic+0xe7/0x247
> [    0.000000]  ? alloc_low_pages+0x130/0x130
> [    0.000000]  ? kernel_physical_mapping_init+0xe0/0x204
> [    0.000000]  ? early_set_memory_enc_dec+0x123/0x174
> [    0.000000]  ? 0xffffffffae000000
> [    0.000000]  ? kvmclock_init+0x60/0x1ea
> [    0.000000]  ? kvm_init_platform+0xa/0x16
> [    0.000000]  ? setup_arch+0x434/0xce9
> [    0.000000]  ? start_kernel+0x67/0x52e
> [    0.000000]  ? load_ucode_bsp+0x76/0x12e
> [    0.000000]  ? secondary_startup_64+0xa4/0xb0

Silly question: can we delay the call to kernel_physical_mapping_init()
to right before those variables are accessed by the guest for the first
time, assuming we can allocate memory at that point?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
