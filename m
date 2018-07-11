Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10923C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B84208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUI5Mwgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B84208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbeGKSXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbeGKSXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:23:33 -0400
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com [209.85.161.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CA820C0B;
        Wed, 11 Jul 2018 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531333081;
        bh=0h065azWcNgtIu2RVpr0IGJI1CNHSBCHNNyPRPSu2zI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NUI5MwgwEM5gkk2O9EHD/WQlqn5ir4l8fFQOV/Bsf47ARvqteTMnaiBEycCKAv+8n
         8BN4rn9XGpef4ZXAeHdW4w/kbX2Y2H9hIXj6BAwIZ2e04TaQ9s2t07XTJAlhCPj31x
         WLfNAAAvFirqtEMsCOtvFk+ljQ935mmRIAa6eZSI=
Received: by mail-yw0-f170.google.com with SMTP id r184-v6so4133111ywg.6;
        Wed, 11 Jul 2018 11:18:01 -0700 (PDT)
X-Gm-Message-State: APt69E1cLLqTIkgICMNTdAC2DHf/i4zoxyJwozavKFi+76ZtLkR9sxnr
        bQbomuVAOwZWXCCEimX8Y5q4qT1CbnXHkKJC9Do=
X-Google-Smtp-Source: AAOMgpfvzINNvCBYK2MUQgF+1INpY4en5Nps1z80wCNSRUQWkJyG7tvmBRNvlWE0TkHCLrQFIWGc7/lrZdkhN+hg0rA=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr14389840ywr.16.1531333080867;
 Wed, 11 Jul 2018 11:18:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:17:20
 -0700 (PDT)
In-Reply-To: <1531172389-7312-1-git-send-email-atull@kernel.org>
References: <1531172389-7312-1-git-send-email-atull@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 11 Jul 2018 13:17:20 -0500
X-Gmail-Original-Message-ID: <CANk1AXTGvMHEMPF6nfzxncgXhH6bazmPaAXovBOi8hBC4ZkCug@mail.gmail.com>
Message-ID: <CANk1AXTGvMHEMPF6nfzxncgXhH6bazmPaAXovBOi8hBC4ZkCug@mail.gmail.com>
Subject: Re: [PATCH] fpga: mgr: rework fpga_mgr_get API for multiple managers
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Alan Tull <atull@kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:39 PM, Alan Tull <atull@kernel.org> wrote:
> Change fpga_mgr_get() function to take manager as the parameter
> instead of dev.

Todo: if this approach seems good, I'm going to do the same thing in
fpga-bridge.c for fpga_bridge_get, taking the bridge struct as a
parameter instead of dev of the bridge.

Alan

>  Caller probably has a pointer to manager already
> anyway, so remove code that searched for manager based on dev.  The
> rationale for this change is that cards that have more than one FPGA
> may have more than one manager.
>
> Add new __fpga_mgr_create() API which adds an 'owner' parameter.  This
> API will save owner in struct fpga_manager.
>
> Existing fpga_mgr_create() API becomes a macro that calls
> __fpga_mgr_create(), setting owner to THIS_MODULE of caller.
>
> fpga_mgr_get() will do try_module_get(mgr->owner).  For drivers that
> have one manager, this has the same effect as the code it replaces
> that did try_module_get(dev->parent->driver->owner) since the parent
> is the low level FPGA manager driver.
>
> Fixes: 9dce0287a60d ("fpga: add method to get fpga manager from device")
> Reported-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/fpga-mgr.c       | 77 +++++++++++++++++++------------------------
>  include/linux/fpga/fpga-mgr.h | 15 +++++----
>  2 files changed, 43 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index c1564cf..8d0ac96 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -162,9 +162,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
>   *
>   * Step the low level fpga manager through the device-specific steps of getting
>   * an FPGA ready to be configured, writing the image to it, then doing whatever
> - * post-configuration steps necessary.  This code assumes the caller got the
> - * mgr pointer from of_fpga_mgr_get() or fpga_mgr_get() and checked that it is
> - * not an error code.
> + * post-configuration steps necessary.
>   *
>   * This is the preferred entry point for FPGA programming, it does not require
>   * any contiguous kernel memory.
> @@ -239,8 +237,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
>   *
>   * Step the low level fpga manager through the device-specific steps of getting
>   * an FPGA ready to be configured, writing the image to it, then doing whatever
> - * post-configuration steps necessary.  This code assumes the caller got the
> - * mgr pointer from of_fpga_mgr_get() and checked that it is not an error code.
> + * post-configuration steps necessary.
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> @@ -310,9 +307,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
>   *
>   * Request an FPGA image using the firmware class, then write out to the FPGA.
>   * Update the state before each step to provide info on what step failed if
> - * there is a failure.  This code assumes the caller got the mgr pointer
> - * from of_fpga_mgr_get() or fpga_mgr_get() and checked that it is not an error
> - * code.
> + * there is a failure.
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> @@ -347,8 +342,11 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
>   * @mgr:       fpga manager
>   * @info:      fpga image information.
>   *
> - * Load the FPGA from an image which is indicated in @info.  If successful, the
> - * FPGA ends up in operating mode.
> + * Load the FPGA from an image which is indicated in @info.  @mgr is a
> + * valid pointer to an FPGA manager whose refcount has been
> + * incremented by of_fpga_mgr_get() or fpga_mgr_get() and has been
> + * locked by fpga_mgr_lock().  If successful, the FPGA ends up in
> + * operating mode.
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> @@ -416,41 +414,28 @@ static struct attribute *fpga_mgr_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(fpga_mgr);
>
> -static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> +/* Assumes mgr->dev has refcount incremented already. */
> +static struct fpga_manager *__fpga_mgr_get(struct fpga_manager *mgr)
>  {
> -       struct fpga_manager *mgr;
> -
> -       mgr = to_fpga_manager(dev);
> -
> -       if (!try_module_get(dev->parent->driver->owner))
> -               goto err_dev;
> +       if (try_module_get(mgr->owner))
> +               return mgr;
>
> -       return mgr;
> +       put_device(&mgr->dev);
>
> -err_dev:
> -       put_device(dev);
>         return ERR_PTR(-ENODEV);
>  }
>
> -static int fpga_mgr_dev_match(struct device *dev, const void *data)
> -{
> -       return dev->parent == data;
> -}
> -
>  /**
> - * fpga_mgr_get - Given a device, get a reference to a fpga mgr.
> - * @dev:       parent device that fpga mgr was registered with
> + * fpga_mgr_get - Increment refcount for a fpga mgr.
> + * @mgr:       fpga manager
>   *
>   * Return: fpga manager struct or IS_ERR() condition containing error code.
>   */
> -struct fpga_manager *fpga_mgr_get(struct device *dev)
> +struct fpga_manager *fpga_mgr_get(struct fpga_manager *mgr)
>  {
> -       struct device *mgr_dev = class_find_device(fpga_mgr_class, NULL, dev,
> -                                                  fpga_mgr_dev_match);
> -       if (!mgr_dev)
> -               return ERR_PTR(-ENODEV);
> +       get_device(&mgr->dev);
>
> -       return __fpga_mgr_get(mgr_dev);
> +       return __fpga_mgr_get(mgr);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_get);
>
> @@ -468,6 +453,7 @@ static int fpga_mgr_of_node_match(struct device *dev, const void *data)
>   */
>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>  {
> +       struct fpga_manager *mgr;
>         struct device *dev;
>
>         dev = class_find_device(fpga_mgr_class, NULL, node,
> @@ -475,7 +461,9 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>         if (!dev)
>                 return ERR_PTR(-ENODEV);
>
> -       return __fpga_mgr_get(dev);
> +       mgr = to_fpga_manager(dev);
> +
> +       return __fpga_mgr_get(mgr);
>  }
>  EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>
> @@ -485,7 +473,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>   */
>  void fpga_mgr_put(struct fpga_manager *mgr)
>  {
> -       module_put(mgr->dev.parent->driver->owner);
> +       module_put(mgr->owner);
>         put_device(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
> @@ -494,9 +482,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_put);
>   * fpga_mgr_lock - Lock FPGA manager for exclusive use
>   * @mgr:       fpga manager
>   *
> - * Given a pointer to FPGA Manager (from fpga_mgr_get() or
> - * of_fpga_mgr_put()) attempt to get the mutex. The user should call
> - * fpga_mgr_lock() and verify that it returns 0 before attempting to
> + * Given a pointer to FPGA Manager, attempt to get the mutex. The user should
> + * call fpga_mgr_lock() and verify that it returns 0 before attempting to
>   * program the FPGA.  Likewise, the user should call fpga_mgr_unlock
>   * when done programming the FPGA.
>   *
> @@ -524,17 +511,20 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>  EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>
>  /**
> - * fpga_mgr_create - create and initialize a FPGA manager struct
> + * __fpga_mgr_create - create and initialize a FPGA manager struct
>   * @dev:       fpga manager device from pdev
> + * @owner:     owner of manager, i.e. THIS_MODULE of manager driver
>   * @name:      fpga manager name
>   * @mops:      pointer to structure of fpga manager ops
>   * @priv:      fpga manager private data
>   *
>   * Return: pointer to struct fpga_manager or NULL
>   */
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> -                                    const struct fpga_manager_ops *mops,
> -                                    void *priv)
> +struct fpga_manager *__fpga_mgr_create(struct device *dev,
> +                                      struct module *owner,
> +                                      const char *name,
> +                                      const struct fpga_manager_ops *mops,
> +                                      void *priv)
>  {
>         struct fpga_manager *mgr;
>         int id, ret;
> @@ -563,6 +553,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>
>         mutex_init(&mgr->ref_mutex);
>
> +       mgr->owner = owner;
>         mgr->name = name;
>         mgr->mops = mops;
>         mgr->priv = priv;
> @@ -587,7 +578,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>
>         return NULL;
>  }
> -EXPORT_SYMBOL_GPL(fpga_mgr_create);
> +EXPORT_SYMBOL_GPL(__fpga_mgr_create);
>
>  /**
>   * fpga_mgr_free - deallocate a FPGA manager
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index eec7c24..f948202 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -127,6 +127,7 @@ struct fpga_manager_ops {
>  /**
>   * struct fpga_manager - fpga manager structure
>   * @name: name of low level fpga manager
> + * @owner: module that owns this manager
>   * @dev: fpga manager device
>   * @ref_mutex: only allows one reference to fpga manager
>   * @state: state of fpga manager
> @@ -135,6 +136,7 @@ struct fpga_manager_ops {
>   */
>  struct fpga_manager {
>         const char *name;
> +       struct module *owner;
>         struct device dev;
>         struct mutex ref_mutex;
>         enum fpga_mgr_states state;
> @@ -154,14 +156,15 @@ int fpga_mgr_lock(struct fpga_manager *mgr);
>  void fpga_mgr_unlock(struct fpga_manager *mgr);
>
>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
> -
> -struct fpga_manager *fpga_mgr_get(struct device *dev);
> -
> +struct fpga_manager *fpga_mgr_get(struct fpga_manager *mgr);
>  void fpga_mgr_put(struct fpga_manager *mgr);
>
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> -                                    const struct fpga_manager_ops *mops,
> -                                    void *priv);
> +struct fpga_manager *__fpga_mgr_create(struct device *dev,
> +                                      struct module *owner, const char *name,
> +                                      const struct fpga_manager_ops *mops,
> +                                      void *priv);
> +#define fpga_mgr_create(dev, name, mops, priv) \
> +       __fpga_mgr_create((dev), THIS_MODULE, (name), (mops), (priv))
>  void fpga_mgr_free(struct fpga_manager *mgr);
>  int fpga_mgr_register(struct fpga_manager *mgr);
>  void fpga_mgr_unregister(struct fpga_manager *mgr);
> --
> 2.7.4
>
