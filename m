Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966997AbeCAJbU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:31:20 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55304 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966780AbeCAJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:31:16 -0500
X-Google-Smtp-Source: AG47ELv7jfSWs8t94HnFerVO5ppe14JOYT//BXyGLFg6qpwfJZmNnEJsG47+kZHf701sf59hbJdtww==
Date: Thu, 1 Mar 2018 10:31:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        william.grant@canonical.com, terraluna977@gmail.com
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] x86/cpu_entry_area: Sync cpu_entry_area to
 initial_page_table
Message-ID: <20180301093111.kyskbidqe5fqvogs@gmail.com>
References: <alpine.DEB.2.21.1802282137290.1392@nanos.tec.linutronix.de>
 <tip-945fd17ab6bab8a4d05da6c3170519fbcfe62ddb@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-945fd17ab6bab8a4d05da6c3170519fbcfe62ddb@git.kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just a few small speling nits:

* tip-bot for Thomas Gleixner <tipbot@zytor.com> wrote:

> Commit-ID:  945fd17ab6bab8a4d05da6c3170519fbcfe62ddb
> Gitweb:     https://git.kernel.org/tip/945fd17ab6bab8a4d05da6c3170519fbcfe62ddb
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Wed, 28 Feb 2018 21:14:26 +0100
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Thu, 1 Mar 2018 09:48:27 +0100
> 
> x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table
> 
> The separation of the cpu_entry_area from the fixmap missed the fact that
> on 32bit non-PAE kernels the cpu_entry_area mapping might not be covered in
> initial_page_table by the previous synchronizations.
> 
> This results in suspend/resume failures because 32bit utilizes initial page
> table for resume. The absence of the cpu_entry_area mapping results in a
> triple fault, aka. insta reboot.
> 
> With PAE enabled this works by chance because the PGD entry which covers
> the fixmap and other parts incindentally provides the cpu_entry_area
> mapping as well.

s/incindentally/incidentally

s/32bit/32-bit

s/utilizes initial page table
 /utilizes the initial page table

> Synchronize the initial page table after setting up the cpu entry
> area. Instead of adding yet another copy of the same code, move it to a
> function and invoke it from the various places.

s/cpu/CPU

> It needs to be investigated if the existing calls in setup_arch() and
> setup_per_cpu_areas() can be replaced by the later invocation from
> setup_cpu_entry_areas(), but that's beyond the scope of this fix.

> +	/*
> +	 * This is the last essential update to swapper_pgdir which needs
> +	 * to be synchronized to initial_page_table on 32bit.
> +	 */
> +	sync_initial_page_table();


s/swapper_pgdir
 /swapper_pg_dir

s/on 32bit/on 32-bit kernels

> +	/*
> +	 * sync back low identity map too.  It is used for example
> +	 * in the 32-bit EFI stub.
> +	 */

s/sync/Sync

Very nice fix!

Thanks,

	Ingo
