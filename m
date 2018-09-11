Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13938206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RNOifkup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13938206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeILAeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:34:02 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39867 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeILAeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:34:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id m62-v6so9680134ywd.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=syNwMSHRGJ6VqGWZ3VZd14w7801JFjU1YHYZQIEq/yk=;
        b=RNOifkupAAPnG+1bw7bC5lqLXlW4BrDOR9rgI6aip24Jp3Js4QA7xn2N9QWtJv5sF7
         b7SC74ogLUjqknuJFfH+1w7BZGh146JvVQCiTrWKSr0nAvpnnuEzaHS0DBmmYjhcGKFG
         DzrM6i+Aock58y+mVKUDjzulVeaJc4NBrbYI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=syNwMSHRGJ6VqGWZ3VZd14w7801JFjU1YHYZQIEq/yk=;
        b=JrhnqSw7jn+Jn1J+Jvgi+RLmXOMV8WESFQ288DebX2SEnlvu3io8WAw4dVUsjrxXBT
         5IPYFz++13FWKg5GmN8ed7XiXx31SR2776fZrhHbxAGpUrT0oT1zQghPvx2C+Zlvvyah
         7gjXVDDslXEYUSFU7UdQep5Q0/DNK7zNgwpFrk/kggXS9nlhpknfUASR7A3beCrOTVV0
         x07b/QZcuLqsBj6B6svubLKrKOS35cHhHobKiOLeg/tAAEJEhwINiZcovJ/LDEuockPV
         BrdVDiK0GICZRwVvAPlzpwGJIoNLM2BUVShw18ZPAOtBOMhk7a8W2JVl4X6X9A5pSxrk
         DiFw==
X-Gm-Message-State: APzg51BUGoQilKRgkgG2ddWsGrisO0bFP1bh1UlMeZ03Axg4c6tqwvGF
        3M8W0X5B4X5cdQy3ytEx10KfhCJssgQ=
X-Google-Smtp-Source: ANB0VdaOzD/YFvYyWH+MifM5atjjZIYtYbrLvlaKP9SNcV2ubZ5Qy4h24KfBe4+f9KXdIKFg83vuxw==
X-Received: by 2002:a81:d40c:: with SMTP id z12-v6mr13439824ywi.388.1536694395166;
        Tue, 11 Sep 2018 12:33:15 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id m82-v6sm8379538ywc.29.2018.09.11.12.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 12:33:13 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id j131-v6so9658515ywc.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:33:13 -0700 (PDT)
X-Received: by 2002:a0d:db10:: with SMTP id d16-v6mr13866974ywe.124.1536694393155;
 Tue, 11 Sep 2018 12:33:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 12:33:12
 -0700 (PDT)
In-Reply-To: <20180911192226.3620-3-labbott@redhat.com>
References: <20180911192226.3620-1-labbott@redhat.com> <20180911192226.3620-3-labbott@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Sep 2018 12:33:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKT88hPBcgj_mbxA5sREQQYBYkdKMkn-WFAUa+=TNUeaw@mail.gmail.com>
Message-ID: <CAGXu5jKT88hPBcgj_mbxA5sREQQYBYkdKMkn-WFAUa+=TNUeaw@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] scsi: ibmvscsis: Ensure partition name is properly
 NUL terminated
To:     Laura Abbott <labbott@redhat.com>
Cc:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        target-devel <target-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:22 PM, Laura Abbott <labbott@redhat.com> wrote:
>
> While reviewing another part of the code, Kees noticed that the
> strncpy of the partition name might not always be NUL terminated. Switch
> to using strscpy which does this safely.
>
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> v2: Switch to strscpy instead of just strlcpy
> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> index b3a029ad07cd..f42a619198c4 100644
> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> @@ -3477,7 +3477,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
>         snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI %s", vdev->name);
>
>         vscsi->dds.unit_id = vdev->unit_address;
> -       strncpy(vscsi->dds.partition_name, partition_name,
> +       strscpy(vscsi->dds.partition_name, partition_name,
>                 sizeof(vscsi->dds.partition_name));
>         vscsi->dds.partition_num = partition_number;
>
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
