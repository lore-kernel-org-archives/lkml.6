Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5783FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156AA20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156AA20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeLACY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:24:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46272 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeLACY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:24:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so6212317qtm.13;
        Fri, 30 Nov 2018 07:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdlcLVklW4vsZoUcRi5bxbieMbDImHs2cXbFZBaov0A=;
        b=NF8o4sTnykpDSiJVUuT8dU+gR6DgwhtpgrLfyStehmGMHl5N/W1gUVTI01qocimQSG
         Pp/JbpsDWNFilYtvG4w6ZVsmeGNnUlGtvc3ffHElVbDGafoQqRAQq9Bliiys0nj3Pgg6
         rZ53HNcwbDLsLAEpsHDmmHDfHIwPCn9/Ce/hLp2vwSZ9w4DVFFgsPnmu0uW0e9y5HjIs
         mCOFL7eL13N8p5K7HoLYPY4ppcWZfO3OD8xrDnSLurkrvaoq6FGIvWtx+L6PfQee2sEc
         z6u8T3ygzJkaGwbJJlx9bn2oipf8d4jgGJR7KSCnazZyX/yRrw7rkH4irrO/MgMRC1M2
         WF6Q==
X-Gm-Message-State: AA+aEWbpHW/fdu847P/Iavo6Y4cl2oi4y0cmxlForwDFJu9yb/rQqesJ
        FgBVIDHMo7pbD40RUojq9KoiTsQLMGCJXKIJBcQ=
X-Google-Smtp-Source: AFSGD/WWXAyVzIHykEePVGfS1z1MbMJNHjYZTGHIaVKPcSeSW27d+/u8PCkprUQHCZlRIxfv9BFwki1h2NvFbmFWwZo=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr5750541qtl.343.1543590888570;
 Fri, 30 Nov 2018 07:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20181130150050.13762-1-robdclark@gmail.com> <20181130150050.13762-3-robdclark@gmail.com>
In-Reply-To: <20181130150050.13762-3-robdclark@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 16:14:30 +0100
Message-ID: <CAK8P3a2ePkk21bz=N=97aMGJVoxSu-cULjLZbf03W4jhSQAGJA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/msm: rework GEM_INFO ioctl
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 4:02 PM Rob Clark <robdclark@gmail.com> wrote:
>

> -
> -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> +/* Get or set GEM buffer info.  The requested value can be passed
> + * directly in 'value', or for data larger than 64b 'value' is a
> + * pointer to userspace buffer, with 'len' specifying the number of
> + * bytes copied into that buffer.  For info returned by pointer,
> + * calling the GEM_INFO ioctl with null 'value' will return the
> + * required buffer size in 'len'
> + */
> +#define MSM_INFO_GET_OFFSET    0x00   /* get mmap() offset, returned by value */
> +#define MSM_INFO_GET_IOVA      0x01   /* get iova, returned by value */
>
>  struct drm_msm_gem_info {
>         __u32 handle;         /* in */
> -       __u32 flags;          /* in - combination of MSM_INFO_* flags */
> -       __u64 offset;         /* out, mmap() offset or iova */
> +       __u32 info;           /* in - one of MSM_INFO_* */
> +       __u64 value;          /* in or out */
> +       __u32 len;            /* in or out */
>  };

As structure with implicit padding has the problem of possibly leaking
kernel stack data. It's better to make the padding explicit here so you
can zero it from the kernel. Also, as I mentioned in the other patch,
you probably need a new data structure and ioctl command number
to keep compatiblity with the old interface.

     Arnd
