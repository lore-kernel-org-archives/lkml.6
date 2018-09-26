Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837EBECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEDE2156E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuEcG0l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEDE2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeI0ASR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:18:17 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36541 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeI0ASQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:18:16 -0400
Received: by mail-yb1-f193.google.com with SMTP id 5-v6so11708097ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fzUOne1LKr3ODWV4c/VqoL56O/v0qIxsRJRo7xbjY+4=;
        b=BuEcG0l2zw8aKouraIh49CFekfhZdatljipYt98qQZlz6RDbw1JfA2PrMHDlKwfz5w
         4Fn6BDBDb1cODig0X4WnQfRSbxhjDNuSM3AtP23u2NEzA+jCRJVQZAoRYDkjF3Z1pF0I
         NJXurWJhwiBLH7bO8jdPj0qfTlkTEw3/egeUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fzUOne1LKr3ODWV4c/VqoL56O/v0qIxsRJRo7xbjY+4=;
        b=IAajYNsze7PcmVgrcQyruCJXuLQSSb/Zyi1ae9SkXFAyegAXrD/Yo3MJbsJmdq1j8y
         c1I8ygm+BMwrW2r7NxYLFEapmDLBcPNCjSXhh+aGruZHqT9SHyfGreEeGohft8FWRer2
         XFjtsFRsTullexUr0ICqtdFNbVLPhGz2p+pkWi8B73gF6d0/MIpN2xqe3W7q41r+9AiR
         oiKNzcjjG+dPDDhiddlZ+OJxq+G9N3khYuirL1kUXfxTrwbfC3iAtDXSpMT6snjDlWdQ
         /1d4SKWod1b3awe6O7MR0JH7S9UdYXaaDKIUfFmTbvEyi9YaUvtjThpGqg4ZLOb5sxEz
         ++KA==
X-Gm-Message-State: ABuFfoiSAbG6/QapzMXuqFa7LJ4fZyeW+B1lOKoTXZryd+mqAE49Fu1q
        /4slBKozdZNL0dPJPXPUHL9wEBF9fjo=
X-Google-Smtp-Source: ACcGV63WPPYN6YVu2mhA4vOjd0YjtxM9JNEuT1O+aZRPy5+FXv/SC313VtI0MsdStk/ON8H/pqya/Q==
X-Received: by 2002:a25:2d1a:: with SMTP id t26-v6mr3772198ybt.332.1537985048292;
        Wed, 26 Sep 2018 11:04:08 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 124-v6sm2382635yws.25.2018.09.26.11.04.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:04:07 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 5-v6so11708041ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:04:06 -0700 (PDT)
X-Received: by 2002:a25:396:: with SMTP id 144-v6mr3894293ybd.403.1537985046630;
 Wed, 26 Sep 2018 11:04:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 11:04:06
 -0700 (PDT)
In-Reply-To: <13450.1537984337@turing-police.cc.vt.edu>
References: <13450.1537984337@turing-police.cc.vt.edu>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 26 Sep 2018 11:04:06 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+tYabS9rOfY=UgrqwP_S9iTnmRC16RSVn5QECrM+eNGA@mail.gmail.com>
Message-ID: <CAGXu5j+tYabS9rOfY=UgrqwP_S9iTnmRC16RSVn5QECrM+eNGA@mail.gmail.com>
Subject: Re: [PATCH] fix error handling in drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        John Whitmore <arigead@gmail.com>,
        kernelnewbies@kernelnewbies.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:52 AM,  <valdis.kletnieks@vt.edu> wrote:
> John notes that if the kzalloc of ieee->pHTInfo fails, we fail to call
> ieee80211_networks_free().  In addition, that function has an un-needed check
> before kfree().
>
> Reported-by: John Whitmore <arigead@gmail.com>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Reviewed-by: Kees Cook <keescook@chromium.org>

(And this seems to be the only case of this -- I don't see this code
trivially copy/pasted in other 80211 stacks.)

-Kees


> ---
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> index 90a097f2cd4e..97ff0371b5bb 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> @@ -78,8 +78,6 @@ static inline int ieee80211_networks_allocate(struct ieee80211_device *ieee)
>
>  static inline void ieee80211_networks_free(struct ieee80211_device *ieee)
>  {
> -       if (!ieee->networks)
> -               return;
>         kfree(ieee->networks);
>         ieee->networks = NULL;
>  }
> @@ -180,6 +178,7 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
>         return dev;
>
>   failed:
> +       ieee80211_networks_free(ieee);
>         if (dev)
>                 free_netdev(dev);
>
>



-- 
Kees Cook
Pixel Security
