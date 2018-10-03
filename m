Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF885C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703E120835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7ZMNbZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703E120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJDAwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:52:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43855 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJDAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:52:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id p34-v6so4812866lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UR9bsXhPxvnSq70kZXNy8mfWKI2Nb7hu20VDQ8TJu4=;
        b=A7ZMNbZlvwVf2gh5Crs81TtMLNh2C1Zu8l3ZWYBJqIM8Ts25tA+d7lhqAkLpUj2FHy
         pGsW07WdO4eugzIkH8bXTpheyPr5NvlU+85BsY7AN+hCVPy0rNEvD+73bcxTe0urrELG
         dcJKZ48Cxgkb0xYTbYlFbSj9/74/mOG66jsMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UR9bsXhPxvnSq70kZXNy8mfWKI2Nb7hu20VDQ8TJu4=;
        b=CzGBiCN9b+5rxir42ee7esdfs7PTo2cFB88NY/zvD4n4YIVp7UeOQf+qB09nPJ0QNO
         K7VZX6D06Zf1wP5/xCZlaYYgxNYEcyc+Cv1GaYNVOXKLHN+Pa+fW0KC5yboMoCzFGhcT
         1yT4Qy8C/dkWYMgoKZTaJlyzEdmpOuJNzP2nlNvleLnM9pduqUYDQBS2weMkbCtLYqCz
         LiV6U8DQDHUBNj8WwChczw19FEjLeirjr0CKehNZOUlBAhYWPkYnlUp8se6QLQTCADJI
         8D44UrujB2e2rRDved4cWCd4KC7ZFIVSr9ldpz6Rg4MA8uNq0oyo3vJxWXre0L68MnKt
         IkVA==
X-Gm-Message-State: ABuFfogDgQ7RyFmo1CvBTZp7SGJNJVwtA6NwZrRSU0iRX5QrBonCMjmh
        fRO7fwucSzZZVBUtmAVmAZqr5F8skN8=
X-Google-Smtp-Source: ACcGV61iWGalFl/LJotUPj6fRxrJZVjS27Wbc/RYmI/fQnEWTRsH9gqfjD5b7nPhyTzPVscE1hmuAA==
X-Received: by 2002:a19:d155:: with SMTP id i82-v6mr1650378lfg.127.1538589751547;
        Wed, 03 Oct 2018 11:02:31 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id k23-v6sm480173ljc.49.2018.10.03.11.02.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 11:02:30 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y71-v6so5960747lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:02:29 -0700 (PDT)
X-Received: by 2002:a2e:20da:: with SMTP id g87-v6mr1699291lji.88.1538589748767;
 Wed, 03 Oct 2018 11:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org> <1537770516-28410-3-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1537770516-28410-3-git-send-email-sayalil@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 3 Oct 2018 11:01:52 -0700
X-Gmail-Original-Message-ID: <CAE=gft6dLW5zzrOg470kS=O8rMgPr02Nb4NL9pEtpymc83ms+w@mail.gmail.com>
Message-ID: <CAE=gft6dLW5zzrOg470kS=O8rMgPr02Nb4NL9pEtpymc83ms+w@mail.gmail.com>
Subject: Re: [PATCH V14 2/2] scsi: ufs: Add configfs support for UFS provisioning
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

On Sun, Sep 23, 2018 at 11:29 PM Sayali Lokhande <sayalil@codeaurora.org> wrote:
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
> CONFIG_CONFIGFS_FS and CONFIG_SCSI_UFS_PROVISION needs to be enabled
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
>  Documentation/ABI/testing/configfs-driver-ufs |  12 ++
>  drivers/scsi/ufs/Kconfig                      |  10 ++
>  drivers/scsi/ufs/Makefile                     |   1 +
>  drivers/scsi/ufs/ufs-configfs.c               | 237 ++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.c                     |   3 +-
>  drivers/scsi/ufs/ufshcd.h                     |  18 ++
>  6 files changed, 280 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
>  create mode 100644 drivers/scsi/ufs/ufs-configfs.c
>
> diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
> new file mode 100644
> index 0000000..6743ea9
> --- /dev/null
> +++ b/Documentation/ABI/testing/configfs-driver-ufs
> @@ -0,0 +1,12 @@
> +What:          /config/*/ufs_config_desc_X
> +Date:          Jun 2018
> +KernelVersion: 4.20
> +Description:
> +               This file shows bytes of the current ufs configuration descriptor
> +               with index X (where X = 0/1/2/3) set in device. This can be used to
> +               provision ufs device if bConfigDescrLock is 0.
> +               For more details, refer 14.1.6.3 Configuration Descriptor and
> +               table 14-12 - Unit Descriptor configurable parameters from specs for
> +               description and format of each configuration descriptor parameter.
> +               Parameters of Configuration descriptor buffer for respective index
> +               needs to be passed as bytes in space separated format.
> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
> index e27b4d4..6e7ff35 100644
> --- a/drivers/scsi/ufs/Kconfig
> +++ b/drivers/scsi/ufs/Kconfig
> @@ -100,3 +100,13 @@ config SCSI_UFS_QCOM
>
>           Select this if you have UFS controller on QCOM chipset.
>           If unsure, say N.
> +
> +config SCSI_UFS_PROVISION
> +       bool "Runtime UFS Provisioning support"
> +       depends on SCSI_UFSHCD && CONFIGFS_FS
> +       help
> +         This enables runtime UFS provisioning support. This can be used
> +         primarily during assembly line as some devices may be required to
> +         be configured multiple times during initial development phase.
> +
> +         If unsure, say N.
> diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
> index 918f579..09880b9 100644
> --- a/drivers/scsi/ufs/Makefile
> +++ b/drivers/scsi/ufs/Makefile
> @@ -5,5 +5,6 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-d
>  obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
>  obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
>  ufshcd-core-objs := ufshcd.o ufs-sysfs.o
> +obj-$(CONFIG_SCSI_UFS_PROVISION) += ufs-configfs.o

Hi Sayali,
Can you try both of your patches with "make allmodconfig". There seem
to be a few issues compiling in that configuration. Also, as it stands
this file is either not compiled in, or baked into the kernel, where
it really should go into the driver. Check out the patch below for how
Guenter patched things up in our tree:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1255524
