Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D293C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B237921781
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B237921781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeHMQet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:34:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:52185 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbeHMQes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:34:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7DDpnWQ000660;
        Mon, 13 Aug 2018 08:51:51 -0500
Message-ID: <be2863f5037e8326b0906bd0aee82dcb370d2d80.camel@kernel.crashing.org>
Subject: Re: [PATCH v6 1/2] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     ego@linux.vnet.ibm.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Aug 2018 23:51:49 +1000
In-Reply-To: <20180813113633.GA19859@in.ibm.com>
References: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
         <1533792728-6304-2-git-send-email-ego@linux.vnet.ibm.com>
         <20180809132743.GB42474@linux.vnet.ibm.com>
         <20180813113633.GA19859@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 17:06 +0530, Gautham R Shenoy wrote:
> Hi Srikar,
> 
> Thanks for reviewing the patch.
> 
> On Thu, Aug 09, 2018 at 06:27:43AM -0700, Srikar Dronamraju wrote:
> > * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-09 11:02:07]:
> > 
> > > 
> > >  int threads_per_core, threads_per_subcore, threads_shift;
> > > +bool has_big_cores;
> > >  cpumask_t threads_core_mask;
> > >  EXPORT_SYMBOL_GPL(threads_per_core);
> > >  EXPORT_SYMBOL_GPL(threads_per_subcore);
> > >  EXPORT_SYMBOL_GPL(threads_shift);
> > > +EXPORT_SYMBOL_GPL(has_big_cores);
> > 
> > Why do we need EXPORT_SYMBOL_GPL?
> 
> As Christoph pointed out, I was blindly following the suit.
> 
> You are right, we don't need to export it at the moment. The remaining
> EXPORT_SYMBOL_GPL are required by KVM. However, as of now, there is no
> need for "has_big_cores" in the KVM.

There is actually. KVM needs to refuse to start on big cores, at least
HV KVM. And when KVM grows support for big cores (may or may not
happen), it will need to know. So keep the GPL export.

> Will remove this in the next version.
> > 
> > >  EXPORT_SYMBOL_GPL(threads_core_mask);
> > > 
> > > + *
> > > + * Returns 0 on success, -EINVAL if the property does not exist,
> > > + * -ENODATA if property does not have a value, and -EOVERFLOW if the
> > > + * property data isn't large enough.
> > > + */
> > > +int parse_thread_groups(struct device_node *dn,
> > > +			struct thread_groups *tg)
> > > +{
> > > +	unsigned int nr_groups, threads_per_group, property;
> > > +	int i;
> > > +	u32 thread_group_array[3 + MAX_THREAD_LIST_SIZE];
> > > +	u32 *thread_list;
> > > +	size_t total_threads;
> > > +	int ret;
> > > +
> > > +	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
> > > +					 thread_group_array, 3);
> > > +
> > > +	if (ret)
> > > +		goto out_err;
> > > +
> > > +	property = thread_group_array[0];
> > > +	nr_groups = thread_group_array[1];
> > > +	threads_per_group = thread_group_array[2];
> > > +	total_threads = nr_groups * threads_per_group;
> 
> 
> > > +
> > 
> > Shouldnt we check for property and nr_groups
> > If the property is not 1 and nr_groups < 1, we should error out
> > No point in calling a of_property read if property is not right.
> 
> Yes, the nr_groups < 1 check can be moved into this function.
> 
> However, this function merely parses the the thread group structure
> exposed by the device tree. So it should error out only if there is a
> failure in parsing, or as you said the parsed values are incorrect
> (nr_groups < 1, threads_per_group < 1, etc). Whether the thread group
> is relevant or not (in this case we are interested in thread groups
> that share L1 cache, translation etc) is something for the caller to
> decide.
> 
> However, I see what you mean. We can avoid parsing the remainder of
> the array if the property in the device-tree isn't the property that
> the caller is interested in.
> 
> This can be solved by passing the interested property value as a
> parameter and so that the code errors out if this property doesn't
> match the property in the device-tree. Will add this in the next
> version.
> 
> > 
> > 
> > Nit: 
> > Cant we directly assign to tg->property, and hence avoid local
> > variables, property, nr_groups and threads_per_group?
> 
> Will clean this up. This was from an older version where I added the
> local variables so that the statements referencing them don't need to
> be split across multiple lines. However, the code has been optimized
> since then. So, the local variables are not needed.
> 
> > 
> > > +	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
> > > +					 thread_group_array,
> > > +					 3 + total_threads);
> > > +
> > > +static inline bool dt_has_big_core(struct device_node *dn,
> > > +				   struct thread_groups *tg)
> > > +{
> > > +	if (parse_thread_groups(dn, tg))
> > > +		return false;
> > > +
> > > +	if (tg->property != 1)
> > > +		return false;
> > > +
> > > +	if (tg->nr_groups < 1)
> > > +		return false;
> > 
> > Can avoid these check if we can check in parse_thread_groups.
> > 
> > >  /**
> > >   * setup_cpu_maps - initialize the following cpu maps:
> > >   *                  cpu_possible_mask
> > > @@ -457,6 +605,7 @@ void __init smp_setup_cpu_maps(void)
> > >  	int cpu = 0;
> > >  	int nthreads = 1;
> > > 
> > > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> > > index 755dc98..f5717de 100644
> > > --- a/arch/powerpc/kernel/sysfs.c
> > > +++ b/arch/powerpc/kernel/sysfs.c
> > > @@ -18,6 +18,7 @@
> > >  #include <asm/smp.h>
> > >  #include <asm/pmc.h>
> > >  #include <asm/firmware.h>
> > > +#include <asm/cputhreads.h>
> > > 
> > >  #include "cacheinfo.h"
> > >  #include "setup.h"
> > > @@ -1025,6 +1026,33 @@ static ssize_t show_physical_id(struct device *dev,
> > >  }
> > >  static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> > > 
> > > +static ssize_t show_small_core_siblings(struct device *dev,
> > > +					struct device_attribute *attr,
> > > +					char *buf)
> > > +{
> > > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> > > +	struct device_node *dn = of_get_cpu_node(cpu->dev.id, NULL);
> > > +	struct thread_groups tg;
> > > +	int i, j;
> > > +	ssize_t ret = 0;
> > > +
> > 
> > Here we need to check for validity of dn and error out accordingly.
> 
> Will add this check.
> 
> > 
> > 
> > > +	if (parse_thread_groups(dn, &tg))
> > > +		return -ENODATA;
> > 
> > Did we miss a of_node_put(dn)?
> 
> Yes we did. Will fix this.
> > 
> > > +
> > > +	i = get_cpu_thread_group_start(cpu->dev.id, &tg);
> > > +
> > > +	if (i == -1)
> > > +		return -ENODATA;
> > > +
> > > +	for (j = 0; j < tg.threads_per_group - 1; j++)
> > > +		ret += sprintf(buf + ret, "%d,", tg.thread_list[i + j]);
> > 
> > Here, we are making the assumption that group_start will always be the
> > first thread in the thread_group. However we didnt make the same
> > assumption in get_cpu_thread_group_start.
> 
> Above the get_cpu_thread_group_start function , we have the following
> comment which indicates that group_start will point to the start of
> the thread group. Is this what you are referring to?
> 
> /*
>  * Returns the index to tg->thread_list that points to the the start
>  * of the thread_group that @cpu belongs to.
>  *
>  * Returns -1 if cpu doesn't belong to any of the groups pointed to by
>  * tg->thread_list.
>  */

