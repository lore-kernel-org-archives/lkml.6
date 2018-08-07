Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6367CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138C12152E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMxJqAhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138C12152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390213AbeHGTic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:38:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36110 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389126AbeHGTic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:38:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so14065242lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO74xGXO1BSceoKbqAal+slGwHwBexro2ORf4FKwOFw=;
        b=XMxJqAhWYqJ8SnP7GgEjbgbJM8Duw/TcdTxCPJaLug4jSytGJ7RDj+yxSX9Ceye7l1
         Y1tVEsJpRRAcc+Y+vgmfRwhozTzoHqCR32i6uaI8guVhSMLKQLPAPh5NfBQIzFr7IO4/
         o1x4pvLe87V8xP+eXzFdezYFHqPz3bH169Cfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO74xGXO1BSceoKbqAal+slGwHwBexro2ORf4FKwOFw=;
        b=OGrlLgSY+1qaiKN6UFFgjqQTRWtSAVf3yvi90ub5yeQPboVUfXBTvUyoCNgF/abTX0
         deyDhr0hNQ4aVV0hIrBTcc5Y67E33mAtCexz1L85JiH2i/Bf4em9xM0rl9nPDHMuORjW
         GuQqkhb16qmmcCeQt356OCae6kO1g5CqAgFHbJA9b03EZ93B4DqLwxZyyxdVy3AuqRWW
         GNSsI2ooH7Pve+pW0obFd/bUNGGUgb6i2OxsKCg8zVaSrVucdxmyUkWHS6qDZcl6XOOO
         gOJp3cTOWTsUavqK7WG0pIQl5sAyvt9p3h2JnsbQan35O8oeuHVJHzkzlYF3iOFrknrx
         KaJA==
X-Gm-Message-State: AOUpUlGsTW2M0WKk5Y0z2JYeRNHb6f0ten7DGphDQvjAnSJmCmhtNtqF
        M0XVMzKOt5kqEr91pPlwqCK6bzEGLEc=
X-Google-Smtp-Source: AAOMgpflrPFFcAbHAcUj0maQF1zahMis9OCVvw421Ifi1n08sJKIBX8gJJD/D8fuKHz0xluNP83NcQ==
X-Received: by 2002:a2e:9742:: with SMTP id f2-v6mr17261999ljj.5.1533662589993;
        Tue, 07 Aug 2018 10:23:09 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w27-v6sm393665lfk.5.2018.08.07.10.23.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 10:23:08 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id n96-v6so12220921lfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:23:08 -0700 (PDT)
X-Received: by 2002:a19:d484:: with SMTP id l126-v6mr14165268lfg.28.1533662588467;
 Tue, 07 Aug 2018 10:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180801233145.65049-1-mka@chromium.org>
In-Reply-To: <20180801233145.65049-1-mka@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 7 Aug 2018 10:22:32 -0700
X-Gmail-Original-Message-ID: <CAE=gft4fdDxuf7NUXVeh6F+4k2cXpBVu3147KCbuG-k6iq836w@mail.gmail.com>
Message-ID: <CAE=gft4fdDxuf7NUXVeh6F+4k2cXpBVu3147KCbuG-k6iq836w@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Suspend clock scaling only once in ufshcd_hba_exit()
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

On Wed, Aug 1, 2018 at 4:31 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Commit 401f1e4490ee ("scsi: ufs: don't suspend clock scaling during
> clock gating") introduced a check in ufshcd_hba_exit() to suspend
> clock scaling only when the controller supports clock scaling.
> However the unconditional call to ufshcd_suspend_clkscaling() was
> also left in place, so that it is now called twice when clock
> scaling is supported and still once when the controller doesn't
> support it. Remove the unconditional call.
>
> Fixes: 401f1e4490ee ("scsi: ufs: don't suspend clock scaling during clock gating")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 397081d320b1..dca7525af696 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -7186,7 +7186,6 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
>         if (hba->is_powered) {
>                 ufshcd_variant_hba_exit(hba);
>                 ufshcd_setup_vreg(hba, false);
> -               ufshcd_suspend_clkscaling(hba);
>                 if (ufshcd_is_clkscaling_supported(hba)) {
>                         if (hba->devfreq)
>                                 ufshcd_suspend_clkscaling(hba);
> --
> 2.18.0.597.ga71716f1ad-goog
>

Reviewed-by: Evan Green <evgreen@chromium.org>
