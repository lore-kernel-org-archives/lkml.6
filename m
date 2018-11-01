Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175DCC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC5E2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ALmFqLJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC5E2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeKBC6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:58:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36679 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeKBC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:58:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24-v6so1080693plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xfaHN79ex2Wr+Aa6snj5pZBSVlURtG42kIKXYmk9NYc=;
        b=ALmFqLJm9tUCTwEpu+w3HkgzbBXM6eOlXVSK6UnGRkwgwFCUfssCMly/4D8vRNvbKm
         S8mo7sP93+DRtceMw5b+Y/mGnCAyVkpen5PDBZxar7l7TW9DeyD6vAPgad8wshumuxzZ
         BhOIyxl76f88Z2KbvcbiWZQ+ao+bIN89HY1HufyfrVR1+eWn+1Hj1O8yf8FQHo6rkbd1
         7P9nuziE99L9sxB25XD3mR/CNh+DKngU4d6RlTjBIvKOF/0GCPsBgQD/KMJejaNWCp0N
         BvEoc/bAbagYT3AzNWRc0KVK17iUcHbRTJT3hCU3a2wZnaV/e8HH9oaGeyrxrxw5WCaS
         hlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xfaHN79ex2Wr+Aa6snj5pZBSVlURtG42kIKXYmk9NYc=;
        b=bVL2n5Hkbhw7PMIDfcdx1VytcpmBxSgwBUm5qFTKyFbjTbByi+gWQgBRp1YO/lI3iH
         JnIK4gu8L+4qE/1qER0l+f+3Dn6+KV13ynYMGEE1WokzBi+eT+gzhRwKNIfM6iEeoYfd
         I7oHj1bcn3yRkvZ0eeeZc3Gyy35ExqIHJSAygsfsTwQAQsaNAwJkm8sso7SBA6UQyiZU
         ReywMwlWk9n8R0KNDpH+LB1w7Agl/CUjPJoEjhUfiRBP0a44KsVWNRM/TjCzl8mU6mCX
         51Lo4Z1IQyWk/vFxSumXeLCQNS2G9IK3KqL/lvFShMGH2babUZuZaw8J+Px17wjnEVMw
         FtDw==
X-Gm-Message-State: AGRZ1gIKMyemU2wH4iXrBkibi/4fB7eTeDOjjzxgvfJz/mmkuTPRWetm
        +PtwXP5HLC0QO+jm9EIhbI3OJA==
X-Google-Smtp-Source: AJdET5eE/znqCSQRZmJHzFeLG/xzBozxNF1yLJbPKGzIZSnzV0P90ZpHrRLSe+sYE64sksuYWjrcdA==
X-Received: by 2002:a17:902:7045:: with SMTP id h5-v6mr8514883plt.211.1541094888775;
        Thu, 01 Nov 2018 10:54:48 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g3-v6sm9245166pgr.40.2018.11.01.10.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 10:54:47 -0700 (PDT)
Date:   Thu, 01 Nov 2018 10:54:47 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Nov 2018 10:54:29 PDT (-0700)
Subject:     Re: [PATCH v2 2/2] RISC-V: defconfig: Enable printk timestamps
In-Reply-To: <20181101051033.10089-2-anup@brainfault.org>
CC:     aou@eecs.berkeley.edu, Olof Johansson <olof@lixom.net>,
        atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-f1ed976f-ca28-42af-bdb2-ee53e4585c2a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 22:10:33 PDT (-0700), anup@brainfault.org wrote:
> The printk timestamps are very useful information to visually see
> where kernel is spending time during boot. It also helps us see
> the timing of hotplug events at runtime.
>
> This patch enables printk timestamps in RISC-V defconfig so that
> we have it enabled by default (similar to other architectures
> such as x86_64, arm64, etc).
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 07fa9ea75fea..ef4f15df9adf 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -76,4 +76,5 @@ CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_PRINTK_TIME=y
>  # CONFIG_RCU_TRACE is not set

Thanks.  Since this is a functional change I'm not going to rush it in, but I 
think it's OK to go in after rc1 so I'll include it as part of my 
regularly-scheduled PR next week.
