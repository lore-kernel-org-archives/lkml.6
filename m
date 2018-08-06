Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAD521A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FlAaJ/7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAD521A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbeHFSuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42797 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbeHFSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id u202-v6so9527023lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Do+8CoceSHk1pQOfSqGWPIYMp+v3IIe+xvtyrDdHmWg=;
        b=FlAaJ/7ELcwajCc/VX6I3t97UmWA21XUTNXVAsCWRBqjKmDgTMYRW2mQpeqgyuCQiM
         mRUuoaM2jVoOGCUA+65dQ+WC7w87gPoxAAKC12C/ViEXGDeXcPz7bIWraxu4BgWArmUp
         nedH9UQOeWSN0jPB0xbmJQA83ZPHHFVLID2VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Do+8CoceSHk1pQOfSqGWPIYMp+v3IIe+xvtyrDdHmWg=;
        b=peZs4FnllgRp9DhRIo97uB2FuZEVntwwPdoTkFQ0Vnq4QCPsnbKfiUpRBnyS6ty6rJ
         DR9l6aSPMJ0Mg3qaiFDuAqbZIwbYJocp/NUrQa4gn7wvm++y3IZBC1YxpCAyihi50j2v
         Ab9e8Vc9EMTfMRvQ0eSA+8u0lWLsM8TYPoIfZ2NiqnWfhbNS4MU/4G3zJBlE7ty4rMEI
         Ggk8xdcmMRu70P0XnF7U8Yq9nevFxeCkuYoYBZuKSsLm/ZuoVNGyAACZLwd+9oPzDDdO
         KsEHDkrDxYhqNuudnCSETvIlCckxjiwNrRI4f2moTmYD3NX+DsX+7Io3ylCV0aasFNlg
         eDdA==
X-Gm-Message-State: AOUpUlFpsZ8gRz56cTXSNZW1qIzyAY7dOoEd8la3jJqYmih6YCjXrOeE
        S2f2phiAD7PbOXdG7Jq7IRfvlLyqCRw=
X-Google-Smtp-Source: AAOMgpd9tiBh8BDq/ZIDutgZ7lNgnxHKYfNmLi+U4WfPwq2vu9rKgcJ4GtaSyO24tsTEyxrqnBEPVw==
X-Received: by 2002:a19:14dc:: with SMTP id 89-v6mr11365000lfu.45.1533573658255;
        Mon, 06 Aug 2018 09:40:58 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p65-v6sm2366321lja.44.2018.08.06.09.40.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:40:57 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id l16-v6so9511753lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:40:55 -0700 (PDT)
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr331802lff.9.1533573655344;
 Mon, 06 Aug 2018 09:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <1533113338-31750-1-git-send-email-sayalil@codeaurora.org> <1533113338-31750-3-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1533113338-31750-3-git-send-email-sayalil@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 6 Aug 2018 09:40:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft46yHTxG5rpBLJ-x5AiETaGGdnsnEHjzSx2BsG4=sUKHA@mail.gmail.com>
Message-ID: <CAE=gft46yHTxG5rpBLJ-x5AiETaGGdnsnEHjzSx2BsG4=sUKHA@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] scsi: ufs: Add configfs support for UFS provisioning
To:     sayalil@codeaurora.org
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        adrian.hunter@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sayali,

On Wed, Aug 1, 2018 at 1:49 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
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
>  drivers/scsi/ufs/ufshcd.c                     |   7 +-
>  drivers/scsi/ufs/ufshcd.h                     |  10 ++
>  6 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
>  create mode 100644 drivers/scsi/ufs/ufs-configfs.c
>

You didn't address any of my feedback from V6. All of that still applies.
-Evan
