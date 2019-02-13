Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE95C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6B1222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amc+nUSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfBMD4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:56:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40947 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfBMD4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:56:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so1695330oth.7;
        Tue, 12 Feb 2019 19:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c5gtsRA3DLoK8eJKe4+U7UmwuQLsYumEfJhv2F4zpI4=;
        b=amc+nUSbtt/O0Xe07BCz/Qc2F/OxnwsClaHGRgkQhquMji4kqIwq7YmeMMyUBvm8js
         UlaffsTf5P80oSyO2q4J6pD9aIdkxFNQEM3iysqkRMt3Euv9Wv7FMKWbQjSnrwt3eZTV
         D76D1gnGcNt2mVUEun1EqmWSRr+pGY83cI5oCnwXCNb2sDCQG4gC27kgmO4XzvUel5J+
         hOEezyJLbAZEm5kSsoDDctEmVNcpsu+0n6DUtc3p+eV3qJVgXhX3r6xlJcOsdqyneeQW
         Boq2eE1Cj2TIAwOy65GOU/F4ZTo0XF16K/54okZQ7zNRekWwaoaiThmrp7Fz7ODmfviN
         NtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c5gtsRA3DLoK8eJKe4+U7UmwuQLsYumEfJhv2F4zpI4=;
        b=THMugcCTQo/PImqyll+Ww5yHcDT+++fhXebI+GgT8Npx35TMA5LZ/UdYLxU811QJNp
         iAQYrpo17sNdPB5AyHcaZT/w1dZ/8e52mSd+vN33l6JPFF8yTyCRHI2ptjbd2QyE7sOV
         Hggqjc/dfJu0kDjCvZMOp4sCYbHqs1kOKIQTn2JjOLg0+44TN0QybNQOYGH2fITgzpoW
         CbvUPhwYCS//WKSLjajM+XLz2BGIxmltYrQ1+vc4lpOf5P+nrUvx3ogDl/jogfqJAsPr
         iy/X2AnEPg5zJb44AInZl3kycP55gbvPixMPUUQoBeCCBUPCAEPJ9ITIKlNNIcKPaP1p
         ZV8Q==
X-Gm-Message-State: AHQUAuZp2+1ePuFfH2YlcUtT+mb+a6HDSZkOvmNyd3hNtJDbZZBUJTWN
        736PCH/rMdKTlTv/RIl4vtI=
X-Google-Smtp-Source: AHgI3IZu/MH+ERf4UGlWmUd2kC0FKkq+jban9umhOOx60WHjlL38XxZrRSXr5Ott6h48phd/a/5+jg==
X-Received: by 2002:a9d:641:: with SMTP id 59mr6742268otn.215.1550030194447;
        Tue, 12 Feb 2019 19:56:34 -0800 (PST)
Received: from [192.168.0.2] ([98.156.228.54])
        by smtp.gmail.com with ESMTPSA id j23sm6939114oih.22.2019.02.12.19.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 19:56:33 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell_rbu: fix lock imbalance in
 img_update_realloc
To:     Christoph Hellwig <hch@lst.de>, dvhart@infradead.org,
        andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20190211130940.28206-1-hch@lst.de>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <8d8a1ad0-2192-5293-9073-21d1916778ff@gmail.com>
Date:   Tue, 12 Feb 2019 21:56:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20190211130940.28206-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 190212-4, 02/12/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2019 7:09 AM, Christoph Hellwig wrote:
> We need to ensure rbu_data.lock is always held on return.
> 
> Fixes: 289790a3ea94 ("platform/x86: dell_rbu: stop abusing the DMA API")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/platform/x86/dell_rbu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
> index 8104ca0c44ca..031c68903583 100644
> --- a/drivers/platform/x86/dell_rbu.c
> +++ b/drivers/platform/x86/dell_rbu.c
> @@ -436,6 +436,7 @@ static int img_update_realloc(unsigned long size)
>  	ordernum = get_order(size);
>  	image_update_buffer =
>  		(unsigned char *)__get_free_pages(GFP_DMA32, ordernum);
> +	spin_lock(&rbu_data.lock);
>  	if (!image_update_buffer) {
>  		pr_debug("Not enough memory for image update:"
>  			"size = %ld\n", size);
> @@ -446,7 +447,6 @@ static int img_update_realloc(unsigned long size)
>  	if (WARN_ON_ONCE(img_buf_phys_addr > BIOS_SCAN_LIMIT))
>  		return -EINVAL; /* can't happen per definition */
>  
> -	spin_lock(&rbu_data.lock);
>  	rbu_data.image_update_buffer = image_update_buffer;
>  	rbu_data.image_update_buffer_size = size;
>  	rbu_data.bios_image_size = rbu_data.image_update_buffer_size;
> 

Acked-by: Stuart Hayes <stuart.w.hayes@gmail.com>
