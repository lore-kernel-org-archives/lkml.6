Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF91AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D59221773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnnyoTWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfBSQqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:46:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43429 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBSQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:46:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so10481406pfh.10;
        Tue, 19 Feb 2019 08:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Qu2t5Kd9pgLrX06LIAt+b3Zb2/etIust7WpLoqpeB4=;
        b=VnnyoTWWXidBBt1pIhmQhNUC9SzzTpvgaTLeao1BXgcGOWzsewI9x5wHlWUVy7SBSI
         rR7evGhQDQCRcWt+HoBI+Dccj3VLpVqJJf5GbhEDGdj4+284Z4Su9n9ms2B73HEPJNdf
         hiORm99BPGhH9qVdCeKQm1cIrN0dO30q/DXNJiqacLLgmCY2+cFxR6LHAR+H0rfaghWq
         EdhkmviPFG72waxZmMQ7ON6eManhKvNwBttKW9zif2vzPrX9hGa0G+gUPaimEUVt6jZn
         IKm6HCP23jHSCRDoUqf6WwovJzELuHIYDNzC+4cW6ch+SgpHRtbi4OAFK2tG3P+gX803
         eBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Qu2t5Kd9pgLrX06LIAt+b3Zb2/etIust7WpLoqpeB4=;
        b=hPd3IgNrSiqZaK81Gxb6mEywcp/jT7LUZ5xri9/fMAP+K3DbPwcdsnac+lCfT413aC
         dLRkvseLVPAgBIDfyyf3WTbwO5NHjlJQYnwVLBHGfRbetPG/IhZct90sVOqCC2DtvH+e
         lB20ARGZoiGha7Q4oklAYKWmaUNa6bhonLpzXWcg9SthPVOlhPulB8H4j7FGpn6bbmsH
         ZkQxfFLufMwyeyLiEv5qnrIbnDZau1oXfkqyzn1QMxYERH7pe0+yD3l1p3aNlAfkYKAF
         gId4P9vfugn9+7sDDJSakvUxYlWUMotEuevm21tF3K142BMTC2anMYiOoEPoWTbRt3jz
         KZxQ==
X-Gm-Message-State: AHQUAua1SShOVtFMard4o+7Nx4ZuFA3XFVPkqf2LOhklq2RyOIvpcDeg
        hdaQio4dpG5rfFv/BiEt6pNzDNDc
X-Google-Smtp-Source: AHgI3Ib6+IpIb6iWPXOP+ND0r+rOxPkRYt30YOrDjAMvpO2KclWCe/WX0wQv6DxvIOFfolyWkUmHyw==
X-Received: by 2002:a63:7403:: with SMTP id p3mr1737158pgc.343.1550594774669;
        Tue, 19 Feb 2019 08:46:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm23049732pga.71.2019.02.19.08.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:46:14 -0800 (PST)
Subject: Re: [PATCH 11/11] hwmon/coretemp: Support multi-die/package
To:     Len Brown <lenb@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <8ce75b95ef6105ebe5fb8c9e43b33f06516e3c16.1550545163.git.len.brown@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e9ca4e1-d9ff-8f0c-c3c3-80f8b19bb7ee@roeck-us.net>
Date:   Tue, 19 Feb 2019 08:46:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8ce75b95ef6105ebe5fb8c9e43b33f06516e3c16.1550545163.git.len.brown@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 7:40 PM, Len Brown wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> This patch introduces coretemp driver support
> for new dual-die/package systems.
> 
> On the new dual-die/package systems, the package temperature MSRs becomes
> die-scope. Thus instead of one hwmon device per physical package, now
> there should be one hwmon device for each die on these systems.
> 
> On the hardwares that do not have multi-die support,
> topology_unique_die_id() equals topology_physical_package_id(), thus the
> only difference is that physical package id is used as the coretemp
> platform device id, instead of logical package id on these systems.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/coretemp.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 5d34f7271e67..a0b6b2247c3a 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -435,7 +435,7 @@ static int chk_ucode_version(unsigned int cpu)
>   
>   static struct platform_device *coretemp_get_pdev(unsigned int cpu)
>   {
> -	int pkgid = topology_logical_package_id(cpu);
> +	int pkgid = topology_unique_die_id(cpu);
>   
>   	if (pkgid >= 0 && pkgid < max_packages)
>   		return pkg_devices[pkgid];
> @@ -579,7 +579,7 @@ static struct platform_driver coretemp_driver = {
>   
>   static struct platform_device *coretemp_device_add(unsigned int cpu)
>   {
> -	int err, pkgid = topology_logical_package_id(cpu);
> +	int err, pkgid = topology_unique_die_id(cpu);
>   	struct platform_device *pdev;
>   
>   	if (pkgid < 0)
> @@ -703,7 +703,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   	 * the rest.
>   	 */
>   	if (cpumask_empty(&pd->cpumask)) {
> -		pkg_devices[topology_logical_package_id(cpu)] = NULL;
> +		pkg_devices[topology_unique_die_id(cpu)] = NULL;
>   		platform_device_unregister(pdev);
>   		return 0;
>   	}
> @@ -732,6 +732,7 @@ static enum cpuhp_state coretemp_hp_online;
>   static int __init coretemp_init(void)
>   {
>   	int err;
> +	struct cpuinfo_x86 *c = &cpu_data(0);
>   
>   	/*
>   	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
> @@ -741,7 +742,7 @@ static int __init coretemp_init(void)
>   	if (!x86_match_cpu(coretemp_ids))
>   		return -ENODEV;
>   
> -	max_packages = topology_max_packages();
> +	max_packages = topology_max_packages() * c->x86_max_dies;
>   	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
>   			      GFP_KERNEL);
>   	if (!pkg_devices)
> 

