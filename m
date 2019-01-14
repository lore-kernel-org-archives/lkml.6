Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD05C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2479720896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfANQVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfANQVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:21:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF9420873;
        Mon, 14 Jan 2019 16:21:16 +0000 (UTC)
Date:   Mon, 14 Jan 2019 11:21:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     linux@armlinux.org.uk, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190114112115.1cbf21c0@gandalf.local.home>
In-Reply-To: <20190112065701.30841-1-changbin.du@gmail.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2019 14:57:01 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> This patch adds a new trace option 'funcgraph-retval' and is disabled by
> default. When this option is enabled, fgraph tracer will show the return
> value of each function. This is useful to find/analyze a original error
> source in a call graph.
> 
> One limitation is that kernel doesn't know the prototype of functions. So
> fgraph assumes all functions have a retvalue of type int. You must ignore
> the value of *void* function. And if the retvalue looks like an error code
> then both hexadecimal and decimal number are displayed.
> 
> In this patch, only x86 and ARM platforms are supported.
> 
> Here is example showing the error is caused by vmx_create_vcpu() and the
> error code is -5 (-EIO).
> 
> with echo 1 > /sys/kernel/debug/tracing/options/funcgraph-retval
> 
>  3)               |  kvm_vm_ioctl() {
>  3)               |    mutex_lock() {
>  3)               |      _cond_resched() {
>  3)   0.234 us    |        rcu_all_qs(); /* ret=0x80000000 */
>  3)   0.704 us    |      } /* ret=0x0 */
>  3)   1.226 us    |    } /* ret=0x0 */
>  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
>  3)               |    kvm_arch_vcpu_create() {
>  3)               |      vmx_create_vcpu() {
>  3) + 17.969 us   |        kmem_cache_alloc(); /* ret=0xffff88813a980040 */
>  3) + 15.948 us   |        kmem_cache_alloc(); /* ret=0xffff88813aa99200 */
>  3)   0.653 us    |        allocate_vpid.part.88(); /* ret=0x1 */
>  3)   6.964 us    |        kvm_vcpu_init(); /* ret=0xfffffffb */
>  3)   0.323 us    |        free_vpid.part.89(); /* ret=0x1 */
>  3)   9.985 us    |        kmem_cache_free(); /* ret=0x80000000 */
>  3)   9.491 us    |        kmem_cache_free(); /* ret=0x80000000 */
>  3) + 69.858 us   |      } /* ret=0xfffffffffffffffb/-5 */
>  3) + 70.631 us   |    } /* ret=0xfffffffffffffffb/-5 */
>  3)               |    mutex_lock() {
>  3)               |      _cond_resched() {
>  3)   0.199 us    |        rcu_all_qs(); /* ret=0x80000000 */
>  3)   0.594 us    |      } /* ret=0x0 */
>  3)   1.067 us    |    } /* ret=0x0 */
>  3)   0.337 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
>  3) + 92.730 us   |  } /* ret=0xfffffffffffffffb/-5 */
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>

Hi Changbin,

I'm rewriting a lot of the function graph tracer code to have
kretprobes be able to work on top of it. It's still a work in progress.
It would be easier to add something to that work when its done than to
do it now.

Thanks!

-- Steve
