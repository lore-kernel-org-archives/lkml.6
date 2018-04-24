Return-Path: <nsekhar@ti.com>
X-Google-Smtp-Source: AIpwx48T2PMi30z/IuOBIbFp+ZxgO2404vrMSGiQ22URack3UOGWPzFmQOuyc7KaYuoP/F2Z4N/i
ARC-Seal: i=1; a=rsa-sha256; t=1524557489; cv=none;
        d=google.com; s=arc-20160816;
        b=D0nasAB2Pytui9I94WWPlAyEWB+/m9Euf3LwRFUEiCChLrFxllKB0Xk5pAqxObMK/U
         kDTZra8n3lReIYfSIH9tOzYjJqmrPDYuOn46A4Qx8bAHMMCV6QBdjMIwAEeyouSI/2FB
         mca5qAKXYqf81Sm5MOzVwt9577WMIDliLSn9652Hx+TARGXwz+ai6bEFtreth3G/bhQv
         AI4nmwQmpMTtjRDg4v8CLDfMn1AuM+slKmDZxor/o40xkzjhYUY7kZCaLIQmkmUFVCJv
         d2dSmKK5+3XlsYOLA/VgUIgrKhg2eijHlMBoydUYRWHPVJr9YjOAtkIDp/gSyySViNnA
         C5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ql0EktlZ189vON4SZXrPDL+/FOHcBQ07ERnkYL/5uLM=;
        b=QHQM8sgUztu7yJCgxMzW5lh0SmqlThzFvUJnWVSvHojUMriCaRFX/440xnEq+wDs1R
         8R92ZjWtNDZQyyNGfSBuOVfKNYAGet3Xdfil5RqD7p5u9E1JdEP1zH3A7eUtE5DBiHMq
         kAndtcLBQveg0esJRW6o9t+spNNBQTsYBsF3ZZkUl6KJLeQJF7uAuKooBY5Ae8WYSq2M
         /IKeP8j5qxcTJnkTs/eFmGDhyQqN4lvRw0fbkfykrZvqWQCiqRFBxQ3G7BTM8Jin+5yS
         JV6P4TD2gwKGCiAyrySardNTtNi5og/1n0brdVXn4PauJwNQkJfGobYLuA+2VY7gPfO2
         JLPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=mxVPRVG0;
       spf=pass (google.com: domain of nsekhar@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=nsekhar@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=mxVPRVG0;
       spf=pass (google.com: domain of nsekhar@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=nsekhar@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [RFC work-in-progress 5/7] !WIP ARM: davinci: convert da850 to
 using the davinci clocksource driver
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>
CC: Kevin Hilman <khilman@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd --cc=Arnd Bergmann
	<"sboyd@kernel.orgarnd"@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski
	<bgolaszewski@baylibre.com>
References: <20180423183814.20615-1-brgl@bgdev.pl>
 <20180423183814.20615-6-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <bed00d18-a4c1-5e8f-a15c-f2482e5ecb9a@ti.com>
Date: Tue, 24 Apr 2018 13:40:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423183814.20615-6-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598563244496982650?=
X-GMAIL-MSGID: =?utf-8?q?1598614393378588343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday 24 April 2018 12:08 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da850.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 3f27d46ca43f..712964383bc2 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -757,13 +757,28 @@ void __init da850_init(void)
>  	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
>  }
>  
> +static struct platform_device da850_timer_device = {
> +	.name			= "timer-davinci",
> +	.id			= -1,
> +};
> +
>  void __init da850_init_time(void)
>  {
>  	struct clk *clk;
> +	int ret;
>  
>  	clk = clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
>  
>  	davinci_timer_init(clk);
> +
> +	ret = clk_register_clkdev(clk, NULL, "timer-davinci");
> +	if (ret) {
> +		pr_err("%s: error registering ref_clk: %d", __func__, ret);
> +		return;
> +	}

This part had to be added because you don't have clocks converted to
early platform devices in your branch, right?

Thanks,
Sekhar
