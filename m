Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC3A20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC3A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeGKJ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:57:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726269AbeGKJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:57:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6B9oPGL013705
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:54:26 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5bu6ryfd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:54:26 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 03:54:25 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 03:54:21 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6B9sKtd56230060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 02:54:20 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBF536E050;
        Wed, 11 Jul 2018 03:54:20 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 737E06E04C;
        Wed, 11 Jul 2018 03:54:20 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 03:54:20 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 56B7D2E2F51; Wed, 11 Jul 2018 15:24:18 +0530 (IST)
Date:   Wed, 11 Jul 2018 15:24:18 +0530
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
Subject: Re: [PATCH v3 1/2] powerpc: Detect the presence of big-cores via
 "ibm, thread-groups"
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1530867876.git.ego@linux.vnet.ibm.com>
 <abaea3bd2aa89c7c9f284e3a7beabb865d8e1050.1530867876.git.ego@linux.vnet.ibm.com>
 <20180708160334.GA6947@kermit-br-ibm-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708160334.GA6947@kermit-br-ibm-com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18071109-0012-0000-0000-0000168A66B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009349; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059723; UDB=6.00543901; IPR=6.00837644;
 MB=3.00022101; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 09:54:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071109-0013-0000-0000-000053A1D072
Message-Id: <20180711095418.GC6591@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Murilo,

On Sun, Jul 08, 2018 at 01:03:34PM -0300, Murilo Opsfelder Araujo wrote:
> On Fri, Jul 06, 2018 at 02:35:48PM +0530, Gautham R. Shenoy wrote:
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
> >  arch/powerpc/include/asm/cputhreads.h              |  22 +++
> >  arch/powerpc/kernel/setup-common.c                 | 154 +++++++++++++++++++++
> >  arch/powerpc/kernel/sysfs.c                        |  35 +++++
> >  4 files changed, 219 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > index 9c5e7732..62f24de 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> > +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > @@ -487,3 +487,11 @@ Description:	Information about CPU vulnerabilities
> >  		"Not affected"	  CPU is not affected by the vulnerability
> >  		"Vulnerable"	  CPU is affected and no mitigation in effect
> >  		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
> > +
> > +What: 		/sys/devices/system/cpu/cpu[0-9]+/small_core_siblings
> > +Date:		05-Jul-2018
> > +KernelVersion:	v4.18.0
> > +Contact:	Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > +Description:	List of Physical ids of CPUs which share the the L1 cache,
> > +		translation cache and instruction data-flow with this CPU.
> 
> What about this?
> 
>     Description: List of physical CPU IDs that share a common L1 cache,
>                  translation cache and instruction data flow with this CPU.
> 
> Or perhaps just remove the extra "the".

Oops! Will remove the extra "the". Thanks for spotting it.


> 
> > +Values:		Comma separated list of decimal integers.
> > diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
> > index d71a909..33226d7 100644
> > --- a/arch/powerpc/include/asm/cputhreads.h

[..snip..]

> > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> > index 755dc98..f5717de 100644
> > --- a/arch/powerpc/kernel/sysfs.c
> > +++ b/arch/powerpc/kernel/sysfs.c
> > @@ -18,6 +18,7 @@
> >  #include <asm/smp.h>
> >  #include <asm/pmc.h>
> >  #include <asm/firmware.h>
> > +#include <asm/cputhreads.h>
> >  
> >  #include "cacheinfo.h"
> >  #include "setup.h"
> > @@ -1025,6 +1026,33 @@ static ssize_t show_physical_id(struct device *dev,
> >  }
> >  static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> >  
> > +static ssize_t show_small_core_siblings(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> 
> Interesting enough, checkpatch.pl warned about this function name:
> 
>     WARNING: Consider renaming function(s) 'show_small_core_siblings' to 'small_core_siblings_show'
>     #354: FILE: arch/powerpc/kernel/sysfs.c:1053:
>     +}

Yes I kept it despite the warning, as doing otherwise would introduce
inconsistency with the way the remaining functions are named in the
file.

If Michael Ellerman is ok, I can send a file converting all these
sysfs calls to use DEVICE_ATTR_RO/RW, which will require renaming all
the other functions to XXX_show().


> 
> > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> > +	struct device_node *dn = of_get_cpu_node(cpu->dev.id, NULL);
> > +	struct thread_groups tg;
> > +	int i, j;
> > +	ssize_t ret = 0;
> > +
> > +	if (parse_thread_groups(dn, &tg))
> > +		return -ENODATA;
> > +
> > +	i = get_cpu_thread_group_start(cpu->dev.id, &tg);
> > +
> > +	if (i == -1)
> > +		return -ENODATA;
> > +
> > +	for (j = 0; j < tg.threads_per_group - 1; j++)
> > +		ret += sprintf(buf + ret, "%d,", tg.thread_list[i + j]);
> > +
> > +	ret += sprintf(buf + ret, "%d\n", tg.thread_list[i + j]);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR(small_core_siblings, 0444, show_small_core_siblings, NULL);
> > +
> >  static int __init topology_init(void)
> >  {
> >  	int cpu, r;
> > @@ -1048,6 +1076,13 @@ static int __init topology_init(void)
> >  			register_cpu(c, cpu);
> >  
> >  			device_create_file(&c->dev, &dev_attr_physical_id);
> > +
> > +			if (has_big_cores) {
> > +				const struct device_attribute *attr =
> > +				       &dev_attr_small_core_siblings;
> > +
> > +			       device_create_file(&c->dev, attr);
> > +			}
> >  		}
> >  	}
> >  	r = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powerpc/topology:online",
> > -- 
> > 1.9.4
> > 
> 
> -- 
> Murilo

