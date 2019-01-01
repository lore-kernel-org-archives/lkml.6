Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3500E208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfAAVXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:23:52 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34897 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfAAVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:23:51 -0500
Received: by mail-ua1-f66.google.com with SMTP id d2so9411874ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 13:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nf/BNLan3bgecUg9xxsTNzMFhLqEgR058RxfN91rOmU=;
        b=V7zgQu87B0aehyg6jO/Y7WvHZlUz7VEzgOdvKiGesrHjUm98ODS+V8qzXj/sdDzDwj
         mVhwPXhL7nwNsmO2e/l6tR9dHACujmY7efzdO3SBGmoOefnnlcIF38BI992X1/wWu8HX
         orlvVIopw+fAGCBfnXK8NAilY+X+o5mdrN+8EbJ/fyLXJSXY06cJMDVL5F8ScyltKkIm
         CZVRcxcaiKqx1yaAb7yhezVuBkoCDXwgpYidiotvGAPUt3j0vU+T/y/fvHuGmfrWVBR4
         a92VWdheKc+4gX8u74XOCu9jpNtYQsc1QDl2SO2KJj4oJU806t0XtD0Garyte8yKd9D2
         f2SA==
X-Gm-Message-State: AJcUuke1pgA87rJM+tHA8cBlh2AaViVtToX5ugOGpH8y/D7v0b6ojOwE
        +Clk8Wu2vp+8e22lJhBs+M1QTlMrogTdKCdtKCI=
X-Google-Smtp-Source: ALg8bN5HYsslMWxs1c3zrLu+gh1KCJW06j2ZG3l3f/437jAmOqMKdZK0eJT3lsTOotFd/mVNmM/PBaC4+ThtLYON8Bo=
X-Received: by 2002:a9f:314c:: with SMTP id n12mr15560034uab.33.1546377830754;
 Tue, 01 Jan 2019 13:23:50 -0800 (PST)
MIME-Version: 1.0
References: <cb43e1cb-dffa-26d8-c938-49ca4b48d38a@nisi.nl>
In-Reply-To: <cb43e1cb-dffa-26d8-c938-49ca4b48d38a@nisi.nl>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 1 Jan 2019 16:23:39 -0500
Message-ID: <CAKb7UvjMCGOdKybtUrV9DRY1vjiQvi+pkzf2FCHefdedqMGnig@mail.gmail.com>
Subject: Re: Nouveau module results in total lockups without any dmesg trace
 on a NP900X5N Kaby Lake machine
To:     Jan Vlietland <j.vlietland@nisi.nl>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 4:06 PM Jan Vlietland <j.vlietland@nisi.nl> wrote:
>
> Hi Ben, David and Daniel ,
>
> First of all happy new year. Based on advice of Greg K-H herewith a mail
> about a number of Nouveau issues with my laptop.
>
> I installed various Kali linux versions up to Linux 4.20.0-rc7
> (downloaded, compiled and installed) on a Samsung NP900X5N laptop and
> have an issue with the driver after loading.
>
> My configuration:
>
> - i7 7500
> - 16 gb / 256 gb ssd
> - nvidia 940MX (for 3D graphics)
>
> When I enable loading of the nouveau module for my Nvidia 3D card I get
> three MMIO faults:
>
> [   35.984104] nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 6013d4 [ IBUS ]
> [   35.997510] nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 10ac08 [ IBUS ]
> [   37.551790] nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 619444 [ IBUS ]
>
> I see currenty varous discussions on bugzilla: (as summarized by Bruno
> Pagani) https://bugs.freedesktop.org/show_bug.cgi?id=100423.
>
> But I do not see any confirmed solutions on the MMIO faults.
>
> The module is loaded but X server cannot run in framebuffer mode. I
> assume that the module does not provide any video memory to X to run in
> graphics mode.
>
> First of all I would like to understand what the faults impose.
> And I also would like to help you providing testing to fix the errors.

The faults are, generally, nothing to worry about, esp if they occur
infrequently. It's one bit or another of code that's poking at a part
of the GPU it shouldn't be touching.

To the best of my knowledge, 940MX (GM108) should work reasonably
well. Perhaps it would make most sense if you posted about some of
your other issues (usually GM108's are have no outputs, so only usable
as offload devices). Feel free to join #nouveau on irc.freenode.net to
get more info as well.

Cheers,

  -ilia
