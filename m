Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494FAC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEC0208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrOL//g5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEC0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933098AbeGCPRZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932367AbeGCPRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:17:23 -0400
Received: from mail-yb0-f170.google.com (mail-yb0-f170.google.com [209.85.213.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABBB208E4;
        Tue,  3 Jul 2018 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530631042;
        bh=q43+H+6Tp7Cg/tAL147MshJchyenRc8RCsFpfVUxLzk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=OrOL//g5nHbV5u/k3xiOlC1noJnOvuQxxmXofmGbObbyPWgmLbkKPhDX6XeS2W1KR
         88c8XLnC+WwBJWFGdQzXAL4EX5Nr0BX15VDFdwZTgcJnNYPZkK6TMBACKiUYACm8OQ
         90Wc25K8mHW0OHAN/p6GBXk4w3I0cyXJFYOF5EDg=
Received: by mail-yb0-f170.google.com with SMTP id a2-v6so859893ybe.11;
        Tue, 03 Jul 2018 08:17:22 -0700 (PDT)
X-Gm-Message-State: APt69E22plMUMPPJDs+aNNeSGaeqZHy+QzSW/Zi6mb5TTR/EquCYOkM3
        NwrjCRhnmp+VhPeTALhGqFPwzTtEx3ZG+7pWHaw=
X-Google-Smtp-Source: ADUXVKI+BZ4A71TAXugXoBJfEjtpT+nMjnqrW9H5r93XhH/mzwWgSKSUfT52aUxpCGeccW02k9G3uUZTC4OwcIYruU8=
X-Received: by 2002:a25:1f0b:: with SMTP id f11-v6mr16103961ybf.100.1530631041930;
 Tue, 03 Jul 2018 08:17:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 08:16:41 -0700 (PDT)
In-Reply-To: <1530607463-6287-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1530607463-6287-1-git-send-email-appana.durga.rao@xilinx.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 3 Jul 2018 10:16:41 -0500
X-Gmail-Original-Message-ID: <CANk1AXRhRDmsqUxVi4p+vE-X+OL0ayQ=4zpM-4PxZBqJXjPsRw@mail.gmail.com>
Message-ID: <CANk1AXRhRDmsqUxVi4p+vE-X+OL0ayQ=4zpM-4PxZBqJXjPsRw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] fpga: fpga-mgr: Add readback support
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, navam@xilinx.com,
        linux-fpga@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 3:44 AM, Appana Durga Kedareswara rao
<appana.durga.rao@xilinx.com> wrote:

Hi Appana,

> Inorder to debug issues with fpga's users would
> like to read the fpga configuration information.
> This patch adds readback support for fpga configuration data
> in the framework through debugfs interface.
>
> Usage:
>         cat /sys/kernel/debug/fpga/readback

Two things here: I'd prefer calling the attribute "image" rather than "readback"

This should be an entry per fpga manager, not one entry for the whole
framework, so

cat /sys/kernel/debug/fpga/fpga0/image

>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
>  drivers/fpga/fpga-mgr.c       | 52 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fpga/fpga-mgr.h |  6 +++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 9939d2c..7a9fd7c 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -484,6 +484,39 @@ void fpga_mgr_put(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>
> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +
> +static int fpga_mgr_read(struct seq_file *s, void *data)
> +{
> +       struct fpga_manager *mgr = (struct fpga_manager *)s->private;
> +       int ret = 0;

Here you should return an error for mgr's that don't support read function:

if (!mgr->mops->read)
    return -ENOENT;

Then you probably should lock the mgr so that nobody tries to write it
while you are reading.  If you can't lock it, return -EBUSY.

> +
> +       if (mgr->state != FPGA_MGR_STATE_OPERATING)
> +               return -EBUSY;

If the FPGA isn't programmed, I'm not sure that EBUSY would be the
correct error.

> +
> +       /* Read the FPGA configuration data from the fabric */
> +       ret = mgr->mops->read(mgr, s);
> +       if (ret) {
> +               dev_err(&mgr->dev, "Error while reading configuration data from FPGA\n");
> +               return ret;

Don't need this return here since we return right afterwards anyway.

> +       }
> +
> +       return ret;
> +}
> +
> +static int fpga_mgr_read_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, fpga_mgr_read, inode->i_private);
> +}
> +
> +static const struct file_operations fpga_mgr_debugops = {

Suggest including the name of the debugfs file in the name since more
debugfs files will be added over time, so

s/fpga_mgr_debugops/fpga_mgr_ops_image/ or something.

> +       .owner = THIS_MODULE,
> +       .open = fpga_mgr_read_open,
> +       .read = seq_read,
> +};
> +#endif
> +
>  /**
>   * fpga_mgr_lock - Lock FPGA manager for exclusive use
>   * @mgr:       fpga manager
> @@ -581,6 +614,21 @@ int fpga_mgr_register(struct device *dev, const char *name,
>         if (ret)
>                 goto error_device;
>
> +#ifdef CONFIG_DEBUG_FS

I'd prefer an added config such as CONFIG_FPGA_MGR_DEBUG_FS.

> +       mgr->dir = debugfs_create_dir("fpga", NULL);
> +       if (!mgr->dir)
> +               goto error_device;
> +
> +       mgr->parent = mgr->dir;
> +       mgr->dir = debugfs_create_file("readback", 0644, mgr->parent, mgr,
> +                                      &fpga_mgr_debugops);
> +       if (!mgr->dir) {
> +               debugfs_remove_recursive(mgr->parent);
> +               mgr->parent = NULL;
> +               goto error_device;
> +       }
> +#endif
> +
>         dev_info(&mgr->dev, "%s registered\n", mgr->name);
>
>         return 0;
> @@ -604,6 +652,10 @@ void fpga_mgr_unregister(struct device *dev)
>
>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>
> +#ifdef CONFIG_DEBUG_FS
> +       debugfs_remove_recursive(mgr->parent);
> +       mgr->parent = NULL;
> +#endif
>         /*
>          * If the low level driver provides a method for putting fpga into
>          * a desired state upon unregister, do it.
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 3c6de23..6013809 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -114,6 +114,7 @@ struct fpga_image_info {
>   * @write: write count bytes of configuration data to the FPGA
>   * @write_sg: write the scatter list of configuration data to the FPGA
>   * @write_complete: set FPGA to operating state after writing is done
> + * @read: read FPGA configuration information

Please add note that the read ops is optional similar to below.

>   * @fpga_remove: optional: Set FPGA into a specific state during driver remove
>   * @groups: optional attribute groups.
>   *
> @@ -131,6 +132,7 @@ struct fpga_manager_ops {
>         int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>         int (*write_complete)(struct fpga_manager *mgr,
>                               struct fpga_image_info *info);
> +       int (*read)(struct fpga_manager *mgr, struct seq_file *s);
>         void (*fpga_remove)(struct fpga_manager *mgr);
>         const struct attribute_group **groups;
>  };
> @@ -151,6 +153,10 @@ struct fpga_manager {
>         enum fpga_mgr_states state;
>         const struct fpga_manager_ops *mops;
>         void *priv;
> +#ifdef CONFIG_DEBUG_FS
> +       struct dentry *dir;
> +       struct dentry *parent;
> +#endif
>  };
>
>  #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Alan
