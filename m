Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeEGW2o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:28:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37033 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeEGW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:28:43 -0400
X-Google-Smtp-Source: AB8JxZqyiQAiTQOX9Ksuh4foJal6zgtMh7bQNbh7ZBO4Y7rb+k86LC1bTDS9G+Xuzru7Ij8G0/hHaA==
Date: Mon, 7 May 2018 16:28:39 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 21/27] coresight: Convert driver messages to dev_dbg
Message-ID: <20180507222839.GB22194@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-22-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:51AM +0100, Suzuki K Poulose wrote:
> Convert component enable/disable messages from dev_info to dev_dbg.
> This is required to prevent LOCKDEP splats when operating in perf
> mode where we could be called with locks held to enable a coresight
> path. If someone wants to really see the messages, they can always
> enable it at runtime via dynamic_debug.

I'm also in favor of moving to dev_dbg() - the messages they produce are useless
unless serious debugging of the CS framework is happening.  But as Robin Murphy
pointed out it would be great to fix the problem for real rather than masking
it.

I understand this kind of work would be outside the scope of this set.  As such
I'd take this patch but the log message would need to be modified to avoid
talking about LOCKDEP splats, only to make sure nobody thinks the problem has
been fixed.

That being said I work extensively with the CS framework every day (with option
CONFIG_LOCKED_SUPPORT=y) and haven't seen any splats.  Perhaps you have a
recipe to reproduce the problem?

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 4 ++--
>  drivers/hwtracing/coresight/coresight-etb10.c              | 6 +++---
>  drivers/hwtracing/coresight/coresight-etm3x.c              | 4 ++--
>  drivers/hwtracing/coresight/coresight-etm4x.c              | 4 ++--
>  drivers/hwtracing/coresight/coresight-funnel.c             | 4 ++--
>  drivers/hwtracing/coresight/coresight-replicator.c         | 4 ++--
>  drivers/hwtracing/coresight/coresight-stm.c                | 4 ++--
>  drivers/hwtracing/coresight/coresight-tmc-etf.c            | 8 ++++----
>  drivers/hwtracing/coresight/coresight-tmc-etr.c            | 4 ++--
>  drivers/hwtracing/coresight/coresight-tmc.c                | 4 ++--
>  drivers/hwtracing/coresight/coresight-tpiu.c               | 4 ++--
>  11 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> index 043da86..c41d95c 100644
> --- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> @@ -64,7 +64,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>  
>  	CS_LOCK(drvdata->base);
>  
> -	dev_info(drvdata->dev, "REPLICATOR enabled\n");
> +	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
>  	return 0;
>  }
>  
> @@ -83,7 +83,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>  
>  	CS_LOCK(drvdata->base);
>  
> -	dev_info(drvdata->dev, "REPLICATOR disabled\n");
> +	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
>  }
>  
>  static const struct coresight_ops_link replicator_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 74232e6..d9c2f87 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -163,7 +163,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  out:
> -	dev_info(drvdata->dev, "ETB enabled\n");
> +	dev_dbg(drvdata->dev, "ETB enabled\n");
>  	return 0;
>  }
>  
> @@ -269,7 +269,7 @@ static void etb_disable(struct coresight_device *csdev)
>  
>  	local_set(&drvdata->mode, CS_MODE_DISABLED);
>  
> -	dev_info(drvdata->dev, "ETB disabled\n");
> +	dev_dbg(drvdata->dev, "ETB disabled\n");
>  }
>  
>  static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
> @@ -512,7 +512,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
>  	}
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_info(drvdata->dev, "ETB dumped\n");
> +	dev_dbg(drvdata->dev, "ETB dumped\n");
>  }
>  
>  static int etb_open(struct inode *inode, struct file *file)
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 39f42fd..9d4a663 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -510,7 +510,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>  	drvdata->sticky_enable = true;
>  	spin_unlock(&drvdata->spinlock);
>  
> -	dev_info(drvdata->dev, "ETM tracing enabled\n");
> +	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
>  	return 0;
>  
>  err:
> @@ -613,7 +613,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
>  	spin_unlock(&drvdata->spinlock);
>  	cpus_read_unlock();
>  
> -	dev_info(drvdata->dev, "ETM tracing disabled\n");
> +	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
>  }
>  
>  static void etm_disable(struct coresight_device *csdev,
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index e84d80b..c9c73c2 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -274,7 +274,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>  	drvdata->sticky_enable = true;
>  	spin_unlock(&drvdata->spinlock);
>  
> -	dev_info(drvdata->dev, "ETM tracing enabled\n");
> +	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
>  	return 0;
>  
>  err:
> @@ -387,7 +387,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>  	spin_unlock(&drvdata->spinlock);
>  	cpus_read_unlock();
>  
> -	dev_info(drvdata->dev, "ETM tracing disabled\n");
> +	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
>  }
>  
>  static void etm4_disable(struct coresight_device *csdev,
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 9f8ac0be..18b5361 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -72,7 +72,7 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
>  
>  	funnel_enable_hw(drvdata, inport);
>  
> -	dev_info(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
> +	dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
>  	return 0;
>  }
>  
> @@ -96,7 +96,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
>  
>  	funnel_disable_hw(drvdata, inport);
>  
> -	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
> +	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
>  }
>  
>  static const struct coresight_ops_link funnel_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 3756e71..4f77812 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -42,7 +42,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>  {
>  	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> -	dev_info(drvdata->dev, "REPLICATOR enabled\n");
> +	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
>  	return 0;
>  }
>  
> @@ -51,7 +51,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>  {
>  	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> -	dev_info(drvdata->dev, "REPLICATOR disabled\n");
> +	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
>  }
>  
>  static const struct coresight_ops_link replicator_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 15e7ef38..4c88d99 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -218,7 +218,7 @@ static int stm_enable(struct coresight_device *csdev,
>  	stm_enable_hw(drvdata);
>  	spin_unlock(&drvdata->spinlock);
>  
> -	dev_info(drvdata->dev, "STM tracing enabled\n");
> +	dev_dbg(drvdata->dev, "STM tracing enabled\n");
>  	return 0;
>  }
>  
> @@ -281,7 +281,7 @@ static void stm_disable(struct coresight_device *csdev,
>  		pm_runtime_put(drvdata->dev);
>  
>  		local_set(&drvdata->mode, CS_MODE_DISABLED);
> -		dev_info(drvdata->dev, "STM tracing disabled\n");
> +		dev_dbg(drvdata->dev, "STM tracing disabled\n");
>  	}
>  }
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 1dd44fd..0a32734 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -244,7 +244,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>  	if (ret)
>  		return ret;
>  
> -	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
> +	dev_dbg(drvdata->dev, "TMC-ETB/ETF enabled\n");
>  	return 0;
>  }
>  
> @@ -267,7 +267,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
>  
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_info(drvdata->dev, "TMC-ETB/ETF disabled\n");
> +	dev_dbg(drvdata->dev, "TMC-ETB/ETF disabled\n");
>  }
>  
>  static int tmc_enable_etf_link(struct coresight_device *csdev,
> @@ -286,7 +286,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
>  	drvdata->mode = CS_MODE_SYSFS;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_info(drvdata->dev, "TMC-ETF enabled\n");
> +	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
>  	return 0;
>  }
>  
> @@ -306,7 +306,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
>  	drvdata->mode = CS_MODE_DISABLED;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_info(drvdata->dev, "TMC-ETF disabled\n");
> +	dev_dbg(drvdata->dev, "TMC-ETF disabled\n");
>  }
>  
>  static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 41dde0a..1ef0f62 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1350,7 +1350,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  		tmc_etr_free_sysfs_buf(free_buf);
>  
>  	if (!ret)
> -		dev_info(drvdata->dev, "TMC-ETR enabled\n");
> +		dev_dbg(drvdata->dev, "TMC-ETR enabled\n");
>  
>  	return ret;
>  }
> @@ -1393,7 +1393,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
>  
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_info(drvdata->dev, "TMC-ETR disabled\n");
> +	dev_dbg(drvdata->dev, "TMC-ETR disabled\n");
>  }
>  
>  static const struct coresight_ops_sink tmc_etr_sink_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 4d41b4b..7adcde3 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -92,7 +92,7 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>  	}
>  
>  	if (!ret)
> -		dev_info(drvdata->dev, "TMC read start\n");
> +		dev_dbg(drvdata->dev, "TMC read start\n");
>  
>  	return ret;
>  }
> @@ -114,7 +114,7 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
>  	}
>  
>  	if (!ret)
> -		dev_info(drvdata->dev, "TMC read end\n");
> +		dev_dbg(drvdata->dev, "TMC read end\n");
>  
>  	return ret;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 805f7c2..c7f0827 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -80,7 +80,7 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode)
>  
>  	tpiu_enable_hw(drvdata);
>  
> -	dev_info(drvdata->dev, "TPIU enabled\n");
> +	dev_dbg(drvdata->dev, "TPIU enabled\n");
>  	return 0;
>  }
>  
> @@ -106,7 +106,7 @@ static void tpiu_disable(struct coresight_device *csdev)
>  
>  	tpiu_disable_hw(drvdata);
>  
> -	dev_info(drvdata->dev, "TPIU disabled\n");
> +	dev_dbg(drvdata->dev, "TPIU disabled\n");
>  }
>  
>  static const struct coresight_ops_sink tpiu_sink_ops = {
> -- 
> 2.7.4
> 
