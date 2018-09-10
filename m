Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A3C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3172F206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dFXeI7Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3172F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeIKE1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:27:14 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42461 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeIKE1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:27:14 -0400
Received: by mail-yb1-f195.google.com with SMTP id j8-v6so8634676ybg.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NcJTiVda9qNLkIcK6ilDi4YUjY23ckcR220NYasT/7I=;
        b=dFXeI7WstUtnaOoeKX4qnTmMVKYrX4z6q1smOuZGBbrYZyIEl42CxRpxAuS3atHKaD
         bdBtbUkyvquwkzqghp7X3QfWmfXXaNpiuKgo+3dV/ey11cPXnKLg0JiaEeyJejcH20Ze
         spx4FaoC11dWvOXMTFUSd3EzrVctLkvCx38C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NcJTiVda9qNLkIcK6ilDi4YUjY23ckcR220NYasT/7I=;
        b=HU4gK649m/Y+3nZVGvtNoSFNBLXDFkLqHwZWvVM5J3rfI54VGlknFAiWDehXrGYvl9
         sT1o1HCcaRe32I0xTiVItG3qFnIu+1yXUCSYgmw2/FDJTWe66JTUshgn1uMZE77Z4BWQ
         DdmFlML3IQ2keeVehzga6IZ4X+N06s2f7hYYpDQPjqzc2ICL1MVbSPP+pofryWFjZgoN
         2yl8x2Sxa3d0vGKkYiDWUVRpQyJsXCdDFc/B1Q1eGd4MDOTdBdYIYgPbhsa9xEiR018E
         d2NiAKkuJrgjEuf1n0QcA2xPp5eI3NGymMojaDN5B0HRMm8amC62KnI/dHnhcR9o3BUP
         y4tg==
X-Gm-Message-State: APzg51CfyTif9DxJ4qfh18r8+den2il+P0jqAnbRpQaC1+OLzJif6ey0
        o1VIFj0dzmKFctCQyZjiiWrrj+nkLVE=
X-Google-Smtp-Source: ANB0VdakzAMEePUoeBNJYcS/xXjcqAeTnAGZyF7RsikyU01ZEx/ClNCOR+fk1cHzLLzI6GPDKg/Qyg==
X-Received: by 2002:a25:a4c8:: with SMTP id g66-v6mr11278808ybi.76.1536622249723;
        Mon, 10 Sep 2018 16:30:49 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id d6-v6sm5743303ywa.85.2018.09.10.16.30.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 16:30:48 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id n21-v6so8532019ywh.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:30:47 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr11699570ywr.168.1536622247298;
 Mon, 10 Sep 2018 16:30:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 16:30:46
 -0700 (PDT)
In-Reply-To: <20180910223723.25357-1-labbott@redhat.com>
References: <20180910223723.25357-1-labbott@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Sep 2018 16:30:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+-RNeEr+FUc6maamvzYpY7W0VJ-yYGDHnFTuNPeOUMFw@mail.gmail.com>
Message-ID: <CAGXu5j+-RNeEr+FUc6maamvzYpY7W0VJ-yYGDHnFTuNPeOUMFw@mail.gmail.com>
Subject: Re: [PATCH] scsi: ibmvscsis: Fix a stringop-overflow warning
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

On Mon, Sep 10, 2018 at 3:37 PM, Laura Abbott <labbott@redhat.com> wrote:
> There's currently a warning about string overflow with strncat:
>
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specified
> bound 64 equals destination size [-Werror=stringop-overflow=]
>   strncat(vscsi->eye, vdev->name, MAX_EYE);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Switch to using strlcat which correctly accounts for lengths that
> are equal to the destination buffer.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> index fac377320158..53d344d8dc43 100644
> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> @@ -3475,7 +3475,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
>                 vscsi->dds.window[REMOTE].liobn);
>
>         strcpy(vscsi->eye, "VSCSI ");
> -       strncat(vscsi->eye, vdev->name, MAX_EYE);
> +       strlcat(vscsi->eye, vdev->name, MAX_EYE);

Can this just get switched to snprintf() instead?

snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI%s", vdev->name);

>         vscsi->dds.unit_id = vdev->unit_address;
>         strncpy(vscsi->dds.partition_name, partition_name,

And does this strncpy need a NUL-termination and/or trailing padding?

-Kees

-- 
Kees Cook
Pixel Security
