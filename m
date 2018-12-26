Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFFBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598672148D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545817091;
	bh=lBqDclltvD5YwuwhyXShCM2Xocr2s8NThfwHYXokLIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KXsJ5l9R9ebnSYPbmHVBa1xbAapezm5KRdybZokdlZSZXD3WNQMJz0Dy8qHXSiJUx
	 8bjnEWHSw1GhzDKROuYiGOTUg/0iE62iI7nXMNr7RRzcWeROO7xsUxfTTai7YU+U2j
	 dEjUOE851F0NphJ/sfJ6j+xNA3gU9Pc4qYJ9iudA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeLZJiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:38:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54141 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLZJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 04:38:10 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so20360151ita.3;
        Wed, 26 Dec 2018 01:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ak4dVKm58o6uZCYSsv57KLTpcDrjRloEZVsTqYnpSoI=;
        b=QmbkupTG2/Opzi5jB7XT7ae3N6J6ZcWSMKxH1OkYdh3AjbjfMsMLkBmOwvJpfpAV/y
         WZh+0nBkkt+fMSrdO6efK9d0L3bXFlOIde1pYTvW0bu+lbsMFi4GQTP2SxvRvtsTQ49e
         +pnd8BjPXrPUBqcLsmME8gbNekDKCLvqP4I470kcmT3k8p9S6+10g5xSmO3SvrCc8mkW
         QJX8UkBnxynMOJkSOoCiWR5XgzbHgk6bQlzaNwbeFQEpdrGdEaFFkoHtYFgh6dWawpti
         AjNchQxircJM4HyTJEt0HkXCzNs5+D8Ezw/CPQkZ+PpSCIh94CegEQ35x39mHHV7tQmt
         /JOQ==
X-Gm-Message-State: AA+aEWbX9R5IdoZh200BEAhTMwcE8Ye13kzmW64ybM6lktb3tor2p7AP
        QBJvPtyBDvcprFeWFaxjigLqjerD5VN/2hUVHJVBFlzi
X-Google-Smtp-Source: AFSGD/UNK14eGDjIuErXlAxvZCMOWdmiWVD7VF/8QI7dWFuyZHwi8oTb4rQ/glsOYBPHrzgvgzqiiL84Rq/+X3iDDIU=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr12138535ith.123.1545817088945;
 Wed, 26 Dec 2018 01:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20181226024700.72318-1-kjlu@umn.edu>
In-Reply-To: <20181226024700.72318-1-kjlu@umn.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Dec 2018 10:37:54 +0100
Message-ID: <CAJZ5v0iK+ASbadEjj+9vgCV+1ycjp8Hs2GbEmT3dGSqjLVGbPA@mail.gmail.com>
Subject: Re: [PATCH] base: fix a missing check of clk_prepare
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 3:47 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
> clk_prepare() could fail, so let's check its status, and if it fails,
> issue an error message.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/base/power/clock_ops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 5a42ae4078c2..cb6144fb24e2 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>         if (IS_ERR(ce->clk)) {
>                 ce->status = PCE_STATUS_ERROR;
>         } else {
> -               clk_prepare(ce->clk);
> +               if (clk_prepare(ce->clk))
> +                       dev_err(dev, "clk_prepare failed.\n");

I'm not sure that this is useful.  The code continues regardless of
the error anyway and it should at least set ce->status to
PCE_STATUS_ERROR in the failing case.

Have you seen a failure in this particular spot in practice?

> +
>                 ce->status = PCE_STATUS_ACQUIRED;
>                 dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
>                         ce->clk, ce->con_id);
> --
> 2.17.2 (Apple Git-113)
>
