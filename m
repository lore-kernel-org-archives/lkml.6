Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F07C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CD02245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CD02245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeKMMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:07:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60863 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbeKMMHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:07:13 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47980580"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Nov 2018 10:11:18 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id E55144B6ED4F;
        Tue, 13 Nov 2018 10:11:13 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 10:11:18 +0800
Date:   Tue, 13 Nov 2018 10:10:16 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v11 2/5] x86/boot: Add bios_get_rsdp_addr() to search
 RSDP in memory
Message-ID: <20181113021016.GC7453@localhost.localdomain>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-3-fanc.fnst@cn.fujitsu.com>
 <20181112152744.GG8167@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112152744.GG8167@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: E55144B6ED4F.A9E87
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:27:44PM +0100, Borislav Petkov wrote:
>On Mon, Nov 12, 2018 at 05:46:42PM +0800, Chao Fan wrote:
>> Imitate ACPI code to search RSDP pointer from memory.
>> Walk memory and check the signature until get the RSDP signature.
>> Based on acpi_tb_scan_memory_for_rsdp() and acpi_find_root_pointer().
>> If didn't get RSDP from EFI table, will run this function.
>
>That's some very strange english. Please improve.
>
>> Used for later patch to dig out SRAT table and get the memory
>> information. And figure out the immovable memory regions
>> to avoid KASLR extracts kernel on movable memory, slove the
>						    ^^^^^^
>
>Please introduce a spellchecker into your patch creation workflow.
>

Thanks.

>> conflict between KASLR and movable_node feature.
>
>Btw, this paragraph could be used for a CONFIG_ item you could define
>for your particular use case. Because right now you have funnies like:
>
>+#if (defined CONFIG_MEMORY_HOTREMOVE) && (defined CONFIG_RANDOMIZE_BASE)
>+vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/acpitb.o
>+#endif
>
>where CONFIG_RANDOMIZE_BASE is repeated for no good reason.
>
>But we'll see - need to get to the end of your patch series first.
>
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpitb.c | 106 ++++++++++++++++++++++++++++++
>>  1 file changed, 106 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
>> index 56b54b0e0889..50fa65cf824d 100644
>> --- a/arch/x86/boot/compressed/acpitb.c
>> +++ b/arch/x86/boot/compressed/acpitb.c
>> @@ -94,3 +94,109 @@ static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>>  	}
>>  #endif
>>  }
>> +
>> +static u8 compute_checksum(u8 *buffer, u32 length)
>> +{
>> +	u8 sum = 0;
>> +	u8 *end = buffer + length;
>> +
>> +	while (buffer < end)
>> +		sum = (u8)(sum + *(buffer++));
>
>What's that cast for?
>
>Ah, this is the version in acpi_tb_checksum(). Well, I'd write this
>simply as:
>
>		sum += *(buffer++);

Thanks for your suggestion.

>
>> +
>> +	return sum;
>> +}
>> +
>> +/*
>> + * Used to search a block of memory for the RSDP signature.
>> + * Return Pointer to the RSDP if found, otherwise NULL.
>
>     "Returns pointer... "
>
>> + * Based on acpi_tb_scan_memory_for_rsdp().
>> + */
>> +static u8 *scan_mem_for_rsdp(u8 *start, u32 length)
>> +{
>> +	struct acpi_table_rsdp *rsdp;
>> +	u8 *end;
>> +	u8 *rover;
>
>rover?
>
>> +
>> +	end = start + length;
>> +
>> +	/* Search from given start address for the requested length */
>> +	for (rover = start; rover < end; rover += ACPI_RSDP_SCAN_STEP) {

The 'rover' was named as 'mem_rover', but the length of this line is too
long. So shorten it as 'rever' so that they can keep in one line.

>> +		/*
>> +		 * The RSDP signature and checksum must both be correct
>> +		 * Note: Sometimes there exists more than one RSDP in memory;
>> +		 * the valid RSDP has a valid checksum, all others have an
>> +		 * invalid checksum.
>> +		 */
>> +		rsdp = (struct acpi_table_rsdp *)rover;
>> +
>> +		/* Nope, BAD Signature */
>> +		if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature))
>> +			continue;
>> +
>> +		/* Check the standard checksum */
>> +		if (compute_checksum((u8 *) rsdp, ACPI_RSDP_CHECKSUM_LENGTH))
>> +			continue;
>> +
>> +		/* Check extended checksum if table version >= 2 */
>> +		if ((rsdp->revision >= 2) &&
>> +		    (compute_checksum((u8 *) rsdp, ACPI_RSDP_XCHECKSUM_LENGTH)))
>> +			continue;
>> +
>> +		/* Sig and checksum valid, we have found a real RSDP */
>> +		return rover;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Used to search RSDP physical address.
>> + * Based on acpi_find_root_pointer(). Since only use physical address
>> + * in this period, so there is no need to do the memory map jobs.
>
>You mean: "All addresses used here are physical."?
>
>"memory map jobs"?
>
>Please be more careful when writing comments which are going to be read
>by other people. "jobs" means a lot of things and you don't want "jobs"
>in that context here.

OK.

>
>> + */
>> +static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
>
>Same remark as before: the function is void and you're returning through
>its parameter. Make it return acpi_physical_address instead.
>

I will change all these functions.

>> +{
>> +	struct acpi_table_rsdp *rsdp;
>> +	u8 *table_ptr;
>> +	u8 *mem_rover;
>
>rover?

This name came from ACPI driver code, acpi_find_root_pointer().
Used for the loop. If you have a better name, please tell me.

>
>> +	u32 address;
>> +
>> +	/*
>> +	 * Get the location of the Extended BIOS Data Area (EBDA)
>> +	 * Since we use physical address directely, so
>
>It is "directly" - what about that spellchecker?
>
>> +	 * acpi_os_map_memory() and acpi_os_unmap_memory() are
>> +	 * not needed here.
>
>Why do you even need to say that here?

I will try to improve all the comment.
>
>> +	 */
>> +	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
>> +	*(u32 *)(void *)&address = *(u16 *)(void *)table_ptr;
>> +	address <<= 4;
>> +	table_ptr = (u8 *)address;
>
>arch/x86/boot/compressed/acpitb.c: In function ‘bios_get_rsdp_addr’:
>arch/x86/boot/compressed/acpitb.c:172:14: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  table_ptr = (u8 *)address;
>              ^
>
>Also, that is some crazy casting here and I think you could use
>unsigned longs here for all the address arithmetic and cast to
>acpi_physical_address only at the end.

That's a good suggestion.

>
>> +
>> +	/*
>> +	 * Search EBDA paragraphs (EBDA is required to be a minimum of
>> +	 * 1K length)
>> +	 */
>> +	if (address > 0x400) {
>> +		mem_rover = scan_mem_for_rsdp(table_ptr, ACPI_EBDA_WINDOW_SIZE);
>> +
>
>Superfluous new line.
>
>> +		if (mem_rover) {
>> +			address += (u32)ACPI_PTR_DIFF(mem_rover, table_ptr);
>> +			*rsdp_addr = (acpi_physical_address)address;
>> +			return;
>> +		}
>> +	}
>> +
>> +	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
>> +	mem_rover = scan_mem_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
>> +
>> +	/*
>> +	 * Search upper memory: 16-byte boundaries in E0000h-FFFFFh
>> +	 * Since we use physical address directely, so
>> +	 * acpi_os_map_memory() and acpi_os_unmap_memory() are
>> +	 * not needed here.
>> +	 */
>
>And this comment needs to be repeated here because... ?
I will try to improve all the comment.

Thanks,
Chao Fan

>
>> +	if (mem_rover) {
>> +		address = (u32)(ACPI_HI_RSDP_WINDOW_BASE +
>> +				ACPI_PTR_DIFF(mem_rover, table_ptr));
>> +		*rsdp_addr = (acpi_physical_address)address;
>> +	}
>> +}
>> -- 
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


