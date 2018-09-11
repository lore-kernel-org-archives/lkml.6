Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB7AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0510020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsGTTlSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0510020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeIKXZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:25:17 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41129 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbeIKXZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:25:16 -0400
Received: by mail-yb1-f193.google.com with SMTP id v10-v6so2031905ybm.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kkhW6GAbQBBtYsPYn8QZQMWQ3TLPhTWGHEXtpZMEdvM=;
        b=QsGTTlSfHitkkPwR7uOhIib6gj3mMIOQWwzF52fqPGkezooVEfuBRlmYveXlokzw6u
         jXGmWh4wq7msX1rFwdKFw0uMv/6hVneTqb98qyA21CL8+e3JBLvrcHUG7Hr9quq7vtgy
         LBM958WyhZLs7b35uWRu/EtfBap13kHh8sMMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kkhW6GAbQBBtYsPYn8QZQMWQ3TLPhTWGHEXtpZMEdvM=;
        b=OiqZlf0fNFP3oPzLnHFyyTHyc5zkO/XUStXzkej51lc1GZ5ArwCmsaKo1hYO1GFwmn
         WNKtG9qY2eV0aLWzbq1P9J3xMcBbJvxzpBPbqTO53j4dUnygdebs+ZUY5x3Dr5KALhQw
         RW1l+LeWrvUcpeWMSQma5HK5EX5z8miSX3kHogEay+mlvIQEE5DWZA6azHDXu7DDJW1E
         mmRZKevsTzYiYYkYcBdpXPO+E01+fKAAYSJg3wjKYXyZ2UwVhvQn/PrAqG3bzGEy6ke/
         yVqjep/htx+5xX9clclc4ykceOprI3WWKLCRw9Ctx5nEhmFrGB/Q4hyh4MtSZ8bfDhlU
         CKEQ==
X-Gm-Message-State: APzg51D/lJfPgCNxpSEc+sr3ALHm48l4SlpFPR5fZLtvuGbP1TQpVTAU
        ckmfMQbvIiOw5C8yjZ2KWv1H1E5l7H4=
X-Google-Smtp-Source: ANB0VdaPgc0ZzjTIOHOAXX4ethmZ6WKaIINdryAjJE9764lw5ZiwBulL6zS/jU4S/dUd0Rl119glfQ==
X-Received: by 2002:a25:a28c:: with SMTP id c12-v6mr11973097ybi.368.1536690283179;
        Tue, 11 Sep 2018 11:24:43 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t4-v6sm7239269ywa.51.2018.09.11.11.24.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:24:41 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id t10-v6so9716881ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:24:41 -0700 (PDT)
X-Received: by 2002:a25:23c3:: with SMTP id j186-v6mr12068638ybj.137.1536690280758;
 Tue, 11 Sep 2018 11:24:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 11:24:39
 -0700 (PDT)
In-Reply-To: <20180911180542.7778-1-labbott@redhat.com>
References: <20180911180542.7778-1-labbott@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Sep 2018 11:24:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+R_VLzKxwtqu7yR=vwRBSZNhcjjMtz8OgWRh48Gwisww@mail.gmail.com>
Message-ID: <CAGXu5j+R_VLzKxwtqu7yR=vwRBSZNhcjjMtz8OgWRh48Gwisww@mail.gmail.com>
Subject: Re: [PATCHv2] scsi: ibmvscsis: Fix a stringop-overflow warning
To:     Laura Abbott <labbott@redhat.com>
Cc:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        target-devel <target-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:05 AM, Laura Abbott <labbott@redhat.com> wrote:
>
> There's currently a warning about string overflow with strncat:
>
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specified
> bound 64 equals destination size [-Werror=stringop-overflow=]
>   strncat(vscsi->eye, vdev->name, MAX_EYE);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Switch to a single snprintf instead of a strcpy + strcat to handle this
> cleanly.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> v2: Swtich to using snprintf per suggestion of Kees
> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> index fac377320158..9305440a00a1 100644
> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> @@ -3474,8 +3474,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
>                 vscsi->dds.window[LOCAL].liobn,
>                 vscsi->dds.window[REMOTE].liobn);
>
> -       strcpy(vscsi->eye, "VSCSI ");
> -       strncat(vscsi->eye, vdev->name, MAX_EYE);
> +       snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI%s", vdev->name);
>
>         vscsi->dds.unit_id = vdev->unit_address;
>         strncpy(vscsi->dds.partition_name, partition_name,
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
