Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFB1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD39F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545053720;
	bh=NKMR4vnnkuxo8J+gfei93Ay/kBvfZwSNUCDaIg+UBQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vtK/jFE09ySeOviEOr0qgqsSHeSZegAFg/C00NWLgHkQMBDnCsTZYnXpltTfqt3g3
	 qz0XYAogjR1gGCAfkFQ+jcVvhLzT2ePqQLLUtvq7I7qeHazXAMOsKHJv90Nf1YVhid
	 R1KRWlItnXujw0wRKjldAOTMncIU3kj5XZkxkh7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbeLQNfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:35:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:43244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732938AbeLQNfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:35:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 553F6ABD5;
        Mon, 17 Dec 2018 13:35:17 +0000 (UTC)
Date:   Mon, 17 Dec 2018 14:35:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
Message-ID: <20181217133516.GO30879@dhcp22.suse.cz>
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
 <20181212172712.34019-2-zaslonko@linux.ibm.com>
 <476a80cb-5524-16c1-6dd5-da5febbd6139@redhat.com>
 <bcd0c49c-e417-ef8b-996f-99ecef540d9c@redhat.com>
 <20181214202315.1c685f1e@thinkpad>
 <cffab731-81e0-b80c-665e-c9a62faed4ec@redhat.com>
 <20181217122812.GJ30879@dhcp22.suse.cz>
 <8b1bc4ff-0a30-573c-94c3-a8d943cd291c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b1bc4ff-0a30-573c-94c3-a8d943cd291c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-12-18 14:29:04, David Hildenbrand wrote:
> On 17.12.18 13:28, Michal Hocko wrote:
> > On Mon 17-12-18 10:38:32, David Hildenbrand wrote:
> > [...]
> >> I am wondering if we should fix this on the memblock level instead than.
> >> Something like, before handing memory over to the page allocator, add
> >> memory as reserved up to the last section boundary. Or even when setting
> >> the physical memory limit (mem= scenario).
> > 
> > Memory initialization is spread over several places and that makes it
> > really hard to grasp and maintain. I do not really see why we should
> > make memblock even more special. We do intialize the section worth of
> > memory here so it sounds like a proper place to quirk for incomplete
> > sections.
> > 
> 
> True as well. The reason I am asking is, that memblock usually takes
> care of physical memory holes.

Yes and no. It only reflects existing memory ranges (so yes it skips
over holes) and then it provides an API that platform/arch code can
abuse to cut holes into existing ranges.
-- 
Michal Hocko
SUSE Labs
