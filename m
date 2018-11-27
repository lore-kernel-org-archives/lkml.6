Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A54C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A754205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A754205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeK1Eqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:46:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:24189 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeK1Eqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:46:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 09:47:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="277684420"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2018 09:47:57 -0800
Date:   Tue, 27 Nov 2018 10:44:57 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH 2/7] node: Add heterogenous memory performance
Message-ID: <20181127174457.GB6401@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-3-keith.busch@intel.com>
 <CAPcyv4jNpgzpfG1awrxspTeQ1JOK-4-Wu6Kb6cd6NGY6Atj3cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jNpgzpfG1awrxspTeQ1JOK-4-Wu6Kb6cd6NGY6Atj3cg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:00:09PM -0800, Dan Williams wrote:
> On Wed, Nov 14, 2018 at 2:53 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > Heterogeneous memory systems provide memory nodes with latency
> > and bandwidth performance attributes that are different from other
> > nodes. Create an interface for the kernel to register these attributes
> > under the node that provides the memory. If the system provides this
> > information, applications can query the node attributes when deciding
> > which node to request memory.
> >
> > When multiple memory initiators exist, accessing the same memory target
> > from each may not perform the same as the other. The highest performing
> > initiator to a given target is considered to be a local initiator for
> > that target. The kernel provides performance attributes only for the
> > local initiators.
> >
> > The memory's compute node should be symlinked in sysfs as one of the
> > node's initiators.
> >
> > The following example shows the new sysfs hierarchy for a node exporting
> > performance attributes:
> >
> >   # tree /sys/devices/system/node/nodeY/initiator_access
> >   /sys/devices/system/node/nodeY/initiator_access
> >   |-- read_bandwidth
> >   |-- read_latency
> >   |-- write_bandwidth
> >   `-- write_latency
> 
> With the expectation that there will be nodes that are initiator-only,
> target-only, or both I think this interface should indicate that. The
> 1:1 "local" designation of HMAT should not be directly encoded in the
> interface, it's just a shortcut for finding at least one initiator in
> the set that can realize the advertised performance. At least if the
> interface can enumerate the set of initiators then it becomes clear
> whether sysfs can answer a performance enumeration question or if the
> application needs to consult an interface with specific knowledge of a
> given initiator-target pairing.
> 
> It seems a precursor to these patches is arranges for offline node
> devices to be created for the ACPI proximity domains that are
> offline-by default for reserved memory ranges.

The intention is that all initiators symlinked to the memory node share
the initiator_access attributes, as well as itself the node is its own
initiator. There's no limit to how many the new kernel interface in
patch 1/7 allows you to register, so it's not really a 1:1 relationship.

Either instead or in addition to the symlinks, we can export a node_mask
in the initiator_access directory for which these access attributes
apply if that makes the intention more clear.
