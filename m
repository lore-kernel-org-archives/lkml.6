Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DADC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD2520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD2520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeILRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:25:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:49466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbeILRZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:25:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DECBCAD53;
        Wed, 12 Sep 2018 12:21:32 +0000 (UTC)
Date:   Wed, 12 Sep 2018 14:21:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zaslonko Mikhail <zaslonko@linux.vnet.ibm.com>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        osalvador@suse.de, gerald.schaefer@de.ibm.com
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Message-ID: <20180912122132.GF10951@dhcp22.suse.cz>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
 <04b427ad-df4e-67bd-2942-2a7a2cccf1aa@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b427ad-df4e-67bd-2942-2a7a2cccf1aa@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-09-18 16:06:23, Zaslonko Mikhail wrote:
[...]
> > Well, I am afraid this is not the proper solution. We are relying on the
> > full pageblock worth of initialized struct pages at many other place. We
> > used to do that in the past because we have initialized the full
> > section but this has been changed recently. Pavel, do you have any ideas
> > how to deal with this partial mem sections now?
> 
> I think this is not related to the recent changes of memory initialization.
> If
> you mean deferred init case, the problem exists even without
> CONFIG_DEFERRED_STRUCT_PAGE_INIT kernel option.

This is more about struct page initialization (which doesn't clear
whole) memmap area and as such it stays unitialized. So you are right
this is a much older issue we just happened to not notice without
explicit memmap poisoning.
-- 
Michal Hocko
SUSE Labs
