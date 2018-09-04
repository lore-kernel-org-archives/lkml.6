Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0635C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746E320869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746E320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeIDHZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:25:59 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:40228 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbeIDHZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:25:59 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowAC3je_T9Y1bYE5IBw--.12281S2;
        Tue, 04 Sep 2018 11:02:44 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 03/16] x86/mtrr: get MTRR number and support TOP_MEM2
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <cover.1535459012.git.puwen@hygon.cn>
 <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
 <20180903190438.GF10249@zn.tnic>
Message-ID: <946157a5-fdb2-a45a-63aa-97e9d602e6f0@hygon.cn>
Date:   Tue, 4 Sep 2018 11:02:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903190438.GF10249@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAC3je_T9Y1bYE5IBw--.12281S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr17ZFyrZr1kCFyktF43Jrb_yoWDCFb_ur
        yUCr15t3yqya1FqrZxGr45Jw43Jws09rnY9FyjqrWUCr1fAFy5GanrtrWDKrn2qa1fJw4q
        kF4vkas09w42vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVWUJVW8JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU89ID7UUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/4 3:04, Borislav Petkov wrote:
> It was "Hygon Dhyana" before now "Hygon" only. Can we agree on the
> naming nomenclature and stick with it.

OK, agree on it.

...

>> -	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
>> -	      (boot_cpu_data.x86 >= 0x0f)))
>> +	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
>> +	       boot_cpu_data.x86 >= 0x0f) ||
>> +	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
> 
> Why are you even touching this statement? The function returns early on
> !X86_VENDOR_AMD.

The statement is briefly equal to !(X86_VENDOR_AMD || X86_VENDOR_HYGON).
So the function will not return early on !X86_VENDOR_AMD. :-)

Also the statement can be changed to:
+	if (!(boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	      boot_cpu_data.x86 >= 0x0f) &&
+	    !(boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
or:
+	if ((boot_cpu_data.x86_vendor != X86_VENDOR_AMD ||
+	     boot_cpu_data.x86 < 0x0f) &&
+	    (boot_cpu_data.x86_vendor != X86_VENDOR_HYGON))

Which statement is better?

Thanks,
Pu Wen

