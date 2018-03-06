Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELuzR6wRpgIdq4YSQncEi0lTQ+goO62bysFPedmUqg6nuPyEzbMzh/PWDLkTraFMcESx44Kc
ARC-Seal: i=1; a=rsa-sha256; t=1520358622; cv=none;
        d=google.com; s=arc-20160816;
        b=zF1eSCiSM4+6/KDPfLoGOxPOuRSn39b3e9Ua/TG3rK+yHqb1eRwG+L5phgpM7ampP5
         ew+vvZo3KZMO5oWTww36qJuCV52HGbsrggCNxCQr4oo2lifEHUrAkd2/s6QicpCqriPV
         MWsTL+nS538MXLfFpK8/L0i6MWiPWVEn7Ll8wfEH3bhMMb8VGpvvK51+/PYrLI0QUryL
         LgeNr2yyJUoGo8E/M4jkp8qPqfhlFAYQKoZUhbUMcUBgQ3wC0uG0KX6cNv+k2S/4vmvd
         xJhMfZVUuk10yegG2coYZY3I2QKkQ6bLKbk7Ta8ktWWW5SgXibtfRMBIBuIansKsRanp
         efAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=ICw1ef35f34kbhiiCXup1FXo7DgkaEH1YbIcxQHa++4=;
        b=Uo6sGr/BduvxwhGUP7B0SggIv9SE+LlkhU2QGW088+46kfeObkkhW80IhREUogcgUf
         0+6+euCWyirige5S3ZK0hG3GRh3s1x1NKSP0YRm9+SAi18EwPvflKnw971At1ajKUn9Q
         R9QKrFtgQydUBmJy6v3rJCicb4ejYeXJscCewmuDtexDPijPfILrocj2kJ29DrLeuJzP
         v+93t3heHRHIJ36Ja2tAiV9ABIKv1mXtvcR2DdzerEaa5VlTLTGnfMz/oa0PS9X/id8k
         W6IrlNeyq/frbC6Z2oIOgjdNrqhfLESAGgVFa/Gkk6EbUFsGpFIgZEYC3K6iNElY54do
         QtkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 07/13] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-8-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <eb07e64d-ec91-6952-717e-d8a62ec0e8b0@arm.com>
Date: Tue, 6 Mar 2018 17:50:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-8-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684152561134116?=
X-GMAIL-MSGID: =?utf-8?q?1594211563569778065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 28/02/18 22:06, Jeremy Linton wrote:
> Call ACPI cache parsing routines from base cacheinfo code if ACPI
> is enable. Also stub out cache_setup_acpi() so that individual
> architectures can enable ACPI topology parsing.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c       |  1 +
>  drivers/base/cacheinfo.c  | 14 ++++++++++----
>  include/linux/cacheinfo.h |  9 +++++++++
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 883e4318c6cd..c98f94ebd272 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -343,6 +343,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>  {
>  	int valid_flags = 0;
>  
> +	this_leaf->fw_token = cpu_node;


Any reason why this can't part of 05/13 ?

>  	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
>  		this_leaf->size = found_cache->size;
>  		valid_flags++;
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 597aacb233fc..2880e2ab01f5 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -206,7 +206,7 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>  					   struct cacheinfo *sib_leaf)
>  {
>  	/*
> -	 * For non-DT systems, assume unique level 1 cache, system-wide
> +	 * For non-DT/ACPI systems, assume unique level 1 caches, system-wide
>  	 * shared caches for all other levels. This will be used only if
>  	 * arch specific code has not populated shared_cpu_map
>  	 */
> @@ -214,6 +214,11 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>  }
>  #endif
>  
> +int __weak cache_setup_acpi(unsigned int cpu)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  static int cache_shared_cpu_map_setup(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> @@ -227,8 +232,8 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>  	if (of_have_populated_dt())
>  		ret = cache_setup_of_node(cpu);
>  	else if (!acpi_disabled)
> -		/* No cache property/hierarchy support yet in ACPI */
> -		ret = -ENOTSUPP;
> +		ret = cache_setup_acpi(cpu);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -279,7 +284,8 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
>  			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
>  			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
>  		}
> -		of_node_put(this_leaf->fw_token);
> +		if (of_have_populated_dt())
> +			of_node_put(this_leaf->fw_token);
>  	}
>  }
>  
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 0c6f658054d2..1446d3f053a2 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -97,6 +97,15 @@ int func(unsigned int cpu)					\
>  struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>  int init_cache_level(unsigned int cpu);
>  int populate_cache_leaves(unsigned int cpu);
> +int cache_setup_acpi(unsigned int cpu);
> +int acpi_find_last_cache_level(unsigned int cpu);
> +#ifndef CONFIG_ACPI
> +int acpi_find_last_cache_level(unsigned int cpu)

The above 3 lines looks weird, can't it be:

#ifdef CONFIG_ACPI
int acpi_find_last_cache_level(unsigned int cpu);
#else
int acpi_find_last_cache_level(unsigned int cpu)
{
	/* ACPI kernels should be built with PPTT support */
	return 0;
}

Also I think it should be CONFIG_ACPI_PPTT, otherwise it might cause
issue on platforms which define CONFIG_ACPI but CONFIG_ACPI_PPTT is not.
I can only relate this to the s390 error reported by kbuild robot.

-- 
Regards,
Sudeep
