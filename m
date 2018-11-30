Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A478C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8CA20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8CA20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeLAAIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:08:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34882 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeLAAIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:08:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so5767231qtc.2;
        Fri, 30 Nov 2018 04:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aerBP6lm7kFFV67ilmw6qMvPj/6mK7eECFqwlSngiE=;
        b=azWlsSAsSQpd3u8ZLFouesv4AHcEXbahtJYFA05O4OS8PqCzovDYl/gOy69mgN2Kv+
         slxT2rR/HGo3ZhE99R8cQIT8mJS3FsP1SCB6eJVPL8KQp2F9f4Ak9BwhRM+kNM6SwcUj
         zFs38z8eB8kXAvp4vVdCbSiJPmSOXc+x5/o+0Qgvw9FmxzwSEJrvRSsKjBV5yyO+0y62
         Yye6hjggLId5FhzGGK6FWViZPxeU1noX9B9xJ6r0gU+BtnoxrBwgB48eUdrge2gP7RDP
         Yo7Cs7ZUyOUNj44ozZKx/2crk7o6WmmXv7t0fuGtg28yrecrH7PiD2ShI9vBWfyz3Qsk
         qN1A==
X-Gm-Message-State: AA+aEWZZcsBPA/Wwu43kMht4wcEfAUJUVfHA2gvesRIQRC+qVBUn0hU7
        brU5f8jbhfTx1Pdq8WfnmUwD2UpKgBlNpZzW7c2CCQ==
X-Google-Smtp-Source: AFSGD/UDaTyRxRMJAkhIW+lMIo8kL46AO7xTn8g8t0J9xtPjhZabfp3LtOX3Z7gvMtjBXRW0F7koYbQytBbE0U6ilKA=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr5120850qtm.96.1543582734532;
 Fri, 30 Nov 2018 04:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org> <20181130104657.14875-7-srinivas.kandagatla@linaro.org>
In-Reply-To: <20181130104657.14875-7-srinivas.kandagatla@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 13:58:36 +0100
Message-ID: <CAK8P3a1XaGHu3NrAeLn0OEg0nL1uae_MyrP7EgadJpfeeXtR2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] char: fastrpc: Add support for compat ioctls
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> From: Thierry Escande <thierry.escande@linaro.org>
>
> This patch adds support for compat ioctl from 32 bits userland to
> Qualcomm fastrpc driver.
>
> Supported ioctls in this change are INIT, INVOKE, and ALLOC/FREE_DMA.
>
> Most of the work is derived from various downstream Qualcomm kernels.
> Credits to various Qualcomm authors who have contributed to this code.
> Specially Tharun Kumar Merugu <mtharu@codeaurora.org>
>
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Can't you just define the native ioctls so that you don't need this.

     Arnd
