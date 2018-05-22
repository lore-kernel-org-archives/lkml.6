Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeEVEej (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 00:34:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750733AbeEVEei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 00:34:38 -0400
Date: Tue, 22 May 2018 10:04:30 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc: Detect the presence of big-core with
 interleaved threads
Reply-To: ego@linux.vnet.ibm.com
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
 <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com>
 <87h8n5xfot.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8n5xfot.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18052204-0024-0000-0000-000018745FA4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009064; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035844; UDB=6.00529854; IPR=6.00814972;
 MB=3.00021230; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 04:34:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052204-0025-0000-0000-000050179DAF
Message-Id: <20180522043430.GB5213@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On Fri, May 18, 2018 at 11:21:22PM +1000, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> > index 0af5c11..884dff2 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -436,8 +438,56 @@ static void __init cpu_init_thread_core_maps(int tpc)
> >  	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
> >  }
> >  
> > -
> >  u32 *cpu_to_phys_id = NULL;
> > +/*
> > + * check_for_interleaved_big_core - Checks if the core represented by
> > + *	 dn is a big-core whose threads are interleavings of the
> > + *	 threads of the component small cores.
> > + *
> > + * @dn: device node corresponding to the core.
> > + *
> > + * Returns true if the core is a interleaved big-core.
> > + * Returns false otherwise.
> > + */
> > +static inline bool check_for_interleaved_big_core(struct device_node *dn)
> > +{
> > +	int len, nr_groups, threads_per_group;
> > +	const __be32 *thread_groups;
> > +	__be32 *thread_list, *first_cpu_idx;
> > +	int cur_cpu, next_cpu, i, j;
> > +
> > +	thread_groups = of_get_property(dn, "ibm,thread-groups", &len);
> > +	if (!thread_groups)
> > +		return false;
> 
> There are better device tree APIs than bare of_get_property() these
> days, can you try to use those?

Ok, I will use them.

> 
> > +	nr_groups = be32_to_cpu(*(thread_groups + 1));
> > +	if (nr_groups <= 1)
> > +		return false;
> 
> eg. this would be of_property_read_u32_index()
> 

Ok.

> > @@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
> >  	vdso_data->processorCount = num_present_cpus();
> >  #endif /* CONFIG_PPC64 */
> >  
> > -        /* Initialize CPU <=> thread mapping/
> > +	dn = of_find_node_by_type(NULL, "cpu");
> > +	if (dn) {
> > +		if (check_for_interleaved_big_core(dn)) {
> > +			has_interleaved_big_core = true;
> > +			pr_info("Detected interleaved big-cores\n");
> > +		}
> > +		of_node_put(dn);
> > +	}
> 
> This is a bit untidy, given how unlikely it is that you would have no
> CPUs :)

This can actually go into the earlier loop where we initialize the
smp_processor_ids(). I have fixed it in the next iteration.

> 
> You should be able to do the lookup of the property and the setting of
> has_interleaved_big_core all inside
> check_for_interleaved_big_core().

Yes, that's what I am doing in the next iteration.

> 
> cheers
> 
