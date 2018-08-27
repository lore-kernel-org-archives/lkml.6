Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A34C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5DE20666
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5DE20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeH0NSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:18:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbeH0NSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:18:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A43F87A7F;
        Mon, 27 Aug 2018 09:32:24 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 494632026D6B;
        Mon, 27 Aug 2018 09:32:22 +0000 (UTC)
Date:   Mon, 27 Aug 2018 17:32:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, n-horiguchi@ah.jp.nec.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org, ard.biesheuvel@linaro.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 2/4] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20180827093220.GF1748@MiWiFi-R3L-srv>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
 <20180807065000.30958-3-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807065000.30958-3-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 27 Aug 2018 09:32:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 27 Aug 2018 09:32:24 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 08/07/18 at 02:49pm, Chao Fan wrote:

I think better add acpi/efi maintainers to CC when you post.


> +static acpi_physical_address get_rsdp_addr(void)
> +{
> +	acpi_physical_address pa = 0;
> +	bool status = false;


Here, I think you should make get_rsdp_addr() consistent with its
counterpart acpi_os_get_root_pointer(). In acpi_os_get_root_pointer(),
we take care of the case that acpi_rsdp passed in a value.
> +
> +	status = efi_get_rsdp_addr(&pa);
> +
> +	if (!status || pa == 0)
> +		bios_get_rsdp_addr(&pa);
> +
> +	return pa;
> +}
> +
> +struct acpi_table_header *get_acpi_srat_table(void)
> +{
> +	char *args = (char *)get_cmd_line_ptr();
> +	acpi_physical_address acpi_table;
> +	acpi_physical_address root_table;
> +	struct acpi_table_header *header;
> +	struct acpi_table_rsdp *rsdp;
> +	char *signature;
> +	u8 *entry;
> +	u32 count;
> +	u32 size;
> +	int i, j;
> +	u32 len;
> +
> +	rsdp = (struct acpi_table_rsdp *)get_rsdp_addr();
> +	if (!rsdp)
> +		return NULL;
> +
> +	/* Get rsdt or xsdt from rsdp. */
> +	if (!strstr(args, "acpi=rsdt") &&
> +	    rsdp->xsdt_physical_address && rsdp->revision > 1) {
> +		root_table = rsdp->xsdt_physical_address;
> +		size = ACPI_XSDT_ENTRY_SIZE;
> +	} else {
> +		root_table = rsdp->rsdt_physical_address;
> +		size = ACPI_RSDT_ENTRY_SIZE;
> +	}
> +
> +	/* Get ACPI root table from rsdt or xsdt.*/
> +	header = (struct acpi_table_header *)root_table;
> +	len = header->length;
> +	count = (u32)((len - sizeof(struct acpi_table_header)) / size);
> +	entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
> +
> +	for (i = 0; i < count; i++) {
> +		u64 address64;
> +
> +		if (size == ACPI_RSDT_ENTRY_SIZE)
> +			acpi_table = ((acpi_physical_address)
> +				      (*ACPI_CAST_PTR(u32, entry)));
> +		else {
> +			*(u64 *)(void *)&address64 = *(u64 *)(void *)entry;
> +			acpi_table = (acpi_physical_address) address64;
> +		}
> +
> +		if (acpi_table) {
> +			header = (struct acpi_table_header *)acpi_table;
> +			signature = header->signature;
> +
> +			if (!strncmp(signature, "SRAT", 4))
> +				return header;
> +		}
> +		entry += size;
> +	}
> +	return NULL;
> +}
> -- 
> 2.17.1
> 
> 
> 
