Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D52C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A0E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CMN1xCkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A0E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeIKXZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:25:44 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34658 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbeIKXZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:25:44 -0400
Received: by mail-yb1-f195.google.com with SMTP id t10-v6so9717501ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zHa0CViV8KOs/JPKqRglgPRBbP0M3/iFC0Zd4K7jMEA=;
        b=CMN1xCkPgWGy4apS+Ys4C6Ym3+JdSzV9heIWQ+0ocOGACrbYs//xDl2Y2FoPkhSKII
         +JY5nOVeJwByjkRfbr+v0c/7U21VpVwYbg0a+x/uM3zNAfV8FNCv2zN/FXgq3cKLPCqb
         9C5VznyDtHKBNyy/WQRK4c2d2QWkwoNyJcK+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zHa0CViV8KOs/JPKqRglgPRBbP0M3/iFC0Zd4K7jMEA=;
        b=tLpgNFf5h6tLbbDPdQpiGPW1YJ8wNhgwwSJD/AVZrW7YnStM8goaigVPSd1N27WLqj
         NPDZgfFDSZeSe144ptTFPSlIUu2D+ClCU5D3/LjrGsHgMGPXvgeEe0UeSiEiqCWlCt/Z
         BA2+3dIlQ6Aa6SxK9qPfbFBR2UPv413xJXF6LGJdpQihry+y+ZVUwzRvoqYXVVGKVjqs
         jP70fFrHToKjljQdSnt6kxTU0xMwTVoLJj5WVgzHCaFYx898/B9WaSuVvR6AxW7LyJF+
         KCugxxMxMzXY59StdZc/ulMtKILSrto5xKjHFChraS6/n3AFqGdYhuMP+w5clbKgL5jO
         odsw==
X-Gm-Message-State: APzg51BWDn7+ZWaxpRz28vzv5bpaoa2I++tn9kK3Ad1sZMhg8j+/pS0h
        oZFgL8bP/hKb8EYAK/aw+sauTvQQRsc=
X-Google-Smtp-Source: ANB0VdbQD002SYvBpNeLbPJWZx3UJHoiuMFJ8+2Eb9oQOV8w/CZ3r2rqDn1tK25jYEwLBq4V1Y+BJA==
X-Received: by 2002:a25:3585:: with SMTP id c127-v6mr13108449yba.194.1536690311775;
        Tue, 11 Sep 2018 11:25:11 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id m16-v6sm9208994ywd.32.2018.09.11.11.25.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:25:09 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id h22-v6so9693492ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:25:09 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr13039192ybh.209.1536690308948;
 Tue, 11 Sep 2018 11:25:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 11:25:08
 -0700 (PDT)
In-Reply-To: <20180911181534.18553-1-labbott@redhat.com>
References: <20180911181534.18553-1-labbott@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Sep 2018 11:25:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLE3kBFrz-HDfYcUFJU=Up_+q1t1BP6708+Y3RMvO8ivA@mail.gmail.com>
Message-ID: <CAGXu5jLE3kBFrz-HDfYcUFJU=Up_+q1t1BP6708+Y3RMvO8ivA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ibmvscsis: Ensure partition name is properly NUL terminated
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

On Tue, Sep 11, 2018 at 11:15 AM, Laura Abbott <labbott@redhat.com> wrote:
> While reviewing another part of the code, Kees noticed that the
> strncpy of the partition name might not always be NUL terminated. Switch
> to using strlcpy which does this safely.
>
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> I realized looking at this that I probably should have made
> this and my previous patch a series given this has context depending on
> the other patch. I can resend if the scsi maintainers want.
> ---
>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> index 9305440a00a1..1217bf2a28db 100644
> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
> @@ -3477,7 +3477,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
>         snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI%s", vdev->name);
>
>         vscsi->dds.unit_id = vdev->unit_address;
> -       strncpy(vscsi->dds.partition_name, partition_name,
> +       strlcpy(vscsi->dds.partition_name, partition_name,

Please use strscpy() in favor of strlcpy().

-Kees

>                 sizeof(vscsi->dds.partition_name));
>         vscsi->dds.partition_num = partition_number;
>
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
