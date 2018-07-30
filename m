Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D09716256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE29E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sPWdtdBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE29E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbeG3RnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:43:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3RnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cqFMwEjaA0MXP1XgSjpSLSzs09XRJ4isT5CQbVvbX6Q=; b=sPWdtdBFeNcw1bB0nNn+2JB1G
        xZvaDCUOMGq+KCF1dtJ7HAb5+toRMdnq4SwWbvk+7FvRIxAI5w9Q92OjZKTdsIBsBUG+6k/MW8gAW
        mywuVnQcKJWn6Kk9gADOun5TF3WP4vM7s45+XIDdXvDVL+oa6ViwQE++H3GnDmi/pkeuzA3VBGM+h
        kirrTEEkDXQx0CUCojh1RgGWkgHKjZZ8ITNhkHaGwCcMxOvR1uKZtdKIUnWrGJ43j2vpD69gffBxo
        Lus+hIZL+AV5wufetujufabS6bWicGOnKfryoO0VceRkLAateJzD8l4B0+c4jh36HRiaFE3Oxqv8O
        LRd+HBZ6w==;
Received: from [179.95.0.119] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkAhQ-0000Bh-C0; Mon, 30 Jul 2018 16:07:08 +0000
Date:   Mon, 30 Jul 2018 13:07:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans de Goede <hdegoede@redhat.com>, hverkuil@xs4all.nl,
        mchehab@kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        rostedt@goodmis.org, mingo@redhat.com, isely@pobox.com,
        bhumirks@gmail.com, colin.king@canonical.com,
        linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
Message-ID: <20180730130702.27664d15@coco.lan>
In-Reply-To: <eb2b495fe7e8bbeaf3f9e2814be4923583482852.camel@collabora.com>
References: <20180617143625.32133-1-matwey@sai.msu.ru>
        <20180617143625.32133-2-matwey@sai.msu.ru>
        <c02f92a8998fc62d3e3d48aa154fbaa7e223dd10.camel@collabora.com>
        <CAJs94EavBDcFHpd0KcCZJTgWf0JC=AEDY=X8b3P2nZvt8mBCPA@mail.gmail.com>
        <eb2b495fe7e8bbeaf3f9e2814be4923583482852.camel@collabora.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 17 Jul 2018 17:10:22 -0300
Ezequiel Garcia <ezequiel@collabora.com> escreveu:

> Yeah, and not setting URB_NO_TRANSFER_DMA_MAP makes the USB core
> create DMA mappings and use the streaming API. Which makes more
> sense in hardware without hardware coherency.
>
> The only thing that bothers me with this patch is that it's not
> really something specific to this driver. If this fix is valid
> for pwc, then it's valid for all the drivers allocating coherent
> memory.

We're actually doing this change on other drivers:
	https://git.linuxtv.org/media_tree.git/commit/?id=d571b592c6206

I suspect that the reason why all USB media drivers were using
URB_NO_TRANSFER_DMA_MAP is just because the first media USB driver
upstream used it.

On that time, I remember I tried once to not use this flag, but there
was something that broke (perhaps I just didn't know enough about the
USB layer - or perhaps some fixes happened at USB core - allowing it
to be used with ISOC transfers).

Anyway, nowadays, I fail to see a reason why not let the USB core
do the DMA maps. On my tests after this patch, at the boards I tested
(arm and x86), I was unable to see any regressions.

Thanks,
Mauro
