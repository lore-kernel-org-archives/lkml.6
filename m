Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40279C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE1A2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE1A2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbeLBIP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:15:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33063 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbeLBIP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:15:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0D670207B0; Sun,  2 Dec 2018 09:15:54 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id B00B7206D8;
        Sun,  2 Dec 2018 09:15:43 +0100 (CET)
Date:   Sun, 2 Dec 2018 09:15:43 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robert.jarzmik@free.fr, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, keescook@chromium.org,
        shreeya.patel23498@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: remove DEBUGFS_RO_ATTR()
Message-ID: <20181202091543.73c74aea@bbrezillon>
In-Reply-To: <20181202073202.10587-1-tiny.windzz@gmail.com>
References: <20181202073202.10587-1-tiny.windzz@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like getting rid of DEBUGFS_RO_ATTR() is just one of the change
you do. I think you should change the subject line:

"mtd: use DEFINE_SHOW_ATTRIBUTE() instead of open-coding it"

This way it covers all of your changes.

On Sun,  2 Dec 2018 02:32:02 -0500
Yangtao Li <tiny.windzz@gmail.com> wrote:

> We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define

					    ^ missing space

> such a macro,so remove DEBUGFS_RO_ATTR.Also use DEFINE_SHOW_ATTRIBUTE

	       ^ here as well

> to simplify some code.

If you go for the new subject line, you'll have to change this commit
message.

> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> changes in v3:
> -remove the blank line between the function
>  definition and DEFINE_SHOW_ATTRIBUTE()
> ---
>  drivers/mtd/devices/docg3.c    | 16 ++++++++--------
>  drivers/mtd/devices/docg3.h    | 11 -----------
>  drivers/mtd/mtdswap.c          | 13 +------------
>  drivers/mtd/nand/raw/nandsim.c | 17 +++--------------
>  4 files changed, 12 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> index 512bd4c2eec0..4c94fc096696 100644
> --- a/drivers/mtd/devices/docg3.c
> +++ b/drivers/mtd/devices/docg3.c
> @@ -1603,7 +1603,7 @@ static void doc_unregister_sysfs(struct platform_device *pdev,
>  /*
>   * Debug sysfs entries
>   */
> -static int dbg_flashctrl_show(struct seq_file *s, void *p)
> +static int flashcontrol_show(struct seq_file *s, void *p)
>  {
>  	struct docg3 *docg3 = (struct docg3 *)s->private;
>  
> @@ -1623,9 +1623,9 @@ static int dbg_flashctrl_show(struct seq_file *s, void *p)
>  
>  	return 0;
>  }
> -DEBUGFS_RO_ATTR(flashcontrol, dbg_flashctrl_show);
> +DEFINE_SHOW_ATTRIBUTE(flashcontrol);
>  
> -static int dbg_asicmode_show(struct seq_file *s, void *p)
> +static int asic_mode_show(struct seq_file *s, void *p)
>  {
>  	struct docg3 *docg3 = (struct docg3 *)s->private;
>  
> @@ -1660,9 +1660,9 @@ static int dbg_asicmode_show(struct seq_file *s, void *p)
>  	seq_puts(s, ")\n");
>  	return 0;
>  }
> -DEBUGFS_RO_ATTR(asic_mode, dbg_asicmode_show);
> +DEFINE_SHOW_ATTRIBUTE(asic_mode);
>  
> -static int dbg_device_id_show(struct seq_file *s, void *p)
> +static int device_id_show(struct seq_file *s, void *p)
>  {
>  	struct docg3 *docg3 = (struct docg3 *)s->private;
>  	int id;
> @@ -1674,9 +1674,9 @@ static int dbg_device_id_show(struct seq_file *s, void *p)
>  	seq_printf(s, "DeviceId = %d\n", id);
>  	return 0;
>  }
> -DEBUGFS_RO_ATTR(device_id, dbg_device_id_show);
> +DEFINE_SHOW_ATTRIBUTE(device_id);
>  
> -static int dbg_protection_show(struct seq_file *s, void *p)
> +static int protection_show(struct seq_file *s, void *p)
>  {
>  	struct docg3 *docg3 = (struct docg3 *)s->private;
>  	int protect, dps0, dps0_low, dps0_high, dps1, dps1_low, dps1_high;
> @@ -1726,7 +1726,7 @@ static int dbg_protection_show(struct seq_file *s, void *p)
>  		   !!(dps1 & DOC_DPS_KEY_OK));
>  	return 0;
>  }
> -DEBUGFS_RO_ATTR(protection, dbg_protection_show);
> +DEFINE_SHOW_ATTRIBUTE(protection);
>  
>  static void __init doc_dbg_register(struct mtd_info *floor)
>  {
> diff --git a/drivers/mtd/devices/docg3.h b/drivers/mtd/devices/docg3.h
> index e99946575398..e16dca23655b 100644
> --- a/drivers/mtd/devices/docg3.h
> +++ b/drivers/mtd/devices/docg3.h
> @@ -317,17 +317,6 @@ struct docg3 {
>  #define doc_info(fmt, arg...) dev_info(docg3->dev, (fmt), ## arg)
>  #define doc_dbg(fmt, arg...) dev_dbg(docg3->dev, (fmt), ## arg)
>  #define doc_vdbg(fmt, arg...) dev_vdbg(docg3->dev, (fmt), ## arg)
> -
> -#define DEBUGFS_RO_ATTR(name, show_fct) \
> -	static int name##_open(struct inode *inode, struct file *file) \
> -	{ return single_open(file, show_fct, inode->i_private); }      \
> -	static const struct file_operations name##_fops = { \
> -		.owner = THIS_MODULE, \
> -		.open = name##_open, \
> -		.llseek = seq_lseek, \
> -		.read = seq_read, \
> -		.release = single_release \
> -	};
>  #endif
>  
>  /*
> diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
> index d9dcb2d051b4..d162d1717fad 100644
> --- a/drivers/mtd/mtdswap.c
> +++ b/drivers/mtd/mtdswap.c
> @@ -1265,18 +1265,7 @@ static int mtdswap_show(struct seq_file *s, void *data)
>  
>  	return 0;
>  }
> -
> -static int mtdswap_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, mtdswap_show, inode->i_private);
> -}
> -
> -static const struct file_operations mtdswap_fops = {
> -	.open		= mtdswap_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(mtdswap);
>  
>  static int mtdswap_add_debugfs(struct mtdswap_dev *d)
>  {
> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> index c452819f6123..ef8721418f2d 100644
> --- a/drivers/mtd/nand/raw/nandsim.c
> +++ b/drivers/mtd/nand/raw/nandsim.c
> @@ -443,7 +443,7 @@ static unsigned long total_wear = 0;
>  /* MTD structure for NAND controller */
>  static struct mtd_info *nsmtd;
>  
> -static int nandsim_debugfs_show(struct seq_file *m, void *private)
> +static int nandsim_show(struct seq_file *m, void *private)
>  {
>  	unsigned long wmin = -1, wmax = 0, avg;
>  	unsigned long deciles[10], decile_max[10], tot = 0;
> @@ -494,18 +494,7 @@ static int nandsim_debugfs_show(struct seq_file *m, void *private)
>  
>  	return 0;
>  }
> -
> -static int nandsim_debugfs_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, nandsim_debugfs_show, inode->i_private);
> -}
> -
> -static const struct file_operations dfs_fops = {
> -	.open		= nandsim_debugfs_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(nandsim);
>  
>  /**
>   * nandsim_debugfs_create - initialize debugfs
> @@ -531,7 +520,7 @@ static int nandsim_debugfs_create(struct nandsim *dev)
>  	}
>  
>  	dent = debugfs_create_file("nandsim_wear_report", S_IRUSR,
> -				   root, dev, &dfs_fops);
> +				   root, dev, &nandsim_fops);
>  	if (IS_ERR_OR_NULL(dent)) {
>  		NS_ERR("cannot create \"nandsim_wear_report\" debugfs entry\n");
>  		return -1;

