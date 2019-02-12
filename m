Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BB0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7D222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbfBLVrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:47:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:25526 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfBLVrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:47:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 13:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="121941465"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 12 Feb 2019 13:47:54 -0800
Date:   Tue, 12 Feb 2019 14:47:36 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Michal Hocko <mhocko@kernel.org>, jcm@redhat.com
Subject: Re: [PATCH 1/3] ACPI: Support Generic Initator only domains
Message-ID: <20190212214736.GG6176@localhost.localdomain>
References: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
 <20190212164926.202-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212164926.202-2-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:49:24PM +0000, Jonathan Cameron wrote:
> +	case ACPI_SRAT_TYPE_GENERIC_INITIATOR_AFFINITY:
> +	{
> +		struct acpi_srat_gi_affinity *p =
> +			(struct acpi_srat_gi_affinity *)header;
> +		char name[9] = {};
> +
> +		if (p->flags & ACPI_SRAT_GI_PCI_HANDLE) {
> +			/*
> +			 * For pci devices this may be the only place they
> +			 * are assigned a proximity domain
> +			 */
> +			pr_debug("SRAT Generic Initiator(Seg:%u BDF:%u) in proximity domain %d %s\n",
> +				p->pci_handle.segment,
> +				p->pci_handle.bdf,
> +				p->proximity_domain,
> +				(p->flags & ACPI_SRAT_GI_ENABLED) ?
> +				"enabled" : "disabled");

<snip>

> +#define ACPI_SRAT_GI_ENABLED     (1)		/* 00: Use affinity structure */
> +#define ACPI_SRAT_GI_ACPI_HANDLE (0)		/* 01: */
> +#define ACPI_SRAT_GI_PCI_HANDLE  (1 << 1)	/* 01: */

It looks like you're reading reserved bits. My copy of the 6.3 spec says
PCI Handle is 1, and is set in Device Handle Type field, not in the Flags.

> +/* 5 : Generic Initiator Affinity (ACPI 6.3) */
> +
> +struct acpi_srat_gi_affinity {
> +	struct acpi_subtable_header header;
> +	u8 reserved;
> +	u8 device_handl_type;
> +	u32 proximity_domain;
> +	union {
> +		struct acpi_srat_gi_acpi_handle acpi_handle;
> +		struct acpi_srat_gi_pci_handle pci_handle;
> +	};
> +	u32 flags;
> +	u32 reserved2;
> +};
