Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbeEVEba (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 00:31:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750709AbeEVEb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 00:31:28 -0400
Date: Tue, 22 May 2018 10:01:19 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
 <1526268071.30369.20.camel@neuling.org>
 <20180516043516.GA14826@in.ibm.com>
 <87k1s1xg0z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1s1xg0z.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18052204-0004-0000-0000-00001421454F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009064; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035843; UDB=6.00529854; IPR=6.00814971;
 MB=3.00021230; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 04:31:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052204-0005-0000-0000-0000874CAC9D
Message-Id: <20180522043119.GA5213@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220052
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On Fri, May 18, 2018 at 11:14:04PM +1000, Michael Ellerman wrote:
> Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> ...
> >> > @@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
> >> >  	vdso_data->processorCount = num_present_cpus();
> >> >  #endif /* CONFIG_PPC64 */
> >> >  
> >> > -        /* Initialize CPU <=> thread mapping/
> >> > +	dn = of_find_node_by_type(NULL, "cpu");
> >> > +	if (dn) {
> >> > +		if (check_for_interleaved_big_core(dn)) {
> >> > +			has_interleaved_big_core = true;
> >> > +			pr_info("Detected interleaved big-cores\n");
> >> 
> >> Is there a runtime way to check this also?  If the dmesg buffer overflows, we
> >> lose this.
> >
> > Where do you suggest we put this ? Should it be a part of
> > /proc/cpuinfo ?
> 
> Hmm, it'd be nice not to pollute it with more junk.
> 
> Can you just look at the pir files in sysfs?

Sure Michael. I will explore this option.

If we add a file called l1cache_thread_group, then the siblings of the
big-core that share the L1-cache can be described as follows.

	# cd  /sys/devices/system/cpu
	# grep . cpu[0-7]/l1cache_thread_group
	cpu0/l1cache_thread_group:0,2,4,6
	cpu1/l1cache_thread_group:1,3,5,7
	cpu2/l1cache_thread_group:0,2,4,6
	cpu3/l1cache_thread_group:1,3,5,7
	cpu4/l1cache_thread_group:0,2,4,6
	cpu5/l1cache_thread_group:1,3,5,7
	cpu6/l1cache_thread_group:0,2,4,6
	cpu7/l1cache_thread_group:1,3,5,7

> 
> eg. on a normal system:
> 
>   # cd /sys/devices/system/cpu
>   # grep . cpu[0-7]/pir
>   cpu0/pir:20
>   cpu1/pir:21
>   cpu2/pir:22
>   cpu3/pir:23
>   cpu4/pir:24
>   cpu5/pir:25
>   cpu6/pir:26
>   cpu7/pir:27


> 
> 
> cheers
> 
