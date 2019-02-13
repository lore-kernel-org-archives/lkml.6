Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD4C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DBA222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbfBMKRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:17:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728291AbfBMKRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:17:06 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 62BE13A9832A82393620;
        Wed, 13 Feb 2019 18:17:02 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 18:16:52 +0800
Date:   Wed, 13 Feb 2019 10:16:40 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        =?ISO-8859-1?Q?J?= =?ISO-8859-1?Q?=E9r=F4me?= Glisse 
        <jglisse@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Michal Hocko <mhocko@kernel.org>, <jcm@redhat.com>
Subject: Re: [PATCH 1/3] ACPI: Support Generic Initator only domains
Message-ID: <20190213101640.00006a51@huawei.com>
In-Reply-To: <20190212214736.GG6176@localhost.localdomain>
References: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
        <20190212164926.202-2-Jonathan.Cameron@huawei.com>
        <20190212214736.GG6176@localhost.localdomain>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 14:47:36 -0700
Keith Busch <keith.busch@intel.com> wrote:

> On Tue, Feb 12, 2019 at 04:49:24PM +0000, Jonathan Cameron wrote:
> > +	case ACPI_SRAT_TYPE_GENERIC_INITIATOR_AFFINITY:
> > +	{
> > +		struct acpi_srat_gi_affinity *p =
> > +			(struct acpi_srat_gi_affinity *)header;
> > +		char name[9] = {};
> > +
> > +		if (p->flags & ACPI_SRAT_GI_PCI_HANDLE) {
> > +			/*
> > +			 * For pci devices this may be the only place they
> > +			 * are assigned a proximity domain
> > +			 */
> > +			pr_debug("SRAT Generic Initiator(Seg:%u BDF:%u) in proximity domain %d %s\n",
> > +				p->pci_handle.segment,
> > +				p->pci_handle.bdf,
> > +				p->proximity_domain,
> > +				(p->flags & ACPI_SRAT_GI_ENABLED) ?
> > +				"enabled" : "disabled");  
> 
> <snip>
> 
> > +#define ACPI_SRAT_GI_ENABLED     (1)		/* 00: Use affinity structure */
> > +#define ACPI_SRAT_GI_ACPI_HANDLE (0)		/* 01: */
> > +#define ACPI_SRAT_GI_PCI_HANDLE  (1 << 1)	/* 01: */  
> 
> It looks like you're reading reserved bits. My copy of the 6.3 spec says
> PCI Handle is 1, and is set in Device Handle Type field, not in the Flags.
Good spot.

Sorry, wrote this long before spec publish and some details got tidied up.
I fixed iasl end but forgot to actually update the reading of it. Oops!
As you can probably guess that my test was using an ACPI handle so didn't
hit this at all.  I'll shove a PCIe card in the machine to check those
as well.

Will fix up for v2!

Thanks,

Jonathan
> 
> > +/* 5 : Generic Initiator Affinity (ACPI 6.3) */
> > +
> > +struct acpi_srat_gi_affinity {
> > +	struct acpi_subtable_header header;
> > +	u8 reserved;
> > +	u8 device_handl_type;
> > +	u32 proximity_domain;
> > +	union {
> > +		struct acpi_srat_gi_acpi_handle acpi_handle;
> > +		struct acpi_srat_gi_pci_handle pci_handle;
> > +	};
> > +	u32 flags;
> > +	u32 reserved2;
> > +};  


