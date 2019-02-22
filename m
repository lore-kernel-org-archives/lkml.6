Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3437B2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="EyKMYChE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfBVNOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:14:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43297 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:14:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so1636608oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 05:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ww/ITOGv3xZsCxNC8ZQVf6mI2ZyZbwl8KaRo/3Q7vRA=;
        b=EyKMYChEWYmqGplGWCLf4MnljouReBUWKtzyV0tNU6pqpH30Y6oPw8KAer9OVRrT2K
         9DjYu7ad40UKM7ov4UQHtnH1q2DZcIbcuy9Nt8O369STNtQdN4ShwuDl3aa4WFojo7sg
         yB7EnmLsUxMUtSmL7wEb1Nno90VY7VQfbDeGmzHOhKvMWph1E1dub9jc8p9vQ00txPAF
         Qiv0NN2fFcNQ5LvhP308LxkWuPtSz2bS5NLdIrSRYPXKfsycGd90ayBE+EASTaYEmJbT
         1ezKFwmWdA802kd07c4UinIUimZOuVgpLImA3Xto3w3mbJyI+5+wQnZZHOhADsvMPJO3
         2tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ww/ITOGv3xZsCxNC8ZQVf6mI2ZyZbwl8KaRo/3Q7vRA=;
        b=aXI/w3QPN56fR2wA0RWMV4jqQVWpatMNopxqs+1Up96W7WaNWjDzCnIf1QHvYvP/G9
         DJyTvhhsang2xbmMoNziT2QAZ36zKP7PRe5NxQKLApyC6NGw7tMEz9ncEao5cQs3EBnl
         gWF52R27u2Z4RG7RWAa+qxEY9ZUEnpBEVRCyaJrvnD4QBiCj/xUxBbadOZFctRAYczWY
         l7OzM9IvF7KuV0nwHqtX1F71dpaHn7TbWv05bvD8W4FB58jIa3nbX/nZfybN4grMXX7x
         6o1Ymxp/XVXHANTIS2PzLa8PYbnmwbufjAzjsB2J+lbKyHl3WPz7pZFsS85gpyRv4FtT
         4vUw==
X-Gm-Message-State: AHQUAub3cjAxU4QbYBLaGekwz5y8gXQcaX+xUqQPHQFGRMwaxJlPz6Va
        CX5ECcQHMgUgQHm3t2FdwsixdA==
X-Google-Smtp-Source: AHgI3IZpKQn7pdfZx9GR+xxRUAoFOMP491bu4342q4WHEqK23gDs8UpbTmknOYLPzcxknjq3Yz8GJQ==
X-Received: by 2002:aca:6206:: with SMTP id w6mr2514398oib.132.1550841248013;
        Fri, 22 Feb 2019 05:14:08 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:55d9:7907:9a5d:e782])
        by smtp.gmail.com with ESMTPSA id o8sm521845oia.53.2019.02.22.05.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 05:14:06 -0800 (PST)
Date:   Fri, 22 Feb 2019 07:14:05 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, honglei5@huawei.com
Subject: Re: [PATCH] ipmi_si: Fix crash when using hard-coded device
Message-ID: <20190222131405.GB6290@minyard.net>
Reply-To: cminyard@mvista.com
References: <20190221183343.13554-1-minyard@acm.org>
 <5C6FBCD5.7000000@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C6FBCD5.7000000@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 05:11:49PM +0800, Yang Yingliang wrote:
> Tested-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for testing.

This is queued for 5.1.  I'd like to let the soak a bit in linux-next.
It is tagged for a backport to stable releases.

-corey

> 
> [  128.069528] ipmi_si: IPMI System Interface driver
> [  128.069556] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [  128.069559] ipmi_platform: ipmi_si: SMBIOS: io 0xe4 regsize 1 spacing 1
> irq 0
> [  128.069561] ipmi_si: Adding SMBIOS-specified bt state machine
> [  128.069657] ipmi_si hisi-lpc-ipmi.1.auto: ipmi_platform: probing via ACPI
> [  128.069694] ipmi_si hisi-lpc-ipmi.1.auto: ipmi_platform: [io
> 0xffc0e3-0xffc0e7] regsize 1 spacing 1 irq 0
> [  128.069696] ipmi_si hisi-lpc-ipmi.1.auto: Hard-coded device at this
> address already exists
> [  128.069815] ipmi_si hardcode-ipmi-si.0: ipmi_platform: probing via
> hardcoded
> [  128.069817] ipmi_platform: ipmi_si: hardcoded: io 0xffc0e3 regsize 1
> spacing 1 irq 0
> [  128.069819] ipmi_si: Adding hardcoded-specified bt state machine
> [  128.069892] ipmi_si: Trying SMBIOS-specified bt state machine at i/o
> address 0xe4, slave address 0x0, irq 0
> [  128.069896] ipmi_si dmi-ipmi-si.0: Could not set up I/O space
> [  128.069900] ipmi_si: Trying hardcoded-specified bt state machine at i/o
> address 0xffc0e3, slave address 0x0, irq 0
> [  128.081782] ipmi_si hardcode-ipmi-si.0: bt cap response too short: 3
> [  128.081784] ipmi_si hardcode-ipmi-si.0: using default values
> [  128.081786] ipmi_si hardcode-ipmi-si.0: req2rsp=5 secs retries=2
> [  128.157855] ipmi_si hardcode-ipmi-si.0: IPMI message handler: Found new
> BMC (man_id: 0x0007db, prod_id: 0x0001, dev_id: 0x01)
> [  128.441860] ipmi_si hardcode-ipmi-si.0: IPMI bt interface initialized
> 
> On 2019/2/22 2:33, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > When excuting a command like:
> >    modprobe ipmi_si ports=0xffc0e3 type=bt
> > The system would get an oops.
> > 
> > The trouble here is that ipmi_si_hardcode_find_bmc() is called before
> > ipmi_si_platform_init(), but initialization of the hard-coded device
> > creates an IPMI platform device, which won't be initialized yet.
> > 
> > The real trouble is that hard-coded devices aren't created with
> > any device, and the fixup is done later.  So do it right, create the
> > hard-coded devices as normal platform devices.
> > 
> > This required adding some new resource types to the IPMI platform
> > code for passing information required by the hard-coded device
> > and adding some code to remove the hard-coded platform devices
> > on module removal.
> > 
> > To enforce the "hard-coded devices passed by the user take priority
> > over firmware devices" rule, some special code was added to check
> > and see if a hard-coded device already exists.
> > 
> > Reported-by: Yang Yingliang <yangyingliang@huawei.com>
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > ---
> > 
> > I believe this is the right fix.  Can you test/review and send the
> > results?
> > 
> > Thanks,
> > 
> > -corey
> > 
> >   drivers/char/ipmi/ipmi_si.h          |   4 +-
> >   drivers/char/ipmi/ipmi_si_hardcode.c | 236 ++++++++++++++++++++-------
> >   drivers/char/ipmi/ipmi_si_intf.c     |  23 ++-
> >   drivers/char/ipmi/ipmi_si_platform.c |  25 ++-
> >   4 files changed, 214 insertions(+), 74 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_si.h b/drivers/char/ipmi/ipmi_si.h
> > index 52f6152d1fcb..7ae52c17618e 100644
> > --- a/drivers/char/ipmi/ipmi_si.h
> > +++ b/drivers/char/ipmi/ipmi_si.h
> > @@ -25,7 +25,9 @@ void ipmi_irq_finish_setup(struct si_sm_io *io);
> >   int ipmi_si_remove_by_dev(struct device *dev);
> >   void ipmi_si_remove_by_data(int addr_space, enum si_type si_type,
> >   			    unsigned long addr);
> > -int ipmi_si_hardcode_find_bmc(void);
> > +void ipmi_hardcode_init(void);
> > +void ipmi_si_hardcode_exit(void);
> > +int ipmi_si_hardcode_match(int addr_type, unsigned long addr);
> >   void ipmi_si_platform_init(void);
> >   void ipmi_si_platform_shutdown(void);
> > diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
> > index 487642809c58..1e5783961b0d 100644
> > --- a/drivers/char/ipmi/ipmi_si_hardcode.c
> > +++ b/drivers/char/ipmi/ipmi_si_hardcode.c
> > @@ -3,6 +3,7 @@
> >   #define pr_fmt(fmt) "ipmi_hardcode: " fmt
> >   #include <linux/moduleparam.h>
> > +#include <linux/platform_device.h>
> >   #include "ipmi_si.h"
> >   /*
> > @@ -12,23 +13,22 @@
> >   #define SI_MAX_PARMS 4
> > -static char          *si_type[SI_MAX_PARMS];
> >   #define MAX_SI_TYPE_STR 30
> > -static char          si_type_str[MAX_SI_TYPE_STR];
> > +static char          si_type_str[MAX_SI_TYPE_STR] __initdata;
> >   static unsigned long addrs[SI_MAX_PARMS];
> >   static unsigned int num_addrs;
> >   static unsigned int  ports[SI_MAX_PARMS];
> >   static unsigned int num_ports;
> > -static int           irqs[SI_MAX_PARMS];
> > -static unsigned int num_irqs;
> > -static int           regspacings[SI_MAX_PARMS];
> > -static unsigned int num_regspacings;
> > -static int           regsizes[SI_MAX_PARMS];
> > -static unsigned int num_regsizes;
> > -static int           regshifts[SI_MAX_PARMS];
> > -static unsigned int num_regshifts;
> > -static int slave_addrs[SI_MAX_PARMS]; /* Leaving 0 chooses the default value */
> > -static unsigned int num_slave_addrs;
> > +static int           irqs[SI_MAX_PARMS] __initdata;
> > +static unsigned int num_irqs __initdata;
> > +static int           regspacings[SI_MAX_PARMS] __initdata;
> > +static unsigned int num_regspacings __initdata;
> > +static int           regsizes[SI_MAX_PARMS] __initdata;
> > +static unsigned int num_regsizes __initdata;
> > +static int           regshifts[SI_MAX_PARMS] __initdata;
> > +static unsigned int num_regshifts __initdata;
> > +static int slave_addrs[SI_MAX_PARMS] __initdata;
> > +static unsigned int num_slave_addrs __initdata;
> >   module_param_string(type, si_type_str, MAX_SI_TYPE_STR, 0);
> >   MODULE_PARM_DESC(type, "Defines the type of each interface, each"
> > @@ -73,12 +73,133 @@ MODULE_PARM_DESC(slave_addrs, "Set the default IPMB slave address for"
> >   		 " overridden by this parm.  This is an array indexed"
> >   		 " by interface number.");
> > -int ipmi_si_hardcode_find_bmc(void)
> > +static struct platform_device *ipmi_hc_pdevs[SI_MAX_PARMS];
> > +
> > +static void __init ipmi_hardcode_init_one(const char *si_type_str,
> > +					  unsigned int i,
> > +					  unsigned long addr,
> > +					  unsigned int flags)
> >   {
> > -	int ret = -ENODEV;
> > -	int             i;
> > -	struct si_sm_io io;
> > +	struct platform_device *pdev;
> > +	unsigned int num_r = 1, size;
> > +	struct resource r[4];
> > +	struct property_entry p[6];
> > +	enum si_type si_type;
> > +	unsigned int regspacing, regsize;
> > +	int rv;
> > +
> > +	memset(p, 0, sizeof(p));
> > +	memset(r, 0, sizeof(r));
> > +
> > +	if (!si_type_str || !*si_type_str || strcmp(si_type_str, "kcs") == 0) {
> > +		size = 2;
> > +		si_type = SI_KCS;
> > +	} else if (strcmp(si_type_str, "smic") == 0) {
> > +		size = 2;
> > +		si_type = SI_SMIC;
> > +	} else if (strcmp(si_type_str, "bt") == 0) {
> > +		size = 3;
> > +		si_type = SI_BT;
> > +	} else if (strcmp(si_type_str, "invalid") == 0) {
> > +		/*
> > +		 * Allow a firmware-specified interface to be
> > +		 * disabled.
> > +		 */
> > +		size = 1;
> > +		si_type = SI_TYPE_INVALID;
> > +	} else {
> > +		pr_warn("Interface type specified for interface %d, was invalid: %s\n",
> > +			i, si_type_str);
> > +		return;
> > +	}
> > +
> > +	regsize = regsizes[i];
> > +	if (regsize == 0)
> > +		regsize = DEFAULT_REGSIZE;
> > +
> > +	p[0] = PROPERTY_ENTRY_U8("ipmi-type", si_type);
> > +	p[1] = PROPERTY_ENTRY_U8("slave-addr", slave_addrs[i]);
> > +	p[2] = PROPERTY_ENTRY_U8("addr-source", SI_HARDCODED);
> > +	p[3] = PROPERTY_ENTRY_U8("reg-shift", regshifts[i]);
> > +	p[4] = PROPERTY_ENTRY_U8("reg-size", regsize);
> > +	/* Last entry must be left NULL to terminate it. */
> > +
> > +	/*
> > +	 * Register spacing is derived from the resources in
> > +	 * the IPMI platform code.
> > +	 */
> > +	regspacing = regspacings[i];
> > +	if (regspacing == 0)
> > +		regspacing = regsize;
> > +
> > +	r[0].start = addr;
> > +	r[0].end = r[0].start + regsize - 1;
> > +	r[0].name = "IPMI Address 1";
> > +	r[0].flags = flags;
> > +
> > +	if (size > 1) {
> > +		r[1].start = r[0].start + regspacing;
> > +		r[1].end = r[1].start + regsize - 1;
> > +		r[1].name = "IPMI Address 2";
> > +		r[1].flags = flags;
> > +		num_r++;
> > +	}
> > +
> > +	if (size > 2) {
> > +		r[2].start = r[1].start + regspacing;
> > +		r[2].end = r[2].start + regsize - 1;
> > +		r[2].name = "IPMI Address 3";
> > +		r[2].flags = flags;
> > +		num_r++;
> > +	}
> > +
> > +	if (irqs[i]) {
> > +		r[num_r].start = irqs[i];
> > +		r[num_r].end = irqs[i];
> > +		r[num_r].name = "IPMI IRQ";
> > +		r[num_r].flags = IORESOURCE_IRQ;
> > +		num_r++;
> > +	}
> > +
> > +	pdev = platform_device_alloc("hardcode-ipmi-si", i);
> > +	if (!pdev) {
> > +		pr_err("Error allocating IPMI platform device %d\n", i);
> > +		return;
> > +	}
> > +
> > +	rv = platform_device_add_resources(pdev, r, num_r);
> > +	if (rv) {
> > +		dev_err(&pdev->dev,
> > +			"Unable to add hard-code resources: %d\n", rv);
> > +		goto err;
> > +	}
> > +
> > +	rv = platform_device_add_properties(pdev, p);
> > +	if (rv) {
> > +		dev_err(&pdev->dev,
> > +			"Unable to add hard-code properties: %d\n", rv);
> > +		goto err;
> > +	}
> > +
> > +	rv = platform_device_add(pdev);
> > +	if (rv) {
> > +		dev_err(&pdev->dev,
> > +			"Unable to add hard-code device: %d\n", rv);
> > +		goto err;
> > +	}
> > +
> > +	ipmi_hc_pdevs[i] = pdev;
> > +	return;
> > +
> > +err:
> > +	platform_device_put(pdev);
> > +}
> > +
> > +void __init ipmi_hardcode_init(void)
> > +{
> > +	unsigned int i;
> >   	char *str;
> > +	char *si_type[SI_MAX_PARMS];
> >   	/* Parse out the si_type string into its components. */
> >   	str = si_type_str;
> > @@ -95,54 +216,45 @@ int ipmi_si_hardcode_find_bmc(void)
> >   		}
> >   	}
> > -	memset(&io, 0, sizeof(io));
> >   	for (i = 0; i < SI_MAX_PARMS; i++) {
> > -		if (!ports[i] && !addrs[i])
> > -			continue;
> > -
> > -		io.addr_source = SI_HARDCODED;
> > -		pr_info("probing via hardcoded address\n");
> > -
> > -		if (!si_type[i] || strcmp(si_type[i], "kcs") == 0) {
> > -			io.si_type = SI_KCS;
> > -		} else if (strcmp(si_type[i], "smic") == 0) {
> > -			io.si_type = SI_SMIC;
> > -		} else if (strcmp(si_type[i], "bt") == 0) {
> > -			io.si_type = SI_BT;
> > -		} else {
> > -			pr_warn("Interface type specified for interface %d, was invalid: %s\n",
> > -				i, si_type[i]);
> > -			continue;
> > -		}
> > +		if (i < num_ports && ports[i])
> > +			ipmi_hardcode_init_one(si_type[i], i, ports[i],
> > +					       IORESOURCE_IO);
> > +		if (i < num_addrs && addrs[i])
> > +			ipmi_hardcode_init_one(si_type[i], i, addrs[i],
> > +					       IORESOURCE_MEM);
> > +	}
> > +}
> > -		if (ports[i]) {
> > -			/* An I/O port */
> > -			io.addr_data = ports[i];
> > -			io.addr_type = IPMI_IO_ADDR_SPACE;
> > -		} else if (addrs[i]) {
> > -			/* A memory port */
> > -			io.addr_data = addrs[i];
> > -			io.addr_type = IPMI_MEM_ADDR_SPACE;
> > -		} else {
> > -			pr_warn("Interface type specified for interface %d, but port and address were not set or set to zero\n",
> > -				i);
> > -			continue;
> > -		}
> > +void ipmi_si_hardcode_exit(void)
> > +{
> > +	unsigned int i;
> > -		io.addr = NULL;
> > -		io.regspacing = regspacings[i];
> > -		if (!io.regspacing)
> > -			io.regspacing = DEFAULT_REGSPACING;
> > -		io.regsize = regsizes[i];
> > -		if (!io.regsize)
> > -			io.regsize = DEFAULT_REGSIZE;
> > -		io.regshift = regshifts[i];
> > -		io.irq = irqs[i];
> > -		if (io.irq)
> > -			io.irq_setup = ipmi_std_irq_setup;
> > -		io.slave_addr = slave_addrs[i];
> > -
> > -		ret = ipmi_si_add_smi(&io);
> > +	for (i = 0; i < SI_MAX_PARMS; i++) {
> > +		if (ipmi_hc_pdevs[i])
> > +			platform_device_unregister(ipmi_hc_pdevs[i]);
> >   	}
> > -	return ret;
> > +}
> > +
> > +/*
> > + * Returns true of the given address exists as a hardcoded address,
> > + * false if not.
> > + */
> > +int ipmi_si_hardcode_match(int addr_type, unsigned long addr)
> > +{
> > +	unsigned int i;
> > +
> > +	if (addr_type == IPMI_IO_ADDR_SPACE) {
> > +		for (i = 0; i < num_ports; i++) {
> > +			if (ports[i] == addr)
> > +				return 1;
> > +		}
> > +	} else {
> > +		for (i = 0; i < num_addrs; i++) {
> > +			if (addrs[i] == addr)
> > +				return 1;
> > +		}
> > +	}
> > +
> > +	return 0;
> >   }
> > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > index ae99d6a14789..abbd526626d5 100644
> > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -1865,6 +1865,18 @@ int ipmi_si_add_smi(struct si_sm_io *io)
> >   	int rv = 0;
> >   	struct smi_info *new_smi, *dup;
> > +	/*
> > +	 * If the user gave us a hard-coded device at the same
> > +	 * address, they presumably want us to use it and not what is
> > +	 * in the firmware.
> > +	 */
> > +	if (io->addr_source != SI_HARDCODED &&
> > +	    ipmi_si_hardcode_match(io->addr_type, io->addr_data)) {
> > +		dev_info(io->dev,
> > +			 "Hard-coded device at this address already exists");
> > +		return -ENODEV;
> > +	}
> > +
> >   	if (!io->io_setup) {
> >   		if (io->addr_type == IPMI_IO_ADDR_SPACE) {
> >   			io->io_setup = ipmi_si_port_setup;
> > @@ -2097,7 +2109,7 @@ static int try_smi_init(struct smi_info *new_smi)
> >   	return rv;
> >   }
> > -static int init_ipmi_si(void)
> > +static int __init init_ipmi_si(void)
> >   {
> >   	struct smi_info *e;
> >   	enum ipmi_addr_src type = SI_INVALID;
> > @@ -2105,11 +2117,9 @@ static int init_ipmi_si(void)
> >   	if (initialized)
> >   		return 0;
> > -	pr_info("IPMI System Interface driver\n");
> > +	ipmi_hardcode_init();
> > -	/* If the user gave us a device, they presumably want us to use it */
> > -	if (!ipmi_si_hardcode_find_bmc())
> > -		goto do_scan;
> > +	pr_info("IPMI System Interface driver\n");
> >   	ipmi_si_platform_init();
> > @@ -2121,7 +2131,6 @@ static int init_ipmi_si(void)
> >   	   with multiple BMCs we assume that there will be several instances
> >   	   of a given type so if we succeed in registering a type then also
> >   	   try to register everything else of the same type */
> > -do_scan:
> >   	mutex_lock(&smi_infos_lock);
> >   	list_for_each_entry(e, &smi_infos, link) {
> >   		/* Try to register a device if it has an IRQ and we either
> > @@ -2307,6 +2316,8 @@ static void cleanup_ipmi_si(void)
> >   	list_for_each_entry_safe(e, tmp_e, &smi_infos, link)
> >   		cleanup_one_si(e);
> >   	mutex_unlock(&smi_infos_lock);
> > +
> > +	ipmi_si_hardcode_exit();
> >   }
> >   module_exit(cleanup_ipmi_si);
> > diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> > index 15cf819f884f..f8f85416d47a 100644
> > --- a/drivers/char/ipmi/ipmi_si_platform.c
> > +++ b/drivers/char/ipmi/ipmi_si_platform.c
> > @@ -128,8 +128,6 @@ ipmi_get_info_from_resources(struct platform_device *pdev,
> >   		if (res_second->start > io->addr_data)
> >   			io->regspacing = res_second->start - io->addr_data;
> >   	}
> > -	io->regsize = DEFAULT_REGSIZE;
> > -	io->regshift = 0;
> >   	return res;
> >   }
> > @@ -137,7 +135,7 @@ ipmi_get_info_from_resources(struct platform_device *pdev,
> >   static int platform_ipmi_probe(struct platform_device *pdev)
> >   {
> >   	struct si_sm_io io;
> > -	u8 type, slave_addr, addr_source;
> > +	u8 type, slave_addr, addr_source, regsize, regshift;
> >   	int rv;
> >   	rv = device_property_read_u8(&pdev->dev, "addr-source", &addr_source);
> > @@ -149,7 +147,7 @@ static int platform_ipmi_probe(struct platform_device *pdev)
> >   	if (addr_source == SI_SMBIOS) {
> >   		if (!si_trydmi)
> >   			return -ENODEV;
> > -	} else {
> > +	} else if (addr_source != SI_HARDCODED) {
> >   		if (!si_tryplatform)
> >   			return -ENODEV;
> >   	}
> > @@ -169,11 +167,23 @@ static int platform_ipmi_probe(struct platform_device *pdev)
> >   	case SI_BT:
> >   		io.si_type = type;
> >   		break;
> > +	case SI_TYPE_INVALID: /* User disabled this in hardcode. */
> > +		return -ENODEV;
> >   	default:
> >   		dev_err(&pdev->dev, "ipmi-type property is invalid\n");
> >   		return -EINVAL;
> >   	}
> > +	io.regsize = DEFAULT_REGSIZE;
> > +	rv = device_property_read_u8(&pdev->dev, "reg-size", &regsize);
> > +	if (!rv)
> > +	    io.regsize = regsize;
> > +
> > +	io.regshift = 0;
> > +	rv = device_property_read_u8(&pdev->dev, "reg-shift", &regshift);
> > +	if (!rv)
> > +	    io.regshift = regshift;
> > +
> >   	if (!ipmi_get_info_from_resources(pdev, &io))
> >   		return -EINVAL;
> > @@ -193,7 +203,8 @@ static int platform_ipmi_probe(struct platform_device *pdev)
> >   	io.dev = &pdev->dev;
> > -	pr_info("ipmi_si: SMBIOS: %s %#lx regsize %d spacing %d irq %d\n",
> > +	pr_info("ipmi_si: %s: %s %#lx regsize %d spacing %d irq %d\n",
> > +		ipmi_addr_src_to_str(addr_source),
> >   		(io.addr_type == IPMI_IO_ADDR_SPACE) ? "io" : "mem",
> >   		io.addr_data, io.regsize, io.regspacing, io.irq);
> > @@ -358,6 +369,9 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
> >   		goto err_free;
> >   	}
> > +	io.regsize = DEFAULT_REGSIZE;
> > +	io.regshift = 0;
> > +
> >   	res = ipmi_get_info_from_resources(pdev, &io);
> >   	if (!res) {
> >   		rv = -EINVAL;
> > @@ -421,6 +435,7 @@ static int ipmi_remove(struct platform_device *pdev)
> >   static const struct platform_device_id si_plat_ids[] = {
> >       { "dmi-ipmi-si", 0 },
> > +    { "hardcode-ipmi-si", 0 },
> >       { }
> >   };
> 
> 
