Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2A2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F572145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRWkEPb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F572145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeIYJXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:23:23 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43690 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeIYJXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:23:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id k66-v6so3185762ywa.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 20:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PHXLbQiFBR6Nnoa7yEJBAf/jL/W8mCQp9zQ6sFuI1fo=;
        b=iRWkEPb+5M/a9dCn4NBZhSav2MGQbN5TTyIfsoWMAcZ8epz8BOcUerzMZObNmPdQuY
         nr5ZUt3jxO0R2TiybDqxmUb2hzT3/PmhgSiTXRGMSTxvVpsIKMqmeiN44kM/YwGKk45q
         +WPb4MH77oqMwCIxjuavqClc8mhLDm4NWsbqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PHXLbQiFBR6Nnoa7yEJBAf/jL/W8mCQp9zQ6sFuI1fo=;
        b=DFM8mX+XpsuFJgwRkQ/vlKLMynCqcDg/+qRq7z4fco+dDmnUIeMd79eopPyUPJsJmu
         0PL6UKP5Iua1zjt8d/NlAS12bYKR050JSh5jVM2Rje41EJNk2RLerTClRWOpE6uFIpFI
         nlPzgYZ57pfyFIWsE7G6Zy2+W62G3nANwsx2mrg96vGQsIvtf525BTpcQ4IUL0PhgHw4
         PUuBowz32lfSiHRf4+D3VtenO5+L5Ih3Rd7DH5QAkk7XktRmUNHIpIRuUriwRfKh8i8y
         LCQG1DPEDZN1y0VYT8YcK18kH1Usn5mFXZ+ZcbIMski0Wyo/KX/3j6h3gS04bxL2UA93
         B7pA==
X-Gm-Message-State: ABuFfojHeovBQcg+aMvB5Zwe/DjfkAf1eO76EpHqff5N8Pe+qv7HDQqA
        s+JbQ+OTEYB/E0OFuLrSOEz6Q7vX/bQ=
X-Google-Smtp-Source: ACcGV60dIb92SzKumEevAAPJO0DETzv4LEe741ni8aBaM7aT9/wKnUNVwURlplXlIpkfn5BBKY/ROA==
X-Received: by 2002:a81:3dd4:: with SMTP id k203-v6mr741492ywa.415.1537845479420;
        Mon, 24 Sep 2018 20:17:59 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r3-v6sm455624ywr.80.2018.09.24.20.17.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 20:17:57 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id d9-v6so9177204ybr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 20:17:57 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr832709yba.141.1537845477241;
 Mon, 24 Sep 2018 20:17:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 20:17:55
 -0700 (PDT)
In-Reply-To: <20180905220351.GA48213@beast>
References: <20180905220351.GA48213@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 24 Sep 2018 20:17:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL4q_FRn7ehDy4MtXpHanhtsu9M_RGKQMZ+by+Rq9ncKw@mail.gmail.com>
Message-ID: <CAGXu5jL4q_FRn7ehDy4MtXpHanhtsu9M_RGKQMZ+by+Rq9ncKw@mail.gmail.com>
Subject: Re: [PATCH] sparc64: viohs: Remove VLA usage
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Allen Pais <allen.pais@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 3:03 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates a fixed size array for the maximum number of cookies and
> adds a runtime sanity check.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1
> RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping. Dave, can you take this?

Thanks!

-Kees

> ---
>  arch/sparc/kernel/viohs.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
> index 635d67ffc9a3..7db5aabe9708 100644
> --- a/arch/sparc/kernel/viohs.c
> +++ b/arch/sparc/kernel/viohs.c
> @@ -180,11 +180,17 @@ static int send_dreg(struct vio_driver_state *vio)
>                 struct vio_dring_register pkt;
>                 char all[sizeof(struct vio_dring_register) +
>                          (sizeof(struct ldc_trans_cookie) *
> -                         dr->ncookies)];
> +                         VIO_MAX_RING_COOKIES)];
>         } u;
> +       size_t bytes = sizeof(struct vio_dring_register) +
> +                      (sizeof(struct ldc_trans_cookie) *
> +                       dr->ncookies);
>         int i;
>
> -       memset(&u, 0, sizeof(u));
> +       if (WARN_ON(bytes > sizeof(u)))
> +               return -EINVAL;
> +
> +       memset(&u, 0, bytes);
>         init_tag(&u.pkt.tag, VIO_TYPE_CTRL, VIO_SUBTYPE_INFO, VIO_DRING_REG);
>         u.pkt.dring_ident = 0;
>         u.pkt.num_descr = dr->num_entries;
> @@ -206,7 +212,7 @@ static int send_dreg(struct vio_driver_state *vio)
>                        (unsigned long long) u.pkt.cookies[i].cookie_size);
>         }
>
> -       return send_ctrl(vio, &u.pkt.tag, sizeof(u));
> +       return send_ctrl(vio, &u.pkt.tag, bytes);
>  }
>
>  static int send_rdx(struct vio_driver_state *vio)
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
