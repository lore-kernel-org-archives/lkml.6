Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A60C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C312084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C312084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbeKFFzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:55:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35757 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeKFFzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:55:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so9349990otj.2;
        Mon, 05 Nov 2018 12:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6M891GVh1xqp3w8rVscQ61pDhV+I1JgNwXgn360CZss=;
        b=rnNDMse95lspQVFD3xjkmvTNRYbeywY+AhbCABtaGgBEv/L5YVTetxmVCcWcIlHXmm
         xKqkAzXcbaOD/Vb0ZdDLp2KQZHPmus6Z7HbowXsafcwp+PBNew1iTHzAI2zc8a2q2pBq
         1CYLjtiG85WR/2bpDR/DiR3UKXeNOPVxfDl9cEsohK/2ZsWGiqBxSNwUFeTjd57edVcU
         BTjcaJ0RPv1y4q3jfzB+yNwkGkL6cWbtNHfo8i67XoxK0qsC6gXlEUQDF8mAdHSNY/Na
         n6/bnuEsH0uI8RsNuD7fVDZByVpAYj0bakbSgE7jofep+XTuuBHmJR5rEO16S8xpc6qD
         R8qA==
X-Gm-Message-State: AGRZ1gLuqm/u20G6VHkBWJz5P/+J2dhtkAhaGCc2pr5O/N3OFu+TJG6b
        cpAh+WfF/MPjiDMASfn/rw==
X-Google-Smtp-Source: AJdET5doqvpVgGQ2jSs5mjGeJ6agGgHy4/A+v6xp83UamTjwbzQ1uIVZOVFMXYBPlfVRFhtBs3uNFw==
X-Received: by 2002:a9d:1526:: with SMTP id u35mr13621184otf.22.1541450024399;
        Mon, 05 Nov 2018 12:33:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t38sm4693341otf.29.2018.11.05.12.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:33:43 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:33:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, rppt@linux.ibm.com,
        linux@armlinux.org.uk, green.hu@gmail.com, deanbo422@gmail.com,
        gxt@pku.edu.cn, ard.biesheuvel@linaro.org,
        linux-snps-arc@lists.infradead.org, vgupta@synopsys.com
Subject: Re: [PATCH v3 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
Message-ID: <20181105203342.GB21852@bogus>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
 <20181031192843.13230-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031192843.13230-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:28:41PM -0700, Florian Fainelli wrote:
> ARM64 is the only architecture that re-defines
> __early_init_dt_declare_initrd() in order for that function to populate
> initrd_start/initrd_end with physical addresses instead of virtual
> addresses. Instead of having an override we can leverage
> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
> populate those variables for us.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/mm/init.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3cf87341859f..00ef2166bb73 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>  	if (*endp == ',') {
>  		size = memparse(endp + 1, NULL);
>  
> -		initrd_start = start;
> -		initrd_end = start + size;
> +		phys_initrd_start = start;
> +		phys_initrd_size = size;
>  	}
>  	return 0;
>  }
> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>  		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>  	}
>  
> -	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>  		/*
>  		 * Add back the memory we just removed if it results in the
>  		 * initrd to become inaccessible via the linear mapping.
>  		 * Otherwise, this is a no-op
>  		 */
> -		u64 base = initrd_start & PAGE_MASK;
> -		u64 size = PAGE_ALIGN(initrd_end) - base;
> +		u64 base = phys_initrd_start & PAGE_MASK;
> +		u64 size = PAGE_ALIGN(phys_initrd_size);
>  
>  		/*
>  		 * We can only add back the initrd memory if we don't end up
> @@ -460,12 +460,11 @@ void __init arm64_memblock_init(void)
>  	 */
>  	memblock_reserve(__pa_symbol(_text), _end - _text);
>  #ifdef CONFIG_BLK_DEV_INITRD
> -	if (initrd_start) {
> -		memblock_reserve(initrd_start, initrd_end - initrd_start);
> -
> +	if (phys_initrd_size) {

Since we're touching the if anyways, perhaps convert the #ifdef to a C 
IS_ENABLED().

>  		/* the generic initrd code expects virtual addresses */
> -		initrd_start = __phys_to_virt(initrd_start);
> -		initrd_end = __phys_to_virt(initrd_end);
> +		initrd_start = __phys_to_virt(phys_initrd_start);
> +		initrd_end = initrd_start + phys_initrd_size;
> +		initrd_below_start_ok = 0;
>  	}
>  #endif
>  
> -- 
> 2.17.1
> 
