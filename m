Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0946EECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31262064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko1rfoUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31262064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJYDvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:51:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39120 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeJYDvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:51:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id e4so4146469qkh.6;
        Wed, 24 Oct 2018 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hRxVeRTXd4H3NKj2v9FbWhQhjA4AnhNznCHf7yfc2Zs=;
        b=ko1rfoUPwl27K4oyf5BB0ncsL7UkhZX6ChTKCiB5ZqIXre0KS3cqr6ephxOGb6Tfxl
         BX1hFVYw/SWhERrmxBZR6A3A2S54tTQF5pGXzJ6cSf+Z6EcGITKTA6fr0Ttgn6ewwtRd
         +YlIlb7R0s6hlUu1StgAqdnNdbufpxwbfXE7JS8nPnd8ezH6I0yMe9LuQ2+JytQM01qI
         sEGuq9Z7NJ0svg8J5FkTaV3Ur5yPJlYy/czEyatu0UJ94oEIPJO0WANLq6LwmonoDXAW
         78aYGWT98A5oygzjdtsyU9NKdc3cHBGptVWw5TGiccM7q6xeEL0lpZq1umrs1lxX4Bhp
         8Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hRxVeRTXd4H3NKj2v9FbWhQhjA4AnhNznCHf7yfc2Zs=;
        b=qY3m2HCZwvkyiWUKJLPejHckMiX6Q8cJdZrCAB+Km/d03k2etFV9QS3uaOnKcbuonU
         4vJHc/A7SBfyZZhhL+frdsRuIUPTIgsTQ2D/cc/qJ5d4ry9zfgX10r0XDZPsTWsxBD7k
         u6i8Ot+M9Ux/OX1+QSyTQHQIBiVywoGo0Zelxj01dfJG9eVVvdhaLf/VM695YpLn4GoG
         YdvOWZKZZHffH0EyCuAHLfToihlyQ1Ss7sNx6Qv3nvwlcD86BHCw2n7PdWuv4HMr7WA2
         0WhD9WWqP0Q+KhjhhzmB/S1JKeD9ZvvWXu32kmI07R0uspnd7xftyNsZnzxWAI1rEtD3
         EOEg==
X-Gm-Message-State: AGRZ1gIU+gwUlS4tomO+YksCuUzn2I8JRpj2GFRbyis1dN8z6OSJBMxz
        8ZhbcfXGQv3VPLLN7+NNuzPZA6s=
X-Google-Smtp-Source: AJdET5e0RnW5SSyjr9mtBUYvOpiit62Xc59kzNAU5QcMe+4CKg+JqIkhNyUO65QygxpVIfsZtkFEzg==
X-Received: by 2002:a37:655:: with SMTP id 82-v6mr3580555qkg.223.1540408904562;
        Wed, 24 Oct 2018 12:21:44 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u67-v6sm4179843qkh.12.2018.10.24.12.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 12:21:44 -0700 (PDT)
Date:   Wed, 24 Oct 2018 15:21:36 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181024192135.7qhhfbbrgb4ojgqe@gabell>
References: <20181013203429.GE31650@zn.tnic>
 <20181013214550.ag5qzokhkrkwnzsy@gabell>
 <20181013220541.GI31650@zn.tnic>
 <20181015005035.z3xym6nx43hogdge@gabell>
 <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
 <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181023024801.GA25978@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023024801.GA25978@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:48:02AM +0800, Chao Fan wrote:
> On Mon, Oct 22, 2018 at 11:42:05AM -0400, Masayoshi Mizuma wrote:
> >Hi Boris,
> 
> Hi Mizuma-san,
> 
> I have several questions:

Thank you for your comments! I think your suggestions are
right.
However, the prototype patch works EFI environment only.
The memory hot-plug affinity in SRAT and KASLR are also available
on legacy BIOS environment, so I need to get the patch useful
for legacy BIOS as well, but I have no idea to add such things...
If you have ideas, could you let me know?

Probably I should have another idea, for example,
add the SRAT parsing code, looks like you are adding to
arch/x86/boot/compressed/acpitb.c, to arch/x86/mm/kaslr.c.

Thanks,
Masa

> 
> >+static void store_possible_addr(unsigned long long possible)
> >+{
> >+	struct setup_data *data;
> >+
> >+	data = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
> I suggest you add check:
> 
> 	if (!data) {
> 		debug_putstr("No setup_data found.\n");
> 		return;
> 	}
> 
> >+	while (data) {
> >+		if (data->type == SETUP_KASLR) {
> >+			*(unsigned long long *)data->data = possible;
> >+			return;
> >+		}
> >+		data = (struct setup_data *)(unsigned long)data->next;
> >+	}
> >+}
> >+
> > /*
> >  * According to ACPI table, filter the immvoable memory regions
> >  * and store them in immovable_mem[].
> >@@ -319,6 +333,7 @@ void get_immovable_mem(void)
> > 	struct acpi_subtable_header *table;
> > 	struct acpi_srat_mem_affinity *ma;
> > 	unsigned long table_end;
> >+	unsigned long long possible_addr, max_possible_addr = 0;
> > 	int i = 0;
> >
> > 	if (!cmdline_find_option_bool("movable_node") ||
> >@@ -338,7 +353,12 @@ void get_immovable_mem(void)
> > 		       sizeof(struct acpi_subtable_header) < table_end) {
> > 		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
> > 			ma = (struct acpi_srat_mem_affinity *)table;
> >-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
> >+
> >+			if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
> >+				possible_addr = ma->base_address + ma->length;
> >+				if (possible_addr > max_possible_addr)
> >+					max_possible_addr = possible_addr;
> >+			} else {
> > 				immovable_mem[i].start = ma->base_address;
> > 				immovable_mem[i].size = ma->length;
> > 				i++;
> >@@ -351,4 +371,5 @@ void get_immovable_mem(void)
> > 			((unsigned long)table + table->length);
> > 	}
> > 	num_immovable_mem = i;
> >+	store_possible_addr(max_possible_addr);
> > }
> >diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> >index 1458b17..9b95fba 100644
> >--- a/arch/x86/boot/compressed/eboot.c
> >+++ b/arch/x86/boot/compressed/eboot.c
> >@@ -192,6 +192,40 @@ static void setup_efi_pci(struct boot_params *params)
> > 	efi_call_early(free_pool, pci_handle);
> > }
> >
> >+#ifdef CONFIG_RANDOMIZE_MEMORY
> >+static void setup_kaslr(struct boot_params *params)
> >+{
> >+	struct setup_data *kaslr_data = NULL;
> >+	struct setup_data *data;
> >+	unsigned long size;
> >+	efi_status_t status;
> >+
> >+	size = sizeof(struct setup_data) + sizeof(unsigned long long);
> >+
> >+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
> >+			size, (void **)&kaslr_data);
> >+	if (status != EFI_SUCCESS) {
> >+		efi_printk(sys_table, "Failed to allocate memory for 'kaslr_data'\n");
> >+		return;
> >+	}
> >+
> >+	kaslr_data->type = SETUP_KASLR;
> >+	kaslr_data->next = 0;
> >+	kaslr_data->len = size;
> >+
> >+	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
> >+	if (data)
> >+		data->next = (unsigned long)kaslr_data;
> Why just put the kaslr_data in data->next. You can't make sure
> data->next was NULL.
> >+	else {
> If data is NULL, go to this else{}, so these two lines below work?
> >+		while (data->next)
> >+			data = (struct setup_data *)(unsigned long)data->next;
> >+		data->next = (unsigned long)kaslr_data;
> >+	}
> If my understanding is not wrong, it should be:
> 
> 	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
> 	if (!data)
> 		params->hdr.setup_data = (unsigned long)kaslr_data;
> 	else {
> 		while (data->next)
> 			data = (struct setup_data *)(unsigned long)data->next;
> 		data->next = (unsigned long)kaslr_data;
> 	}
> 
> If I misunderstand something, please tell me.
> 
> Thanks,
> Chao Fan
> 
> 
