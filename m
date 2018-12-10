Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD7C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544445463;
	bh=W8ZmBzgMSJ78SbIfeUQJ66APXkWiLqnRkdsD2ApB/AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=acpLAO727YGV8EItaimQpFX51bLxuLBvUH74FdJObQEuEZVfvy2RfEnWQoccWRE7Q
	 O7fYJRXcrkSQ8iDNQd1YREHZv/FyQjZGm0zHnPe3sux32/NGAZCdqTcN5MbECoZmKa
	 L3O+8QsFP6ExoAubblJ4H8/rSsGQqZd5aMJ/s4ZA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD7C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeLJMhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:37:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:39186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbeLJMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:37:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28E54AF67;
        Mon, 10 Dec 2018 12:37:40 +0000 (UTC)
Date:   Mon, 10 Dec 2018 13:37:38 +0100
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
Message-ID: <20181210123738.GN1286@dhcp22.suse.cz>
References: <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz>
 <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz>
 <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz>
 <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz>
 <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
 <20181207155627.GG1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207155627.GG1286@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-12-18 16:56:27, Michal Hocko wrote:
> On Fri 07-12-18 22:27:13, Pingfan Liu wrote:
> [...]
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 1308f54..4dc497d 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -754,18 +754,23 @@ void __init init_cpu_to_node(void)
> >  {
> >         int cpu;
> >         u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
> > +       int node, nr;
> > 
> >         BUG_ON(cpu_to_apicid == NULL);
> > +       nr = cpumask_weight(cpu_possible_mask);
> > +
> > +       /* bring up all possible node, since dev->numa_node */
> > +       //should check acpi works for node possible,
> > +       for_each_node(node)
> > +               if (!node_online(node))
> > +                       init_memory_less_node(node);
> 
> I suspect there is no change if you replace for_each_node by
> 	for_each_node_mask(nid, node_possible_map)
> 
> here. If that is the case then we are probably calling
> free_area_init_node too early. I do not see it yet though.

OK, so it is not about calling it late or soon. It is just that
node_possible_map is a misnomer and it has a different semantic than
I've expected. numa_nodemask_from_meminfo simply considers only nodes
with some memory. So my patch didn't really make any difference and the
node stayed uninialized.

In other words. Does the following work? I am sorry to wildguess this
way but I am not able to recreate your setups to play with this myself.

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1308f5408bf7..d51643e10d00 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -216,8 +216,6 @@ static void __init alloc_node_data(int nid)
 
 	node_data[nid] = nd;
 	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
-
-	node_set_online(nid);
 }
 
 /**
@@ -527,6 +525,19 @@ static void __init numa_clear_kernel_node_hotplug(void)
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
@@ -570,7 +581,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 		return -EINVAL;
 
 	/* Finally register nodes. */
-	for_each_node_mask(nid, node_possible_map) {
+	for_each_node(nid) {
 		u64 start = PFN_PHYS(max_pfn);
 		u64 end = 0;
 
@@ -592,6 +603,10 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			continue;
 
 		alloc_node_data(nid);
+		if (!end)
+			init_memory_less_node(nid);
+		else
+			node_set_online(nid);
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
