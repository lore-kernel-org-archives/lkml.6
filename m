Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754943AbeCRWrg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:47:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36360 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754926AbeCRWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:47:34 -0400
X-Google-Smtp-Source: AG47ELvfuLI0gxllItFWwQt/dz8fnPsm3z7GJxy9TCTLiUDK91g3s8GGCS8RdO6JCt9SXl6l/L/kNg==
Date: Sun, 18 Mar 2018 15:47:36 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Anup Patel <anup@brainfault.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] rpmsg: Add driver_override device attribute for
 rpmsg_device
Message-ID: <20180318224736.GK5626@tuxbook-pro>
References: <1515590259-24304-1-git-send-email-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515590259-24304-1-git-send-email-anup@brainfault.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Jan 05:17 PST 2018, Anup Patel wrote:

> This patch adds "driver_override" device attribute for rpmsg_device which
> will allow users to explicitly specify the rpmsg_driver to be used via
> sysfs entry.
> 
> The "driver_override" device attribute implemented here is very similar
> to "driver_override" implemented for platform, pci, and amba bus types.
> 
> One important use-case of "driver_override" device attribute is to force
> use of rpmsg_chrdev driver for certain rpmsg_device instances.
> 

I assume you mean specifically for the case where you want to prevent
some kernel driver to probe for some given channel?

The intention with rpmsg_char is that you through the rpmsg_ctrlX
interface create and destroy endpoints dynamically, so you wouldn't need
to use this mechanism to bind some specific channel to rpmsg_char.


That said, this does make sense for completeness sake.

[..]
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index dffa3aa..9a25e42 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -321,11 +321,11 @@ struct device *rpmsg_find_device(struct device *parent,
>  }
>  EXPORT_SYMBOL(rpmsg_find_device);
>  
> -/* sysfs show configuration fields */
> +/* sysfs configuration fields */
>  #define rpmsg_show_attr(field, path, format_string)			\
>  static ssize_t								\
>  field##_show(struct device *dev,					\
> -			struct device_attribute *attr, char *buf)	\
> +	     struct device_attribute *attr, char *buf)			\

Seems unnecessary.

>  {									\
>  	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
>  									\
> @@ -333,11 +333,52 @@ field##_show(struct device *dev,					\
>  }									\
>  static DEVICE_ATTR_RO(field);
>  
> +#define rpmsg_string_attr(field, path)					\

"path" is an odd name for these, I think it's a "member".

> +static ssize_t								\
> +field##_store(struct device *dev,					\
> +	      struct device_attribute *attr, const char *buf, size_t sz)\

field##_store(struct device *dev, struct device_attribute *attr, 	\
	      const char *buf, size_t sz)				\

Is prettier

> +{									\
> +	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
> +	char *new, *old, *cp;						\
> +									\
> +	new = kstrndup(buf, sz, GFP_KERNEL);				\
> +	if (!new)							\
> +		return -ENOMEM;						\
> +									\
> +	cp = strchr(new, '\n');						\
> +	if (cp)								\
> +		*cp = '\0';						\

I prefer

	new[strcspn(new, "\n")] = '\0';

Regards,
Bjorn
