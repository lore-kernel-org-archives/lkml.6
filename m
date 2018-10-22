Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41568C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD012205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD012205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJVPtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:49:15 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17562 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727350AbeJVPtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:49:15 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46538934"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Oct 2018 15:31:49 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id E460F4B6EDAD;
        Mon, 22 Oct 2018 15:31:45 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Oct 2018 15:31:48 +0800
Date:   Mon, 22 Oct 2018 15:30:51 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <dyoung@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "Indoh, Takao" <indou.takao@fujitsu.com>,
        "Cao, Jin" <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 5/8] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181022073050.GB7641@localhost.localdomain>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-6-fanc.fnst@cn.fujitsu.com>
 <20181021022650.GI1885@192.168.1.4>
 <B74D54765E346E448CD6C7B7B0334C258D955469@G08CNEXMBSHAD01.g08.fujitsu.local>
 <20181022060613.GK1885@192.168.1.4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181022060613.GK1885@192.168.1.4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: E460F4B6EDAD.AF4E9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 02:06:13PM +0800, Baoquan He wrote:
>On 10/22/18 at 05:30am, Fan, Chao wrote:
>> >> +static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
>> >> +{
>> >> +#ifdef CONFIG_KEXEC
>> >> +	unsigned long long res;
>> >> +	int len = 0;
>> >> +	char *val;
>> >> +
>> >> +	val = malloc(20);
>> >
>> >Why is the length 20? Defined a macro?
>> >
>> 
>> Not a calculation, if it's enough to store the address, that will be OK.
>
>Sorry, I didn't catch. It's 16 in setup_acpi_rsdp() of
>drivers/acpi/osl.c . What does 'that' mean?

The second parameter of kstrtoull(), the 16 you mentioned means
hexadecimal, not the length.
I checked my host and guest, the value are ACPI20=0xbfbfa014, ACPI20=0xdb807000.
The length of memory is 8. Well the max memory address is 16, add
"0x" and '\0' is 19. So I set it as 20.
I am not sure whether 8 is enough for the address, if OK, 11 will
be enough, or 19 is OK.
If my understanding is wrong, please tell me.

Thanks,
Chao Fan

>
>Wondering why not making it 200, it's also enough to store the address.
>
>


