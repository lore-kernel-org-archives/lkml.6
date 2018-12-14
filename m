Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C8C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CF12080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544782814;
	bh=G3dkshRg+2110oTMG3/xykQ16ImcfJcGdNGSRIteNXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=do8GrhwoY7DVmVr09tsd8TuK572oMpYTwF+VeFecc6rpZVDf9c89ZMRqO/NglOBe3
	 6Vl+MyTe27gn3H9jY2VYL8KSr1QnGLhA5K3P2r80S4hvtmr5uBRldw/WrM+wMl6Rmu
	 v7U/iU44RGzFteGwpJTYVBZVOIzZBt2rKdSfQLqI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CF12080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbeLNKUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:20:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:52486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbeLNKUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:20:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C74B4AD85;
        Fri, 14 Dec 2018 10:20:00 +0000 (UTC)
Date:   Fri, 14 Dec 2018 11:19:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
Message-ID: <20181214101651.GE5624@dhcp22.suse.cz>
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
 <20181212172712.34019-2-zaslonko@linux.ibm.com>
 <20181213034615.4ntpo4cl2oo5mcx4@master>
 <e4cebbae-3fcb-f03c-3d0e-a1a44ff0675a@linux.bm.com>
 <20181213151209.hmrhrr5gvb256bzm@master>
 <674c53e2-e4b3-f21f-4613-b149acef7e53@linux.bm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674c53e2-e4b3-f21f-4613-b149acef7e53@linux.bm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Your From address seems to have a typo (linux.bm.com) - fixed]

On Fri 14-12-18 10:33:55, Zaslonko Mikhail wrote:
[...]
> Yes, it might still trigger PF_POISONED_CHECK if the first page 
> of the pageblock is left uninitialized (poisoned).
> But in order to cover these exceptional cases we would need to 
> adjust memory_hotplug sysfs handler functions with similar 
> checks (as in the for loop of memmap_init_zone()). And I guess 
> that is what we were trying to avoid (adding special cases to 
> memory_hotplug paths).

is_mem_section_removable should test pfn_valid_within at least.
But that would require some care because next_active_pageblock expects
aligned pages. Ble, this code is just horrible. I would just remove it
altogether. I strongly suspect that nobody is using it for anything
reasonable anyway. The only reliable way to check whether a block is
removable is to remove it. Everything else is just racy.

-- 
Michal Hocko
SUSE Labs
