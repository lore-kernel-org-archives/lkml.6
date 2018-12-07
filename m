Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6293C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D8320837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgsjKIFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D8320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLGXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:25:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41120 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:25:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so5362175otk.8;
        Fri, 07 Dec 2018 15:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qe0ACQZfyNvg5zbmOoLlaU3tWbDrKhhv2hmO8MfdFGg=;
        b=LgsjKIFJ/CrOa7fVuG0DScvLPmSRgiGdBHmwNq2OmHJb3jsULY+LcUM9kVJC1dWjNb
         KkoFPKBJwPHBRMrUiEZaTBDd3g1PbvoOPnpQfxKJuJeGcrtfc82rwC1mfAvJDlA1NWWB
         pKxyTSZN0WURtk3GacAtrNaBmBajuJrmmqadklLeNF4jp2TDTUwQZGFh3WFCJDD/e0zi
         inrI5b/3sfNZaSQD8Yt0+SNkQL1o/BRGcqEtMYlg8erEJsG4AbTBLxbQ1a2s6GXc3P3l
         XGjUWmbxQR1cbM5YZAnwgWR6cUQy+ow6CW1HD+GIBYsfImq6ZrHflb3h6nUS3JSlnjGI
         +mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe0ACQZfyNvg5zbmOoLlaU3tWbDrKhhv2hmO8MfdFGg=;
        b=I+EKqcKepwAw5OiBmLJHMT/jYUEXN1TKBxuzzR2Swo2N2IHAyM01OVsFKIFC3ATe8O
         CP6OgAgYRhVyI6ur5vSUcCiHfLsYFYJhFkvklU/0R6iEKRLTYV903diGtcMlzCkPuttr
         UxPihbBUl7cHNh+9baU3QQTVVtgxgwvOSlumPCM2+RVIxRSfx2xk56PPkz63BAhuZeIZ
         htA5rAdClCNC6vNdlgfzCubrSURMz0HFhAEkpTVhCQmfYk+gN2wxPLv45pdYRLHJKDvF
         Xfx4bcsgiBJXZQ9Vm9NYJWPCxm8KEa3s/836XEguyajJPsXew6Aq90hhuxJynvQR7UsN
         3Acg==
X-Gm-Message-State: AA+aEWZadcgLd9e61TdE+BL2HCkqBJ3Yo7TC0UfQa6LmIf9k8BuDSGEo
        h4VFh90/GFHyRfUPVkEP0rDnSg9KDywvxKkZh9w=
X-Google-Smtp-Source: AFSGD/UiF25joLw3rdcLWHClw9dmtWXr/cPRsGbTMpcYSvD6K7HKDkfLF9Q/+ov6Q3J2UBn5iAYKU8Ry/n3MOj8/dMw=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr2864107oty.203.1544225121368;
 Fri, 07 Dec 2018 15:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20181204151702.8514-1-jonathan@marek.ca> <20181204151702.8514-4-jonathan@marek.ca>
In-Reply-To: <20181204151702.8514-4-jonathan@marek.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 7 Dec 2018 21:25:10 -0200
Message-ID: <CAOMZO5CoBj4OJ++kKgzfksJ6seqKHJN0W-4YwTKKSrwUkM6gMw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] ARM: dts: imx5: add gpu nodes
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org,
        Chris Healy <Chris.Healy@zii.aero>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 1:20 PM Jonathan Marek <jonathan@marek.ca> wrote:
>
> This adds the gpu nodes for the adreno 200 GPU on iMX51 and iMX53, now
> supported by the freedreno driver.
>
> The compatible for the iMX51 uses a patchid of 1, which is used by drm/msm
> driver to identify the smaller 128KiB GMEM size.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
