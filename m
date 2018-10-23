Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF4BC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5349F2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5349F2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJWLKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 07:10:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38454 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbeJWLKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 07:10:17 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46584801"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Oct 2018 10:48:58 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D109B4B6EDB7;
        Tue, 23 Oct 2018 10:48:54 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 23 Oct 2018 10:48:59 +0800
Date:   Tue, 23 Oct 2018 10:48:02 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <mingo@redhat.com>, <hpa@zytor.com>, <keescook@chromium.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <ard.biesheuvel@linaro.org>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181023024801.GA25978@localhost.localdomain>
References: <20181013201958.zfzv5ahhe3xz7bwi@gabell>
 <20181013203429.GE31650@zn.tnic>
 <20181013214550.ag5qzokhkrkwnzsy@gabell>
 <20181013220541.GI31650@zn.tnic>
 <20181015005035.z3xym6nx43hogdge@gabell>
 <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
 <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181022154204.kagmdb55jtoez4ca@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: D109B4B6EDB7.AE3EB
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 11:42:05AM -0400, Masayoshi Mizuma wrote:
>Hi Boris,

Hi Mizuma-san,

I have several questions:

>+static void store_possible_addr(unsigned long long possible)
>+{
>+	struct setup_data *data;
>+
>+	data = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
I suggest you add check:

	if (!data) {
		debug_putstr("No setup_data found.\n");
		return;
	}

>+	while (data) {
>+		if (data->type == SETUP_KASLR) {
>+			*(unsigned long long *)data->data = possible;
>+			return;
>+		}
>+		data = (struct setup_data *)(unsigned long)data->next;
>+	}
>+}
>+
> /*
>  * According to ACPI table, filter the immvoable memory regions
>  * and store them in immovable_mem[].
>@@ -319,6 +333,7 @@ void get_immovable_mem(void)
> 	struct acpi_subtable_header *table;
> 	struct acpi_srat_mem_affinity *ma;
> 	unsigned long table_end;
>+	unsigned long long possible_addr, max_possible_addr = 0;
> 	int i = 0;
>
> 	if (!cmdline_find_option_bool("movable_node") ||
>@@ -338,7 +353,12 @@ void get_immovable_mem(void)
> 		       sizeof(struct acpi_subtable_header) < table_end) {
> 		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> 			ma = (struct acpi_srat_mem_affinity *)table;
>-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
>+
>+			if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
>+				possible_addr = ma->base_address + ma->length;
>+				if (possible_addr > max_possible_addr)
>+					max_possible_addr = possible_addr;
>+			} else {
> 				immovable_mem[i].start = ma->base_address;
> 				immovable_mem[i].size = ma->length;
> 				i++;
>@@ -351,4 +371,5 @@ void get_immovable_mem(void)
> 			((unsigned long)table + table->length);
> 	}
> 	num_immovable_mem = i;
>+	store_possible_addr(max_possible_addr);
> }
>diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
>index 1458b17..9b95fba 100644
>--- a/arch/x86/boot/compressed/eboot.c
>+++ b/arch/x86/boot/compressed/eboot.c
>@@ -192,6 +192,40 @@ static void setup_efi_pci(struct boot_params *params)
> 	efi_call_early(free_pool, pci_handle);
> }
>
>+#ifdef CONFIG_RANDOMIZE_MEMORY
>+static void setup_kaslr(struct boot_params *params)
>+{
>+	struct setup_data *kaslr_data = NULL;
>+	struct setup_data *data;
>+	unsigned long size;
>+	efi_status_t status;
>+
>+	size = sizeof(struct setup_data) + sizeof(unsigned long long);
>+
>+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
>+			size, (void **)&kaslr_data);
>+	if (status != EFI_SUCCESS) {
>+		efi_printk(sys_table, "Failed to allocate memory for 'kaslr_data'\n");
>+		return;
>+	}
>+
>+	kaslr_data->type = SETUP_KASLR;
>+	kaslr_data->next = 0;
>+	kaslr_data->len = size;
>+
>+	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
>+	if (data)
>+		data->next = (unsigned long)kaslr_data;
Why just put the kaslr_data in data->next. You can't make sure
data->next was NULL.
>+	else {
If data is NULL, go to this else{}, so these two lines below work?
>+		while (data->next)
>+			data = (struct setup_data *)(unsigned long)data->next;
>+		data->next = (unsigned long)kaslr_data;
>+	}
If my understanding is not wrong, it should be:

	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
	if (!data)
		params->hdr.setup_data = (unsigned long)kaslr_data;
	else {
		while (data->next)
			data = (struct setup_data *)(unsigned long)data->next;
		data->next = (unsigned long)kaslr_data;
	}

If I misunderstand something, please tell me.

Thanks,
Chao Fan


