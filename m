Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F0FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E1B218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfBFMRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:17:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbfBFMRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:17:21 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 16D01AC5852869D1A110;
        Wed,  6 Feb 2019 20:17:19 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 20:17:17 +0800
Date:   Wed, 6 Feb 2019 12:17:06 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCHv5 09/10] acpi/hmat: Register memory side cache
 attributes
Message-ID: <20190206121706.00005246@huawei.com>
In-Reply-To: <20190124230724.10022-10-keith.busch@intel.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
        <20190124230724.10022-10-keith.busch@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 16:07:23 -0700
Keith Busch <keith.busch@intel.com> wrote:

> Register memory side cache attributes with the memory's node if HMAT
> provides the side cache iniformation table.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
Trivial suggestion inline.
> ---
>  drivers/acpi/hmat/hmat.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 917e6122b3f0..11f65b38e9f9 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -245,6 +245,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  				   const unsigned long end)
>  {
>  	struct acpi_hmat_cache *cache = (void *)header;
> +	struct node_cache_attrs cache_attrs;
>  	u32 attrs;
>  
>  	if (cache->header.length < sizeof(*cache)) {
> @@ -258,6 +259,37 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  		cache->memory_PD, cache->cache_size, attrs,
>  		cache->number_of_SMBIOShandles);
>  
> +	cache_attrs.size = cache->cache_size;
> +	cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
> +	cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
> +
> +	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {

FIELD_GET might be nice for these to avoid having the shifts and the mask.

> +	case ACPI_HMAT_CA_DIRECT_MAPPED:
> +		cache_attrs.associativity = NODE_CACHE_DIRECT_MAP;
> +		break;
> +	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
> +		cache_attrs.associativity = NODE_CACHE_INDEXED;
> +		break;
> +	case ACPI_HMAT_CA_NONE:
> +	default:
> +		cache_attrs.associativity = NODE_CACHE_OTHER;
> +		break;
> +	}
> +
> +	switch ((attrs & ACPI_HMAT_WRITE_POLICY) >> 12) {
> +	case ACPI_HMAT_CP_WB:
> +		cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
> +		break;
> +	case ACPI_HMAT_CP_WT:
> +		cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
> +		break;
> +	case ACPI_HMAT_CP_NONE:
> +	default:
> +		cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> +		break;
> +	}
> +
> +	node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
>  	return 0;
>  }
>  


