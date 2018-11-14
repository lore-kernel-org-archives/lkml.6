Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF1521780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF1521780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbeKOBLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:11:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:42116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728116AbeKOBLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:11:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C2D8AEFA;
        Wed, 14 Nov 2018 15:07:43 +0000 (UTC)
Date:   Wed, 14 Nov 2018 16:07:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-ID: <20181114150742.GZ23419@dhcp22.suse.cz>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 13:19:25, Alexander Duyck wrote:
> This patchset is essentially a refactor of the page initialization logic
> that is meant to provide for better code reuse while providing a
> significant improvement in deferred page initialization performance.
> 
> In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
> memory per node I have seen the following. In the case of regular memory
> initialization the deferred init time was decreased from 3.75s to 1.06s on
> average. For the persistent memory the initialization time dropped from
> 24.17s to 19.12s on average. This amounts to a 253% improvement for the
> deferred memory initialization performance, and a 26% improvement in the
> persistent memory initialization performance.
> 
> I have called out the improvement observed with each patch.

I have only glanced through the code (there is a lot of the code to look
at here). And I do not like the code duplication and the way how you
make the hotplug special. There shouldn't be any real reason for that
IMHO (e.g. why do we init pfn-at-a-time in early init while we do
pageblock-at-a-time for hotplug). I might be wrong here and the code
reuse might be really hard to achieve though.

I am also not impressed by new iterators because this api is quite
complex already. But this is mostly a detail.

Thing I do not like is that you keep microptimizing PageReserved part
while there shouldn't be anything fundamental about it. We should just
remove it rather than make the code more complex. I fell more and more
guilty to add there actually.
-- 
Michal Hocko
SUSE Labs
