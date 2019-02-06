Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E6F2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfBFMZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:25:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727697AbfBFMZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:25:12 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88D5DB51B782B0D4FAD9;
        Wed,  6 Feb 2019 20:25:09 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 20:25:07 +0800
Date:   Wed, 6 Feb 2019 12:24:58 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCHv5 07/10] acpi/hmat: Register performance attributes
Message-ID: <20190206122458.0000793c@huawei.com>
In-Reply-To: <20190124230724.10022-8-keith.busch@intel.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
        <20190124230724.10022-8-keith.busch@intel.com>
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

On Thu, 24 Jan 2019 16:07:21 -0700
Keith Busch <keith.busch@intel.com> wrote:

> Register the local attached performace access attributes with the memory's
performance

> node if HMAT provides the locality table. While HMAT does make it possible
> to know performance for all possible initiator-target pairings, we export
> only the local and matching pairings at this time.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/hmat/Kconfig |  1 +
>  drivers/acpi/hmat/hmat.c  | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> index c9637e2e7514..08e972ead159 100644
> --- a/drivers/acpi/hmat/Kconfig
> +++ b/drivers/acpi/hmat/Kconfig
> @@ -2,6 +2,7 @@
>  config ACPI_HMAT
>  	bool "ACPI Heterogeneous Memory Attribute Table Support"
>  	depends on ACPI_NUMA
> +	select HMEM_REPORTING
>  	help
>  	 If set, this option causes the kernel to set the memory NUMA node
>  	 relationships and access attributes in accordance with ACPI HMAT
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 85fd835c2e23..917e6122b3f0 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -430,6 +430,19 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
>  		hmat_register_if_local(target, initiator);
>  }
>  
> +static __init void hmat_register_target_perf(struct memory_target *target)
> +{
> +	unsigned mem_nid = pxm_to_node(target->memory_pxm);
> +	struct node_hmem_attrs hmem_attrs = {
> +		.read_bandwidth	= target->read_bandwidth,
> +		.write_bandwidth= target->write_bandwidth,
> +		.read_latency	= target->read_latency,
> +		.write_latency	= target->write_latency,
> +	};
> +
> +	node_set_perf_attrs(mem_nid, &hmem_attrs, 0);
> +}
> +
>  static __init void hmat_register_targets(void)
>  {
>  	struct memory_target *target, *tnext;
> @@ -439,6 +452,7 @@ static __init void hmat_register_targets(void)
>  	list_for_each_entry_safe(target, tnext, &targets, node) {
>  		list_del(&target->node);
>  		hmat_register_target_initiators(target);
> +		hmat_register_target_perf(target);
>  		kfree(target);
>  	}
>  


