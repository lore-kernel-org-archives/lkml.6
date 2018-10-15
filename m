Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5027CC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EEF20853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EEF20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeJOQIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:08:47 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44362 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:08:46 -0400
Received: by mail-vs1-f66.google.com with SMTP id w194so15742413vsc.11;
        Mon, 15 Oct 2018 01:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pSeoradrxalP15AWIkg1LMbW0eVL/bIIhTWvlbkWCY=;
        b=Ut//PJpNWvZCkBrGt1yuK8B0pLXX48dP/oAhOIsTJy+ZtEuWZnua2pplmouJcyTo4w
         JS0tl0FB5Vmhy9xa0IZuAqO/mmLK7phlbpvl7svYy5TN86+ii8RWHwjrOyzu8hxEJexe
         keBP3zYhJtkHCVL4d+2+iyMfCum7slzJlQz726Y8scI3aPvjKdU5TsMsgSVK+fOhEY9l
         gsUXhZ8o1KogcMo+MdTyeN7UJWZj9Vt+w+Uytb1othFuyioF+bCJl3MMCKhh6LOd7mjd
         tskD2+OM+ru4jLqu8n0LCoSXPFG18Wl+ZHBy1Ys0a9psnz2QoovjR5eUktGXWqjZ3rn/
         O+Mg==
X-Gm-Message-State: ABuFfojurFoBdOX05YE+/MHP5ZQrcYl0qM6nA0AhLwfWMdXuQAxDuPmh
        I58SRp+ZAUxOq2IdpqMNJf5+6xvOhs2pcOAxdrg=
X-Google-Smtp-Source: ACcGV63YAD2y+48ywrfMoAtrxTtzgES8lt+BEv680LcjXm5QJJrgVPzFa2xVNKPrRLSoNuUJBIl3gnddz14BSF4aUJk=
X-Received: by 2002:a67:e015:: with SMTP id c21mr5886641vsl.63.1539591871972;
 Mon, 15 Oct 2018 01:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539567282-1326-1-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1539567282-1326-1-git-send-email-frowand.list@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Oct 2018 10:24:20 +0200
Message-ID: <CAMuHMdXad2g5zEZ8=XzzVgfijcatKYj5AjwVQg=W-by_rHfcAQ@mail.gmail.com>
Subject: Re: [PATCH] of: overlay: user space synchronization
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Mon, Oct 15, 2018 at 3:36 AM <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> When an overlay is applied or removed, the live devicetree visible in
> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
> changes.  There is no method for user space to determine whether the
> live devicetree was modified by overlay actions.
>
> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
> user space to determine if the live devicetree has remained unchanged
> while a series of one or more accesses of /proc/device-tree/ occur.

Thanks for your patch!

> The use of both dynamic devicetree modifications and overlay apply and
> removal are not supported during the same boot cycle.  Thus non-overlay
> dynamic modifications are not reflected in the value of tree_version.

What does this mean exactly, for users?
I am used to applying and removing overlays at run time (still
carrying Pantelis'
overlay configfs patches), but when would I use non-overlay dynamic
modifications?

> --- a/Documentation/ABI/testing/sysfs-firmware-ofw
> +++ b/Documentation/ABI/testing/sysfs-firmware-ofw
>
> +What:          /sys/firmware/devicetree/tree_version
> +Date:          October 2018
> +KernelVersion: 4.20
> +Contact:       Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
> +Description:
> +               When an overlay is applied or removed, the live devicetree
> +               visible in /proc/device-tree/, aka
> +               /sys/firmware/devicetree/base/, reflects the changes.
> +
> +               tree_version provides a way for user space to determine if the
> +               live devicetree has remained unchanged while a series of one
> +               or more accesses of /proc/device-tree/ occur.
> +
> +               The use of both dynamic devicetree modifications and overlay
> +               apply and removal are not supported during the same boot
> +               cycle.  Thus non-overlay dynamic modifications are not
> +               reflected in the value of tree_version.
> +
> +               Example shell use of tree_version:
> +
> +               done=1
> +
> +               while [ $done = 1 ] ; do
> +
> +                  pre_version=$(cat /sys/firmware/devicetree/tree_version)
> +                  version=$pre_version
> +                  while [ $(( ${version} & 1 )) != 0 ] ; do
> +                     # echo is optional, sleep value can be tuned
> +                     echo "${version}  sleeping"
> +                     sleep 2;
> +                     pre_version=$(cat /sys/firmware/devicetree/tree_version)
> +                     version=${pre_version}
> +                  done
> +
> +                  # 'critical region'
> +                  # access /proc/device-tree/ one or more times
> +
> +                  post_version=$(cat /sys/firmware/devicetree/tree_version)
> +
> +                  if [ ${post_version} = ${pre_version} ] ; then
> +                     done=0
> +                  fi
> +
> +               done

Please say explicitly that tree_version contains a 32-bit unsigned
decimal number, which is incremented before and after every change.
I had to deduce that from the code.

IMHO that is more important than having the sample script here.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
