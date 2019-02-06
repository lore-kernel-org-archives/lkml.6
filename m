Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B360C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B9E217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfBFQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:06:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:6386 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBFQGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:06:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 08:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="142077354"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2019 08:06:44 -0800
Date:   Wed, 6 Feb 2019 09:06:14 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv5 03/10] acpi/hmat: Parse and report heterogeneous memory
Message-ID: <20190206160613.GG28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-4-keith.busch@intel.com>
 <20190206122814.00000127@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206122814.00000127@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:28:14PM +0000, Jonathan Cameron wrote:
> On Thu, 24 Jan 2019 16:07:17 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> 
> > +	pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%d Target Domains:%d Base:%lld\n",
> > +		hmat_loc->flags, hmat_data_type(type), ipds, tpds,
> > +		hmat_loc->entry_base_unit);
> > +
> > +	inits = (u32 *)(hmat_loc + 1);
> > +	targs = &inits[ipds];
>
> This line is a bit of an oddity as it's indexing off the end of the data.
> 	targs = inits + ipds;
> would be nicer to my mind as doesn't even hint that we are in inits still.
> 
> 
> > +	entries = (u16 *)(&targs[tpds]);

Sure, I can change these to addition rather than indexing. I have no
preference either way.

> As above I'd prefer we did the pointer arithmetic explicitly rather
> than used an index off the end of the array.
> 
> > +	for (init = 0; init < ipds; init++) {
> > +		for (targ = 0; targ < tpds; targ++) {
> > +			value = entries[init * tpds + targ];
> > +			value = (value * hmat_loc->entry_base_unit) / 10;
> > +			pr_info("  Initiator-Target[%d-%d]:%d%s\n",
> > +				inits[init], targs[targ], value,
> > +				hmat_data_type_suffix(type));
> 
> Worth checking at this early stage that the domains exist in SRAT?
> + screaming if they don't.

Sure, I think it should be sufficient to check pxm_to_node() for a valid
value to validate the table is okay..

> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static __init int hmat_parse_cache(union acpi_subtable_headers *header,
> > +				   const unsigned long end)
> > +{
> > +	struct acpi_hmat_cache *cache = (void *)header;
> > +	u32 attrs;
> > +
> > +	if (cache->header.length < sizeof(*cache)) {
> > +		pr_debug("HMAT: Unexpected cache header length: %d\n",
> > +			 cache->header.length);
> > +		return -EINVAL;
> > +	}
> > +
> > +	attrs = cache->cache_attributes;
> > +	pr_info("HMAT: Cache: Domain:%d Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
> > +		cache->memory_PD, cache->cache_size, attrs,
> > +		cache->number_of_SMBIOShandles);
> 
> Can we sanity check those smbios handles actually match anything?

Will do.
 
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
> > +					   const unsigned long end)
> > +{
> > +	struct acpi_hmat_address_range *spa = (void *)header;
> > +
> > +	if (spa->header.length != sizeof(*spa)) {
> > +		pr_debug("HMAT: Unexpected address range header length: %d\n",
> > +			 spa->header.length);
> 
> My gut feeling is that it's much more useful to make this always print rather
> than debug.  Same with other error paths above.  Given the number of times
> broken ACPI tables show up, it's nice to complain really loudly!
> 
> Perhaps others prefer to not do so though so I'll defer to subsystem norms.

Yeah, I demoted these to debug based on earlier feedback. We should
still be operational even with broken HMAT, so I don't want to create
unnecessary panic if its broken, but I agree something should be
immediately noticable if the firmware tables are incorrect. Maybe like
what bad_srat() provides.
