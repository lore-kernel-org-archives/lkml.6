Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAECC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF6F2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfARU0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:26:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbfARU0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:26:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A17737E8F;
        Fri, 18 Jan 2019 20:26:23 +0000 (UTC)
Received: from redhat.com (ovpn-123-236.rdu2.redhat.com [10.10.123.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EBB160BE8;
        Fri, 18 Jan 2019 20:26:20 +0000 (UTC)
Date:   Fri, 18 Jan 2019 15:26:18 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, dave@sr71.net,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com, fengguang.wu@intel.com,
        bp@suse.de, bhelgaas@google.com, baiyaowei@cmss.chinamobile.com,
        tiwai@suse.de
Subject: Re: [PATCH 2/4] mm/memory-hotplug: allow memory resources to be
 children
Message-ID: <20190118202618.GB3060@redhat.com>
References: <20190116181859.D1504459@viggo.jf.intel.com>
 <20190116181902.670EEBC3@viggo.jf.intel.com>
 <20190116191635.GD3617@redhat.com>
 <c6df9b8d-571d-3b4f-c528-dc176f8577e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6df9b8d-571d-3b4f-c528-dc176f8577e2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 18 Jan 2019 20:26:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:58:54AM -0800, Dave Hansen wrote:
> On 1/16/19 11:16 AM, Jerome Glisse wrote:
> >> We *could* also simply truncate the existing top-level
> >> "Persistent Memory" resource and take over the released address
> >> space.  But, this means that if we ever decide to hot-unplug the
> >> "RAM" and give it back, we need to recreate the original setup,
> >> which may mean going back to the BIOS tables.
> >>
> >> This should have no real effect on the existing collision
> >> detection because the areas that truly conflict should be marked
> >> IORESOURCE_BUSY.
> > 
> > Still i am worrying that this might allow device private to register
> > itself as a child of some un-busy resource as this patch obviously
> > change the behavior of register_memory_resource()
> > 
> > What about instead explicitly providing parent resource to add_memory()
> > and then to register_memory_resource() so if it is provided as an
> > argument (!NULL) then you can __request_region(arg_res, ...) otherwise
> > you keep existing code intact ?
> 
> We don't have the locking to do this, do we?  For instance, all the
> locking is done below register_memory_resource(), so any previous
> resource lookup is invalid by the time we get to register_memory_resource().

Yeah you are right, maybe just a bool then ? bool as_child

Cheers,
Jérôme
