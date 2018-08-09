Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA024C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D6E21D69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D6E21D69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeHIPwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:52:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730090AbeHIPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:52:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w79DOCLi042369
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 09:27:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krnmjag6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 09:27:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 9 Aug 2018 14:27:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 14:27:47 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w79DRklg41746624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 13:27:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BE7611C050;
        Thu,  9 Aug 2018 16:27:52 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8990511C04C;
        Thu,  9 Aug 2018 16:27:50 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.40.192.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu,  9 Aug 2018 16:27:50 +0100 (BST)
Date:   Thu, 9 Aug 2018 06:27:43 -0700
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
 <1533792728-6304-2-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1533792728-6304-2-git-send-email-ego@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080913-0012-0000-0000-000002976700
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080913-0013-0000-0000-000020CA76C4
Message-Id: <20180809132743.GB42474@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-09 11:02:07]:

> 
>  int threads_per_core, threads_per_subcore, threads_shift;
> +bool has_big_cores;
>  cpumask_t threads_core_mask;
>  EXPORT_SYMBOL_GPL(threads_per_core);
>  EXPORT_SYMBOL_GPL(threads_per_subcore);
>  EXPORT_SYMBOL_GPL(threads_shift);
> +EXPORT_SYMBOL_GPL(has_big_cores);

Why do we need EXPORT_SYMBOL_GPL?

>  EXPORT_SYMBOL_GPL(threads_core_mask);
> 
> + *
> + * Returns 0 on success, -EINVAL if the property does not exist,
> + * -ENODATA if property does not have a value, and -EOVERFLOW if the
> + * property data isn't large enough.
> + */
> +int parse_thread_groups(struct device_node *dn,
> +			struct thread_groups *tg)
> +{
> +	unsigned int nr_groups, threads_per_group, property;
> +	int i;
> +	u32 thread_group_array[3 + MAX_THREAD_LIST_SIZE];
> +	u32 *thread_list;
> +	size_t total_threads;
> +	int ret;
> +
> +	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
> +					 thread_group_array, 3);
> +
> +	if (ret)
> +		goto out_err;
> +
> +	property = thread_group_array[0];
> +	nr_groups = thread_group_array[1];
> +	threads_per_group = thread_group_array[2];
> +	total_threads = nr_groups * threads_per_group;
> +

Shouldnt we check for property and nr_groups
If the property is not 1 and nr_groups < 1, we should error out
No point in calling a of_property read if property is not right.


Nit: 
Cant we directly assign to tg->property, and hence avoid local
variables, property, nr_groups and threads_per_group?

> +	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
> +					 thread_group_array,
> +					 3 + total_threads);
> +
> +static inline bool dt_has_big_core(struct device_node *dn,
> +				   struct thread_groups *tg)
> +{
> +	if (parse_thread_groups(dn, tg))
> +		return false;
> +
> +	if (tg->property != 1)
> +		return false;
> +
> +	if (tg->nr_groups < 1)
> +		return false;

Can avoid these check if we can check in parse_thread_groups.

>  /**
>   * setup_cpu_maps - initialize the following cpu maps:
>   *                  cpu_possible_mask
> @@ -457,6 +605,7 @@ void __init smp_setup_cpu_maps(void)
>  	int cpu = 0;
>  	int nthreads = 1;
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 755dc98..f5717de 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -18,6 +18,7 @@
>  #include <asm/smp.h>
>  #include <asm/pmc.h>
>  #include <asm/firmware.h>
> +#include <asm/cputhreads.h>
> 
>  #include "cacheinfo.h"
>  #include "setup.h"
> @@ -1025,6 +1026,33 @@ static ssize_t show_physical_id(struct device *dev,
>  }
>  static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> 
> +static ssize_t show_small_core_siblings(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> +	struct device_node *dn = of_get_cpu_node(cpu->dev.id, NULL);
> +	struct thread_groups tg;
> +	int i, j;
> +	ssize_t ret = 0;
> +

Here we need to check for validity of dn and error out accordingly.


> +	if (parse_thread_groups(dn, &tg))
> +		return -ENODATA;

Did we miss a of_node_put(dn)?

> +
> +	i = get_cpu_thread_group_start(cpu->dev.id, &tg);
> +
> +	if (i == -1)
> +		return -ENODATA;
> +
> +	for (j = 0; j < tg.threads_per_group - 1; j++)
> +		ret += sprintf(buf + ret, "%d,", tg.thread_list[i + j]);

Here, we are making the assumption that group_start will always be the
first thread in the thread_group. However we didnt make the same
assumption in get_cpu_thread_group_start.

