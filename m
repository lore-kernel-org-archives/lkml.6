Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC06C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C06D224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZSTuXTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C06D224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbeKMKCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:02:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36921 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:02:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so9720856wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 16:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RluVWSbr0rGsFQZcKK0R/ty+uAPLUSMU5iV6EPDNbPo=;
        b=QZSTuXTBDVovMCtNPmWqDu3BAWPZ7LpL8bqAMvlLmmbSLlgCk225KK/AOzx9Icw2Mm
         AlK6Z9HHf5Sl2Ffvx/GsWXR4Oc3rEW+v5VUKX6d9UZwbRLZe+qdZB+yS8BHgRfZ7ej3U
         1J5EO4Q9aeSNIFmeR9LgvDs7QbPCD/RwMe2R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RluVWSbr0rGsFQZcKK0R/ty+uAPLUSMU5iV6EPDNbPo=;
        b=NAcjEQfxAIGX6b2ucPdv53wxNOjRDIFjbnrKnWYhJ9bW0OjLN/LSSQaVVGv45mLcDV
         Pe++zY2/ppWKLD9KgD75k+zdpGlh71u7YfwrRAJpwo01CQ1PB7xXCvgM1KD0l3JhnZKy
         vFlrXBu68GX66Tsezi+pqJcDOjS4NSrK3d+uledFqxo5+jVS6TZK366H1t2qJw9XbTbJ
         frEqEuJzYVF48kvMkMIpHZSSfXluOju+GsrrP8kxtHPzSiMvy1C8bhZvXC/9KiBnSc+d
         tlrM+eIjO+Rv/hx9oqJu804X8Jokn/lr9t2eiWuz1ZyK9GR8qEbRF7xo2WVNQ46et41O
         +RTQ==
X-Gm-Message-State: AGRZ1gLPrtxtQfLJnJ1eU2vdVhxeZSR44TrifwJOOo+Z2beek2+HKg4E
        2SJWwnfg+LicJQoo010X2eFvJkzBMqEsqD36jD43JLhOB8RKqQ==
X-Google-Smtp-Source: AJdET5fjAfVQkuO30jLBHVonjbgWRKEroREaSjKEhzTjz7eJeuStzNTL2bjBWPijX9OZPaB4YylhJzODKdKRlR1UJDY=
X-Received: by 2002:a1c:aa4f:: with SMTP id t76-v6mr1364372wme.64.1542067624281;
 Mon, 12 Nov 2018 16:07:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 16:07:03
 -0800 (PST)
In-Reply-To: <20181109074955.GA27489@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com> <20181109074955.GA27489@lst.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 12 Nov 2018 16:07:03 -0800
Message-ID: <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 11:49 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
>> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
>> swiotlb_map_sg_attrs", I reproduce the hangs.
>>
>> Any suggestions for how to further debug what might be going wrong
>> would be appreciated!
>
> Very odd.  In the end map_sg and map_page are defined to do the same
> things to start with.  The only real issue we had in this area was:
>
> "[PATCH v2] of/device: Really only set bus DMA mask when appropriate"
>
> so with current mainline + that you still see a problem, and if you
> rever the commit we are replying to it still goes away?

Just to confirm, as of 4.20-rc2 (which includes the of/device patch
above), I'm still seeing this issue, but it isn't as reliable to
reproduce as before.

With "swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs" reverted
(along with the dependent swiotlb patches) it doesn't seem to trigger
(no matter what I try).  But re-applying that patch it tends to
trigger by itself at boot up, but sometimes I have to run "find /" to
trigger the io hang/stall.

thanks
-john
