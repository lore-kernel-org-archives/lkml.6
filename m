Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZrYB/nWLqFQRRkJPeS6IMJLemETLIFG5EfrOe9BWajG/sq8EYWh/WJZqO1Ey1epCF+2pSbC
ARC-Seal: i=1; a=rsa-sha256; t=1525961092; cv=none;
        d=google.com; s=arc-20160816;
        b=h+/SVPVAs6ndpMm3Y92q9R4rW38E0XrQaBX9Cv2sjgzGQYB+0FBJXwxiUtAm3vNW1L
         QVtpVTXpOlzLTbMvaPc2CW6t1aEyS2Al4tQ6TV5grNx1HknglJYM0cH++r8JJe8b8tBq
         meH9fmQMKvplOtpPQdy0JVHkwRqTSgvpzQrMY3TAZFHgSbituf3IhXwp8m5qtES3K8TR
         b7Krxlq4w7suS1tmGh3JuDL3gB8J6vIVrsl/3ybIL/exLu1SEAHwyMd3MlIW9sh7ZhRO
         yL73n2wNY9CZ5WRDzcFc+GV112cVw6OR8coRLL6sSF5axGHWcPOReeEPRAxBClXj9EB+
         bMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=xjPO6brRwcgGbVNBmYMFWRBVVVuKr2AwPTLuEWw01QU=;
        b=LBzV/ZSrU4dLvKA4kudVlagdslR7jefkwFgLFegLVE4KeFmDkssMM0qaV/y8SFzAOz
         DZ1nOJJ3nGOBRvv3AvklFAr0hFQ8pWoNvxPuj3RQDUzNwVCcA+igtj9j++Dj22ejE4uU
         hB+ZW9CD3U5YNbjZWt4NmGBTgZAd7RNEkDYzzV+YxX/GKfz9JKmdQX5v5rtFxcYtDnaF
         aFnkUnb8Ef8sTdIEnRhv0v+469nPMXPKywHQLVyeH+YoL8zb5qpdOwQnv37q6rRk6iyo
         ebAQk9Zh3vFlx3lx6+SxdC3NpehzTnTdGs9DAiBILAeyFN6M8H1VpYav6RjiWwSL6D03
         6cDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, rajanv@xilinx.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v6 02/11] firmware: xilinx: Add Zynqmp firmware driver
To: Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
 mingo@kernel.org, gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
 hkallweit1@gmail.com, keescook@chromium.org, dmitry.torokhov@gmail.com,
 mturquette@baylibre.com, sboyd@codeaurora.org, michal.simek@xilinx.com,
 robh+dt@kernel.org, mark.rutland@arm.com, linux-clk@vger.kernel.org
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-3-git-send-email-jollys@xilinx.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <9cbfb3cd-daa3-f145-c6f2-f15f61d1bea0@arm.com>
Date: Thu, 10 May 2018 15:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523389127-14243-3-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389331213451831?=
X-GMAIL-MSGID: =?utf-8?q?1600086178677400070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 10/04/18 20:38, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> This patch is adding communication layer with firmware.
> Firmware driver provides an interface to firmware APIs.
> Interface APIs can be used by any driver to communicate to
> PMUFW(Platform Management Unit). All requests go through ATF.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---

[...]

> +
> +/**
> + * get_set_conduit_method() - Choose SMC or HVC based communication
> + * @np:		Pointer to the device_node structure
> + *
> + * Use SMC or HVC-based functions to communicate with EL2/EL3.
> + *
> + * Return: Returns 0 on success or error code
> + */
> +static int get_set_conduit_method(struct device_node *np)
> +{
> +	const char *method;
> +
> +	if (of_property_read_string(np, "method", &method)) {
> +		pr_warn("%s missing \"method\" property\n", __func__);
> +		return -ENXIO;
> +	}
> +
> +	if (!strcmp("hvc", method)) {
> +		do_fw_call = do_fw_call_hvc;
> +	} else if (!strcmp("smc", method)) {
> +		do_fw_call = do_fw_call_smc;
> +	} else {
> +		pr_warn("%s Invalid \"method\" property: %s\n",
> +			__func__, method);
> +		return -EINVAL;
> +	}
> +

Mark R did some cleanup around SMCCC conduits[1]. It makes sense to base
this on top that. But if you manage to push this for v4.18, then you may
need to wait for that to be merged and clean it up after v4.18

-- 
Regards,
Sudeep

[1] https://www.spinics.net/lists/arm-kernel/msg650305.html
