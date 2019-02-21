Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B504C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B632084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfBURK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:10:26 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:41059 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbfBURKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:10:25 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 1AD7E1C1D6C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 17:10:24 +0000 (GMT)
Received: (qmail 18951 invoked from network); 21 Feb 2019 17:10:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Feb 2019 17:10:23 -0000
Date:   Thu, 21 Feb 2019 17:10:22 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Lars Persson <lars.persson@axis.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Lars Persson <larper@axis.com>
Subject: Re: [PATCH] mm: migrate: add missing flush_dcache_page for
 non-mapped page migrate
Message-ID: <20190221171022.GX9565@techsingularity.net>
References: <20190219123212.29838-1-larper@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190219123212.29838-1-larper@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:32:12PM +0100, Lars Persson wrote:
> Our MIPS 1004Kc SoCs were seeing random userspace crashes with SIGILL
> and SIGSEGV that could not be traced back to a userspace code
> bug. They had all the magic signs of an I/D cache coherency issue.
> 
> Now recently we noticed that the /proc/sys/vm/compact_memory interface
> was quite efficient at provoking this class of userspace crashes.
> 
> Studying the code in mm/migrate.c there is a distinction made between
> migrating a page that is mapped at the instant of migration and one
> that is not mapped. Our problem turned out to be the non-mapped pages.
> 
> For the non-mapped page the code performs a copy of the page content
> and all relevant meta-data of the page without doing the required
> D-cache maintenance. This leaves dirty data in the D-cache of the CPU
> and on the 1004K cores this data is not visible to the I-cache. A
> subsequent page-fault that triggers a mapping of the page will happily
> serve the process with potentially stale code.
> 
> What about ARM then, this bug should have seen greater exposure? Well
> ARM became immune to this flaw back in 2010, see commit c01778001a4f
> ("ARM: 6379/1: Assume new page cache pages have dirty D-cache").
> 
> My proposed fix moves the D-cache maintenance inside move_to_new_page
> to make it common for both cases.
> 
> Signed-off-by: Lars Persson <larper@axis.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
