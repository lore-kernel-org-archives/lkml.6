Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeCONp2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:45:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeCONp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:45:26 -0400
Date: Thu, 15 Mar 2018 14:45:24 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, rafael@kernel.org,
        dedekind1@gmail.com, ming.lei@redhat.com, andy.shevchenko@gmail.com
Subject: Re: [RFC PATCH v2] ACPI / processor: Fix possible CPUs map
In-Reply-To: <20180315030756.5548-1-douly.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1803151436200.1525@nanos.tec.linutronix.de>
References: <20180315030756.5548-1-douly.fnst@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Dou Liyang wrote:
>  
> +static void __init acpi_update_possible_map(void)
> +{
> +	unsigned int cpu;
> +
> +	if (nr_unique_ids >= nr_cpu_ids)
> +		return;
> +
> +	/* Don't yet figure out if it's superfluous */
> +	if (nr_unique_ids >= cpumask_last(cpu_possible_mask))
> +		return;
> +
> +	for_each_cpu_wrap(cpu, cpu_possible_mask, nr_unique_ids)
> +		set_cpu_possible(cpu, false);
> +
> +	nr_cpu_ids = nr_unique_ids;
> +	pr_info("Allowing %d possible CPUs\n", nr_cpu_ids);
> +}
> +
>  static void __init acpi_processor_check_duplicates(void)
>  {
>  	/* check the correctness for all processors in ACPI namespace */
> @@ -680,6 +698,9 @@ static void __init acpi_processor_check_duplicates(void)
>  						NULL, NULL, NULL);
>  	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_ids_walk,
>  						NULL, NULL);
> +
> +	/* make possible CPU count more realistic */
> +	acpi_update_possible_map();
>  }

I tested this on a machine which claims to have gazillion of hotplugable
CPUs:

	smpboot: Allowing 152 CPUs, 120 hotplug CPUs
	setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:152 nr_node_ids:2
	smp: Brought up 2 nodes, 32 CPUs

Now with your patch applied it's still saying:

	smpboot: Allowing 152 CPUs, 120 hotplug CPUs
	setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:152 nr_node_ids:2
	smp: Brought up 2 nodes, 32 CPUs

and the above code runs later on and the result is:

	nr_unique_ids 1 nr_cpu_ids 152
	Allowing 1 possible CPU

which subsequently causes the machine to die as we have already 32 CPUs
online.

So nr_unique_ids is not what it should be and even if it would be the code
runs way too late. It needs to run _before_ setup_percpu() is invoked to
scale everything correctly.

Thanks,

	tglx
