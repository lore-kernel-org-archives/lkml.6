Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx48qZJs7f3E6p2sITjPskuadgwF+/hpFx6dJUqga39tB5k5SyqDAn4jlSHoPqm1OVN3xHftr
ARC-Seal: i=1; a=rsa-sha256; t=1522931398; cv=none;
        d=google.com; s=arc-20160816;
        b=J6a79O6XCWdO8VqCyVRHp1G2XRk9s5qCmb9nZZfdQqy0m9o8SqV4x8RWGuFj0xhwOM
         MCHOD5FeFCjtea2Ao3fkl5/igvJLKD6nUNCpfSA34/5AakhQvr8LGxhH0SSOjjJR1eif
         hG1f1oi13FgTSNPDoiwPxry04yfrGxtZjRBuf1ZF8GPGzSXKuPXiZMdR/uCrcOYqOWjN
         Itqk3VXtwZqM3X0Pwhrqi9gvDCv//gTFy/9WLKcwSJDJs6EeU1rNUuftkVv9LylhYrkn
         NvLpDIjqYthlUBLnuRmPxfOfqepRTgW8u/XsM+ZWM/qAfn6XW5h25LFsH4AEKHCNOEVQ
         jytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=50tCFhxUgYncQ6rZR8i82TWDOigepsq+OvLam6wnD/k=;
        b=ACIVUDh33VMnOOssEgpnjT/boTKQms/M1RsYBIbblvesEHVqfzy6/GB/iEeYwLIDVw
         bWp18VjEirbL5hgdXIOcaFRDAT70ZEa8ebBjDzN0VVcVr8yMRXNGBucNauKMpVS2if1e
         S6TXSzfElMJF8etn+ZKkU1kSuMYwoisl4oJBXII6JDLrrgbH5Vht79LXRfRawJo2F5c+
         7ReGzdbbhvlqaWSjaBkSRRnLpFJjeDJwec/1xTpsOD2DukeUzbqz+rSZ9d6TacsENX5z
         6MgFbV1pbZLO1V/utqfg82o8yaZaR/Azbe3aR6aVM0xrFeSSKuMtE3UYLfuCuCbUB5fd
         uqdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 5 Apr 2018 14:29:57 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dexuan Cui <decui@microsoft.com>
cc: 'Greg KH' <gregkh@linuxfoundation.org>,
    "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    KY Srinivasan <kys@microsoft.com>,
    Stephen Hemminger <sthemmin@microsoft.com>,
    Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: RE: Any standard kernel API to dynamically allocate/free per-cpu
 vectors on x86?
In-Reply-To: <KL1P15301MB0006F72E1B341AA0F58613CBBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.21.1804051215110.2204@nanos.tec.linutronix.de>
References: <KL1P15301MB000638051CC8DC7FD2A2E74BBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM> <alpine.DEB.2.21.1804050004230.1492@nanos.tec.linutronix.de> <KL1P15301MB0006F72E1B341AA0F58613CBBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849968280484666?=
X-GMAIL-MSGID: =?utf-8?q?1596909314253597985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dexuan,

On Wed, 4 Apr 2018, Dexuan Cui wrote:
> > From: Thomas Gleixner
> > That needs a very simple and minimal virtual interrupt controller driver
> > which is mostly a dummy implementation except for the activation function
> > which would allow you to retrieve the vector number and store it in the
> > MSR.
> 
> Can you please give a little more guidance? e.g. is there any similar driver,
> any pointer to the required APIs, etc. 
> I guess I need to dig into stuff like 
> struct irq_domain_ops x86_vector_domain_ops and request_percpu_irq().

request_percpu_irq() is not applicable here. That's a different mechanism
which is used on ARM and others for PerProcessorInterrupts which have a
single virtual irq number which maps to a single hardware vector number
which is identical on all CPUs. We could make it work for x86, but then we
are back to the point where we need the same vector on all CPUs with all
the pain that involves.

> Your quick pointer would help a lot!
> 
> > There are a few details to be hashed out vs. CPU hotplug, but we have all
> > the infrastructure in place to deal with that.
> Sounds great!
> 
> BTW, so far, Hyper-V doesn't support CPU hotplug, but it supports dynamic
> CPU online/offline . I guess I must also consider CPU online/offline here.

Yes, that's all covered. The trick is to use the affinity managed interrupt
facility for these per cpu interrupts and then the cpu online/offline case
including physical(virtual) hotplug is dealt with automagically. You
request the irqs once with request_irq() and they stay requested for the
life time. No action required on the driver side for CPU online/offline
events vs. the interrupt.

Find below a hastily cobbled together minimal starting point. You need to
fill in the gaps by looking at similar implementations: ioapic for some
stuff and the way simpler UV code in x86/platform/uv/uv_irq.c for most of
it.

Hope that helps. If you have questions or run into limitations, feel free
to ask.

Thanks,

	tglx

static struct irqdomain *hyperv_synic_domain;

static struct irq_chip hyperv_synic = {
	.name			= "HYPERV-SYNIC",
	.irq_mask		= hv_noop,
	.irq_unmask		= hv_noop,
	.irq_eoi		= hv_ack_apic,
	.irq_set_affinity	= irq_chip_set_affinity_parent,
};

static int hyperv_irqdomain_activate(..,irqd,)
{
	struct irq_cfg *cfg = irqd_cfg(irqd);

	/*
	 * cfg gives you access to the destination apicid and the vector
	 * number. If you need the CPU number as well, then you can either
	 * retrieve it from the effective affinity cpumask which you can
	 * access with irq_data_get_effective_affinity_mask(irqd) or we
	 * can extend irq_cfg to hold the target CPU number (would be a
	 * trivial thing to do). So this is the place where you can store
	 * the vector number.
	 */
}

/*
 * activate is called when:
 *  - the interrupt is requested via request_irq()
 *  - the interrupt is restarted on a cpu online event
 *    (CPUHP_AP_IRQ_AFFINITY_ONLINE)
 *
 * deactivate is called when:
 *  - the interrupt is freed via free_irq()
 *  - the interrupt is shut down on a cpu offline event shortly
 *    before the outgoing CPU dies (irq_migrate_all_off_this_cpu()).
 */
static const struct irq_domain_ops hyperv_irqdomain_ops = {
	.alloc		= hyperv_irqdomain_alloc,
	.free		= hyperv_irqdomain_free,
	.activate	= hyperv_irqdomain_activate,
	.deactivate	= hyperv_irqdomain_deactivate,
};

static int hyperv_synic_setup(void)
{
	struct fwnode_handle *fwnode;
	struct irqdomain *d;
	void *host_data = NULL;

	fwnode = irq_domain_alloc_named_fwnode("HYPERV-SYNIC");

	d = irq_domain_create_hierarchy(x86_vector_domain, 0, 0, fwnode,
					&hyperv_irqdomain_ops, host_data);
	hyperv_synic_domain = d;
	return 0;
}

int hyperv_alloc_vmbus_irq(...)
{
	struct irq_affinity affd = { 0, };
	struct irq_alloc_info info;
	struct cpumask *masks;
	int ret, nvec, i;

	init_irq_alloc_info(&info, NULL);
	/* You can add HV specific fields in info to transport data */
	info.type = X86_IRQ_ALLOC_TYPE_HV_SYNIC;

	nvec = num_possible_cpus();
	/*
	 * Create an array of affinity masks which are spread out
	 * over all possible cpus.
	 */
	masks = irq_create_affinity_masks(nvec, &affd);

	/*
	 * Allocate the interrupts which are affined to the affinity masks
	 * in the masks array and marked as managed.
	 */
	virq = __irq_domain_alloc_irqs(hyperv_synic_domain, -1, nvec,
				       NUMA_NO_NODE, &info, false, masks);
	kfree(masks);

	/*
	 * This returns the base irq number. The per cpu interrupt is
	 * simply: virq + CPUNR, if the CPU space is linear. If there are
	 * holes in the cpu_possible_mask, then you need more magic.
	 *
	 * On the call site you simply do:
	 * for (i = 0; i < nvec; i++)
	 *	request_irq(virq + i, ......);
	 */
	return virq;
}
