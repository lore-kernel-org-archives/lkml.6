Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeB0PEV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:04:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:36490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932088AbeB0PEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:04:20 -0500
Date: Tue, 27 Feb 2018 16:03:56 +0100
From: Borislav Petkov <bp@suse.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org
Subject: Re: [PATCH v2 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check
 structures
Message-ID: <20180227150356.GH26382@pd.tnic>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-6-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226193904.20532-6-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 01:39:01PM -0600, Yazen Ghannam wrote:
> +static void print_err_info(const char *pfx, u8 err_type, u64 check)
> +{
> +	u16 validation_bits = CHECK_VALID_BITS(check);
> +
> +	printk("%sValidation Bits: 0x%04x\n", pfx, validation_bits);
> +
> +	if (err_type == ERR_TYPE_MS)
> +		return;
> +
> +	if (validation_bits & CHECK_VALID_TRANS_TYPE) {
> +		u8 trans_type = CHECK_TRANS_TYPE(check);
> +
> +		printk("%sTransaction Type: %u, %s\n", pfx, trans_type,
> +		       trans_type < ARRAY_SIZE(ia_check_trans_type_strs) ?
> +		       ia_check_trans_type_strs[trans_type] : "unknown");
> +	}
> +
> +	if (validation_bits & CHECK_VALID_OPERATION) {
> +		u8 op = CHECK_OPERATION(check);
> +
> +		/*
> +		 * CACHE has more operation types than TLB or BUS, though the
> +		 * name and the order are the same.
> +		 */
> +		u8 max_ops = (err_type == ERR_TYPE_CACHE) ? 9 : 7;
> +
> +		printk("%sOperation: %u, %s\n", pfx, op,
> +		       op < max_ops ? ia_check_op_strs[op] : "unknown");
> +	}
> +
> +	if (validation_bits & CHECK_VALID_LEVEL)
> +		printk("%sLevel: %llu\n", pfx, CHECK_LEVEL(check));
> +
> +	if (validation_bits & CHECK_VALID_PCC)
> +		print_bool("Processor Context Corrupt", pfx, check, CHECK_PCC);

I think we want to print PCC here unconditionally and say:

	PCC: (yes|no|invalid)

I don't think the absence of PCC in the error record is a good enough
hint that the PCC field is invalid.

Ditto for the rest and transaction type above too. I think it would be
much easier if we have fixed fields error record.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
