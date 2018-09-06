Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EDCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A972B2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d915Tg8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A972B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeIFPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeIFPsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:48:01 -0400
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com [209.85.216.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D55D20857;
        Thu,  6 Sep 2018 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536232384;
        bh=flz+0719QiJsdJbk83y9AaUb8jRz8QeOKqh6ieJYj6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d915Tg8rkJVzxdJkiYphVOW4p00aBMLQzvcJNeXwqjmVlSd2UUduPfDoH1A71nHDg
         4PT+X/RoEIa6tHlbbJT14M7wudnCYqWaNvcSXQR4jgLA34BOv1SejcSUW5ZcTWborZ
         h8Wn4uDl36F/AVaULKzUm+fQj8CotH5RO+AJ3fQA=
Received: by mail-qt0-f169.google.com with SMTP id x7-v6so11713147qtk.5;
        Thu, 06 Sep 2018 04:13:04 -0700 (PDT)
X-Gm-Message-State: APzg51AsbBY2BwNPIZnXnP8R7cPLVA9StMDR35H6c6M0ChfBYn6EeDFt
        sMn5uczZvHT8SXJK1RFW6IaqlEVjY2GyezyK0w==
X-Google-Smtp-Source: ANB0VdaJWjhEWqihAwwIYmoBq6HY2sWe24a/d8uqV4u/rBe1prcNJgC/lvbL/R8t6tGOSSZYz3l6bkRaVNwxFKYFBds=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr1576509qtd.101.1536232383452;
 Thu, 06 Sep 2018 04:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-19-robh@kernel.org>
 <20180906083506.GA10768@zn.tnic>
In-Reply-To: <20180906083506.GA10768@zn.tnic>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Sep 2018 06:12:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKNh+89dRef3RNx1YUfhD0yJ8BHsanUaGMfrF_EGPCHcA@mail.gmail.com>
Message-ID: <CAL_JsqKNh+89dRef3RNx1YUfhD0yJ8BHsanUaGMfrF_EGPCHcA@mail.gmail.com>
Subject: Re: [PATCH 18/21] edac: cpc925: use for_each_of_cpu_node iterator
To:     Borislav Petkov <bp@alien8.de>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 3:35 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 05, 2018 at 02:37:35PM -0500, Rob Herring wrote:
> > Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> > has the side effect of defaulting to iterating using "cpu" node names in
> > preference to the deprecated (for FDT) device_type == "cpu".
> >
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: linux-edac@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack and I will take via the DT tree. This is dependent on the
> > first 2 patches.
>
> Completely unknown territory for me so I'd trust your judgement. Staring
> at 1/21, the conversion looks ok except the removal of those prints that
> a cpu nodes are not present - I wonder if they even meant anything or
> were just there during driver development...

I should have noted this. It's not the kernel's job to validate the DT
and certainly not some driver's job to validate cpu nodes. It's bad
enough that some random driver is parsing cpu nodes. If they are
missing or are crap, you should get warnings or messages well before
this point.

Rob
