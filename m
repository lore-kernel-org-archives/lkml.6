Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED91C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF8F20989
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF8F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeHOA0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:26:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbeHOA0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:26:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B905ACFC;
        Tue, 14 Aug 2018 21:36:56 +0000 (UTC)
Date:   Tue, 14 Aug 2018 14:36:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Build failures with gcc 4.5 and older
Message-Id: <20180814143655.3acd4bb211d44747f77e74f2@linux-foundation.org>
In-Reply-To: <20180814170904.GA12768@roeck-us.net>
References: <20180814170904.GA12768@roeck-us.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 10:09:04 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> Since commit c1a2f7f0c0645 ("mm: Allocate the mm_cpumask
> (mm->cpu_bitmap[]) dynamically based on nr_cpu_ids"), building
> the Linux kernel with gcc version 4.5 and older fails as follows.
> 
> In file included from ./include/linux/mm.h:17:0,
>                  from ./include/linux/pid_namespace.h:7,
> 		 from ./include/linux/ptrace.h:10,
> 		 from arch/openrisc/kernel/asm-offsets.c:32:
> ./include/linux/mm_types.h:497:16: error: flexible array member in otherwise empty struct

Confused.  Why does it think that the mm_struct is "otherwise empty"?

This shuts it up:

--- a/include/linux/mm_types.h~a
+++ a/include/linux/mm_types.h
@@ -490,6 +490,7 @@ struct mm_struct {
 #endif
 	} __randomize_layout;
 
+	int wibble;
 	/*
 	 * The mm_cpumask needs to be at the end of mm_struct, because it
 	 * is dynamically sized based on nr_cpu_ids.


So we could add something like that, along with the appropriate #if
GCC_VERSION and a comment.  A simple enough change, to keep those old
gcc versions limping along for a bit longer?

