Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF14C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCC12084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eovZD87C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCC12084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJEBrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:47:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41032 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeJEBrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:47:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so3813934pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D6O44GusxfpYzyrCey7fysVcp2hU7vhxxACeKEc23sA=;
        b=eovZD87C6B5bEOhwVRdeOD8VtPtJV9QwQS2tWF3QuNtAgQUoCXOkzE70oHPC2j5muX
         3dB4OlN1p9lpcvy7TGVNzb2fUJxcRhFS0vz8Kkgzw/7URRaTesDdHeK2xrFB1o8qmPhQ
         EgoYZYZlkeB1ZIBLxjx6YYjsQ8gpWkSSJe7y9iXAU9JHBzxrYKlQux+JktmyRGnTom18
         aCkX2WO/IUH33croSXJHyNAixHGpVhRlAk+1bdDDy6gP36eIG50G+u9kxexgpLkSbDlf
         7Qb7ZJjZiaKrVQ0DI6JreDrCA2hHMo8sUhWo3nI3B03dhXaekJh/jzPJVHadotsSzOl0
         OsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=D6O44GusxfpYzyrCey7fysVcp2hU7vhxxACeKEc23sA=;
        b=rTZmAphG/5WpbbOWICzR2wjFEelNuXPrZSWk0RxQ9vYaFAbiXELJocowgppiVWi0Iw
         1LKShlU+bhBaRPrGy+gGZ6xzdplhSa5wTadSRqjf1Cf1LFCjPDmANpYqQC3+Z+aGQeMl
         uRW4uJb5/Gc4D6+IOe3kwiX8D3TGQ3ocqq75j8OzBGHaWcJHddfZ41C4EGG3FUqy0Q0B
         jjBwKGfpMrLS1GZYJuzEgp58WF8hrR7LtPXp7mnqvAgcMwwUGgDivsxjmAyVtutpMxR2
         8A3KKVJ9GwdxO++LofHrqFQwZzYu//fnRF80PkughHfNbMXd1YOiuI8gCmwWV5CcqfND
         EuWw==
X-Gm-Message-State: ABuFfoiaJV/iqakdstMjAKU3n/OxWhMdhDJA5BsRNSx8PK/dwlWhb7Da
        HcUld/XPojU+i5DnmUIsl4Q=
X-Google-Smtp-Source: ACcGV60VTjuSCIIN9CXhqh9tgKdK5tNNsGjW70Je78yq6a2nPaH4rbWyMnfh/1hx65QrAgPgL6uQhg==
X-Received: by 2002:a63:eb07:: with SMTP id t7-v6mr6851585pgh.441.1538679159468;
        Thu, 04 Oct 2018 11:52:39 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e22-v6sm5752158pfi.61.2018.10.04.11.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 11:52:38 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:52:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  amdgpu/gmc : fix compile warning
Message-ID: <20181004185237.GA20667@roeck-us.net>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 14, 2018 at 06:05:52PM +0800, Peng Hao wrote:
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
>     In function ‘gmc_v8_0_process_interrupt’:
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
>     warning: missing braces around initializer [-Wmissing-braces]
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Was there any feedback on this patch ? The problem does affect us,
and we'll need a fix.

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9333109..55f4755 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>  		gmc_v8_0_set_fault_enable_default(adev, false);
>  
>  	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info = { 0 };
> +		struct amdgpu_task_info task_info = { {0} };
>  

I wondered if
		struct amdgpu_task_info task_info = { };
would be better.

Thanks,
Guenter

>  		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 72f8018..e8b78c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  	}
>  
>  	if (printk_ratelimit()) {
> -		struct amdgpu_task_info task_info = { 0 };
> +		struct amdgpu_task_info task_info = { {0} };
>  
>  		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>  
