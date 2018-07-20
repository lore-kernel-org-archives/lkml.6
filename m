Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7B1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1C020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeGTJSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:18:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59418 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbeGTJSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:18:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 451FE80D;
        Fri, 20 Jul 2018 01:31:40 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54BDF3F5B3;
        Fri, 20 Jul 2018 01:31:39 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:31:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: UBSAN: Undefined behaviour in lib/radix-tree.c:123:14: member
 access within null pointer of type 'const struct radix_tree_node'
Message-ID: <20180720083102.4xo3yaatv56ky7fj@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <19427cc3-3372-9b02-4b92-096fbe328622@molgen.mpg.de>

On Fri, Jul 20, 2018 at 09:53:21AM +0200, Paul Menzel wrote:
> Dear Linux folks,

Hi,

> Enabling the undefined behavior sanitizer and building GNU/Linux 4.18-rc5+
> (with some unrelated commits) with GCC 8.1.0 from Debian Sid/unstable, the
> warning below is shown.
> 
> > [    0.958688] ================================================================================
> > [    0.959029] UBSAN: Undefined behaviour in lib/radix-tree.c:123:14

That's in get_slot_offset(), and I think this is addressed by the patch [1] I previously sent.

There are at least a couple of instances in the radix tree code, and I had
intended to address them together, but I haven't had the chance over the last
couple of weeks.

I will try to get back to that soon.

> > [    0.959212] member access within null pointer of type 'const struct radix_tree_node'
> > [    0.959472] CPU: 0 PID: 24 Comm: kworker/0:2 Not tainted 4.18.0-rc5-00316-g4864b68cedf2 #104
> > [    0.959475] Hardware name: ASROCK E350M1/E350M1, BIOS TIMELESS 01/01/1970
> > [    0.959488] Workqueue: events_power_efficient ioc_release_fn
> > [    0.959492] Call Trace:
> > [    0.959501]  dump_stack+0x55/0x89
> > [    0.959507]  ubsan_epilogue+0xb/0x33
> > [    0.959511]  handle_null_ptr_deref+0x7f/0x90
> > [    0.959516]  __ubsan_handle_type_mismatch_v1+0x55/0x60
> > [    0.959521]  __radix_tree_delete+0xc5/0xe0
> > [    0.959525]  radix_tree_delete_item+0x5f/0xf0
> > [    0.959529]  radix_tree_delete+0xa/0x10
> > [    0.959532]  ioc_destroy_icq+0x58/0x1f0
> > [    0.959538]  ? free_tty_struct+0x34/0x50
> > [    0.959541]  ioc_release_fn+0x9c/0x1a0
> > [    0.959548]  process_one_work+0x220/0x700
> > [    0.959553]  worker_thread+0x5a/0x690
> > [    0.959557]  kthread+0x14e/0x200
> > [    0.959561]  ? drain_workqueue+0x290/0x290
> > [    0.959565]  ? kthread_create_worker_on_cpu+0x30/0x30
> > [    0.959568]  ret_from_fork+0x1c/0x38
> > [    0.959572] ================================================================================

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20180706134144.48446-1-mark.rutland@arm.com
