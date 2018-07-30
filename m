Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579FBC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D114120881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="enkzUHbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D114120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeG3Fzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 01:55:32 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39516 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeG3Fzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 01:55:32 -0400
Received: by mail-yb0-f195.google.com with SMTP id k124-v6so4251504ybk.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 21:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhwskOzh+cnqLX4ce0ESOWWEyTVi5P+K+pd2aEMqJTE=;
        b=enkzUHbZFupzTnHLitLIu8LoeocSXc1MlI7Xe+sS5Z57fQZb1363cIuP8pM25tkCm/
         Odcs53/wNDUsjb90rUWWgUFRwTaWCVy9zUOAjQ7eQe2WiLUcmNw1lOv96N45vyJ+h34B
         3816a/nvEYN/r/M4aX/thaOznkFgsKRuXCY38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhwskOzh+cnqLX4ce0ESOWWEyTVi5P+K+pd2aEMqJTE=;
        b=hxiTNZMcBDbtTSir98tpaSYB5/Ojp3mY41FRzQuKGuZ+QUJ/nFGFmopB/xhAKW5lyN
         vQ5Gd7LFVggrahzgxIK/g6dyoRtAa8pq1XU+YQEOr02Y34CHA2MeP3Zq9IjRh9tPNFec
         D0U2cRdIAocDy6e66/0Wq+n395ZS0/XfykGCt+9mUEbwZ53VBMe2VsdDsi13TmWRKji0
         h86BrV8uMJrfAZTKO7VZa/LGD/wTu3Je0qZ0TGc/zJG1kkiJThGsM/+OZFNnUKRI4jrn
         iNPy7OQQJ0ySsMEsm2UHBYInaPfIzl0WP8R9D+l6MSM6Eluf6xsliMif/PpQzj1iTjdx
         CFJA==
X-Gm-Message-State: AOUpUlF9ka3upk28wRTElYTkCCrQuGAbN8P/SS2KouNahDleXMxr5b62
        J5FVALjPlBKz37gBERoWHNRzSCuWQyQ=
X-Google-Smtp-Source: AAOMgpeLfdFz6bh6WTo+cglcrLsxrG6TCik5LIKC/cVcMlQ2rUDq5UPP+D4Scuez4OCM7WTKmVXDmQ==
X-Received: by 2002:a5b:bc5:: with SMTP id c5-v6mr8125468ybr.290.1532924548320;
        Sun, 29 Jul 2018 21:22:28 -0700 (PDT)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com. [209.85.161.171])
        by smtp.gmail.com with ESMTPSA id 139-v6sm5470351ywk.41.2018.07.29.21.22.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 21:22:28 -0700 (PDT)
Received: by mail-yw0-f171.google.com with SMTP id t18-v6so3907940ywg.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 21:22:28 -0700 (PDT)
X-Received: by 2002:a0d:dcc3:: with SMTP id f186-v6mr7708778ywe.66.1532924083649;
 Sun, 29 Jul 2018 21:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs94EahjbkJRWKR=2QeD=tOMR=kznwXbQgTbKvSuTg4jBk1ew@mail.gmail.com>
 <Pine.LNX.4.44L0.1807241652550.1311-100000@iolanthe.rowland.org> <CAJs94EZpJgDg0j8sVgOd56OY53mv7VxSODbhtR5MsZnFUoJA+g@mail.gmail.com>
In-Reply-To: <CAJs94EZpJgDg0j8sVgOd56OY53mv7VxSODbhtR5MsZnFUoJA+g@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 30 Jul 2018 13:14:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AKJrCAAFiis-YjKFULPb1zqboPVSgT8Uepg-C561fgeg@mail.gmail.com>
Message-ID: <CAAFQd5AKJrCAAFiis-YjKFULPb1zqboPVSgT8Uepg-C561fgeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>, hdegoede@redhat.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        rostedt@goodmis.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:47 PM Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
>
> 2018-07-24 23:55 GMT+03:00 Alan Stern <stern@rowland.harvard.edu>:
> > On Tue, 24 Jul 2018, Matwey V. Kornilov wrote:
> >
> >> 2018-07-23 21:57 GMT+03:00 Alan Stern <stern@rowland.harvard.edu>:
> >> > On Mon, 23 Jul 2018, Matwey V. Kornilov wrote:
> >> >
> >> >> I've tried to strategies:
> >> >>
> >> >> 1) Use dma_unmap and dma_map inside the handler (I suppose this is
> >> >> similar to how USB core does when there is no URB_NO_TRANSFER_DMA_MAP)
> >> >
> >> > Yes.
> >> >
> >> >> 2) Use sync_cpu and sync_device inside the handler (and dma_map only
> >> >> once at memory allocation)
> >> >>
> >> >> It is interesting that dma_unmap/dma_map pair leads to the lower
> >> >> overhead (+1us) than sync_cpu/sync_device (+2us) at x86_64 platform.
> >> >> At armv7l platform using dma_unmap/dma_map  leads to ~50 usec in the
> >> >> handler, and sync_cpu/sync_device - ~65 usec.
> >> >>
> >> >> However, I am not sure is it mandatory to call
> >> >> dma_sync_single_for_device for FROM_DEVICE direction?
> >> >
> >> > According to Documentation/DMA-API-HOWTO.txt, the CPU should not write
> >> > to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() is
> >> > not needed.
> >>
> >> Well, I measured the following at armv7l. The handler execution time
> >> (URB_NO_TRANSFER_DMA_MAP is used for all cases):
> >>
> >> 1) coherent DMA: ~3000 usec (pwc is not functional)
> >> 2) explicit dma_unmap and dma_map in the handler: ~52 usec
> >> 3) explicit dma_sync_single_for_cpu (no dma_sync_single_for_device): ~56 usec

That's very strange because on ARM dma_unmap_single() does exactly the
same thing as dma_sync_single_for_cpu():

arm_dma_map_page()
https://elixir.bootlin.com/linux/v4.18-rc7/source/arch/arm/mm/dma-mapping.c#L129
arm_dma_unmap_page()
https://elixir.bootlin.com/linux/v4.18-rc7/source/arch/arm/mm/dma-mapping.c#L159

arm_dma_sync_single_for_cpu()
https://elixir.bootlin.com/linux/v4.18-rc7/source/arch/arm/mm/dma-mapping.c#L167

Could you post the code you used for testing of cases 2) and 3)?

Best regards,
Tomasz
