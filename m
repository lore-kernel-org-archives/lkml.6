Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12BBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B087620820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B087620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439687AbeKWXtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:49:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:40836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403801AbeKWXtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:49:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 479F9AC38;
        Fri, 23 Nov 2018 13:05:47 +0000 (UTC)
Date:   Fri, 23 Nov 2018 14:05:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1] mm/memory_hotplug: drop "online" parameter from
 add_memory_resource()
Message-ID: <20181123130546.GN8625@dhcp22.suse.cz>
References: <20181123123740.27652-1-david@redhat.com>
 <20181123125400.GL8625@dhcp22.suse.cz>
 <a97fcf28-ef71-2b49-c25c-bc96cff8366b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97fcf28-ef71-2b49-c25c-bc96cff8366b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 13:58:16, David Hildenbrand wrote:
> On 23.11.18 13:54, Michal Hocko wrote:
> > On Fri 23-11-18 13:37:40, David Hildenbrand wrote:
> >> User space should always be in charge of how to online memory and
> >> if memory should be onlined automatically in the kernel. Let's drop the
> >> parameter to overwrite this - XEN passes memhp_auto_online, just like
> >> add_memory(), so we can directly use that instead internally.
> > 
> > Heh, I wanted to get rid of memhp_auto_online so much and now we have it
> > in the core memory_hotplug. Not a win on my side I would say :/
> 
> That is actually a good point: Can we remove memhp_auto_online or is it
> already some sort of kernel ABI?
> 
> (as it is exported via /sys/devices/system/memory/auto_online_blocks)

I have tried and there was a pushback [1]. That led to a rework of the
sysfs semantic of onlining btw. The biggest objection against removing was
that the userspace might be too slow to online memory and memmaps could
eat the available memory and trigger OOM. That is why I've started
working on the self hosted memmpas but failed to finish it. Fortunatelly
Oscar is brave enough to continue in that work.

[1] http://lkml.kernel.org/r/20170227092817.23571-1-mhocko@kernel.org
-- 
Michal Hocko
SUSE Labs
