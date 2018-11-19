Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1C220831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1C220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbeKTCQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:16:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:16866 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729825AbeKTCQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:16:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 07:52:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="90491396"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 19 Nov 2018 07:52:53 -0800
Date:   Mon, 19 Nov 2018 08:49:37 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Message-ID: <20181119154937.GD23062@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
 <20181115203654.GA28246@bombadil.infradead.org>
 <20181116183254.GD14630@localhost.localdomain>
 <d5c7a267-840b-f253-ef0d-3715b2bcc196@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5c7a267-840b-f253-ef0d-3715b2bcc196@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 08:45:25AM +0530, Anshuman Khandual wrote:
> On 11/17/2018 12:02 AM, Keith Busch wrote:
> > On Thu, Nov 15, 2018 at 12:36:54PM -0800, Matthew Wilcox wrote:
> >> So ... let's imagine a hypothetical system (I've never seen one built like
> >> this, but it doesn't seem too implausible).  Connect four CPU sockets in
> >> a square, each of which has some regular DIMMs attached to it.  CPU A is
> >> 0 hops to Memory A, one hop to Memory B and Memory C, and two hops from
> >> Memory D (each CPU only has two "QPI" links).  Then maybe there's some
> >> special memory extender device attached on the PCIe bus.  Now there's
> >> Memory B1 and B2 that's attached to CPU B and it's local to CPU B, but
> >> not as local as Memory B is ... and we'd probably _prefer_ to allocate
> >> memory for CPU A from Memory B1 than from Memory D.  But ... *mumble*,
> >> this seems hard.
> > 
> > Indeed, that particular example is out of scope for this series. The
> > first objective is to aid a process running in node B's CPUs to allocate
> > memory in B1. Anything that crosses QPI are their own.
> 
> This is problematic. Any new kernel API interface should accommodate B2 type
> memory as well from the above example which is on a PCIe bus. Because
> eventually they would be represented as some sort of a NUMA node and then
> applications will have to depend on this sysfs interface for their desired
> memory placement requirements. Unless this interface is thought through for
> B2 type of memory, it might not be extensible in the future.

I'm not sure I understand the concern. The proposal allows linking B
to B2 memory.
