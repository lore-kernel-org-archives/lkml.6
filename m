Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA7BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3338320882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544195970;
	bh=GgQpZyggwvg1c0v49la1/Do0wIB1W4l6a9s+oeWC3Nk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=teNg3IBznVl5O4BGC60+Gf3Xsa2vTiHN1I4t78hpfjPNh8wc4+J74ALbNb8/E7K+C
	 wVh+WICMyARUyPECxw6HuEYJl3I4mOcfgMlMJIWDfNfD0VkR0PaFPdY4T7rFfO7Kgl
	 R8nHMRbOY9vGn+QkDt5MtqAKFzJRTY5F5dmUrzjE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3338320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLGPT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeLGPT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:19:28 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E3720892
        for <linux-kernel@vger.kernel.org>; Fri,  7 Dec 2018 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544195968;
        bh=GgQpZyggwvg1c0v49la1/Do0wIB1W4l6a9s+oeWC3Nk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hxdymbnMnfE9jqddXW+qQm04hAtP4VehwN1GOT9aMrVRtDNMvIQ/do8yIYUKPynyc
         h945N9F9juBjJHyeoLiLkC7HoBLhC6qUtlRhiyHyUCyyNkY8kKju3yatykceHMJBeF
         3zQwNNMQPrfeSkBBJ3WwERmlwGRW2xyBx4jN9zUM=
Received: by mail-wm1-f51.google.com with SMTP id f81so4867958wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 07:19:27 -0800 (PST)
X-Gm-Message-State: AA+aEWaCkQrDDf8wdRUj9P0anrE9cjfFhF+J11b6D9gWWqdlofOeRQvc
        mreP/JGeGmDIo7pR3RiQLOtHj8fBzEkMaDT2NXXmVA==
X-Google-Smtp-Source: AFSGD/U8lJakSrxUD2N+1NYCVYC5+M6Wc1YI0Km9KFosyibzJNEgDZRzTD7kyaYrAMCKJWNR/Gz4KXE4yvyC5V+lLDc=
X-Received: by 2002:a1c:b687:: with SMTP id g129mr2543595wmf.59.1544195966260;
 Fri, 07 Dec 2018 07:19:26 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com>
 <20181207000104.GA10814@bogus> <alpine.DEB.2.21.9999.1812061645070.29609@viisi.sifive.com>
 <CAL_JsqJgt3VxHLcxY54Ojpqz_bLwGSySZ9meowgy6pnLPdXuLQ@mail.gmail.com> <alpine.DEB.2.21.9999.1812070624180.16511@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1812070624180.16511@viisi.sifive.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Dec 2018 09:19:14 -0600
X-Gmail-Original-Message-ID: <CABGGisyc-nLZkxtJAr5-BT4ziJO1AW6MU-4ChgBV73No67y0PA@mail.gmail.com>
Message-ID: <CABGGisyc-nLZkxtJAr5-BT4ziJO1AW6MU-4ChgBV73No67y0PA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
To:     paul.walmsley@sifive.com
Cc:     devicetree@vger.kernel.org, palmer@sifive.com, megan@sifive.com,
        wesley@sifive.com, Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        paul@pwsan.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 8:31 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> On Fri, 7 Dec 2018, Rob Herring wrote:
>
> > On Thu, Dec 6, 2018 at 6:46 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > > On Thu, 6 Dec 2018, Rob Herring wrote:
> > > > On Wed, Nov 21, 2018 at 05:06:56PM -0800, Paul Walmsley wrote:
> > > >
> > > > >  .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
> > > > >  1 file changed, 38 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> > > >
> > > > Use the path that was suggested.
> > >
> > > Could you remind me which one that is?
> >
> > In this thread: bindings/riscv/sifive/
>
> SiFive also produces ARM-based SoCs.  Some of those ARM SoCs may use these
> IP blocks from sifive-blocks as well.  As far as I know, there's nothing
> RISC-V-specific about most of these IP blocks.  (As an example, there's
> nothing CPU architecture-specific about a UART.)

Fair enough. As-is is fine.

Rob
