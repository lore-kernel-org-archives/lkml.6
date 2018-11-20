Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC9C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D920685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="hcer8FYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1D920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeKTTCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:02:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45006 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTTCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:02:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so712600lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRiakW4kkU4QxXvrPzVTIVZ+ByHprLn+DwGg+WJ6S0U=;
        b=hcer8FYkzEmzUzh+QVMx3zh7hpxpxyBoXGaRHJVtRV4RFRXLFY14s8ot86FKQYf924
         5rCS/so+Z0mrv7yu8dx6ANHecfBrElhteFDRQRItvd6X5qIjfbPdV+7TrxLKWXbrrze8
         ZNn9WeVzMPnuofz2QwlTSW4rlVN2yMPBj17RzENsTTlbS/pqjk2C5JZho3JEYpAwHwWi
         zJyr3VfCUUk73MPSSuu+O9O3oMxGZL5ulRWtUbMbWlRVAFAGZ4OxFR3PNIx4fhnmu51w
         O3VP732STHLMhyX5ziwkoGT9GCPWKcILetVibVr6qoHrPHmHhLd/MeACeEuk1a5Zut2l
         lBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRiakW4kkU4QxXvrPzVTIVZ+ByHprLn+DwGg+WJ6S0U=;
        b=ab+6/A/HzmdZ+3PA/s6NdZmVF8DaDGxqLeC/Ol8zKpOAAhnPJdSO64Du8VYWrMhuha
         +Yc8IHR5aViWTSEVBB0n6l23NnJ9RB7aZZ8VRzojlvLy7gTazcjlCGBW+kFtroz7Ak7j
         3cRRCefMBoo9xik8vTOK0Q5Fw28geQ3cna8wJnMD6Dbh8OcaS+CKAEVwpZSWiABwNApE
         DYNWMLLU++5YZW5r13+7ft3xl5b9zU8sx+pDjWcYgjw2eveLcOdmy7KIW9BZSrRkZ2Qk
         mtrFE5v22KPZcqW8VKTYYa0XiO6iIr5zS9zt72gfz0UkmIGOv1ddvnuqRmyV3z2TJsIT
         GP6Q==
X-Gm-Message-State: AGRZ1gJOBBi3fn/EeSXIaBuBtf8vK63NuozymdS3WCfUEQqDqmwuu56C
        XzXS+YCK/OrmS659HH9MiO+rjue8Bo0=
X-Google-Smtp-Source: AJdET5fmBC95acV3MaoKFpXiukEcYJ/ihXZO9p4LkPbjr2X0UBJvw2UWMaFfymd8ItOW5LzC4icTUg==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr617917lfa.40.1542702847520;
        Tue, 20 Nov 2018 00:34:07 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id k63sm4965864lfe.13.2018.11.20.00.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 00:34:06 -0800 (PST)
Subject: Re: [PATCH] ia64: export node_distance function
To:     tony.luck@intel.com, fenghua.yu@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com
References: <20181103183716.28841-1-mb@lightnvm.io>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0e230c3f-15a6-1e07-53e0-b27f01ac1333@lightnvm.io>
Date:   Tue, 20 Nov 2018 09:34:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181103183716.28841-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2018 07:37 PM, Matias Bjørling wrote:
> The numa_slit variable used by node_distance is available to a
> module as long as it is linked at compile-time. However, it is
> not available to loadable modules. Leading to errors such as:
> 
>    ERROR: "numa_slit" [drivers/nvme/host/nvme-core.ko] undefined!
> 
> The error above is caused by the nvme multipath code that makes
> use of node_distance for its path calculation. When the patch was
> added, the lightnvm subsystem would select nvme and always compile
> it in, leading to the node_distance call to always succeed.
> However, when this requirement was removed, nvme could be compiled
> in as a module, which exposed this bug.
> 
> This patch extracts node_distance to a function and exports it.
> Since ACPI is depending on node_distance being a simple lookup to
> numa_slit, the previous behavior is exposed as slit_distance and its
> users updated.
> 
> Fixes: f333444708f82 "nvme: take node locality into account when selecting a path"
> Fixes: 73569e11032f "lightnvm: remove dependencies on BLK_DEV_NVME and PCI"
> Signed-off-by: Matias Bjøring <mb@lightnvm.io>
> ---
>   arch/ia64/include/asm/numa.h | 4 +++-
>   arch/ia64/kernel/acpi.c      | 6 +++---
>   arch/ia64/mm/numa.c          | 6 ++++++
>   3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/numa.h b/arch/ia64/include/asm/numa.h
> index ebef7f40aabb..c5c253cb9bd6 100644
> --- a/arch/ia64/include/asm/numa.h
> +++ b/arch/ia64/include/asm/numa.h
> @@ -59,7 +59,9 @@ extern struct node_cpuid_s node_cpuid[NR_CPUS];
>    */
>   
>   extern u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
> -#define node_distance(from,to) (numa_slit[(from) * MAX_NUMNODES + (to)])
> +#define slit_distance(from,to) (numa_slit[(from) * MAX_NUMNODES + (to)])
> +extern int __node_distance(int from, int to);
> +#define node_distance(from,to) __node_distance(from, to)
>   
>   extern int paddr_to_nid(unsigned long paddr);
>   
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index 1dacbf5e9e09..41eb281709da 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -578,8 +578,8 @@ void __init acpi_numa_fixup(void)
>   	if (!slit_table) {
>   		for (i = 0; i < MAX_NUMNODES; i++)
>   			for (j = 0; j < MAX_NUMNODES; j++)
> -				node_distance(i, j) = i == j ? LOCAL_DISTANCE :
> -							REMOTE_DISTANCE;
> +				slit_distance(i, j) = i == j ?
> +					LOCAL_DISTANCE : REMOTE_DISTANCE;
>   		return;
>   	}
>   
> @@ -592,7 +592,7 @@ void __init acpi_numa_fixup(void)
>   			if (!pxm_bit_test(j))
>   				continue;
>   			node_to = pxm_to_node(j);
> -			node_distance(node_from, node_to) =
> +			slit_distance(node_from, node_to) =
>   			    slit_table->entry[i * slit_table->locality_count + j];
>   		}
>   	}
> diff --git a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
> index aa19b7ac8222..5769d4b21270 100644
> --- a/arch/ia64/mm/numa.c
> +++ b/arch/ia64/mm/numa.c
> @@ -36,6 +36,12 @@ struct node_cpuid_s node_cpuid[NR_CPUS] =
>    */
>   u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
>   
> +int __node_distance(int from, int to)
> +{
> +	return slit_distance(from, to);
> +}
> +EXPORT_SYMBOL(__node_distance);
> +
>   /* Identify which cnode a physical address resides on */
>   int
>   paddr_to_nid(unsigned long paddr)
> 

Tony and Fenghua, could you please take a look at the above patch? 
kbuild has been bugging me for a fix.
