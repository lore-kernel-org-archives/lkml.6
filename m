Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CCBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54B02077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdmYb7vH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54B02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeGQVfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:35:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42342 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbeGQVfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:35:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so1848375lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5JYk6tRqjYfJuLRQ/U6rFKZ//PDaSgY9kHWyM3JcX8=;
        b=WdmYb7vHZKo49Dn7jhHuyP6VkkG7PetQa6INUMEM+Cx9dM1QkVHMqKY1tJbpdD88ST
         iY0Xqma+2N9opU82QoCMIxdn+7qGmufvO3Yr9f2M7ZE/HH9T2eUU63jipZTr+eKEqMFo
         JmFdGHa8UPkbY87SxELAV0mnOXEB5pOHMecOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5JYk6tRqjYfJuLRQ/U6rFKZ//PDaSgY9kHWyM3JcX8=;
        b=MtzE6hCoQYkSqpv9nGjgeeye2L3LaguYOEHOBFeYAVzp8LkspdrzS8xMPpdkuVtnYo
         p1uBe8fIog+JBi2mnTJskCtarv6KssiWR3ff8k/b/Wg8o/8yDd6HhDymWxX56mMsbdV4
         C/0MEwrfx/jtghVmC9bsBaVIa/ysEumj90wgju4Vd/P66Wrb55dyxkGXWzW7luc07ndJ
         +MACNoPSRLGeH7vPYNj2UW+z5UroMPURTzKhbYzcz0E5+f0xUq1e/4E+2arbDpGbOj5I
         jZFHRXrkIP9XdMbbQ1ZJU+qKnaXGJVUJw93ZkrSB8MNUZMD6t55egrKWN1uDG8aNPbCt
         FYRQ==
X-Gm-Message-State: AOUpUlFLcNgkm698X05qR7/9EQurXzvdDoAgRayWT0DYJVrFXmYAcw3F
        p6n6ly9SqdhHEZw8c4BDRIsDlPuGzx4=
X-Google-Smtp-Source: AAOMgpcB+/zAbG4gksjA6MZJYAKA+O0vbXquSe5FkQdtcy1rO6zAVIKDDsL8cj/2XJU4y9QcDZgsug==
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr2143589lfh.19.1531861247671;
        Tue, 17 Jul 2018 14:00:47 -0700 (PDT)
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com. [209.85.215.47])
        by smtp.gmail.com with ESMTPSA id p11-v6sm312792ljc.50.2018.07.17.14.00.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:00:46 -0700 (PDT)
Received: by mail-lf0-f47.google.com with SMTP id f18-v6so1855464lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:00:46 -0700 (PDT)
X-Received: by 2002:a19:d754:: with SMTP id o81-v6mr2109744lfg.124.1531861245562;
 Tue, 17 Jul 2018 14:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <1531734237-27421-1-git-send-email-sayalil@codeaurora.org> <1531734237-27421-2-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1531734237-27421-2-git-send-email-sayalil@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 17 Jul 2018 14:00:09 -0700
X-Gmail-Original-Message-ID: <CAE=gft4pJWtRyY5gzOMDz58zaSS-kfy13Ek9qOVmzOdm-csP0A@mail.gmail.com>
Message-ID: <CAE=gft4pJWtRyY5gzOMDz58zaSS-kfy13Ek9qOVmzOdm-csP0A@mail.gmail.com>
Subject: Re: [PATCH V6] scsi: ufs: Add configfs support for UFS provisioning
To:     sayalil@codeaurora.org
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jlbec@evilplan.org, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sayali,
On Mon, Jul 16, 2018 at 2:44 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
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
> CONFIG_CONFIGFS_FS needs to be enabled for using this feature.
>
> Usage:
> 1) To read current configuration descriptor :
>    cat /config/XXXX.ufshc/ufs_provision
> 2) To provision ufs device:
>    echo <config_desc_buf> > /config/XXXX.ufshc/ufs_provision
>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  Documentation/ABI/testing/configfs-driver-ufs |  18 +++
>  drivers/scsi/ufs/Kconfig                      |  10 ++
>  drivers/scsi/ufs/Makefile                     |   1 +
>  drivers/scsi/ufs/ufs-configfs.c               | 162 ++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.c                     |   2 +
>  drivers/scsi/ufs/ufshcd.h                     |  19 +++
>  6 files changed, 212 insertions(+)
>  create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
>  create mode 100644 drivers/scsi/ufs/ufs-configfs.c
>
...
> diff --git a/drivers/scsi/ufs/ufs-configfs.c b/drivers/scsi/ufs/ufs-configfs.c
> new file mode 100644
> index 0000000..3e9837a
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufs-configfs.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2018, Linux Foundation.
> +
> +#include <linux/configfs.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +
> +#include "ufs.h"
> +#include "ufshcd.h"
> +
> +static inline struct ufs_hba *config_item_to_hba(struct config_item *item)
> +{
> +       struct config_group *group = to_config_group(item);
> +       struct configfs_subsystem *subsys = to_configfs_subsystem(group);
> +       struct ufs_hba *hba = container_of(subsys, struct ufs_hba, subsys);
> +
> +       return hba ? hba : NULL;

Can this ever return NULL? to_config_group() and
to_configfs_subsystem() guard against null, but container_of does not,
which would make hba a small negative value. The conditional would
needs to be subsys ? hba : NULL.

> +}
> +
> +static ssize_t ufs_provision_show(struct config_item *item, char *buf)
> +{
> +       u8 desc_buf[QUERY_DESC_CONFIGURATION_DEF_SIZE] = {0};
> +       int buff_len = QUERY_DESC_CONFIGURATION_DEF_SIZE;
> +       int i, ret, curr_len = 0;
> +       struct ufs_hba *hba = config_item_to_hba(item);
> +
> +       if (!hba)
> +               return snprintf(buf, PAGE_SIZE, "ufs hba is NULL!\n");

Maybe just fail, rather than successfully returning something unexpected.

> +
> +       ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
> +               QUERY_DESC_IDN_CONFIGURATION, 0, 0, desc_buf, &buff_len);
> +
> +       if (ret)
> +               return snprintf(buf, PAGE_SIZE,
> +               "Failed reading descriptor. desc_idn %d, opcode %x ret %d\n",
> +               QUERY_DESC_IDN_CONFIGURATION,
> +               UPIU_QUERY_OPCODE_READ_DESC, ret);

Same here, failing is probably better than returning unexpected text.

> +
> +       for (i = 0; i < buff_len; i++)
> +               curr_len += snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> +                               "0x%x ", desc_buf[i]);
> +
> +       return curr_len;
> +}
> +
> +ssize_t ufshcd_desc_configfs_store(struct ufs_hba *hba,
> +               const char *buf, size_t count)
> +{
> +       char *strbuf;
> +       char *strbuf_copy;
> +       u8 desc_buf[QUERY_DESC_CONFIGURATION_DEF_SIZE] = {0};
> +       int buff_len = QUERY_DESC_CONFIGURATION_DEF_SIZE;
> +       char *token;
> +       int i, ret, value;
> +       u32 bConfigDescrLock = 0;
> +
> +       /* reserve one byte for null termination */
> +       strbuf = kmalloc(count + 1, GFP_KERNEL);
> +       if (!strbuf)
> +               return -ENOMEM;
> +
> +       strbuf_copy = strbuf;
> +       strlcpy(strbuf, buf, count + 1);
> +
> +       if (!hba)
> +               goto out;
> +
> +       /* Just return if bConfigDescrLock is already set */
> +       ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +               QUERY_ATTR_IDN_CONF_DESC_LOCK, 0, 0, &bConfigDescrLock);
> +       if (ret)
> +               goto out;
> +
> +       if (bConfigDescrLock) {
> +               dev_err(hba->dev, "%s: bConfigDescrLock already set to %u, cannot re-provision device!\n",
> +               __func__, bConfigDescrLock);
> +               goto out;
> +       }
> +
> +       for (i = 0; i < QUERY_DESC_CONFIGURATION_DEF_SIZE; i++) {
> +               token = strsep(&strbuf, " ");
> +               if (!token && i)
> +                       break;
> +
> +               ret = kstrtoint(token, 0, &value);
> +               if (ret) {
> +                       dev_err(hba->dev, "%s: kstrtoint failed %d %s\n",
> +                               __func__, ret, token);
> +                       break;
> +               }
> +               desc_buf[i] = (u8)value;
> +       }
> +
> +       /* Write configuration descriptor to provision ufs */
> +       ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_WRITE_DESC,
> +               QUERY_DESC_IDN_CONFIGURATION, 0, 0, desc_buf, &buff_len);
> +
> +       if (!ret)
> +               dev_err(hba->dev, "%s: UFS Provisioning done, reboot now!\n",
> +               __func__);
> +
> +out:
> +       kfree(strbuf_copy);
> +       return count;
> +}
> +
> +static ssize_t ufs_provision_store(struct config_item *item,
> +               const char *buf, size_t count)
> +{
> +       struct ufs_hba *hba = config_item_to_hba(item);
> +
> +       return ufshcd_desc_configfs_store(hba, buf, count);
> +}
> +
> +static struct configfs_attribute ufshcd_attr_provision = {
> +       .ca_name        = "ufs_provision",
> +       .ca_mode        = 0644,
> +       .ca_owner       = THIS_MODULE,
> +       .show           = ufs_provision_show,
> +       .store          = ufs_provision_store,
> +};
> +
> +static struct configfs_attribute *ufshcd_attrs[] = {
> +       &ufshcd_attr_provision,
> +       NULL,
> +};
> +
> +static struct config_item_type ufscfg_type = {
> +       .ct_attrs       = ufshcd_attrs,
> +       .ct_owner       = THIS_MODULE,
> +};
> +
> +static struct configfs_subsystem ufscfg_subsys = {
> +       .su_group = {
> +               .cg_item = {
> +                       .ci_type = &ufscfg_type,
> +               },
> +       },
> +};
> +
> +int ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
> +{
> +       int ret;
> +       struct configfs_subsystem *subsys = &hba->subsys;
> +
> +       strncpy(ufscfg_subsys.su_group.cg_item.ci_namebuf, name, strlen(name));
> +       subsys->su_group = ufscfg_subsys.su_group;
> +       config_group_init(&subsys->su_group);
> +       mutex_init(&subsys->su_mutex);
> +       ret = configfs_register_subsystem(subsys);

Are the configfs folks okay with adding a new top level directory for
each host controller in the system? It might be better to have a
single top level directory of ufs, and then each controller as a
subdirectory underneath that. I'll defer to whatever the maintainers
think here.

> +       if (ret)
> +               pr_err("Error %d while registering subsystem %s\n",
> +                      ret,
> +                      subsys->su_group.cg_item.ci_namebuf);
> +
> +       return ret;
> +}
> +
> +void ufshcd_configfs_exit(void)
> +{
> +       configfs_unregister_subsystem(&ufscfg_subsys);
> +}

-Evan
