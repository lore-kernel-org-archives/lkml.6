Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197D8C5ACCD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEAC214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e414aq1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEAC214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeJQHq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:46:58 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36147 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJQHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:46:57 -0400
Received: by mail-ua1-f66.google.com with SMTP id b3so4081898uak.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17qu82h3OB19L2KrrszeKs/sjgDAuoCFgIzWO1FpFYw=;
        b=e414aq1PbGeLPTHEABkD+t1BtIDpAdIRVRkNRzK3EdhxE3l284xVPxE1+nE92jo9Tu
         oj7OM4owlGaNeP5ja+pk66kFjtnrpRXNMi9KqTeBZZJRItzWbbqchWiahPHkNPVuJgkS
         tvWfQTcRi3Pjh/6H9tH7njXJ88gv4DBbmUAD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17qu82h3OB19L2KrrszeKs/sjgDAuoCFgIzWO1FpFYw=;
        b=ONhQ64c4DaeoOBVZ1dhzekb0+6QNaOYI+wBXhHEeogR9wsj8KAxZbCJBkodyTQcfLg
         68yaXTgfywEIGITFvoOjlS5f9xQdRlO3yl+xiPahBdtz7l6QzwlXtY+RoYsf5JeNiC3L
         TL0xuuMrescMKMjQxyiwXcV/zuTCAfVG1x71TDhwyBtQOr8eBa/W5aed81MyOZxwErHu
         zHqEXEWkamjrRfgHW2xQTJ5TFblddIp/DIJvvN7xPpjYjjOP7ZeXLiTww0GYRaftYwPx
         T00zBFdDXKwKMdf148e4uw6yV5RPH4zRG0ZJ7xfx1xp0Wvvtj7r3AOL5Wo9reo/00s/0
         W5+w==
X-Gm-Message-State: ABuFfohOMeUih5vlMms5hi6+OLeXirqiRcPYcXvz043OyXh1USj50+ZJ
        gLxn3C+CeXQbWV6J1ESO1IGMo7bL+YY=
X-Google-Smtp-Source: ACcGV60G9x53fFhy05mAepwaDCGdbl/+gVvR5oWKizsIWxiyjzAWArNvqTVrVMtiQzDsuTDAHKX9FQ==
X-Received: by 2002:ab0:5e8f:: with SMTP id y15mr9860062uag.21.1539734048164;
        Tue, 16 Oct 2018 16:54:08 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id w39sm2497356uac.0.2018.10.16.16.54.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 16:54:07 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id h20-v6so5899433vke.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:06 -0700 (PDT)
X-Received: by 2002:a1f:310c:: with SMTP id x12mr5717814vkx.79.1539734046397;
 Tue, 16 Oct 2018 16:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181013005504.46399-1-briannorris@chromium.org> <20181013005504.46399-4-briannorris@chromium.org>
In-Reply-To: <20181013005504.46399-4-briannorris@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 16 Oct 2018 16:53:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFUeyYZ-LQwYHeQH=b0kBf_wM5ZywpQDS74+_zqeDhEw@mail.gmail.com>
Message-ID: <CAD=FV=XFUeyYZ-LQwYHeQH=b0kBf_wM5ZywpQDS74+_zqeDhEw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ath10k: snoc: fix unbalanced clock error handling
To:     Brian Norris <briannorris@chromium.org>
Cc:     kvalo@qca.qualcomm.com, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Oct 12, 2018 at 5:55 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Similar to regulator error handling, we should only start tearing down
> the 'i - 1' clock when clock 'i' fails to enable. Otherwise, we might
> end up with an unbalanced clock, where we never successfully enabled the
> clock, but we try to disable it anyway.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Presumably you could have a Fixes tag just to help folks, like:

Fixes: a6a793f98786 ("ath10k: vote for hardware resources for WCN3990")

> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 5a8e87339df2..a835599a8d55 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1470,7 +1470,7 @@ static int ath10k_snoc_clk_init(struct ath10k *ar)
>         return 0;
>
>  err_clock_config:
> -       for (; i >= 0; i--) {
> +       for (i = i - 1; i >= 0; i--) {

I see no problem with this and it's a good / easy to backport fix.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

For extra credit, though, you could change this to not duplicate the
"clk_bulk" APIs and just use 'em.  I already mentioned to someone else
that maybe the clk_bulk APIs could probably be improved to handle
optional clocks, but I don't think anyone has posted a patch for it.
Bonus points if you remember that "NULL" is a valid clock so you
really only need special case code in clk_bulk_get().  :-P


-Doug
