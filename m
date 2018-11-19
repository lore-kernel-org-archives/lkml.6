Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2871AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94FD20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94FD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeKTCNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:13:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:48104 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbeKTCNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:13:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 07:49:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="281227482"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2018 07:49:21 -0800
Date:   Mon, 19 Nov 2018 08:46:05 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/7] node: Add heterogenous memory performance
Message-ID: <20181119154604.GC23062@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-3-keith.busch@intel.com>
 <91369e94-d389-7cb9-6274-f46c9ec779d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91369e94-d389-7cb9-6274-f46c9ec779d3@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:05:07AM +0530, Anshuman Khandual wrote:
> On 11/15/2018 04:19 AM, Keith Busch wrote:
> > Heterogeneous memory systems provide memory nodes with latency
> > and bandwidth performance attributes that are different from other
> > nodes. Create an interface for the kernel to register these attributes
> 
> There are other properties like power consumption, reliability which can
> be associated with a particular PA range. Also the set of properties has
> to be extensible for the future.

Sure, I'm just starting with the attributes available from HMAT, 
If there are additional possible attributes that make sense to add, I
don't see why we can't continue appending them if this patch is okay.
 
> > under the node that provides the memory. If the system provides this
> > information, applications can query the node attributes when deciding
> > which node to request memory.
> 
> Right but each (memory initiator, memory target) should have these above
> mentioned properties enumerated to have an 'property as seen' from kind
> of semantics.
> 
> > 
> > When multiple memory initiators exist, accessing the same memory target
> > from each may not perform the same as the other. The highest performing
> > initiator to a given target is considered to be a local initiator for
> > that target. The kernel provides performance attributes only for the
> > local initiators.
> 
> As mentioned above the interface must enumerate a future extensible set
> of properties for each (memory initiator, memory target) pair available
> on the system.

That seems less friendly to use if forces the application to figure out
which CPU is the best for a given memory node rather than just provide
that answer directly.

> > The memory's compute node should be symlinked in sysfs as one of the
> > node's initiators.
> 
> Right. IIUC the first patch skips the linking process of for two nodes A
> and B if (A == B) preventing association to local memory initiator.

Right, CPUs and memory sharing a proximity domain are assumed to be
local to each other, so not going to set up those links to itself.
