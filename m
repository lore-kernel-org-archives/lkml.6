Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971617AbeEYAb0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:31:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966894AbeEYAbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:31:23 -0400
Date: Thu, 24 May 2018 17:31:12 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v2 6/7] platform/mellanox: Introduce support for Mellanox
 register access driver
Message-ID: <20180525003112.GC10172@fury>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
 <1525675735-125547-4-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525675735-125547-4-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 06:48:54AM +0000, Vadim Pasternak wrote:
> Introduce new Mellanox platform driver to allow access to Mellanox
> programmable device register space trough sysfs interface.
> The driver purpose is to provide sysfs interface for user space for the
> registers essential for system control and monitoring.
> The sets of registers for sysfs access are supposed to be defined per
> system type bases and include the registers related to system resets
> operation, system reset causes monitoring and some kinds of mux selection.
> 
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> ---

One question on the attr init which I'm not familiar with... Andy, Greg - can
you offer your opinion below...

> +static int mlxreg_io_attr_init(struct mlxreg_io_priv_data *priv)
> +{
> +	int i;
> +
> +	priv->group.attrs = devm_kzalloc(&priv->pdev->dev,
> +					 priv->pdata->counter *
> +					 sizeof(struct attribute *),
> +					 GFP_KERNEL);
> +	if (!priv->group.attrs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->pdata->counter; i++) {
> +		priv->mlxreg_io_attr[i] =
> +				&priv->mlxreg_io_dev_attr[i].dev_attr.attr;
> +
> +		/* Set attribute name as a label. */
> +		priv->mlxreg_io_attr[i]->name =
> +				devm_kasprintf(&priv->pdev->dev, GFP_KERNEL,
> +					       priv->pdata->data[i].label);
> +
> +		if (!priv->mlxreg_io_attr[i]->name) {
> +			dev_err(&priv->pdev->dev, "Memory allocation failed for sysfs attribute %d.\n",
> +				i + 1);
> +			return -ENOMEM;
> +		}
> +
> +		priv->mlxreg_io_dev_attr[i].dev_attr.attr.mode =
> +						priv->pdata->data[i].mode;
> +		switch (priv->pdata->data[i].mode) {

This seemed a bit odd to me. Do we need to do this conditional assignment within
the kernel, or can these just be assigned, and the mode will guard against the
user being able to call store on a read only attr?

> +		case 0200:
> +			priv->mlxreg_io_dev_attr[i].dev_attr.store =
> +							mlxreg_io_attr_store;
> +			break;
> +
> +		case 0444:
> +			priv->mlxreg_io_dev_attr[i].dev_attr.show =
> +							mlxreg_io_attr_show;
> +			break;
> +
> +		case 0644:
> +			priv->mlxreg_io_dev_attr[i].dev_attr.show =
> +							mlxreg_io_attr_show;
> +			priv->mlxreg_io_dev_attr[i].dev_attr.store =
> +							mlxreg_io_attr_store;
> +			break;

If this is necessary, we can simplify this by checking for the read mask and the
write mask and setting each once - rather than duplicating this for r, w, and
rw. As it is a 0400 would not assign the show function, even though it is
readable by somebody.

-- 
Darren Hart
VMware Open Source Technology Center
