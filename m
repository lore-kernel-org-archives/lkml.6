Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B120C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB14220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1Jon3Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB14220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeKGHYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeKGHYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:24:49 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414AD20862;
        Tue,  6 Nov 2018 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541541449;
        bh=2XOKHhV4+27AGs+8QD6s/rcIOi1MHc1JnYnso7P0mds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X1Jon3CmZuRuKTbCid4dQRz2pCd9IJNFYuS3k40npFOnj+TrXtFLdl+RS5Jpc8qWw
         P1JaRD/viNDMs7y3qbq/+hFEl7VuY/bFzGhqSZ0AvxCJmhKLChVBObUvwq13dXrasd
         9lOIw1n1N0+XDiMfu2TGQnRGPT7qZfBNN3VaKInM=
Received: by mail-qt1-f174.google.com with SMTP id l11so4499354qtp.0;
        Tue, 06 Nov 2018 13:57:29 -0800 (PST)
X-Gm-Message-State: AGRZ1gJjDnWgrxGa9tYoECwl/oEZ6WsBzYVHpQBEQHk776yXf+WvaN9b
        MUVicMeO1iI/s8ejZXnP0thUSoEXKBbR/rzotg==
X-Google-Smtp-Source: AJdET5ebPPTkDTJguHqnF9YPNHdR+x2pzY3ncNJAYP32u4fc3gdYcrEvZIe3FvNWqLyoTs0qHxSD3oi3s1934OD+s88=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr27857174qts.144.1541541448517;
 Tue, 06 Nov 2018 13:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20180928225044.20132-1-robh@kernel.org> <20181001081659.GW11082@phenom.ffwll.local>
In-Reply-To: <20181001081659.GW11082@phenom.ffwll.local>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Nov 2018 15:57:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJaoXd5xhhi1kvLHrRiMh1BTbnQ=p8Oz9893uVMJ1UpEQ@mail.gmail.com>
Message-ID: <CAL_JsqJaoXd5xhhi1kvLHrRiMh1BTbnQ=p8Oz9893uVMJ1UpEQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: Convert to using %pOFn instead of device_node.name
To:     Sean Paul <sean@poorly.run>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 3:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Sep 28, 2018 at 05:50:44PM -0500, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > For drm_modes.c, the full node path is already printed out, so printing
> > just the node name a 2nd time is redundant and can be removed.
> >
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Acked-by: Rob Clark <robdclark@gmail.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: freedreno@lists.freedesktop.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> > - Add to commit msg that we're dropping redundant printing of node name.
>
> Applied, thanks for the patch.

It appears this hasn't been.

> Aside, still don't want drm-misc commit rights so you can offload these
> yourself?

No thanks.

Rob
