Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFA920820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFA920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439643AbeKWXow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:44:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:40150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731971AbeKWXov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:44:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F35BAECE;
        Fri, 23 Nov 2018 13:00:44 +0000 (UTC)
Date:   Fri, 23 Nov 2018 14:00:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.com>
Cc:     linux-mm@kvack.org, david@redhat.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, arunks@codeaurora.org, bhe@redhat.com,
        dan.j.williams@intel.com, Pavel.Tatashin@microsoft.com,
        Jonathan.Cameron@huawei.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-ID: <20181123130043.GM8625@dhcp22.suse.cz>
References: <20181116101222.16581-1-osalvador@suse.com>
 <20181116101222.16581-3-osalvador@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116101222.16581-3-osalvador@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Alexander - email thread starts http://lkml.kernel.org/r/20181116101222.16581-1-osalvador@suse.com]

On Fri 16-11-18 11:12:20, Oscar Salvador wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> arch_add_memory, __add_pages take a want_memblock which controls whether
> the newly added memory should get the sysfs memblock user API (e.g.
> ZONE_DEVICE users do not want/need this interface). Some callers even
> want to control where do we allocate the memmap from by configuring
> altmap. This is currently done quite ugly by searching for altmap down
> in memory hotplug (to_vmem_altmap). It should be the caller to provide
> the altmap down the call chain.
> 
> Add a more generic hotplug context for arch_add_memory and __add_pages.
> struct mhp_restrictions contains flags which contains additional
> features to be enabled by the memory hotplug (MHP_MEMBLOCK_API
> currently) and altmap for alternative memmap allocator.

One note here as well. In the retrospect the API I have come up
with here is quite hackish. Considering the recent discussion about
special needs ZONE_DEVICE has for both initialization and struct page
allocations with Alexander Duyck I believe we wanted a more abstracted
API with allocator and constructor callbacks. This would allow different
usecases to fine tune their needs without specialcasing deep in the core
hotplug code paths.
-- 
Michal Hocko
SUSE Labs
