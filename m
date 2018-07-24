Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08412C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D0020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hshK14Ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D0020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbeGXUEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:04:21 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46944 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbeGXUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:04:21 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so9398768oie.13;
        Tue, 24 Jul 2018 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fxqKepJb2RiPNe+Z61HOZv5+tXaL71PJhWLvpeAgRmY=;
        b=hshK14EeEUeXcK6G+WIcOf1SoU+P47oyHq31XHu+6ardWoJFPTHJWO2/++NE+YzTKB
         3bf8Yl2zgbd91G6AH7N5/ZwE2uNjz2km+fEkgEafvtXuzZK6xCadhMgDDJyHCi/reG/G
         KvIR+rRDCvkGRFBXiaCcnAtLQvWlxrJQE76B0ihOpSoe7GGJF+PvxCUECKSVHQhA5hGB
         M/U+cQdxRDUfbmRfViNUoU97xynWj0to0+ySvR5TkEH1hZbcuw0Fl/T+0ht9fz19HBN/
         dXgNRZDCMU0mgql3qM743S8PK05uPQ0kprvenA5ll4kbOstca4dpFAIPVDGY9rlmZ2Jp
         qh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fxqKepJb2RiPNe+Z61HOZv5+tXaL71PJhWLvpeAgRmY=;
        b=cqa3P3lYQQWEM+NheClY7A1nR2rkHCzNeQsgBUMLm3JWd1afhG6K+lTVyp1hD0pDTa
         EoqZtEj++bhtpof3kafZc0NaxBEZ3ujCNJieMFtAupFvJyo6fRz0c/r91CABBYgriJ+J
         KQ/pSprSlXh4blNJxVUrJwkaaHaYHERa+2enA4n7R3vodr0bsMY1uWKw01UblAF4Klhf
         FU4QuL8svxSGdBd8hzzd2BGEZIRW1Gu7kYZA4biuvJsQzZ2MRJOVZPgURoB6bJjCpCCc
         FdnlqfjG5KpUV9fcuLkyTpylU4M48tkHFyxxE/x/3Hm3c8ZpHdrNQz57LeYcOCKVsmsL
         PF2A==
X-Gm-Message-State: AOUpUlFtL4rMKGm2qbIQzMC14m0ugROTyUy6Ly4psrPPy/hrTDxsnL4K
        UUICYmRkyXhC4uejbc7TI5whqzLrRqZMxUZApQQ=
X-Google-Smtp-Source: AAOMgpf68IY8uLA6Kaj8SCzBE+amHDv2WbITV45VI8Gfuw4ScMG4Aa0UQYLnC9BAPJU7RUaJZ37DYbYz2SCf174CAfg=
X-Received: by 2002:aca:4455:: with SMTP id r82-v6mr86395oia.260.1532458590263;
 Tue, 24 Jul 2018 11:56:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 11:56:09 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1807231444150.1328-100000@iolanthe.rowland.org>
References: <CAJs94EZEqWEscECp7bsJ3DvqoU83_Y2WQ55jPaG4MyoG-hvLFQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1807231444150.1328-100000@iolanthe.rowland.org>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Tue, 24 Jul 2018 21:56:09 +0300
X-Google-Sender-Auth: __iqG8QUM870rK3_J2OV1syo2OE
Message-ID: <CAJs94EahjbkJRWKR=2QeD=tOMR=kznwXbQgTbKvSuTg4jBk1ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
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

2018-07-23 21:57 GMT+03:00 Alan Stern <stern@rowland.harvard.edu>:
> On Mon, 23 Jul 2018, Matwey V. Kornilov wrote:
>
>> I've tried to strategies:
>>
>> 1) Use dma_unmap and dma_map inside the handler (I suppose this is
>> similar to how USB core does when there is no URB_NO_TRANSFER_DMA_MAP)
>
> Yes.
>
>> 2) Use sync_cpu and sync_device inside the handler (and dma_map only
>> once at memory allocation)
>>
>> It is interesting that dma_unmap/dma_map pair leads to the lower
>> overhead (+1us) than sync_cpu/sync_device (+2us) at x86_64 platform.
>> At armv7l platform using dma_unmap/dma_map  leads to ~50 usec in the
>> handler, and sync_cpu/sync_device - ~65 usec.
>>
>> However, I am not sure is it mandatory to call
>> dma_sync_single_for_device for FROM_DEVICE direction?
>
> According to Documentation/DMA-API-HOWTO.txt, the CPU should not write
> to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() is
> not needed.

Well, I measured the following at armv7l. The handler execution time
(URB_NO_TRANSFER_DMA_MAP is used for all cases):

1) coherent DMA: ~3000 usec (pwc is not functional)
2) explicit dma_unmap and dma_map in the handler: ~52 usec
3) explicit dma_sync_single_for_cpu (no dma_sync_single_for_device): ~56 usec

So, I suppose that unfortunately Tomasz suggestion doesn't work. There
is no performance improvement when dma_sync_single is used.

At x86_64 the following happens:

1) coherent DMA: ~2 usec
2) explicit dma_unmap and dma_map in the handler: ~3.5 usec
3) explicit dma_sync_single_for_cpu (no dma_sync_single_for_device): ~4 usec

So, whats to do next? Personally, I think that DMA streaming API
introduces not so great overhead.
Does anybody happy with turning to streaming DMA or I'll introduce
module-level switch as Ezequiel suggested?


>
> Alan Stern
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
