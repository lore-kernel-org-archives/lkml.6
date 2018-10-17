Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D172ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181352151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181352151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeJQPRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:17:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43570 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeJQPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:17:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id s69-v6so20231704oie.10;
        Wed, 17 Oct 2018 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wWOicmG0opXUUezMjrygOAk3VFTrpPBle/ml4xfyII=;
        b=bGifESik/Sen3wzmzmnhd2yzNdGE2Zxs2AodPyqlVihq3ta2Orm1KMhkEnZgukI0j6
         UnJurbimSzDteK57lpSp+26LQClUO8q51AKdpT8CgkGaU1WZjX0mGVNxMklC7HFWJEb7
         +NnJpPzsIpa6OPIS9faOLzr8s7DaGgS+OHrMu4+BSFAkDohQBg5KlJscGE4kxljslhqg
         lIoL7Uxi06fS7pQdCKEOMKUTQ0bd5nWcomgI15BNC39b3nnVvmooQcAAjcaLXgkZGUc9
         5mZKW7nSnH7GFnUgBkc0BrXxBzJx7W9KOS+j4V81P2gA/bkVCdpTnHzzfSl+OkUj3XTj
         xwAg==
X-Gm-Message-State: ABuFfojbzlVtUf4JRu0KCOkShJGgTnH6Ukmi/PWmijvH/4iVa3a34T/I
        eiVKuM2RGsKe+L+yFpTjniFH5IH8I9+/PfujO18=
X-Google-Smtp-Source: ACcGV62G2aMZN4ZbkFoYz6OIAX/eS6BgyApNutD4juy94opofsDIjmqNCXIUbO15O3W6VylP6kiBDxg49IL2QdjUpAw=
X-Received: by 2002:aca:b655:: with SMTP id g82-v6mr12573024oif.195.1539760969868;
 Wed, 17 Oct 2018 00:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-2-hch@lst.de>
 <CAJZ5v0ju2Y=yQn9uz6HpYGw5BZovxYh2YbYD7Ujq8kajJfvLSQ@mail.gmail.com> <20181017071942.GB23407@lst.de>
In-Reply-To: <20181017071942.GB23407@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Oct 2018 09:22:37 +0200
Message-ID: <CAJZ5v0h=niQOtdMGYWtE4P4NX=-xmgDvga7t2mTAtpbOYWQY0A@mail.gmail.com>
Subject: Re: [PATCH 1/8] cpufreq: tegra186: don't pass GFP_DMA32 to dma_alloc_coherent
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 9:19 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Oct 15, 2018 at 09:43:04AM +0200, Rafael J. Wysocki wrote:
> > On Sat, Oct 13, 2018 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > The DMA API does its own zone decisions based on the coherent_dma_mask.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Can you pick it up through the cpufreq tree?

Sure, I'll do that, thanks!
