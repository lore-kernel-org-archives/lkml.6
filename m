Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14118C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BC720C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOBpaKVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BC720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbeISCbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:31:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39462 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:31:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id v77-v6so3151988lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jB6RL8+Z+NwqOFMrULgkVHbxD0RTu2PpTpuDGL+xMos=;
        b=lOBpaKVVHtop/ez5WihIP+6FO9zAlseVUt+PW6+3elEcFgdk3OcqeHG4Wct3g0XEJ9
         I/ex58pwJh1TtdA2YJFNHeSkgE2vVY4U5UcHpugpABFkY5tbPIwbdSE1rZbLA9EUG3Zy
         PkMQqOXOIgbIVLJWtrNxCz9CoVkqGndTaRgfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jB6RL8+Z+NwqOFMrULgkVHbxD0RTu2PpTpuDGL+xMos=;
        b=gSV1JqOLB11IOx2XIOVLIaF+LukLrrIgz2NF0C34j7I1oo41igswWH3XP/AzyPU+zm
         SFRrthUosi/GUWfUn0pFu1raMsM5jJLl+fs0Tayf2/GI66b1OiFgKcasZIyyHSg/cPeS
         MMmHiC3mm2jO2t5oz2Ah5jFXbAj6HIsH5g+X1PNRM3P/WAKp0ruUcL82ZDe5UeOQIHXr
         m2T6pGYqeKgWB7bbh6XJf40qEkpoO4UJbSUoz+YUNtmTuRDX8d9rUKQC+zmUwguz02C0
         AFMDuPN6A2nqKoqfhmd/uzZnAPOqArUneTF4blk7qMV27wZlF6Tcigu8R8YTOcZLW/Px
         fs/Q==
X-Gm-Message-State: APzg51DrH+LDsTANqkDpbotq2tdwSGeR+jX4sCRdNy7yvaAJqSmEFF16
        xhCOAbAIHo/3GpEcsskQhTGWZghMoNA=
X-Google-Smtp-Source: ANB0VdasDxMffnI0YZEb90HjvfbxKSVED9fnsKix+gQRMifjEVPue0gtcQaxREQE0zINjRyQr+zFLQ==
X-Received: by 2002:a19:1709:: with SMTP id n9-v6mr12020188lfi.74.1537304234759;
        Tue, 18 Sep 2018 13:57:14 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g16-v6sm665298lfb.5.2018.09.18.13.57.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 13:57:14 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id j19-v6so3037037ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:57:14 -0700 (PDT)
X-Received: by 2002:a2e:4584:: with SMTP id s126-v6mr19188203lja.60.1537304234133;
 Tue, 18 Sep 2018 13:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <1536918159-311-1-git-send-email-sayalil@codeaurora.org> <1536918159-311-3-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1536918159-311-3-git-send-email-sayalil@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 18 Sep 2018 13:56:36 -0700
X-Gmail-Original-Message-ID: <CAE=gft5Hfstqe38daPAGncjZjdnfL-+Fv7QGSvLtBWc7BFzwPg@mail.gmail.com>
Message-ID: <CAE=gft5Hfstqe38daPAGncjZjdnfL-+Fv7QGSvLtBWc7BFzwPg@mail.gmail.com>
Subject: Re: [PATCH V13 2/2] scsi: ufs: Add configfs support for UFS provisioning
To:     sayali <sayalil@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, adrian.hunter@intel.com,
        Joel Becker <jlbec@evilplan.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 2:43 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
>
> This patch adds configfs support to provision UFS device at
> runtime. This feature can be primarily useful in factory or
> assembly line as some devices may be required to be configured
> multiple times during initial system development phase.
> Configuration Descriptors can be written multiple times until
> bConfigDescrLock attribute is zero.
>
> Configuration descriptor buffer consists of Device and Unit
> descriptor configurable parameters which are parsed from vendor
> specific provisioning file and then passed via configfs node at
> runtime to provision ufs device.
> CONFIG_CONFIGFS_FS and CONFIG_UFS_PROVISION needs to be enabled
> for using this feature.
>
> Usage:
> 1) To read current configuration descriptor with index X
>    (where index X can be 0/1/2/3) :
>    cat /config/<device_name>/ufs_config_desc_X
>
> 2) To write configuration descriptor with index X :
>    echo <config_desc_buf> > /config/<device_name>/ufs_config_desc_X
>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
...
> diff --git a/drivers/scsi/ufs/ufs-configfs.c b/drivers/scsi/ufs/ufs-configfs.c
> new file mode 100644
> index 0000000..84ccb1a
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufs-configfs.c
> @@ -0,0 +1,237 @@
...
> +static ssize_t ufs_config_desc_0_show(struct config_item *item, char *buf)
> +{
> +       return ufs_config_desc_show(item, buf, 0);
> +}
> +
> +static ssize_t ufs_config_desc_0_store(struct config_item *item,
> +                                      const char *buf, size_t count)
> +{
> +       return ufshcd_desc_configfs_store(item, buf, count, 0);
> +}
> +
> +static ssize_t ufs_config_desc_1_show(struct config_item *item, char *buf)
> +{
> +       return ufs_config_desc_show(item, buf, 1);
> +}
> +
> +static ssize_t ufs_config_desc_1_store(struct config_item *item,
> +                                      const char *buf, size_t count)
> +{
> +       return ufshcd_desc_configfs_store(item, buf, count, 1);
> +}
> +
> +static ssize_t ufs_config_desc_2_show(struct config_item *item, char *buf)
> +{
> +       return ufs_config_desc_show(item, buf, 2);
> +}
> +
> +static ssize_t ufs_config_desc_2_store(struct config_item *item,
> +                                      const char *buf, size_t count)
> +{
> +       return ufshcd_desc_configfs_store(item, buf, count, 2);
> +}
> +
> +static ssize_t ufs_config_desc_3_show(struct config_item *item, char *buf)
> +{
> +       return ufs_config_desc_show(item, buf, 3);
> +}
> +
> +static ssize_t ufs_config_desc_3_store(struct config_item *item,
> +                                      const char *buf, size_t count)
> +{
> +       return ufshcd_desc_configfs_store(item, buf, count, 3);
> +}
> +

The copypasta above and below is not my favorite, but I suppose it's
either this or wrap it all up in a macro that you stamp down 4 times.
I'm not sure if that's really any cleaner, so I guess this is fine.

> +static struct configfs_attribute ufshcd_attr_provision_0 = {
> +       .ca_name        = "ufs_config_desc_0",
> +       .ca_mode        = 0644,
> +       .ca_owner       = THIS_MODULE,
> +       .show           = ufs_config_desc_0_show,
> +       .store          = ufs_config_desc_0_store,
> +};
> +
> +static struct configfs_attribute ufshcd_attr_provision_1 = {
> +       .ca_name        = "ufs_config_desc_1",
> +       .ca_mode        = 0644,
> +       .ca_owner       = THIS_MODULE,
> +       .show           = ufs_config_desc_1_show,
> +       .store          = ufs_config_desc_1_store,
> +};
> +
> +static struct configfs_attribute ufshcd_attr_provision_2 = {
> +       .ca_name        = "ufs_config_desc_2",
> +       .ca_mode        = 0644,
> +       .ca_owner       = THIS_MODULE,
> +       .show           = ufs_config_desc_2_show,
> +       .store          = ufs_config_desc_2_store,
> +};
> +
> +static struct configfs_attribute ufshcd_attr_provision_3 = {
> +       .ca_name        = "ufs_config_desc_3",
> +       .ca_mode        = 0644,
> +       .ca_owner       = THIS_MODULE,
> +       .show           = ufs_config_desc_3_show,
> +       .store          = ufs_config_desc_3_store,
> +};
> +
> +static struct configfs_attribute *ufshcd_attrs[] = {
> +       &ufshcd_attr_provision_0,
> +       &ufshcd_attr_provision_1,
> +       &ufshcd_attr_provision_2,
> +       &ufshcd_attr_provision_3,
> +       NULL,
> +};
> +
> +static struct config_item_type ufscfg_type = {
> +       .ct_attrs       = ufshcd_attrs,
> +       .ct_owner       = THIS_MODULE,
> +};
> +
> +void ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
> +{
> +       int ret;
> +       struct config_item *cg_item;
> +       struct configfs_subsystem *subsys;
> +
> +       cg_item = &hba->subsys.su_group.cg_item;
> +       sprintf(cg_item->ci_namebuf, "%s", name);

CONFIGFS_ITEM_NAME_LEN is only 20. Is there anything preventing the
device name passed in here from being longer than that? You'd have a
nasty overrun on your hands if not. Maybe snprintf here?

> +       cg_item->ci_type = &ufscfg_type;
> +
> +       subsys = &hba->subsys;
> +       config_group_init(&subsys->su_group);
> +       mutex_init(&subsys->su_mutex);
> +       ret = configfs_register_subsystem(subsys);
> +       if (ret)
> +               pr_err("Error %d while registering subsystem %s\n",
> +                      ret,
> +                      subsys->su_group.cg_item.ci_namebuf);
> +}
> +
> +void ufshcd_configfs_exit(struct ufs_hba *hba)
> +{
> +       configfs_unregister_subsystem(&hba->subsys);
> +}
