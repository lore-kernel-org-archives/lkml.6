Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D158C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC081214DB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544084893;
	bh=iqYnfUWBOP616PKEH+8CQx103WjSPHGfoC3UvwTCiLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H2ewxlaEtX/NoRBQNwoMOIixfUWJeyhYk0Rvf90QvWUg7kp8zBXXyDnX1X/H4RNfB
	 SXPlOth8yqqKFExV/CRFeRrVW6HEPqHmW4iQbm0lGaf3RUJfjUmtFkvbRBfE3bz7aV
	 2BCx3ACCEHd8EHJ0E99gDvw6c8iYXZtCN0jrbW2s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC081214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeLFI2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:28:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:43382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFI2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:28:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43833AD30;
        Thu,  6 Dec 2018 08:28:08 +0000 (UTC)
Date:   Thu, 6 Dec 2018 09:28:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181206082806.GB1286@dhcp22.suse.cz>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz>
 <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204085601.GC1286@dhcp22.suse.cz>
 <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz>
 <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz>
 <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-12-18 11:07:33, Pingfan Liu wrote:
> On Wed, Dec 5, 2018 at 5:40 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 12/5/18 10:29 AM, Pingfan Liu wrote:
> > >> [    0.007418] Early memory node ranges
> > >> [    0.007419]   node   1: [mem 0x0000000000001000-0x000000000008efff]
> > >> [    0.007420]   node   1: [mem 0x0000000000090000-0x000000000009ffff]
> > >> [    0.007422]   node   1: [mem 0x0000000000100000-0x000000005c3d6fff]
> > >> [    0.007422]   node   1: [mem 0x00000000643df000-0x0000000068ff7fff]
> > >> [    0.007423]   node   1: [mem 0x000000006c528000-0x000000006fffffff]
> > >> [    0.007424]   node   1: [mem 0x0000000100000000-0x000000047fffffff]
> > >> [    0.007425]   node   5: [mem 0x0000000480000000-0x000000087effffff]
> > >>
> > >> There is clearly no node2. Where did the driver get the node2 from?
> >
> > I don't understand these tables too much, but it seems the other nodes
> > exist without them:
> >
> > [    0.007393] SRAT: PXM 2 -> APIC 0x20 -> Node 2
> >
> > Maybe the nodes are hotplugable or something?
> >
> I also not sure about it, and just have a hurry look at acpi spec. I
> will reply it on another email, and Cced some acpi guys about it
> 
> > > Since using nr_cpus=4 , the node2 is not be instanced by x86 initalizing code.
> >
> > Indeed, nr_cpus seems to restrict what nodes we allocate and populate
> > zonelists for.
> 
> Yes, in init_cpu_to_node(),  since nr_cpus limits the possible cpu,
> which affects the loop for_each_possible_cpu(cpu) and skip the node2
> in this case.

THanks for pointing this out. It made my life easier. So It think the
bug is that we call init_memory_less_node from this path. I suspect
numa_register_memblks is the right place to do this. So I admit I
am not 100% sure but could you give this a try please?

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1308f5408bf7..4575ae4d5449 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -527,6 +527,19 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	}
 }
 
+static void __init init_memory_less_node(int nid)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0};
+	unsigned long zholes_size[MAX_NR_ZONES] = {0};
+
+	free_area_init_node(nid, zones_size, 0, zholes_size);
+
+	/*
+	 * All zonelists will be built later in start_kernel() after per cpu
+	 * areas are initialized.
+	 */
+}
+
 static int __init numa_register_memblks(struct numa_meminfo *mi)
 {
 	unsigned long uninitialized_var(pfn_align);
@@ -592,6 +605,8 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			continue;
 
 		alloc_node_data(nid);
+		if (!end)
+			init_memory_less_node(nid);
 	}
 
 	/* Dump memblock with node info and return. */
@@ -721,21 +736,6 @@ void __init x86_numa_init(void)
 	numa_init(dummy_numa_init);
 }
 
-static void __init init_memory_less_node(int nid)
-{
-	unsigned long zones_size[MAX_NR_ZONES] = {0};
-	unsigned long zholes_size[MAX_NR_ZONES] = {0};
-
-	/* Allocate and initialize node data. Memory-less node is now online.*/
-	alloc_node_data(nid);
-	free_area_init_node(nid, zones_size, 0, zholes_size);
-
-	/*
-	 * All zonelists will be built later in start_kernel() after per cpu
-	 * areas are initialized.
-	 */
-}
-
 /*
  * Setup early cpu_to_node.
  *
@@ -763,9 +763,6 @@ void __init init_cpu_to_node(void)
 		if (node == NUMA_NO_NODE)
 			continue;
 
-		if (!node_online(node))
-			init_memory_less_node(node);
-
 		numa_set_node(cpu, node);
 	}
 }
-- 
Michal Hocko
SUSE Labs
