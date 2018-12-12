Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53835C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29BF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544615626;
	bh=l77KoBYSIhnEp/UpOKjdX6Brybe6q6/LhTUDlc05tr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ts366/XcC/pghB4dJuEO57z6wyOYdK4elsnAaSMRJ0rrTwdzbWT6Xo1GbZfL4LoPO
	 turAj2jpCTmxnC7qUMOwX1Y+vL9S+FaB8+ylqE/If9Ue8aiM22r1iD9W43qUvrqC5e
	 pKFwgbhIvQojT1ZeCqx1UI5UQqh12JZmo2JnlD7Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29BF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeLLLxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:53:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:55010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbeLLLxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:53:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B45FFABCB;
        Wed, 12 Dec 2018 11:53:41 +0000 (UTC)
Date:   Wed, 12 Dec 2018 12:53:40 +0100
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
Message-ID: <20181212115340.GQ1286@dhcp22.suse.cz>
References: <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz>
 <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz>
 <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz>
 <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
 <20181207155627.GG1286@dhcp22.suse.cz>
 <20181210123738.GN1286@dhcp22.suse.cz>
 <CAFgQCTupPc1rKv2SrmWD+eJ0H6PRaizPBw3+AG67_PuLA2SKFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTupPc1rKv2SrmWD+eJ0H6PRaizPBw3+AG67_PuLA2SKFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-12-18 16:31:35, Pingfan Liu wrote:
> On Mon, Dec 10, 2018 at 8:37 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> [...]
> >
> > In other words. Does the following work? I am sorry to wildguess this
> > way but I am not able to recreate your setups to play with this myself.
> >
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 1308f5408bf7..d51643e10d00 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -216,8 +216,6 @@ static void __init alloc_node_data(int nid)
> >
> >         node_data[nid] = nd;
> >         memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> > -
> > -       node_set_online(nid);
> >  }
> >
> >  /**
> > @@ -527,6 +525,19 @@ static void __init numa_clear_kernel_node_hotplug(void)
> >         }
> >  }
> >
> > +static void __init init_memory_less_node(int nid)
> > +{
> > +       unsigned long zones_size[MAX_NR_ZONES] = {0};
> > +       unsigned long zholes_size[MAX_NR_ZONES] = {0};
> > +
> > +       free_area_init_node(nid, zones_size, 0, zholes_size);
> > +
> > +       /*
> > +        * All zonelists will be built later in start_kernel() after per cpu
> > +        * areas are initialized.
> > +        */
> > +}
> > +
> >  static int __init numa_register_memblks(struct numa_meminfo *mi)
> >  {
> >         unsigned long uninitialized_var(pfn_align);
> > @@ -570,7 +581,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
> >                 return -EINVAL;
> >
> >         /* Finally register nodes. */
> > -       for_each_node_mask(nid, node_possible_map) {
> > +       for_each_node(nid) {
> >                 u64 start = PFN_PHYS(max_pfn);
> >                 u64 end = 0;
> >
> > @@ -592,6 +603,10 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
> >                         continue;
> >
> >                 alloc_node_data(nid);
> > +               if (!end)
> 
> Here comes the bug, since !end can not reach here.

You are right. I am dumb. I've just completely missed that. Sigh.
Anyway, I think the code is more complicated than necessary and we can
simply drop the check. I do not think we really have to worry about
the start overflowing end. So the end patch should look as follows.
Btw. I believe it is better to pull alloc_node_data out of init_memory_less_node
because a) there is no need to duplicate the call and moreover we want
to pull node_set_online as well. The code also seems cleaner this way.

Thanks for your testing and your patience with me here.

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1308f5408bf7..a5548fe668fb 100644
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
 
@@ -581,9 +592,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			end = max(mi->blk[i].end, end);
 		}
 
-		if (start >= end)
-			continue;
-
 		/*
 		 * Don't confuse VM with a node that doesn't have the
 		 * minimum amount of memory:
@@ -592,6 +600,10 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			continue;
 
 		alloc_node_data(nid);
+		if (!end)
+			init_memory_less_node(nid);
+		else
+			node_set_online(nid);
 	}
 
 	/* Dump memblock with node info and return. */
@@ -721,21 +733,6 @@ void __init x86_numa_init(void)
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
@@ -763,9 +760,6 @@ void __init init_cpu_to_node(void)
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
