Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68BEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F6421533
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dcE4FN6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F6421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbeHGTZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:25:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43702 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389561AbeHGTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:25:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id f135-v6so12148477lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGNxF30N/BYPMZAHxtQhj9FLaP2whlIxyq623wp2kG8=;
        b=dcE4FN6nsl4f8+X3ppFih3HRc8uCrEUvAmDy4fPRP18qvtNjeDiiN9lqv22l99N/Dy
         eFvf/KHN5hhHWOVSfgpoHweawyw0UeZn+opo6GbKXbQ2V1maF64PT19YN7KnV68wUVxx
         AOx1srnFsrf25koBYxOrqK4db3UYa+YySJT9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGNxF30N/BYPMZAHxtQhj9FLaP2whlIxyq623wp2kG8=;
        b=LuYnfkJieacSXefFEcokbB4G5nBTuTwaRhDSRgQyGeRd03CDHEyf7fW6M0CUS0J33s
         y6ZHaA/7JzeU0h9CAq08xseEn8dqeJe+zcylxNyh1CoQLAyqa1UYMhsmPM9Xuh25x/GA
         MW7i+RfUJzn0PBiWxE5W4SfEdaSzucV/H6Mwb6IUQlkuXmXlS86SH3rylx+iw7FUutiB
         jRwAYV/sZ2T9VcLT5w6BzqUmz2ZzNfplKwdDFF/qoV64gqhBuHaxq77KX3dLhgHYWd//
         YA/08fFkf5Q2KURjMaEkPWIUU90/lvzjdXnp/idSiDXfnRA4CNzuMq2ZiLpuyw+vWqaE
         8YNA==
X-Gm-Message-State: AOUpUlHUpVoXejh2I2L1twbnRkjwoCjU8yKPuaNF4RLvWcDCT93iqi+5
        kmVU64Z3r1Q0Z9KMR2kDpVXwMnKdUDQ=
X-Google-Smtp-Source: AAOMgpdneLJc8KfCvXvczWLi4XnYKE/gvbK47i49sZGX3uo7Y6GK3/pgt2a7aW5DKZBYm5A4fRCUpA==
X-Received: by 2002:a19:b598:: with SMTP id g24-v6mr15188886lfk.129.1533661818203;
        Tue, 07 Aug 2018 10:10:18 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u203-v6sm378409lff.40.2018.08.07.10.10.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 10:10:17 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u202-v6so12154615lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:10:15 -0700 (PDT)
X-Received: by 2002:a19:db94:: with SMTP id t20-v6mr14272662lfi.126.1533661815462;
 Tue, 07 Aug 2018 10:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180802001435.116963-1-mka@chromium.org>
In-Reply-To: <20180802001435.116963-1-mka@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 7 Aug 2018 10:09:39 -0700
X-Gmail-Original-Message-ID: <CAE=gft5JaQZEvujP68mhe9ANzLThBLRtr+mCrNWFRxkSDZYLmA@mail.gmail.com>
Message-ID: <CAE=gft5JaQZEvujP68mhe9ANzLThBLRtr+mCrNWFRxkSDZYLmA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Check workqueue exists before destroying it
To:     mka@chromium.org
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        subhashj@codeaurora.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 5:14 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> In ufshcd_hba_exit() the clock gating workqueue is always destroyed
> when clock gating is supported. However the workqueue pointer is NULL
> when ufshcd_init() fails before the workqueue is created. Only destroy
> the workqueue if it exists.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 397081d320b1..401f7dbe2981 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -7190,7 +7190,8 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
>                 if (ufshcd_is_clkscaling_supported(hba)) {
>                         if (hba->devfreq)
>                                 ufshcd_suspend_clkscaling(hba);
> -                       destroy_workqueue(hba->clk_scaling.workq);
> +                       if (hba->clk_scaling.workq)
> +                               destroy_workqueue(hba->clk_scaling.workq);
>                         ufshcd_devfreq_remove(hba);
>                 }
>                 ufshcd_setup_clocks(hba, false);
> --
> 2.18.0.597.ga71716f1ad-goog
>

Reviewed-by: Evan Green <evgreen@chromium.org>
