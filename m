Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40E2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70C20818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfBFQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:47:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727797AbfBFQrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:47:46 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A543F91B5040A52C41F5;
        Thu,  7 Feb 2019 00:47:40 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Feb 2019
 00:47:34 +0800
Date:   Wed, 6 Feb 2019 16:47:24 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
Message-ID: <20190206164724.000019c5@huawei.com>
In-Reply-To: <20190206161227.GH28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
        <20190124230724.10022-5-keith.busch@intel.com>
        <20190206122635.00005d37@huawei.com>
        <20190206161227.GH28064@localhost.localdomain>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 09:12:27 -0700
Keith Busch <keith.busch@intel.com> wrote:

> On Wed, Feb 06, 2019 at 04:26:35AM -0800, Jonathan Cameron wrote:
> > On Thu, 24 Jan 2019 16:07:18 -0700
> > Keith Busch <keith.busch@intel.com> wrote:  
> > > +What:		/sys/devices/system/node/nodeX/accessY/initiators/
> > > +Date:		December 2018
> > > +Contact:	Keith Busch <keith.busch@intel.com>
> > > +Description:
> > > +		The directory containing symlinks to memory initiator
> > > +		nodes that have class "Y" access to this target node's
> > > +		memory. CPUs and other memory initiators in nodes not in
> > > +		the list accessing this node's memory may have different
> > > +		performance.  
> > 
> > Also seems to contain the characteristics of those accesses.  
> 
> Right, but not in this patch. I will append the description for access
> characterisitics in the patch that adds those attributes.
>  
> > > + * 	This function will export node relationships linking which memory
> > > + * 	initiator nodes can access memory targets at a given ranked access
> > > + * 	class.
> > > + */
> > > +int register_memory_node_under_compute_node(unsigned int mem_nid,
> > > +					    unsigned int cpu_nid,
> > > +					    unsigned access)
> > > +{
> > > +	struct node *init_node, *targ_node;
> > > +	struct node_access_nodes *initiator, *target;
> > > +	int ret;
> > > +
> > > +	if (!node_online(cpu_nid) || !node_online(mem_nid))
> > > +		return -ENODEV;  
> > 
> > What do we do under memory/node hotplug?  More than likely that will
> > apply in such systems (it does in mine for starters).
> > Clearly to do the full story we would need _HMT support etc but
> > we can do the prebaked version by having hmat entries for nodes
> > that aren't online yet (like we do for SRAT).
> > 
> > Perhaps one for a follow up patch set.  However, I'd like an
> > pr_info to indicate that the node is listed but not online currently.  
> 
> Yes, hot plug is planned to follow on to this series.
> 
> > > +
> > > +	init_node = node_devices[cpu_nid];
> > > +	targ_node = node_devices[mem_nid];
> > > +	initiator = node_init_node_access(init_node, access);
> > > +	target = node_init_node_access(targ_node, access);
> > > +	if (!initiator || !target)
> > > +		return -ENOMEM;  
> >
> > If one of these fails and the other doesn't + the one that succeeded
> > did an init, don't we end up leaking a device here?  I'd expect this
> > function to not leave things hanging if it has an error. It should
> > unwind anything it has done.  It has been added to the list so
> > could be cleaned up later, but I'm not seeing that code. 
> > 
> > These only get cleaned up when the node is removed.  
> 
> The intiator-target relationship is many-to-many, so we don't want to
> free it just because we couldn't allocate its pairing node. The
> exisiting one may still be paired to others we were able to allocate.

Reference count them?  We have lots of paths that can result in
creation any of which might need cleaning up. Sounds like a classic
case for reference counts.

Jonathan


