Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66028ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBF420875
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0GG2XIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBF420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJGC3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 22:29:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43857 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeJGC3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 22:29:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id 80-v6so6121108pgh.10;
        Sat, 06 Oct 2018 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V5wk/2oj1+l5wuy56UtoH7Jr+yK4git70zmHSWkozw8=;
        b=V0GG2XIzmiWa82JWPa5/pbieIeQG1BEV19HJOD7gpQWbm20xJWHhtMaJfsrhD3+ZqY
         oNydXhDCcYvf4wH7Z8jp/0sz7ozpWFnZ6JWnNaTqcKeXghojt0CfiGnIlspXD/1bj6pJ
         zoISBF5cqVoek8GWe0pp7BrnCCJm+BnNn2cdSp4j3zPvOy1Pq/8oTO2Lqi8muRdxBH77
         Rv+ZUT/ILlw73BwB0+uKYuM4qK9xM4q0EUbauMj6n0ncZ5whjLPTmFuGtJ9am6bYX4Bc
         C+F0Hpir7QIdi166qfa5jZHx0/k5Owu2y5ohbaAQt0u/tZH04bfR8pX7yPzm1pBuK3r6
         RqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V5wk/2oj1+l5wuy56UtoH7Jr+yK4git70zmHSWkozw8=;
        b=CwM8xUa4HMhVA5MryzqH3dBeqRdrdw3uGa1LvC79oupr2+9mE3s8KR5bleOE8hziGM
         KGWIHpa0uRHrOc806nVv36r9G0yPsm59s+MI2hf9AxBhZY5TTykWUDaA3Fqp3O6DDw+O
         mURKpACaXTCOkqhV5+S/3B7zNduQc8sKk8G3QofUg/rLM1nOAclcdKm50B7sxyx3EUDn
         aWxUplACv76BsCXwNnfPAkl/lTZrgB+Bkh5BzpgzyLoqchL8uvxj+e8SVKy8A4x3z5Z6
         gIoH2p87fnH4NNDgKaKGX4LAJTMNIdpWIONAsgha1zEavz48V70nv4rB1T8ngDEEaib1
         6Kyg==
X-Gm-Message-State: ABuFfohrVk84DPlVYoIyjwCVvPdVnaNvI8R9R0NJwAKwsD7Zjy/mztNa
        tV/uUdrgeKf/e6LKcqkZ6jU=
X-Google-Smtp-Source: ACcGV62E53W579XTxJ/lDi6BsO8tSNrf9iI8eDoQDO0nbgRMpjdKMfCgQ9mui2ixs5zWH2tl2rEA6g==
X-Received: by 2002:a63:6a86:: with SMTP id f128-v6mr15303279pgc.165.1538853891999;
        Sat, 06 Oct 2018 12:24:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q127-v6sm6966298pgq.19.2018.10.06.12.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 12:24:50 -0700 (PDT)
Date:   Sat, 6 Oct 2018 12:24:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (core) Add hwmon_in_enable attribute
Message-ID: <20181006192449.GA30010@roeck-us.net>
References: <20181005235905.29403-1-nicoleotsuka@gmail.com>
 <20181005235905.29403-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005235905.29403-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 04:59:04PM -0700, Nicolin Chen wrote:
> According to hwmon ABI, in%d_enable is a sysfs interface that
> allows user space to enable and disable the input sensor. So
> this patch just simply adds the attribute to the list.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 1 +
>  include/linux/hwmon.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 33d51281272b..ac1cdf88840f 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -356,6 +356,7 @@ static const char * const hwmon_in_attr_templates[] = {
>  	[hwmon_in_max_alarm] = "in%d_max_alarm",
>  	[hwmon_in_lcrit_alarm] = "in%d_lcrit_alarm",
>  	[hwmon_in_crit_alarm] = "in%d_crit_alarm",
> +	[hwmon_in_enable] = "in%d_enable",
>  };
>  
>  static const char * const hwmon_curr_attr_templates[] = {
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 9493d4a388db..99e0c1b0b5fb 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -118,6 +118,7 @@ enum hwmon_in_attributes {
>  	hwmon_in_max_alarm,
>  	hwmon_in_lcrit_alarm,
>  	hwmon_in_crit_alarm,
> +	hwmon_in_enable,
>  };
>  
>  #define HWMON_I_INPUT		BIT(hwmon_in_input)
> @@ -135,6 +136,7 @@ enum hwmon_in_attributes {
>  #define HWMON_I_MAX_ALARM	BIT(hwmon_in_max_alarm)
>  #define HWMON_I_LCRIT_ALARM	BIT(hwmon_in_lcrit_alarm)
>  #define HWMON_I_CRIT_ALARM	BIT(hwmon_in_crit_alarm)
> +#define HWMON_I_ENABLE		BIT(hwmon_in_enable)
>  
>  enum hwmon_curr_attributes {
>  	hwmon_curr_input,
