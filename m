Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7304C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADDA240BD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADDA240BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935576AbeF2SST (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:18:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754309AbeF2SSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:18:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D6118A;
        Fri, 29 Jun 2018 11:18:17 -0700 (PDT)
Received: from [192.168.100.244] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 078873F5AD;
        Fri, 29 Jun 2018 11:18:16 -0700 (PDT)
Subject: Re: [PATCH] ACPI/PPTT: use ACPI ID whenever
 ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <955705e0-1d31-2c4b-3c5a-9c10603e36f8@arm.com>
Date:   Fri, 29 Jun 2018 13:18:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/29/2018 11:17 AM, Sudeep Holla wrote:
> Currently we use the ACPI processor ID only for the leaf/processor nodes
> as the specification states it must match the value of ACPI processor ID
> field in the processor’s entry in the MADT.
> 
> However, if a PPTT structure represents processors group, it match a
> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
> flag describe whether the ACPI processor ID is valid.
> 
> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
> consistent instead of using table offset as it's currently done for non
> leaf nodes.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/acpi/pptt.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Hi,
> 
> There's ongoing discussion on assigning ID based in OS using simple
> counters. It can never be consistent with firmware's view. So if the
> firmware provides valid UID for non-processors node, we must use it.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index e5ea1974d1e3..d1e26cb599bf 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -481,8 +481,14 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>   	if (cpu_node) {
>   		cpu_node = acpi_find_processor_package_id(table, cpu_node,
>   							  level, flag);
> -		/* Only the first level has a guaranteed id */
> -		if (level == 0)
> +		/*
> +		 * As per specification if the processor structure represents
> +		 * an actual processor, then ACPI processor ID must be valid.
> +		 * For processor containers ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
> +		 * should be set if the UID is valid
> +		 */
> +		if (level == 0 ||
> +		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>   			return cpu_node->acpi_processor_id;

While, for some machines this likely helps create more human readable 
ID's... What happens when the ID namespaces conflict with each other?

AKA, I'm a little shy of this change because your going from something 
we can guarantee is unique to depending on an portion of the PPTT 
definition that has a couple different ways that it can be interpreted.

OTOH the change is probably safe at the moment because i don't think 
anyone has partially marked nodes at a given PPTT "level" valid, or put 
structures that aren't part of the PE/cache's in the tree (outside of my 
juno test tree with the GPU's/etc).


