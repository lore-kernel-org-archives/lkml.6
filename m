Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB82C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C0D20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C0D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeH3RBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:01:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50112 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbeH3RBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:01:22 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvMXW-0003EC-5a; Thu, 30 Aug 2018 14:59:10 +0200
Date:   Thu, 30 Aug 2018 14:59:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Gu Zhimin <kookoo.gu@intel.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Yu Chen <yu.c.chen@intel.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86, hibernate: Extract the common code of 64/32
 bit system
In-Reply-To: <541d9caef16c4a6c6e0ef160f607566c61c081c9.1535361949.git.kookoo.gu@intel.com>
Message-ID: <alpine.DEB.2.21.1808301445400.1210@nanos.tec.linutronix.de>
References: <cover.1535361949.git.kookoo.gu@intel.com> <541d9caef16c4a6c6e0ef160f607566c61c081c9.1535361949.git.kookoo.gu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018, Gu Zhimin wrote:
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> new file mode 100644
> index 0000000..6f91f7b
> --- /dev/null
> +++ b/arch/x86/power/hibernate.c
> @@ -0,0 +1,255 @@
> +/*
> + * Hibernation support for x86
> + *
> + * Distribute under GPLv2

We have SPDX identifiers for that and not some randomly chosen license
hint.

> +
> +/*
> + *	pfn_is_nosave - check if given pfn is in the 'nosave' section

This is a half baken kernel doc header. 

> + */
> +

Random new line.

> +int pfn_is_nosave(unsigned long pfn)
> +{
> +	unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
> +	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;

Instead of blindly copying stuff please fix it so it matches kernel coding
rules.

> +	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);

The brackets are pointless

> +}
> +
> +#ifdef CONFIG_X86_64
> +static int relocate_restore_code(void)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	relocated_restore_code = get_safe_page(GFP_ATOMIC);
> +	if (!relocated_restore_code)
> +		return -ENOMEM;
> +
> +	memcpy((void *)relocated_restore_code, core_restore_code, PAGE_SIZE);
> +
> +	/* Make the page containing the relocated code executable */
> +	pgd = (pgd_t *)__va(read_cr3_pa()) +
> +		pgd_index(relocated_restore_code);
> +	p4d = p4d_offset(pgd, relocated_restore_code);
> +	if (p4d_large(*p4d)) {
> +		set_p4d(p4d, __p4d(p4d_val(*p4d) & ~_PAGE_NX));
> +		goto out;
> +	}
> +	pud = pud_offset(p4d, relocated_restore_code);
> +	if (pud_large(*pud)) {
> +		set_pud(pud, __pud(pud_val(*pud) & ~_PAGE_NX));
> +		goto out;
> +	}
> +	pmd = pmd_offset(pud, relocated_restore_code);
> +	if (pmd_large(*pmd)) {
> +		set_pmd(pmd, __pmd(pmd_val(*pmd) & ~_PAGE_NX));
> +		goto out;
> +	}
> +	pte = pte_offset_kernel(pmd, relocated_restore_code);
> +	set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_NX));
> +out:
> +	__flush_tlb_all();
> +	return 0;
> +}
> +
> +#define MD5_DIGEST_SIZE 16
> +
> +struct restore_data_record {
> +	unsigned long jump_address;
> +	unsigned long jump_address_phys;
> +	unsigned long cr3;
> +	unsigned long magic;
> +	u8 e820_digest[MD5_DIGEST_SIZE];
> +};
> +
> +#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
> +/**
> + * get_e820_md5 - calculate md5 according to given e820 table
> + *
> + * @table: the e820 table to be calculated
> + * @buf: the md5 result to be stored to
> + */
> +static int get_e820_md5(struct e820_table *table, void *buf)
> +{
> +	struct crypto_shash *tfm;
> +	struct shash_desc *desc;
> +	int size;
> +	int ret = 0;
> +
> +	tfm = crypto_alloc_shash("md5", 0, 0);
> +	if (IS_ERR(tfm))
> +		return -ENOMEM;
> +
> +	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
> +		       GFP_KERNEL);
> +	if (!desc) {
> +		ret = -ENOMEM;
> +		goto free_tfm;
> +	}
> +
> +	desc->tfm = tfm;
> +	desc->flags = 0;
> +
> +	size = offsetof(struct e820_table, entries) +
> +		sizeof(struct e820_entry) * table->nr_entries;
> +
> +	if (crypto_shash_digest(desc, (u8 *)table, size, buf))
> +		ret = -EINVAL;
> +
> +	kzfree(desc);
> +
> +free_tfm:
> +	crypto_free_shash(tfm);
> +	return ret;
> +}
> +
> +static void hibernation_e820_save(void *buf)
> +{
> +	get_e820_md5(e820_table_firmware, buf);

So if get_e820_md5() fails, then it will hibernate nevertheless. Why is
that error code not propagated?

Thanks,

	tglx
