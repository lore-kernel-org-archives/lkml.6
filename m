Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D68C6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955252087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hJKBuyaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955252087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJLDug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:50:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43459 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeJLDuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:50:35 -0400
Received: by mail-vs1-f65.google.com with SMTP id w85so9821744vsa.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLb5dhnivT+1/4hU4EU2dDLTGyDtSL2UFXUJdu0lDAg=;
        b=hJKBuyaWyh0E4D4M3tnP8avrPcUZU/XcFLeq18kDwqy0EFpE+QiQZ7OB076MVcqXlB
         jBVrRR3hDnb2WfFoQ+vcbMjumf4+XcHxOn7NxDJaSXWdvLd29GHVrAvJnqhsgqlAclEt
         xiVA0Aw2lIt77grRG0z/RylNQIFbsz6RRn8DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLb5dhnivT+1/4hU4EU2dDLTGyDtSL2UFXUJdu0lDAg=;
        b=ANokSrnHtEkMS1XKeTEzxKJTAjBnbtdFwsMgSXhhJBkywN3/Jdg3Yth4pZxUojs8FC
         0HK9fbotDJRojtXAjdDxBmpKki6F86tSVtXZ42njPBwcAJ7TEXRdSt6eYySfeujLM6L2
         JgVSalU4pTgnvwe4Cvnk9sP90THSiFdi/FGymRmQ+n1L7Yo9j2jBd+Pljr3Q7NeG3C1y
         YSnzM/r/CvKjrGTcZg1VQGxcY7ZlPuVDIazsg8uSA+dMNjINICFqr75sQ/sFN9Fj3wb8
         FYTCKibwZTxpCKBLgSnmxBOsukrOtjMcFFrYkrxgFpsYh7YO5644R2K7D2dkBsPFrk8O
         /Xbw==
X-Gm-Message-State: ABuFfoivdGR6BEzzv/+qgPggVOHy5uj35jq75TUmVZ+Iz/WRUa+ECIlH
        DuZ5Mqi2DESXvUkHIx52JzhndGllGvE=
X-Google-Smtp-Source: ACcGV60GBAhFoWYsbJvGN42qSxEwiaWQvIELzHlYCIPSeGYeT1Vho6t5uDveQ1lWMS74FPa3CWeKpg==
X-Received: by 2002:ab0:14e4:: with SMTP id f33-v6mr1460637uae.122.1539289302826;
        Thu, 11 Oct 2018 13:21:42 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id u72-v6sm3658246vku.26.2018.10.11.13.21.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 13:21:41 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id r83so9843811vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:21:41 -0700 (PDT)
X-Received: by 2002:a67:1141:: with SMTP id 62-v6mr1299123vsr.213.1539289301181;
 Thu, 11 Oct 2018 13:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <1539261196-14550-1-git-send-email-cang@codeaurora.org>
In-Reply-To: <1539261196-14550-1-git-send-email-cang@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Oct 2018 13:21:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VSyJAna4JwLXJi1=Z_Y1mzr8cW4iD+vJLPU2GASP3wQA@mail.gmail.com>
Message-ID: <CAD=FV=VSyJAna4JwLXJi1=Z_Y1mzr8cW4iD+vJLPU2GASP3wQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] scsi: ufs: make UFS Tx lane1 clock optional for
 QCOM platforms
To:     cang@codeaurora.org
Cc:     subhashj@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        venkatg@codeaurora.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 11, 2018 at 5:33 AM Can Guo <cang@codeaurora.org> wrote:
>  static int ufs_qcom_host_clk_get(struct device *dev,
> -               const char *name, struct clk **clk_out)
> +               const char *name, struct clk **clk_out, bool optional)
>  {
>         struct clk *clk;
>         int err = 0;
>
>         clk = devm_clk_get(dev, name);
> -       if (IS_ERR(clk)) {
> +       if (clk == ERR_PTR(-EPROBE_DEFER)) {
> +               err = -EPROBE_DEFER;
> +               dev_warn(dev, "required clock %s hasn't probed yet, err %d\n",
> +                               name, err);
> +       } else if (IS_ERR(clk)) {
> +               if (optional)
> +                       return 0;

Change this function to:

static int ufs_qcom_host_clk_get(struct device *dev,
    const char *name, struct clk **clk_out, bool optional)
{
  struct clk *clk;
  int err;

  clk = devm_clk_get(dev, name);
  if (!IS_ERR(clk)) {
    *clk_out = clk;
    return 0;
  }

  err = PTR_ERR(clk);

  if (optional && err == -ENOENT) {
    *clk_out = NULL;
    return 0;
  }

  if (err != -EPROBE_DEFER)
    dev_err(dev, "failed to get %s err %d",
        name, err);

  return err;
}

Specifically:

* Typically it just spams the log to print something when you see an
-EPROBE_DEFER.

* If a clock is optional you should only consider things a success
only if "-ENOENT" was returned.  All other errors should be considered
fatal.

* If a clock is optional it's slightly cleaner to set *clk_out to
NULL.  I know you're initting global data that happened to already be
NULL by default, but it still feels nice for the abstraction of the
function to do this.

* Please don't pass __func__ to your error messages.


>                 err = PTR_ERR(clk);
>                 dev_err(dev, "%s: failed to get %s err %d",
>                                 __func__, name, err);
> @@ -113,10 +119,10 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
>         if (!host->is_lane_clks_enabled)
>                 return;
>
> -       if (host->hba->lanes_per_direction > 1)
> +       if (host->tx_l1_sync_clk)

Remove this "if".  Always call clk_disable_unprepare() which will be a
no-op if "host->tx_l1_sync_clk" is NULL.  clk_disable_unprepare() is a
no-op for NULL clocks by design specifically to make code like this
cleaner.


>                 clk_disable_unprepare(host->tx_l1_sync_clk);
>         clk_disable_unprepare(host->tx_l0_sync_clk);
> -       if (host->hba->lanes_per_direction > 1)
> +       if (host->rx_l1_sync_clk)

Remove this "if".  Always call clk_disable_unprepare() which will be a
no-op if "host->rx_l1_sync_clk" is NULL.  clk_disable_unprepare() is a
no-op for NULL clocks by design specifically to make code like this
cleaner.


>                 clk_disable_unprepare(host->rx_l1_sync_clk);
>         clk_disable_unprepare(host->rx_l0_sync_clk);
>
> @@ -141,12 +147,14 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
>         if (err)
>                 goto disable_rx_l0;
>
> -       if (host->hba->lanes_per_direction > 1) {
> +       if (host->rx_l1_sync_clk) {

Remove this "if".  Always call ufs_qcom_host_clk_enable().  The
clk_prepare_enable() inside ufs_qcom_host_clk_enable() will be a no-op
if "host->rx_l1_sync_clk" is NULL and will return 0 (no error).


>                 err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
>                         host->rx_l1_sync_clk);
>                 if (err)
>                         goto disable_tx_l0;
> +       }
>
> +       if (host->tx_l1_sync_clk) {

Remove this "if".  Always call ufs_qcom_host_clk_enable().  The
clk_prepare_enable() inside ufs_qcom_host_clk_enable() will be a no-op
if "host->tx_l1_sync_clk" is NULL and will return 0 (no error).


-Doug
