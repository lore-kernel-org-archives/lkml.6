Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A51BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2841325116
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2841325116
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeGBUsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:48:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeGBUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:48:49 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9EC5FCFC;
        Mon,  2 Jul 2018 20:48:48 +0000 (UTC)
Date:   Mon, 2 Jul 2018 13:48:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-Id: <20180702134845.c4f536dead5374b443e24270@linux-foundation.org>
In-Reply-To: <20180702140502.GZ19043@dhcp22.suse.cz>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
        <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
        <20180629183501.9e30c26135f11853245c56c7@linux-foundation.org>
        <084aeccb-2c54-2299-8bf0-29a10cc0186e@linux.alibaba.com>
        <20180629201547.5322cfc4b52d19a0443daec2@linux-foundation.org>
        <20180702140502.GZ19043@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 16:05:02 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> On Fri 29-06-18 20:15:47, Andrew Morton wrote:
> [...]
> > Would one of your earlier designs have addressed all usecases?  I
> > expect the dumb unmap-a-little-bit-at-a-time approach would have?
> 
> It has been already pointed out that this will not work.

I said "one of".  There were others.

> You simply
> cannot drop the mmap_sem during unmap because another thread could
> change the address space under your feet. So you need some form of
> VM_DEAD and handle concurrent and conflicting address space operations.

Unclear that this is a problem.  If a thread does an unmap of a range
of virtual address space, there's no guarantee that upon return some
other thread has not already mapped new stuff into that address range. 
So what's changed?


