Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A65CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6489206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6489206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbeGZXaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:30:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731479AbeGZXaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:30:08 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2EAFC9B;
        Thu, 26 Jul 2018 22:11:19 +0000 (UTC)
Date:   Thu, 26 Jul 2018 15:11:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com>
Cc:     "Michal Hocko" <mhocko@kernel.org>,
        mgorman <mgorman@techsingularity.net>,
        minchan <minchan@kernel.org>, vinmenon <vinmenon@codeaurora.org>,
        hannes <hannes@cmpxchg.org>,
        "hillf.zj" <hillf.zj@alibaba-inc.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hugh Dickins" <hughd@google.com>
Subject: Re: [PATCH] [PATCH] mm: disable preemption before swapcache_free
Message-Id: <20180726151118.db0cf8016e79bed849e549f9@linux-foundation.org>
In-Reply-To: <20180726150323057627100@wingtech.com>
References: <2018072514375722198958@wingtech.com>
        <20180725141643.6d9ba86a9698bc2580836618@linux-foundation.org>
        <2018072610214038358990@wingtech.com>
        <20180726060640.GQ28386@dhcp22.suse.cz>
        <20180726150323057627100@wingtech.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 15:03:23 +0800 "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com> wrote:

> >On Thu 26-07-18 10:21:40, zhaowuyun@wingtech.com wrote:
> >[...]
> >> Our project really needs a fix to this issue
> >
> >Could you be more specific why? My understanding is that RT tasks
> >usually have all the memory mlocked otherwise all the real time
> >expectations are gone already.
> >--
> >Michal Hocko
> >SUSE Labs 
> 
> 
> The RT thread is created by a process with normal priority, and the process was sleep, 
> then some task needs the RT thread to do something, so the process create this thread, and set it to RT policy.
> I think that is the reason why RT task would read the swap.

A simpler bandaid might be to replace the cond_resched() with msleep(1).
