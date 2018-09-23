Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB29DECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 12:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CB02148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 12:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CB02148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeIWSzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 14:55:36 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:48348 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeIWSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 14:55:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8B88C605A91B;
        Sun, 23 Sep 2018 14:58:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6jZS23dOgs5p; Sun, 23 Sep 2018 14:58:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 13AD8605A91A;
        Sun, 23 Sep 2018 14:58:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g7kxiYtZFCmj; Sun, 23 Sep 2018 14:58:08 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B65A76088983;
        Sun, 23 Sep 2018 14:58:08 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Lars Persson <lists@bofh.nu>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martinbayern@outlook.com
Subject: Re: [PATCH 4.9 069/101] ubi: fastmap: Correctly handle interrupted erasures in EBA
Date:   Sun, 23 Sep 2018 14:58:08 +0200
Message-ID: <2076412.mQRaXglRsh@blindfold>
In-Reply-To: <CADnJP=s+Lu8BiKeM6vsVbHtfYQCPudXHqrA+hKbXOR5FLxTK6g@mail.gmail.com>
References: <20180701160757.138608453@linuxfoundation.org> <20180701160759.928145668@linuxfoundation.org> <CADnJP=s+Lu8BiKeM6vsVbHtfYQCPudXHqrA+hKbXOR5FLxTK6g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lars,

Am Sonntag, 23. September 2018, 14:49:23 CEST schrieb Lars Persson:
> On Sun, Jul 1, 2018 at 6:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Richard Weinberger <richard@nod.at>
> >
> > commit 781932375ffc6411713ee0926ccae8596ed0261c upstream.
> >
> > Fastmap cannot track the LEB unmap operation, therefore it can
> > happen that after an interrupted erasure the mapping still looks
> > good from Fastmap's point of view, while reading from the PEB will
> > cause an ECC error and confuses the upper layer.
> >
> > Instead of teaching users of UBI how to deal with that, we read back
> > the VID header and check for errors. If the PEB is empty or shows ECC
> > errors we fixup the mapping and schedule the PEB for erasure.
> >
> > Fixes: dbb7d2a88d2a ("UBI: Add fastmap core")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: martin bayern <Martinbayern@outlook.com>
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> >
> Hi Greg
> 
> This commit belongs to a series of 3 commits that are intended to be
> used together. Currently the stable branches have only the first
> commit from the series and we get a UBI speed regression because an
> extra NAND page read is always performed for each access to a UBI LEB.
> 
> 3e5e4335cc0ffd668054564b113fb3c9c97badb8 ubi: fastmap: Detect EBA
> mismatches on-the-fly
> 34653fd8c46e771585fce5975e4243f8fd401914 ubi: fastmap: Check each
> mapping only once
> 781932375ffc6411713ee0926ccae8596ed0261c ubi: fastmap: Correctly
> handle interrupted erasures in EBA
> 
> This will in turn require also this follow-up patch:
> 25677478474a91fa1b46f19a4a591a9848bca6fb ubi: Initialize Fastmap
> checkmapping correctly

Wait.
Commit 34653fd8c46e771585fce5975e4243f8fd401914 was not scheduled for stable
on purpose.
It is just an optimization. How much is the performance regression you see?
Commit 3e5e4335cc0ffd668054564b113fb3c9c97badb8 does not fix anything, all it
does is adding another paranoia check to UBI.

I'd appreciate if you would come up with regression reports on linux-mtd first
before asking Greg to pick patches up...

Thanks,
//richard



