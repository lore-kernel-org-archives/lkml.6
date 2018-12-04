Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AB1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235D02082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235D02082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLDWuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:50:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:50:37 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 548C3A47;
        Tue,  4 Dec 2018 22:50:36 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:50:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 4/4] mm: use the cached page for filemap_fault
Message-Id: <20181204145034.4b69bdea36506be45946f8c9@linux-foundation.org>
In-Reply-To: <20181130195812.19536-5-josef@toxicpanda.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
        <20181130195812.19536-5-josef@toxicpanda.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 14:58:12 -0500 Josef Bacik <josef@toxicpanda.com> wrote:

> If we drop the mmap_sem we have to redo the vma lookup which requires
> redoing the fault handler.  Chances are we will just come back to the
> same page, so save this page in our vmf->cached_page and reuse it in the
> next loop through the fault handler.
> 

Is this really worthwhile?  Rerunning the fault handler is rare (we
hope) and a single pagecache lookup is fast.

Some performance testing results would be helpful here.  It's
practically obligatory when claiming a performance improvement.


