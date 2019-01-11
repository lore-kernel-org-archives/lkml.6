Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B63C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6692177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfAKKb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:31:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63216 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfAKKb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:31:28 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 0e38490c2288c393; Fri, 11 Jan 2019 11:31:25 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org
Subject: Re: [PATCH] ACPI: Change wrong print type to display the real value for i386-PAE
Date:   Fri, 11 Jan 2019 11:30:38 +0100
Message-ID: <6382453.vq0rehcvgY@aspire.rjw.lan>
In-Reply-To: <20181226033450.5098-1-fanc.fnst@cn.fujitsu.com>
References: <20181226033450.5098-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 26, 2018 4:34:50 AM CET Chao Fan wrote:
> There is a wrong display for memory address of NUMA node in i386-PAE.
> That may mislead developers.
> 
> Here is a debian9-32bit with PAE in QEMU guest whose total memory is
> more than 4G:
> qemu-system-i386 \
> -hda /var/lib/libvirt/images/debian32.qcow2 \
> -m 5G \
> -enable-kvm \
> -smp 10 \
> -numa node,mem=512M,nodeid=0,cpus=0 \
> -numa node,mem=512M,nodeid=1,cpus=1 \
> -numa node,mem=512M,nodeid=2,cpus=2 \
> -numa node,mem=512M,nodeid=3,cpus=3 \
> -numa node,mem=512M,nodeid=4,cpus=4 \
> -numa node,mem=512M,nodeid=5,cpus=5 \
> -numa node,mem=512M,nodeid=6,cpus=6 \
> -numa node,mem=512M,nodeid=7,cpus=7 \
> -numa node,mem=512M,nodeid=8,cpus=8 \
> -numa node,mem=512M,nodeid=9,cpus=9 \
> -serial stdio
> 
> Because of the wrong value type, it prints as below:
> [    0.021049] ACPI: SRAT Memory (0x0 length 0xa0000) in proximity domain 0 enabled
> [    0.021740] ACPI: SRAT Memory (0x100000 length 0x1ff00000) in proximity domain 0 enabled
> [    0.022425] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 1 enabled
> [    0.023092] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 2 enabled
> [    0.023764] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 3 enabled
> [    0.024431] ACPI: SRAT Memory (0x80000000 length 0x20000000) in proximity domain 4 enabled
> [    0.025104] ACPI: SRAT Memory (0xa0000000 length 0x20000000) in proximity domain 5 enabled
> [    0.025791] ACPI: SRAT Memory (0x0 length 0x20000000) in proximity domain 6 enabled
> [    0.026412] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 7 enabled
> [    0.027118] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 8 enabled
> [    0.027802] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 9 enabled
> The upper half of start address from domain 6 to domain 9 was cut so
> that developers get a wrong value.
> 
> Fix the value type, it prints as below:
> [    0.023698] ACPI: SRAT Memory (0x0 length 0xa0000) in proximity domain 0 enabled
> [    0.024325] ACPI: SRAT Memory (0x100000 length 0x1ff00000) in proximity domain 0 enabled
> [    0.024981] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 1 enabled
> [    0.025659] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 2 enabled
> [    0.026317] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 3 enabled
> [    0.026980] ACPI: SRAT Memory (0x80000000 length 0x20000000) in proximity domain 4 enabled
> [    0.027635] ACPI: SRAT Memory (0xa0000000 length 0x20000000) in proximity domain 5 enabled
> [    0.028311] ACPI: SRAT Memory (0x100000000 length 0x20000000) in proximity domain 6 enabled
> [    0.028985] ACPI: SRAT Memory (0x120000000 length 0x20000000) in proximity domain 7 enabled
> [    0.029667] ACPI: SRAT Memory (0x140000000 length 0x20000000) in proximity domain 8 enabled
> [    0.030334] ACPI: SRAT Memory (0x160000000 length 0x20000000) in proximity domain 9 enabled
> The start address from domain 6 to domain 9 is the real value.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  drivers/acpi/numa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 274699463b4f..7bbbf8256a41 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -146,9 +146,9 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_srat_mem_affinity *p =
>  			    (struct acpi_srat_mem_affinity *)header;
> -			pr_debug("SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s%s\n",
> -				 (unsigned long)p->base_address,
> -				 (unsigned long)p->length,
> +			pr_debug("SRAT Memory (0x%llx length 0x%llx) in proximity domain %d %s%s%s\n",
> +				 (unsigned long long)p->base_address,
> +				 (unsigned long long)p->length,
>  				 p->proximity_domain,
>  				 (p->flags & ACPI_SRAT_MEM_ENABLED) ?
>  				 "enabled" : "disabled",
> 

Applied, thanks!

