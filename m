Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1590AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E349C2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfBSRUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:20:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:59429 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfBSRUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:20:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 09:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="134708934"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Feb 2019 09:20:10 -0800
Date:   Tue, 19 Feb 2019 10:20:07 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv6 00/10] Heterogenous memory node attributes
Message-ID: <20190219172004.GD16341@localhost.localdomain>
References: <20190214171017.9362-1-keith.busch@intel.com>
 <f2add663-a9e1-86df-0afd-22ef03d3d943@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2add663-a9e1-86df-0afd-22ef03d3d943@inria.fr>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 03:25:31PM +0100, Brice Goglin wrote:
> Le 14/02/2019 à 18:10, Keith Busch a écrit :
> >   Determining the cpu and memory node local relationships is quite
> >   different this time (PATCH 7/10). The local relationship to a memory
> >   target will be either *only* the node from the Initiator Proximity
> >   Domain if provided, or if it is not provided, all the nodes that have
> >   the same highest performance. Latency was chosen to take prioirty over
> >   bandwidth when ranking performance.
> 
> 
> Hello Keith
> 
> I am trying to understand what this last paragraph means.
> 
> Let's say I have a machine with DDR and NVDIMM both attached to the same
> socket, and I use Dave Hansen's kmem patchs to make the NVDIMM appear as
> "normal memory" in an additional NUMA node. Let's call node0 the DDR and
> node1 the NVDIMM kmem node.
> 
> Now user-space wants to find out which CPUs are actually close to the
> NVDIMMs. My understanding is that SRAT says that CPUs are local to the
> DDR only. Hence /sys/devices/system/node/node1/cpumap says there are no
> CPU local to the NVDIMM. And HMAT won't change this, right?

HMAT actually does change this. The relationship is in 6.2's HMAT
Address Range or 6.3's Proximity Domain Attributes, and that's
something SRAT wasn't providing.

The problem with these HMAT structures is that the CPU node is
optional. The last paragraph is saying that if that optional information
is provided, we will use that. If it is not provided, we will fallback
to performance attributes to determine what is the "local" CPU domain.
 
> Will node1 contain access0/initiators/node0 to clarify that CPUs local
> to the NVDIMM are those of node0? Even if latency from node0 to node1
> latency is higher than node0 to node0?

Exactly, yes. To expand on this, what you'd see from sysfs:

  /sys/devices/system/node/node0/access0/targets/node1 -> ../../../node1

And

  /sys/devices/system/node/node1/access0/initiators/node0 -> ../../../node0

> Another way to ask this: Is the latency/performance only used for
> distinguishing the local initiator CPUs among multiple CPU nodes
> accesing the same memory node? Or is it also used to distinguish the
> local memory target among multiple memories access by a single CPU node?

It's the first one. A single CPU domain may have multiple local targets,
but each of those targets may have different performance.

For example, you could have something like this with "normal" DDR
memory, high-bandwidth memory, and slower nvdimm:

 +------------------+    +------------------+
 | CPU Node 0       +----+ CPU Node 1       |
 | Node0 DDR Mem    |    | Node1 DDR Mem    |
 +--------+---------+    +--------+---------+
          |                       |
 +--------+---------+    +--------+---------+
 | Node2 HBMem      |    | Node3 HBMem      |
 +--------+---------+    +--------+---------+
          |                       |
 +--------+---------+    +--------+---------+
 | Node4 Slow NVMem |    | Node5 Slow NVMem |
 +------------------+    +------------------+

In the above, Initiator node0 is "local" to targets 0, 2, and 4, and
would show up in node0's access0/targets/. Each memory target node,
though, has different performance than the others that are local to the
same intiator domain.

> The Intel machine I am currently testing patches on doesn't have a HMAT
> in 1-level-memory unfortunately.

Platforms providing HMAT tables are still rare at the moment, but expect
will become more common.
