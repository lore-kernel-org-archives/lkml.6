Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240DEC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C440F213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JSjnW0Ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C440F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJJFP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:15:56 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35065 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJFPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:15:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id c10so3117813vsk.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXRIKfnZ48WP82n92ZNWk77jjQVNKnLE/WTB0ajRh8U=;
        b=JSjnW0IjlXLi0VhaLl/IghYadzG2gUYfrzkP2dt1bRVYtk/O+dWnSf1YBBjtqt5njg
         STAF2y3Aex+pcAy2kk24ViPQk2bdX9CX6DlSensCvC2O8GgU+w9eO/qB1rO0BIVlqoX/
         8SmkpHicpfNhHi1SrGv6Huwrx5iHX/cPrq7s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXRIKfnZ48WP82n92ZNWk77jjQVNKnLE/WTB0ajRh8U=;
        b=IaBQ8gjy800944xbvySybsEjJCDUM6mlZZapGAz7slq9KF+yNWKLrOjfc8HRAj6oNC
         P631AJQ15lB2AcpyUPiLN4mL1Tf1V7lbPdWAFC7sa41a/syryDDNZSYOwazCOGUzennS
         Anxyzoh1HzlDGLKkj9JChu7De84kpxZefEGsiqtUakSBQDrcgEGCmJlt8pyZpFoObdIj
         eJ+a+E6glzvIKXJHr5WLDS3Sf5HAC4QBap2RAZuOW4USoUNdaZNG3tizZciaa30B/1Xo
         KbCZjZpthwU6S1Qpt+HGW5m3A663rLg3utTQ6cf7Z5mGUdeH8yr377kZ8y+Ncq587aM7
         aNRA==
X-Gm-Message-State: ABuFfojZK7osIqVxMAOtzDSNcUrlsODpWXhEEi1p01jwlOimcYm4oMPC
        JJY6jbEebsQOH7RS7cQAA9W4L87w0fU=
X-Google-Smtp-Source: ACcGV61aRH913wsXEQVdtOm2aROEM8qOk8foQbzyjvPcTfLXbiCt9qX5mPi3hH72Eo8WCBRkc343mg==
X-Received: by 2002:ab0:350:: with SMTP id 74mr11683826uat.135.1539122215029;
        Tue, 09 Oct 2018 14:56:55 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id c189-v6sm9076157vkd.1.2018.10.09.14.56.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:56:54 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id v12-v6so3130451vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 14:56:53 -0700 (PDT)
X-Received: by 2002:a67:1141:: with SMTP id 62-v6mr11207954vsr.213.1539122213412;
 Tue, 09 Oct 2018 14:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <1538973275-5961-1-git-send-email-cang@codeaurora.org>
In-Reply-To: <1538973275-5961-1-git-send-email-cang@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Oct 2018 14:56:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xg4UtkJxvVQ2_ky+6-XnM=FvXcnc8xb=uhHeiP5bdFiw@mail.gmail.com>
Message-ID: <CAD=FV=Xg4UtkJxvVQ2_ky+6-XnM=FvXcnc8xb=uhHeiP5bdFiw@mail.gmail.com>
Subject: Re: [PATCH 1/1] scsi: ufs: make UFS Tx lane1 clock optional
To:     cang@codeaurora.org
Cc:     subhashj@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, venkatg@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 7, 2018 at 9:34 PM Can Guo <cang@codeaurora.org> wrote:
>
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>
> The UFS Tx lane1 clock could be muxed, hence keep it optional by ignoring
> it if it is not provided in device tree.

Thanks for the updated commit message.  This makes much more sense now!  :-)


> @@ -113,10 +110,10 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
>         if (!host->is_lane_clks_enabled)
>                 return;
>
> -       if (host->hba->lanes_per_direction > 1)
> +       if (host->tx_l1_sync_clk)
>                 clk_disable_unprepare(host->tx_l1_sync_clk);

I don't believe you need the "if".  A NULL clock is by definition OK
to enable / disable which is designed to make optional clocks easier
to deal with.


>         clk_disable_unprepare(host->tx_l0_sync_clk);
> -       if (host->hba->lanes_per_direction > 1)
> +       if (host->rx_l1_sync_clk)
>                 clk_disable_unprepare(host->rx_l1_sync_clk);

optional: Technically this part of the patch wasn't actually needed,
right?  "rx_l1_sync_clk" is not optional so that means that
"rx_l1_sync_clk" should be non-NULL exactly when lanes_per_direction >
1.

...but actually I'm fine with keeping this part of your patch for
symmetry.  Especially since you can leverage the
clk_disable_unprepare(NULL) to simplify your code.  Please mention in
your commit message that this is a cleanup and just for symmetry.
Probably also remove the "if" tests that are guarding
ufs_qcom_host_clk_enable().


>         clk_disable_unprepare(host->rx_l0_sync_clk);
>
> @@ -141,24 +138,21 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
>         if (err)
>                 goto disable_rx_l0;
>
> -       if (host->hba->lanes_per_direction > 1) {
> +       if (host->rx_l1_sync_clk) {

Similar: the above change isn't required but I'm OK if you want to
make this change for symmetry / to cleanup clock handling.  Please
mention in your commit message.


> +       /* The tx lane1 clk could be muxed, hence keep this optional */
> +       if (host->tx_l1_sync_clk)
> +               ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
> +                                        host->tx_l1_sync_clk);

If "host->tx_l1_sync_clk" is provided then you should still check the
return value of ufs_qcom_host_clk_enable(), right?  ...so please leave
the error path here.


> @@ -174,23 +168,33 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>
>         err = ufs_qcom_host_clk_get(dev,
>                         "rx_lane0_sync_clk", &host->rx_l0_sync_clk);
> -       if (err)
> +       if (err) {
> +               dev_err(dev, "%s: failed to get rx_lane0_sync_clk, err %d",
> +                               __func__, err);

nit: including "__func__" in dev_xxx() calls is discouraged.  The
"dev_xxx" calls already print the device name and the string within a
given device driver should be unique enough so __func__ just adds crap
to the logs.  If you really feel that __func__ adds something for you,
try posting up a patch to make all "dev_err" functions include
__func__.  ...but I think you'd probably be rejected.

suggestion: you'd save a few lines of code and simplify your probe if
you just passed an "optional" bool to the ufs_qcom_host_clk_get() that
controlled the printout.


> -               err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
> -                       &host->tx_l1_sync_clk);
> +               /* The tx lane1 clk could be muxed, hence keep this optional */
> +               ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
> +                                       &host->tx_l1_sync_clk);

To be technically correct you should actually check the error value
returned by ufs_qcom_host_clk_get().  Specifically figure out what the
error value is when "tx_lane1_sync_clk" isn't specified and check for
that.

...one reason this matters is -EPROBE_DEFER.  In theory devm_clk_get()
could return -EPROBE_DEFER.  In such a case you'd want to exit the
probe, not continue on.  It's also just good coding practice to handle
just the error you want though so that if the function returned some
other failing case you'd propagate it down instead of eating it.

If you passed "optional" to ufs_qcom_host_clk_get() as suggested above
you could put this error-code checking in ufs_qcom_host_clk_get() and
return 0 from that function if an optional clock was found to not
exist.

-Doug
