Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE98C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF320855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDF320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeKZLwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:52:50 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:62255 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKZLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:52:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,280,1539648000"; 
   d="scan'208";a="71436163"
Subject: Re: [Xen-devel] [PATCH v3] xen/balloon: Mark unallocated host memory
 as UNUSABLE
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <xen-devel@lists.xen.org>, <linux-kernel@vger.kernel.org>
CC:     <jgross@suse.com>, <helgaas@kernel.org>,
        <christian.koenig@amd.com>, <JBeulich@suse.com>
References: <1513778746-6155-1-git-send-email-boris.ostrovsky@oracle.com>
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <7c833e3a-4a0b-e80c-91e2-4348d6959651@citrix.com>
Date:   Mon, 26 Nov 2018 01:00:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1513778746-6155-1-git-send-email-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2017 14:05, Boris Ostrovsky wrote:
> Commit f5775e0b6116 ("x86/xen: discard RAM regions above the maximum
> reservation") left host memory not assigned to dom0 as available for
> memory hotplug.
> 
> Unfortunately this also meant that those regions could be used by
> others. Specifically, commit fa564ad96366 ("x86/PCI: Enable a 64bit BAR
> on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)") may try to map those
> addresses as MMIO.
> 
> To prevent this mark unallocated host memory as E820_TYPE_UNUSABLE (thus
> effectively reverting f5775e0b6116) and keep track of that region as
> a hostmem resource that can be used for the hotplug.
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

This commit breaks Xen balloon memory hotplug for us in Dom0 with
"hoplug_unpopulated" set to 1. The issue is that the common kernel
memory onlining procedures require "System RAM" resource to be 1-st
level. That means by inserting it under "Unusable memory" as the commit
above does (intentionally or not) we make it 2-nd level and break memory
onlining.

There are multiple ways to fix it depending on what was the intention of
original commit and what exactly it tried to workaround. It seems it
does several things at once:
1) Marks non-Dom0 host memory "Unusable memory" in resource tree.
2) Keeps track of all the areas safe for hotplug in Dom0
3) Changes allocation algorithms itself in balloon driver to use those areas

Are all the things above necessary to cover the issue in fa564ad96366
("x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f,
60-7f)")?

Can we remove "Unusable memory" resources as soon as we finished
booting? Is removing on-demand is preferable over "shoot them all" in
that case?

Does it even make sense to remove the 1-st level only restriction in
kernel/resource.c ?

Igor
