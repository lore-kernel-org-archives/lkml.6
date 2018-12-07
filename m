Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1E8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2BE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2BE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLGJsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:48:23 -0500
Received: from foss.arm.com ([217.140.101.70]:40476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbeLGJsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:48:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D6A7EBD;
        Fri,  7 Dec 2018 01:48:23 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DD693F59C;
        Fri,  7 Dec 2018 01:48:21 -0800 (PST)
Date:   Fri, 7 Dec 2018 09:48:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, kmemleak: Little optimization while scanning
Message-ID: <20181207094819.GA23085@arrakis.emea.arm.com>
References: <20181206131918.25099-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206131918.25099-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:19:18PM +0100, Oscar Salvador wrote:
> kmemleak_scan() goes through all online nodes and tries
> to scan all used pages.
> We can do better and use pfn_to_online_page(), so in case we have
> CONFIG_MEMORY_HOTPLUG, offlined pages will be skiped automatically.
> For boxes where CONFIG_MEMORY_HOTPLUG is not present, pfn_to_online_page()
> will fallback to pfn_valid().
> 
> Another little optimization is to check if the page belongs to the node
> we are currently checking, so in case we have nodes interleaved we will
> not check the same pfn multiple times.
> 
> I ran some tests:
> 
> Add some memory to node1 and node2 making it interleaved:
> 
> (qemu) object_add memory-backend-ram,id=ram0,size=1G
> (qemu) device_add pc-dimm,id=dimm0,memdev=ram0,node=1
> (qemu) object_add memory-backend-ram,id=ram1,size=1G
> (qemu) device_add pc-dimm,id=dimm1,memdev=ram1,node=2
> (qemu) object_add memory-backend-ram,id=ram2,size=1G
> (qemu) device_add pc-dimm,id=dimm2,memdev=ram2,node=1
> 
> Then, we offline that memory:
>  # for i in {32..39} ; do echo "offline" > /sys/devices/system/node/node1/memory$i/state;done
>  # for i in {48..55} ; do echo "offline" > /sys/devices/system/node/node1/memory$i/state;don
>  # for i in {40..47} ; do echo "offline" > /sys/devices/system/node/node2/memory$i/state;done
> 
> And we run kmemleak_scan:
> 
>  # echo "scan" > /sys/kernel/debug/kmemleak
> 
> before the patch:
> 
> kmemleak: time spend: 41596 us
> 
> after the patch:
> 
> kmemleak: time spend: 34899 us
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
