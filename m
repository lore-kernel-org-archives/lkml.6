Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327792145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327792145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeLAA4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:56:08 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33241 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeLAA4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:56:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so5945542qtp.0;
        Fri, 30 Nov 2018 05:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIdeg+oMgzcGZ402w5TMrHUL5oRSMJL2//KB9mDZoes=;
        b=tSLMT9SHz9EpAOplIg06FIbcVbkLtQCOE0jhrj1tE5hP7FYDKg64n5egPFgTXgS1Xd
         OxVAZ7enRPlAKK1n1h40eW8kQ0JsTKV62tLRW69p/CAeR7CABP+xr2XV7krKmsaHGkSZ
         /okHL8yGH5B93yYFXtk1+bdOGDzxs2ATAfllz56qBlWqJ1E5jthINdTsie31VzncPYRb
         yOeXz5bowo9wbZEYlKFaj1IBgXC/PmnAHFxJLSh1LMAp8Z55nYiPt2oGJiWUIh2bRTs3
         MQ6/PjXlescvcAV/411QC38idJhHcx707wybg68vVoWESccNl+RLKcDDHI3NJDFsJFiu
         8T/Q==
X-Gm-Message-State: AA+aEWYtMUMGqTjKSDdiis3k91DWKKcMftbet4lRUhS0JNyKC28tyeWM
        gHv3Ax/a1siPOx/9YBq5MswH/Z7qB/FvWbzC9ts=
X-Google-Smtp-Source: AFSGD/X2kpMPFpR2oZ9fumD+JTvVxe3ey9rPmImcW98106+b7N0/KXevriMXlsBSsryOsDF1xeRLynafazSOSieBEdo=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr5413334qtl.343.1543585605559;
 Fri, 30 Nov 2018 05:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-7-srinivas.kandagatla@linaro.org> <CAK8P3a1XaGHu3NrAeLn0OEg0nL1uae_MyrP7EgadJpfeeXtR2Q@mail.gmail.com>
 <2dbd06c5-d094-6d16-2983-131d3ae24c8d@linaro.org>
In-Reply-To: <2dbd06c5-d094-6d16-2983-131d3ae24c8d@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 14:46:27 +0100
Message-ID: <CAK8P3a3DsADgQo7b1B5vWV2Ws8mOpB1ixbi5tR=Z6cfvp+eZpA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] char: fastrpc: Add support for compat ioctls
To:     thierry.escande@linaro.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 2:20 PM Thierry Escande
<thierry.escande@linaro.org> wrote:
> On 30/11/2018 13:58, Arnd Bergmann wrote:
> > On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >> From: Thierry Escande <thierry.escande@linaro.org>
> >>
> >> This patch adds support for compat ioctl from 32 bits userland to
> >> Qualcomm fastrpc driver.
> >>
> >> Supported ioctls in this change are INIT, INVOKE, and ALLOC/FREE_DMA.
> >>
> >> Most of the work is derived from various downstream Qualcomm kernels.
> >> Credits to various Qualcomm authors who have contributed to this code.
> >> Specially Tharun Kumar Merugu <mtharu@codeaurora.org>
> >>
> >> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >
> > Can't you just define the native ioctls so that you don't need this.
>
> There are long time defined structures that are passed as argument to
> these ioctls and their sizes vary between 32 and 64 bits userlands, so
> the ioctl command values.

Where? I don't see them in linux-4.19.

> Unless I'm missing something here this also has the advantage not to be
> compiled if CONFIG_COMPAT is not set.

You can normally just set .compat_ioctl() to the same function as
.unlocked_ioctl(), and get no overhead either way.

    Arnd
