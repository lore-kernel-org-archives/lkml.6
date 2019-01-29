Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1346CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE38420857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfA2WSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:18:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2WSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:18:50 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BCE032A1;
        Tue, 29 Jan 2019 22:18:49 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:18:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: calculate end pointer for /proc/*/* lookup at
 compile time
Message-Id: <20190129141848.5f3d2d1aa125c8ec45ee091d@linux-foundation.org>
In-Reply-To: <20190114200422.GB9680@avx2>
References: <20190114200422.GB9680@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 23:04:23 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Compilers like to transform loops like
> 
> 	for (i = 0; i < n; i++) {
> 		[use p[i]]
> 	}
> 
> into
> 	for (p = p0; p < end; p++) {
> 		...
> 	}
> 
> Do it by hand, so that it results in overall simpler loop
> and smaller code.
> 
> Space savings:
> 
> 	$ ./scripts/bloat-o-meter ../vmlinux-001 ../obj/vmlinux
> 	add/remove: 0/0 grow/shrink: 2/1 up/down: 4/-9 (-5)
> 	Function                                     old     new   delta
> 	proc_tid_base_lookup                          17      19      +2
> 	proc_tgid_base_lookup                         17      19      +2
> 	proc_pident_lookup                           179     170      -9
> 
> Note: this trick bloats readdir, so don't do it :-\

I don't understand the Note:.  Can you please expand?
