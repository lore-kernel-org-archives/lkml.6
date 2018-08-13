Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B28C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0762177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFef4/I6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0762177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbeHMVzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:55:01 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44464 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeHMVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:55:00 -0400
Received: by mail-ua1-f66.google.com with SMTP id k25-v6so10436789uao.11;
        Mon, 13 Aug 2018 12:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hlts2vVqRNc+1czg7+T2beLKaIz2Lb2dXUkZ9YYcsHs=;
        b=PFef4/I69VNiMRNq7FExxPF6wxWh3TkXLAVll1oJb4uUV6i7DNQfNuIzy40/g1JqGC
         GveRpxheiG6Y8NninwBwQjqQeKVUZvCuEiBCKuU1thBx0hNcSvgWZCMDuR0ZeFz8m+PW
         G9jtWqRkXmyOHLr1JfWddKOBIZzeVP9FSI3ywFws4+QQ/0ZOUiyAF0BhebN1ENK/01Qw
         JMDghsFZnywn5AJF4WTQoPCDM0H4uK9/L8umwjXyARHwHRy/D0d1+RT3Z4BWp7+FRhEr
         mbN63Wkgw13Cl/r836+RSMrwe0+SJdYa0fu0wt6eTdIK6LKvl0yl9E42nlGPufoTYR8I
         6+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hlts2vVqRNc+1czg7+T2beLKaIz2Lb2dXUkZ9YYcsHs=;
        b=AlscDt/unb+6davnC0jC1jh/uKZU0KhxGSLbw4Tki227Rb7JfV1Pqf05BpcjooO7hW
         ynlXJH6t45kPvZLRownA13qoUsoCMw2fCScrxu9NA+8qs9K3pdwFBPXZ28LJUsv4mENr
         YNR3tlPBWIcq0452zM/FemYCHdpuF8G0eKPC1dkN8XEQHcjgvDysyL1mdeCgMikC0k/Q
         RLmkxeW4UlSC9XUP3pMbtmxvA31KTWs5buoyrtzv7/L9OCnVTtCVBWrFXAuYF9uc7dM6
         Fd4bUHc61cejwK+6FGekbzlpXvER+E8wZq1o/7ShlDlrX2D8iV5t7VwOZUs5ixJ1uvOW
         kaSg==
X-Gm-Message-State: AOUpUlEBLSPTRNYgPRPuHcfQjullJaVTc5+TffbDVSu8Hg6oOVyfeldF
        al4bk39p6lmqwlSM8WZ/rQL0gsZQ6AZdepT4/WNQWA==
X-Google-Smtp-Source: AA+uWPynFdWONBMUmmUmDiNM0SNOWNrygt7Zjz/n9avL/0SG4raVAsSiqMgVIjSB8iYYRnB2keRP7mq1mVEsffufYBE=
X-Received: by 2002:a1f:a94b:: with SMTP id s72-v6mr11917783vke.122.1534187489096;
 Mon, 13 Aug 2018 12:11:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2358:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 12:11:28
 -0700 (PDT)
In-Reply-To: <20180813190706.24172-4-lyude@redhat.com>
References: <20180813190706.24172-1-lyude@redhat.com> <20180813190706.24172-4-lyude@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 13 Aug 2018 15:11:28 -0400
X-Google-Sender-Auth: BHiGKIGx4vsG4gudum513JTiFG0
Message-ID: <CAKb7UvjqVC5w4PDaVLtZqKs94bo22d4BGYgsQj9K-2_rksoqvg@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] drm/nouveau: Fix deadlock with fb_helper with
 async RPM requests
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "# 3.9+" <stable@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 3:07 PM, Lyude Paul <lyude@redhat.com> wrote:
> +bool
> +nouveau_fbcon_hotplugged_in_suspend(struct nouveau_fbdev *fbcon)
> +{
> +       bool hotplug;
> +
> +       if (!fbcon)
> +               return false;
> +
> +       mutex_lock(&fbcon->hotplug_lock);
> +       hotplug = fbcon->hotplug_waiting;
> +       mutex_unlock(&fbcon->hotplug_lock);
> +
> +       return hotplug;
> +}

I'm probably missing it, but where is this function used?
