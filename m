Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F59C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5FE2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CHwma98E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfAYWXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:23:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43227 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYWXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:23:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so8528672eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TGMnnI7HYKREogizUUSAYUvAzDtz+zujZiO2hJ98R/8=;
        b=CHwma98EkJIGeDpDLPo6aSz7td263eRiQ13ukYJpJKcuTyV8ZBlvucDL7x3FqkqZjf
         uCMmczvJx163kcejhd8ED5FMsgr2IjjgmFtGyn659OJthUCAVhuvRSR2oLgdxN73G85T
         iBOb5F4vXs58A6C7KUk8kHJEa/hGN955sIp/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TGMnnI7HYKREogizUUSAYUvAzDtz+zujZiO2hJ98R/8=;
        b=nS99g2QJ9T1qb+oJqZolW04w+LQuEf8JCnDoddYlJEd+eK7uK2dthK9tRqMzKgLdSj
         JJUeQum5/sEHBt/0RCTvIq/pYvQmDCB1Egj7+MsQgzeFmY6RPQMNdDs1AWK6dV/Zwc61
         z9Rt6HKzC72mSKw8sAZDgKKgPsyIUbZhOwCsZGa6sTUuNBjmGI2iPYqdTWiWd/EsBW0e
         bCmAcd4FXIxeGcmB1D2tl9Oyg5MvKAdXSdnEULliouq3hYaSFkEBYW+5lc2HxuqtE/6j
         2lhnmSKqU61v71hoqBNwxfIEnNkFOWPt1xihdBKsTuylNBISxJM43dCalLXq9N2uMIMw
         +cUw==
X-Gm-Message-State: AJcUuke2AckeRyguY8QoTw5Z3G1tEmvVB4ZdNDtYFWeZOa92O4+L3+17
        suRyrMlgXRY67ZUqEksCWaOMCg==
X-Google-Smtp-Source: ALg8bN7B6iPsUS4hSiKb4zcXL6pjkBb4lZsJ1xIDFlLwBIzaWK6TKElYmCqLA7McVHGhIsEnJDydeA==
X-Received: by 2002:a50:d085:: with SMTP id v5mr12242132edd.61.1548455020198;
        Fri, 25 Jan 2019 14:23:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y16sm11992103edb.41.2019.01.25.14.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 14:23:39 -0800 (PST)
Date:   Fri, 25 Jan 2019 23:23:37 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Olof Johansson <olof@lixom.net>
Cc:     linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com
Subject: Re: [PATCH 1/5] drivers/accel: Introduce subsystem
Message-ID: <20190125222337.GI3271@phenom.ffwll.local>
Mail-Followup-To: Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>, ogabbay@habana.ai,
        airlied@redhat.com, jglisse@redhat.com
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
 <20190125181616.62609-2-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125181616.62609-2-olof@lixom.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:16:12AM -0800, Olof Johansson wrote:
> We're starting to see more of these kind of devices, the current
> upcoming wave will likely be around machine learning and inference
> engines. A few drivers have been added to drivers/misc for this, but
> it's timely to make it into a separate group of drivers/subsystem, to
> make it easier to find them, and to encourage collaboration between
> contributors.
> 
> Over time, we expect to build shared frameworks that the drivers will
> make use of, but how that framework needs to look like to fill the needs
> is still unclear, and the best way to gain that knowledge is to give the
> disparate implementations a shared location.
> 
> There has been some controversy around expectations for userspace
> stacks being open. The clear preference is to see that happen, and any
> driver and platform stack that is delivered like that will be given
> preferential treatment, and at some point in the future it might
> become the requirement. Until then, the bare minimum we need is an
> open low-level userspace such that the driver and HW interfaces can be
> exercised if someone is modifying the driver, even if the full details
> of the workload are not always available.
> 
> Bootstrapping this with myself and Greg as maintainers (since the current
> drivers will be moving out of drivers/misc). Looking forward to expanding
> that group over time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>

I spent a bit of time reading the proposed drivers, mostly just their uapi
(habanalabs and ocxl&cxl), and there's really no technical difference I
think between an accelaration driver sitting in drivers/gpu and an
accelaration driver sitting in drivers/accel. Except:

- drivers/gpu already has common interfaces for the things you'll probably
  want to standardize (buffer sharing, syncronization primitives,
  scheduler - right now we're working on figuring out some common
  tracepoints).

- Maybe even more important, drivers/gpu has the lessons learned in its
  codebase about what not to standardize between drivers (everything else,
  you'll regret it, we've been there).

- drivers/gpu is the subsystem with 20 years of experience writing tiny
  shim drivers in the kernel for high performance accelarators that need a
  pretty huge stack in userspace to make them do anything useful. 20 years
  ago all the rage to make faster was graphics, now it's AI. Looks exactly
  the same from a kernel pov - command buffers, gigabytes of DMA and a
  security/long term support nightmare.

- drivers/gpu requires open source. The real thing, not some demo that
  does a few DMA operations.

And now we have drivers/accel and someone gets to explain to nvidia (or
arm or whatever) how their exact same drivers (and well run engineering
orgs really only invent command submission once) can be merged when they
say it's for a TPU, and will get rejected when they say it's for a GPU. Or
someone gets to explain to TPU+GPU vendors why their driver is not cool
(because we'd end up with two), while their startup-competition only doing
a TPU is totally fine and merged into upstream. Or we just stuff all the
kernel drivers for blobby userspace into drivers/accel and otherwise
ignore each another.

I guess that last option would at least somewhat help me, since I wont
ever have to explain anymore why we're the radical commies on dri-devel
:-)

Anyway, only reason I replied here again is because I accidentally started
a private thread (well was too lazy to download the mbox to properly
reply), and that's not good either. But I don't think anyone's going to
change their opinion here, I think this reply is just for the record.

Cheers, Daniel

PS: Seen that there's a v2 of this now with Documentation, hasn't reached
my inbox (yet). I don't think that one clarifies any of the tricky
questions between drivers/gpu and drivers/accel, so figured won't harm if
I leave the reply on v1.


> ---
>  MAINTAINERS            |  8 ++++++++
>  drivers/Kconfig        |  2 ++
>  drivers/Makefile       |  1 +
>  drivers/accel/Kconfig  | 16 ++++++++++++++++
>  drivers/accel/Makefile |  5 +++++
>  5 files changed, 32 insertions(+)
>  create mode 100644 drivers/accel/Kconfig
>  create mode 100644 drivers/accel/Makefile
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddcdc29dfe1f6..8a9bbaf8f6e90 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7033,6 +7033,14 @@ W:	https://linuxtv.org
>  S:	Supported
>  F:	drivers/media/platform/sti/hva
>  
> +HW ACCELERATOR OFFLOAD SUBSYSTEM
> +M:	Olof Johansson <olof@lixom.net>
> +M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +L:	linux-accelerators@lists.ozlabs.org
> +S:	Supported
> +F:	drivers/accel/
> +F:	Documentation/accelerators/
> +
>  HWPOISON MEMORY FAILURE HANDLING
>  M:	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>  L:	linux-mm@kvack.org
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 4f9f99057ff85..3cc461f325569 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -228,4 +228,6 @@ source "drivers/siox/Kconfig"
>  
>  source "drivers/slimbus/Kconfig"
>  
> +source "drivers/accel/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 04da7876032cc..e4be06579cc5d 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -186,3 +186,4 @@ obj-$(CONFIG_MULTIPLEXER)	+= mux/
>  obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
>  obj-$(CONFIG_SIOX)		+= siox/
>  obj-$(CONFIG_GNSS)		+= gnss/
> +obj-$(CONFIG_ACCEL)		+= accel/
> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> new file mode 100644
> index 0000000000000..13b36c0398895
> --- /dev/null
> +++ b/drivers/accel/Kconfig
> @@ -0,0 +1,16 @@
> +#
> +# Drivers for hardware offload accelerators
> +# See Documentation/accel/README.rst for more details
> +#
> +
> +menuconfig ACCEL
> +	bool "Hardware offload accelerator support"
> +        help
> +	  HW offload accelerators are used for high-bandwidth workloads
> +	  where a higher-level kernel/userspace interface isn't suitable.
> +
> +if ACCEL
> +
> +comment "HW Accellerator drivers"
> +
> +endif
> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> new file mode 100644
> index 0000000000000..343bbb8f45a14
> --- /dev/null
> +++ b/drivers/accel/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for accel devices
> +#
> +
> -- 
> 2.11.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
