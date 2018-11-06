Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE972C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A202083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A202083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbeKGGdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:33:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388525AbeKGGdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:33:07 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6CBCA9E7;
        Tue,  6 Nov 2018 21:05:58 +0000 (UTC)
Date:   Tue, 6 Nov 2018 13:05:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     jeyu@kernel.org, willy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org, kristen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com
Subject: Re: [PATCH v8 4/4] Kselftest for module text allocation
 benchmarking
Message-Id: <20181106130557.11bfeddafe103bb609352aba@linux-foundation.org>
In-Reply-To: <20181102192520.4522-5-rick.p.edgecombe@intel.com>
References: <20181102192520.4522-1-rick.p.edgecombe@intel.com>
        <20181102192520.4522-5-rick.p.edgecombe@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Nov 2018 12:25:20 -0700 Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> This adds a test module in lib/, and a script in kselftest that does
> benchmarking on the allocation of memory in the module space. Performance here
> would have some small impact on kernel module insertions, BPF JIT insertions
> and kprobes. In the case of KASLR features for the module space, this module
> can be used to measure the allocation performance of different configurations.
> This module needs to be compiled into the kernel because module_alloc is not
> exported.

Well, we could export module_alloc().  Would that be helpful at all?

> With some modification to the code, as explained in the comments, it can be
> enabled to measure TLB flushes as well.
> 
> There are two tests in the module. One allocates until failure in order to
> test module capacity and the other times allocating space in the module area.
> They both use module sizes that roughly approximate the distribution of in-tree
> X86_64 modules.
> 
> You can control the number of modules used in the tests like this:
> echo m1000>/dev/mod_alloc_test
> 
> Run the test for module capacity like:
> echo t1>/dev/mod_alloc_test
> 
> The other test will measure the allocation time, and for CONFG_X86_64 and
> CONFIG_RANDOMIZE_BASE, also give data on how often the “backup area" is used.
> 
> Run the test for allocation time and backup area usage like:
> echo t2>/dev/mod_alloc_test
> The output will be something like this:
> num		all(ns)		last(ns)
> 1000		1083		1099
> Last module in backup count = 0
> Total modules in backup     = 0
> >1 module in backup count   = 0

Are the above usage instructions captured in the kernel code somewhere?
I can't see it, and expecting people to trawl git changelogs isn't
very friendly.


