Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27185C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21A5216FA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21A5216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeH0F60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:58:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbeH0F6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E105685722;
        Mon, 27 Aug 2018 02:13:53 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 906E284422;
        Mon, 27 Aug 2018 02:13:52 +0000 (UTC)
Date:   Mon, 27 Aug 2018 10:13:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, n-horiguchi@ah.jp.nec.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v5 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20180827021349.GR29313@MiWiFi-R3L-srv>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
 <20180807065000.30958-4-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807065000.30958-4-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 27 Aug 2018 02:13:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 27 Aug 2018 02:13:53 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/18 at 02:49pm, Chao Fan wrote:
> If 'CONFIG_MEMORY_HOTREMOVE' specified, walk the acpi srat memory
> tables, store the immovable memory regions, so that kaslr can get
> the information abouth where can be selected or not.
> If 'CONFIG_MEMORY_HOTREMOVE' not specified, go on the old code.
Just adjust the patch log a little bit, just for your reference.

If 'CONFIG_MEMORY_HOTREMOVE' specified, walk through the acpi srat memory
tables and store those immovable memory regions so that kaslr can get
where to choose for randomization.

> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 59 ++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 302517929932..720878f967a3 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -31,6 +31,7 @@
>  
>  #include "misc.h"
>  #include "error.h"
> +#include "acpitb.h"
>  #include "../string.h"
>  
>  #include <generated/compile.h>
> @@ -104,6 +105,14 @@ static bool memmap_too_large;
>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>  static unsigned long long mem_limit = ULLONG_MAX;
>  
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/* Store the immovable memory regions */
> +static struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +
> +/* Store the amount of immovable memory regions */
> +static int num_immovable_mem;
> +#endif
> +
>  
>  enum mem_avoid_index {
>  	MEM_AVOID_ZO_RANGE = 0,
> @@ -298,6 +307,51 @@ static int handle_mem_options(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/*
> + * According to ACPI table, filter the immvoable memory regions
> + * and store them in immovable_mem[].
> + */
> +static void handle_immovable_mem(void)

Can we change this function like below, passed in the immovable_mem and
the array lengty, the value of num_immovable_mem will be passed back?

static void handle_immovable_mem(char* region, int max, int *num)
{
}

Like this, you don't need patch 1/4 to make a header file, just put this
function handle_immovable_mem() into acpitb.c since it's handling acpi
tables. And its name can be get_immovable_mem().


> +{
> +	char *args = (char *)get_cmd_line_ptr();
> +	struct acpi_table_header *table_header;
> +	struct acpi_subtable_header *table;
> +	struct acpi_srat_mem_affinity *ma;
> +	unsigned long table_end;
> +	int i = 0;
> +
> +	if (!strstr(args, "movable_node"))
> +		return;
> +
> +	table_header = get_acpi_srat_table();
> +	if (!table_header)
> +		return;
> +
> +	table_end = (unsigned long)table_header + table_header->length;
> +
> +	table = (struct acpi_subtable_header *)
> +		((unsigned long)table_header + sizeof(struct acpi_table_srat));
> +
> +	while (((unsigned long)table) + table->length < table_end) {
> +		if (table->type == 1) {
> +			ma = (struct acpi_srat_mem_affinity *)table;
> +			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
> +				immovable_mem[i].start = ma->base_address;
> +				immovable_mem[i].size = ma->length;
> +				i++;
> +			}
> +
> +			if (i >= MAX_NUMNODES*2)
> +				break;
> +		}
> +		table = (struct acpi_subtable_header *)
> +			((unsigned long)table + table->length);
> +	}
> +	num_immovable_mem = i;
> +}
> +#endif
> +
>  /*
>   * In theory, KASLR can put the kernel anywhere in the range of [16M, 64T).
>   * The mem_avoid array is used to store the ranges that need to be avoided
> @@ -421,6 +475,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>  	/* Mark the memmap regions we need to avoid */
>  	handle_mem_options();
>  
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +	/* Mark the immovable regions we need to choose */
> +	handle_immovable_mem();
> +#endif
> +
>  #ifdef CONFIG_X86_VERBOSE_BOOTUP
>  	/* Make sure video RAM can be used. */
>  	add_identity_map(0, PMD_SIZE);
> -- 
> 2.17.1
> 
> 
> 
