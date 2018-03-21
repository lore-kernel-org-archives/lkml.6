Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AG47ELsa5ssNojC/kU/vCtNhklRDtlAYF0Fa4jRZ36jqrM/STdcPHPmXPyuXs44zVmZAFiAYNq+L
ARC-Seal: i=1; a=rsa-sha256; t=1521673104; cv=none;
        d=google.com; s=arc-20160816;
        b=ekFAaoXeYHgu71ira8UdadK2jr5Fa5UZFAJnQN7eYATmZoTpyzeoXiXrlHZpM0qdbg
         Yy+oaQLsB4ocZh+ALokJ2h4LRFuJjCONWU92P+nBsljioIi6tJ8OtFB7HxFIG1tq/EvU
         CU9KU/X/+2ai4QsNn/yZGfostC8SujvisSmuWK8884rpeNW5LdJ/CBQRxF/ttTlFGFTM
         I+R/pggPOxuaQMonjYTJDmuwDgLeZrLm7z2wpu3R+Cqv9Z/eAP4FjcM+x6tcSFIFUL4V
         GWkaf+m2nkYj1TgMJOB+Ni4ikqOJ+eXRtHizYcwERj/93UjT3S3QZZ8VH5tXlZMnSgJv
         ZKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=FeLRcVMAan8pglpGi855vGUbTijTwBXu6QVdyj92CdM=;
        b=A9+oGhyG5QO7PjoufEP1LfDItQ1zKXVlukcDtM7UM7iKWCbebfVIEwFPeUYTwYZSx1
         +q18fnlWz3SrJ3rlbtYRypu8b2Pb/cKp3KB4q56GBlkVwYlyiA3DZXyfYkO2nMnXltUz
         VIFUYsDiAkVGpqIY13PNP1u1tBdygUAErDbAs+Rij+RED6vWYdXyoBPF0z4+1ta4gh2t
         ZtDMVa7xe6BORr9s+DsC0Z6k/t7yiVZk2zmrbPNeGICHBN7n8Xl1thcR22VnZ69NLbZ5
         g6GBlveTpgN0w1EUSk+QEeYs4vvolSTssJk+Ro7v5FkaLMXTa9puGi/gjVVXz0VVwPE8
         B13Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=KAaKy30Z;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=KAaKy30Z;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Wed, 21 Mar 2018 15:58:18 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com,
	Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1 2/4] platform/x86: mlx-platform: Add differed bus
 functionality
Message-ID: <20180321225818.GA23931@fury>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
 <1518559776-188942-3-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518559776-188942-3-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318017732489878?=
X-GMAIL-MSGID: =?utf-8?q?1595589896661111222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 10:09:34PM +0000, Vadim Pasternak wrote:
> Add deferred bus functionality in order to enforce probing flow execution
> order. Driver mlx-platform activates platform driver i2c-mux-reg, which
> creates busses infrastructure, after that it activates mlxreg-hotplug
> driver, which uses these busses, for connecting devices. The possible
> miss-ordering can happened, for example in case the probing routine of
> mlxreg-hotplug is already started execution, while i2c-mux-reg probing
> routine is not completed yet. In such situation the first one could
> attempt to connect device to adapter number, which is not created yet.
> And as a result this connection will fail. In order to ensure the order of
> probing execution on mlxreg-hotplug probe routine will be deferred until
> all the busses is not created by  probe routine of i2c-mux-reg.
> In order to ensure the flow order, mlx-platform driver passes the highest
> bus number to the mlxreg-hotplug platform data, which in their turn could
> wait in the deferred state, until all the necessary buses topology is not
> exist.

Vadim,

I've got part way through a review of this series several times, and keep
running out of time trying to determine if the solution is appropriate
for the problem.

The deferred probing waiting for the i2c bus to be available seems like
something we might be able to handle more elegantly with:

1) request_module() in the platform driver
2) careful use of init levels (subsys, device, late)

This isn't something I'm well versed in - so I'll reach out here for
some advice from Greg and the i2c maintainer, Wolfram, and list (added
to Cc).

Thanks,


> 
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> ---
>  drivers/platform/mellanox/mlxreg-hotplug.c |  7 +++++++
>  drivers/platform/x86/mlx-platform.c        | 10 ++++++++++
>  include/linux/platform_data/mlxreg.h       |  2 ++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
> index 313cf8a..fe4910b 100644
> --- a/drivers/platform/mellanox/mlxreg-hotplug.c
> +++ b/drivers/platform/mellanox/mlxreg-hotplug.c
> @@ -550,6 +550,7 @@ static int mlxreg_hotplug_probe(struct platform_device *pdev)
>  {
>  	struct mlxreg_core_hotplug_platform_data *pdata;
>  	struct mlxreg_hotplug_priv_data *priv;
> +	struct i2c_adapter *deferred_adap;
>  	int err;
>  
>  	pdata = dev_get_platdata(&pdev->dev);
> @@ -558,6 +559,12 @@ static int mlxreg_hotplug_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	/* Defer probing if the necessary adapter is not configured yet. */
> +	deferred_adap = i2c_get_adapter(pdata->deferred_nr);
> +	if (!deferred_adap)
> +		return -EPROBE_DEFER;
> +	i2c_put_adapter(deferred_adap);
> +
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
> index 71b452a..67f3c6d 100644
> --- a/drivers/platform/x86/mlx-platform.c
> +++ b/drivers/platform/x86/mlx-platform.c
> @@ -697,6 +697,8 @@ static int __init mlxplat_dmi_default_matched(const struct dmi_system_id *dmi)
>  				ARRAY_SIZE(mlxplat_default_channels[i]);
>  	}
>  	mlxplat_hotplug = &mlxplat_mlxcpld_default_data;
> +	mlxplat_hotplug->deferred_nr =
> +		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
>  
>  	return 1;
>  };
> @@ -711,6 +713,8 @@ static int __init mlxplat_dmi_msn21xx_matched(const struct dmi_system_id *dmi)
>  				ARRAY_SIZE(mlxplat_msn21xx_channels);
>  	}
>  	mlxplat_hotplug = &mlxplat_mlxcpld_msn21xx_data;
> +	mlxplat_hotplug->deferred_nr =
> +		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
>  
>  	return 1;
>  };
> @@ -725,6 +729,8 @@ static int __init mlxplat_dmi_msn274x_matched(const struct dmi_system_id *dmi)
>  				ARRAY_SIZE(mlxplat_msn21xx_channels);
>  	}
>  	mlxplat_hotplug = &mlxplat_mlxcpld_msn274x_data;
> +	mlxplat_hotplug->deferred_nr =
> +		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
>  
>  	return 1;
>  };
> @@ -739,6 +745,8 @@ static int __init mlxplat_dmi_msn201x_matched(const struct dmi_system_id *dmi)
>  				ARRAY_SIZE(mlxplat_msn21xx_channels);
>  	}
>  	mlxplat_hotplug = &mlxplat_mlxcpld_msn201x_data;
> +	mlxplat_hotplug->deferred_nr =
> +		mlxplat_default_channels[i - 1][MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
>  
>  	return 1;
>  };
> @@ -753,6 +761,8 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
>  				ARRAY_SIZE(mlxplat_msn21xx_channels);
>  	}
>  	mlxplat_hotplug = &mlxplat_mlxcpld_default_ng_data;
> +	mlxplat_hotplug->deferred_nr =
> +		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
>  
>  	return 1;
>  };
> diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
> index fcdc707..2629109 100644
> --- a/include/linux/platform_data/mlxreg.h
> +++ b/include/linux/platform_data/mlxreg.h
> @@ -129,6 +129,7 @@ struct mlxreg_core_platform_data {
>   * @mask: top aggregation interrupt common mask;
>   * @cell_low: location of low aggregation interrupt register;
>   * @mask_low: low aggregation interrupt common mask;
> + * @deferred_nr: I2C adapter number must be exist prior probing execution;
>   */
>  struct mlxreg_core_hotplug_platform_data {
>  	struct mlxreg_core_item *items;
> @@ -139,6 +140,7 @@ struct mlxreg_core_hotplug_platform_data {
>  	u32 mask;
>  	u32 cell_low;
>  	u32 mask_low;
> +	int deferred_nr;
>  };
>  
>  #endif /* __LINUX_PLATFORM_DATA_MLXREG_H */
> -- 
> 2.1.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
