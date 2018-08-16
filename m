Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4BA21479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4BA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeHPUbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:31:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbeHPUbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:31:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84C6A410BC3F;
        Thu, 16 Aug 2018 17:32:05 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D02132156712;
        Thu, 16 Aug 2018 17:32:02 +0000 (UTC)
Date:   Thu, 16 Aug 2018 13:32:01 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Pavel.Tatashin@microsoft.com,
        david@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180816173201.GC28097@redhat.com>
References: <20180807135221.GA3301@redhat.com>
 <20180807145900.GH10003@dhcp22.suse.cz>
 <20180807151810.GB3301@redhat.com>
 <20180808064758.GB27972@dhcp22.suse.cz>
 <20180808165814.GB3429@redhat.com>
 <20180809082415.GB24884@dhcp22.suse.cz>
 <20180809142709.GA3386@redhat.com>
 <20180809150950.GB15611@dhcp22.suse.cz>
 <20180809165821.GC3386@redhat.com>
 <20180816145849.GA17638@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816145849.GA17638@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 16 Aug 2018 17:32:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 16 Aug 2018 17:32:05 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 04:58:49PM +0200, Oscar Salvador wrote:
> On Thu, Aug 09, 2018 at 12:58:21PM -0400, Jerome Glisse wrote:
> > I agree, i never thought about that before. Looking at existing resource
> > management i think the simplest solution would be to use a refcount on the
> > resources instead of the IORESOURCE_BUSY flags.
> > 
> > So when you release resource as part of hotremove you would only dec the
> > refcount and a resource is not busy only when refcount is zero.
> > 
> > Just the idea i had in mind. Right now i am working on other thing, Oscar
> > is this something you would like to work on ? Feel free to come up with
> > something better than my first idea :)
> 
> So, I thought a bit about this.
> First I talked a bit with Jerome about the refcount idea.
> The problem with reconverting this to refcount is that it is too intrusive,
> and I think it is not really needed.
> 
> I then thought about defining a new flag, something like
> 
> #define IORESOURCE_NO_HOTREMOVE	xxx
> 
> but we ran out of bits for the flag field.
> 
> I then thought about doing something like:
> 
> struct resource {
>         resource_size_t start;
>         resource_size_t end;
>         const char *name;
>         unsigned long flags;
>         unsigned long desc;
>         struct resource *parent, *sibling, *child;
> #ifdef CONFIG_MEMORY_HOTREMOVE
>         bool device_managed;
> #endif
> };
> 
> but it is just too awful, not needed, and bytes consuming.

Agree the above is ugly.

> 
> The only idea I had left is:
> 
> register_memory_resource(), which defines a new resource for the added memory-chunk
> is only called from add_memory().
> This function is only being hit when we add memory-chunks.
> 
> HMM/devm gets the resources their own way, calling devm_request_mem_region().
> 
> So resources that are requested from HMM/devm, have the following flags:
> 
>  (IORESOURCE_MEM|IORESOURCE_BUSY)
> 
> while resources that are requested via mem-hotplug have:
> 
>  (IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY)
> 
> IORESOURCE_SYSTEM_RAM = (IORESOURCE_MEM|IORESOURCE_SYSRAM)
> 
> 
> release_mem_region_adjustable() is only being called from hot-remove path, so
> unless I am mistaken, all resources hitting that path should match IORESOURCE_SYSTEM_RAM.
> 
> That leaves me with the idea that we could check for the resource->flags to contain IORESOURCE_SYSRAM,
> as I think it is only being set for memory-chunks that are added via memory-hot-add path.
> 
> In case it is not, we know that that resource belongs to HMM/devm, so we can back off since
> they take care of releasing the resource via devm_release_mem_region.
> 
> I am working on a RFC v2 containing this, but, Jerome, could you confirm above assumption, please?

I think you nail it. I am not 100% sure about devm as i have not
followed closely how persistent memory can be reported by ACPI. But
i am pretty sure it should never end up as SYSRAM.

Thank you for scratching your head on this :)

Cheers,
Jérôme
