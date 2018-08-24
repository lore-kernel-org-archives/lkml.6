Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4930FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20DC2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnK4SGee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20DC2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeHXRln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:41:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39420 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:41:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so4599688pff.6;
        Fri, 24 Aug 2018 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ep+Lw9us11yU9urW8LrhIGhsId4Kl5l5f5dBynUDh7w=;
        b=DnK4SGeeYSkdb6VUiPnU0PGK+pdSrrSJ79uIMCIFNgOWbwYNsKmRtpQ8ughfXaVuW0
         U8f1E7UVfddClNPsx4wIiru6+tYgtk+enFymZbNOU0W2lVV4E4Zvy7nd8D5peWczZeC+
         bSNf+y9HDK+D73bzE55NcZusvKNAOFaCEr+pUW9PnPo/3kCP8XZApD/Z6N6lIfBnmhuw
         nyAgu6ETto72GQ3Dc6e5jdc71Vxfg8Uz1mSMUAkQ2IlNbVYLXtnnb49VNszT6GTEx7CR
         19SIu533SeD1kpCBznlLBbmFWxDUdwu3MbJ/gWVxBgiHdUPgozf2XXvDO5suVddRooOl
         u0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ep+Lw9us11yU9urW8LrhIGhsId4Kl5l5f5dBynUDh7w=;
        b=CwAlQJWbcUxt8hJpeuqHCh4oiEHkBT9JhJTlUZJchcB7X8OGxLu6/V+uL3pTH6tU/N
         4TmemZ4XGpDW6xOFGzHCxnsSAxXzwIV+N+ykkwIGdpXg3Z+IZPHV7VEr9jkvf5JZDDxz
         ozcyXiW6ooIyi8UAbl00OMWg4rUF0wl1i0KAB4MgucWnTkemOveJpEEkb7eG38AbEswS
         NHfe/1peun5fyCjcQKjASJgBFPlmsoGQSdlLo17iw6Nx7BgSVRIfsJvIziEXAte6YU5k
         wbHy3w156C8103SczuIdHmMKGhzka0OxwrqHvuFsX0cB7NJxymzYEA1w4BesWxdRHiQ3
         cjZA==
X-Gm-Message-State: APzg51AjyhmO/PjJSGxrWl5hCwxuClXaci7tie1tEyEblY+e68vcqWfz
        hllIQRvxf43IhBNw2xCFH0I=
X-Google-Smtp-Source: ANB0Vdak7qOkQYziWsGqhA061P2ckHngP120CJEu39HhthEsAXzfCwBPIr7I+uWjrG75ICwT+qupRg==
X-Received: by 2002:aa7:8118:: with SMTP id b24-v6mr2220046pfi.78.1535119614110;
        Fri, 24 Aug 2018 07:06:54 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j184-v6sm9963376pge.77.2018.08.24.07.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 07:06:53 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma (build
 failures)
To:     Will Deacon <will.deacon@arm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
 <20180824130722.GA31409@roeck-us.net> <20180824131026.GB11868@brain-police>
 <20180824132419.GA9983@roeck-us.net> <20180824133427.GC11868@brain-police>
 <20180824135048.GF11868@brain-police>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7d0111f4-c369-43a8-72c6-1a7390cdebdd@roeck-us.net>
Date:   Fri, 24 Aug 2018 07:06:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824135048.GF11868@brain-police>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 06:50 AM, Will Deacon wrote:

>> -#include <asm-generic/tlb.h>
>> +struct mmu_gather;
>>   
>>   static inline void tlb_flush(struct mmu_gather *tlb)
>>   {
>>   	flush_tlb_mm(tlb->mm);
> 
> Bah, didn't spot the dereference so this won't work either. You basically
> just need to copy what I did for arm64 in d475fac95779.
> 

Yes, this seems to work. It doesn't really need "struct mmu_gather;" -
I assume that is included from elsewhere - but I added it to be safe.

Can you send a full patch, or do you want me to do it ?

Thanks,
Guenter

---
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index c229509288ea..439dc7072e05 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -14,6 +14,10 @@
  #ifndef _ASM_RISCV_TLB_H
  #define _ASM_RISCV_TLB_H

+struct mmu_gather;
+
+static void tlb_flush(struct mmu_gather *tlb);
+
  #include <asm-generic/tlb.h>

  static inline void tlb_flush(struct mmu_gather *tlb)
