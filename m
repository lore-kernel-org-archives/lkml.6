Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A76C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581D0223BD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581D0223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933987AbeGDJ0m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:26:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932399AbeGDJ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:26:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w649Itkq038214
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 05:26:36 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0t95kcg2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:26:36 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 05:26:35 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 05:26:32 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w649QVa87078330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 09:26:31 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F343AAE060;
        Wed,  4 Jul 2018 05:26:12 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0A25AE05C;
        Wed,  4 Jul 2018 05:26:12 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.79.210.176])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jul 2018 05:26:12 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 7F0F02E2F3F; Wed,  4 Jul 2018 13:39:19 +0530 (IST)
Date:   Wed, 4 Jul 2018 13:39:19 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/2] powerpc: Detect the presence of big-cores via
 "ibm, thread-groups"
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
 <b922aa0ea79a83ad733508c861900a08c4fee25a.1530609795.git.ego@linux.vnet.ibm.com>
 <20180703171655.GA6474@kermit-br-ibm-com.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703171655.GA6474@kermit-br-ibm-com.br.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18070409-0072-0000-0000-00000379DCE7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009307; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056354; UDB=6.00541880; IPR=6.00834276;
 MB=3.00021990; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-04 09:26:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070409-0073-0000-0000-0000489684BF
Message-Id: <20180704080919.GA1007@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Murilo,

Thanks for reviewing the patch. Replies inline.

On Tue, Jul 03, 2018 at 02:16:55PM -0300, Murilo Opsfelder Araujo wrote:
> On Tue, Jul 03, 2018 at 04:33:50PM +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > On IBM POWER9, the device tree exposes a property array identifed by
> > "ibm,thread-groups" which will indicate which groups of threads share a
> > particular set of resources.
> > 
> > As of today we only have one form of grouping identifying the group of
> > threads in the core that share the L1 cache, translation cache and
> > instruction data flow.
> > 
> > This patch defines the helper function to parse the contents of
> > "ibm,thread-groups" and a new structure to contain the parsed output.
> > 
> > The patch also creates the sysfs file named "small_core_siblings" that
> > returns the physical ids of the threads in the core that share the L1
> > cache, translation cache and instruction data flow.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  Documentation/ABI/testing/sysfs-devices-system-cpu |   8 ++
> >  arch/powerpc/include/asm/cputhreads.h              |  22 +++++
> >  arch/powerpc/kernel/setup-common.c                 | 110 +++++++++++++++++++++
> >  arch/powerpc/kernel/sysfs.c                        |  35 +++++++
> >  4 files changed, 175 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > index 9c5e7732..53a823a 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> > +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > @@ -487,3 +487,11 @@ Description:	Information about CPU vulnerabilities
> >  		"Not affected"	  CPU is not affected by the vulnerability
> >  		"Vulnerable"	  CPU is affected and no mitigation in effect
> >  		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
> > +
> > +What: 		/sys/devices/system/cpu/cpu[0-9]+/small_core_sibings
> 
> s/small_core_sibings/small_core_siblings

Nice catch! Will fix this. 
> 
> By the way, big_core_siblings was mentioned in the introductory
email.

It should be small_core_siblings in the introductory e-mail. My bad.


> 
> > +Date:		03-Jul-2018
> > +KernelVersion:	v4.18.0
> > +Contact:	Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > +Description:	List of Physical ids of CPUs which share the the L1 cache,
> > +		translation cache and instruction data-flow with this CPU.
> > +Values:		Comma separated list of decimal integers.

[..snip..]

> > +/*
> > + * parse_thread_groups: Parses the "ibm,thread-groups" device tree
> > + *                      property for the CPU device node dn and stores
> > + *                      the parsed output in the thread_groups
> > + *                      structure tg.
> 
> Perhaps document the arguments of this function, as done in the second
> patch?

Will do this. Thanks.

> 
> > + *
> > + * ibm,thread-groups[0..N-1] array defines which group of threads in
> > + * the CPU-device node can be grouped together based on the property.
> > + *
> > + * ibm,thread-groups[0] tells us the property based on which the
> > + * threads are being grouped together. If this value is 1, it implies
> > + * that the threads in the same group share L1, translation cache.
> > + *
> > + * ibm,thread-groups[1] tells us how many such thread groups exist.
> > + *
> > + * ibm,thread-groups[2] tells us the number of threads in each such
> > + * group.
> > + *
> > + * ibm,thread-groups[3..N-1] is the list of threads identified by
> > + * "ibm,ppc-interrupt-server#s" arranged as per their membership in
> > + * the grouping.
> > + *
> > + * Example: If ibm,thread-groups = [1,2,4,5,6,7,8,9,10,11,12] it
> > + * implies that there are 2 groups of 4 threads each, where each group
> > + * of threads share L1, translation cache.
> > + *
> > + * The "ibm,ppc-interrupt-server#s" of the first group is {5,6,7,8}
> > + * and the "ibm,ppc-interrupt-server#s" of the second group is {9, 10,
> > + * 11, 12} structure
> > + *
> > + * Returns 0 on success, -EINVAL if the property does not exist,
> > + * -ENODATA if property does not have a value, and -EOVERFLOW if the
> > + * property data isn't large enough.
> > + */
> > +int parse_thread_groups(struct device_node *dn,
> > +			struct thread_groups *tg)
> > +{
> > +	unsigned int nr_groups, threads_per_group, property;
> > +	int i;
> > +	u32 thread_group_array[3 + MAX_THREAD_LIST_SIZE];
> > +	u32 *thread_list;
> > +	size_t total_threads;
> > +	int ret;
> > +
> > +	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
> > +					 thread_group_array, 3);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	property = thread_group_array[0];
> > +	nr_groups = thread_group_array[1];
> > +	threads_per_group = thread_group_array[2];
> > +	total_threads = nr_groups * threads_per_group;
> > +
> > +	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
> > +					 thread_group_array,
> > +					 3 + total_threads);
> > +	if (ret)
> > +		return ret;
> > +
> > +	thread_list = &thread_group_array[3];
> > +
> > +	for (i = 0 ; i < total_threads; i++)
> > +		tg->thread_list[i] = thread_list[i];
> > +
> > +	tg->property = property;
> > +	tg->nr_groups = nr_groups;
> > +	tg->threads_per_group = threads_per_group;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * get_cpu_thread_group_start : Searches the thread group in tg->thread_list
> > + *                              that @cpu belongs to.
> 
> Same here.

Sure. 
> 
> > + *
> > + * Returns the index to tg->thread_list that points to the the start
> > + * of the thread_group that @cpu belongs to.
> > + *
> > + * Returns -1 if cpu doesn't belong to any of the groups pointed
> > + * to by tg->thread_list.
> > + */
> > +int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
> > +{
> > +	int hw_cpu_id = get_hard_smp_processor_id(cpu);
> > +	int i, j;
> > +
> > +	for (i = 0; i < tg->nr_groups; i++) {
> > +		int group_start = i * tg->threads_per_group;
> > +
> > +		for (j = 0; j < tg->threads_per_group; j++) {
> > +			int idx = group_start + j;
> > +
> > +			if (tg->thread_list[idx] == hw_cpu_id)
> > +				return group_start;
> > +		}
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> >  /**
> >   * setup_cpu_maps - initialize the following cpu maps:
> >   *                  cpu_possible_mask
> > @@ -467,6 +571,7 @@ void __init smp_setup_cpu_maps(void)
> >  		const __be32 *intserv;
> >  		__be32 cpu_be;
> >  		int j, len;
> > +		struct thread_groups tg = {.nr_groups = 0};
> 
> We assume has_big_cores = true but here we initialize .nr_groups
> otherwise.  It's kind of contradictory.

.nr_groups is being initialized to some sane value here. Perhaps I
should move the initializations of tg.nr_groups and tg.property inside
parse_thread_groups.

> 
> What if has_big_cores is assumed false and members of tg are initialized
> with zeroes?

The idea here is that after parsing all the CPU nodes, the variable
"has_big_cores" continues to remain to true if all the CPU nodes are
big cores. Even if one of them isn't a big core (not sure if this is
possible in practise) then we want to set it to false.

Hence we start with the assumption that has_big_cores is true, and
switch it on finding even one core that is not a big-core.

But I got to know that this is an overkill since if the component
small core is bad, the entire big-core is disabled. Thus it might be
sufficient to just check for one CPU node, if it is a big core or not,
and set the variable from "false" to "true".


> 
> >  
> >  		DBG("  * %pOF...\n", dn);
> >  
> > @@ -505,6 +610,11 @@ void __init smp_setup_cpu_maps(void)
> >  			cpu++;
> >  		}
> >  
> > +		if (parse_thread_groups(dn, &tg) ||
> > +		    tg.nr_groups < 1 || tg.property != 1) {
> > +			has_big_cores = false;
> > +		}
> > +
> 
> parse_thread_groups() returns before setting tg.property if property
> doesn't exist.  Are we confident that tg.property won't contain any
> garbage that could lead to a false positive here?  Shouldn't we also
> initialize .property when declaring tg?

Yes we should. Will move the initializations to parse_thread_groups.

> 
> What if this logic is encapsulated in a function?  For example:
> 
>     has_big_cores = dt_has_big_cores(dn, &tg);

Good idea.

> 
> >  		if (cpu >= nr_cpu_ids) {
> >  			of_node_put(dn);
> >  			break;
> > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
[..snip..]


Will address these changes in the subsequent patch series.
> 
> Cheers
> Murilo

--
Thanks and Regards
gautham.

