Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B854C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D686D20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BXyNgK9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D686D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeKBThC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:37:02 -0400
Received: from casper.infradead.org ([85.118.1.10]:54454 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKBThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qwrhSMd9jydeaTn5x9krKMQuGZtWTEsQdcOsTvi7xVA=; b=BXyNgK9TeH8IKv54zsAPdRa3GG
        2jkYflOg9y6NAXrxX0GnSIZTA7esuirxwXOHaoMscSqewbPW8Yx8SyafPsg5fcgAksCdRCHgQVqMU
        fpVKIp9R9liNc/GXIiOTmRdEAqTAbktEl/rkxohOLYRcXWG98qRp0T1KBCn8uz97oX6avADVuu++O
        A4q8Aet6pPCSjQr5jdEFi8Ks0LmPcVPthyivT/NeN9fPiRGf3IfOflHGzxzlF3JmZbRUx0WBDvOBD
        o8Or0ckAIEkfnp0w6q5wgnp4KSrHtuajb0c2QsI+CeCjg/hQvosAwVoSav4tHdf/ZZ1XEbPNm833P
        4USQjBHg==;
Received: from [191.33.154.111] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIWia-0006Xd-Ku; Fri, 02 Nov 2018 10:30:21 +0000
Date:   Fri, 2 Nov 2018 07:30:16 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: linux-next: build warning in Linus' tree tree
Message-ID: <20181102073005.4fb45747@coco.lan>
In-Reply-To: <20181101082820.76abf19e@canb.auug.org.au>
References: <20181101082820.76abf19e@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Em Thu, 1 Nov 2018 08:28:20 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> Building Linus' tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> ./usr/include/linux/v4l2-controls.h:1105: found __[us]{8,16,32,64} type without #include <linux/types.h>
> 
> Introduced by commit
> 
>   c27bb30e7b6d ("media: v4l: Add definitions for MPEG-2 slice format and metadata")
> 

How are you building it? Here this warning doesn't pop up.

I'm using here:

	gcc (GCC) 8.2.1 20181011 (Red Hat 8.2.1-4)

And I'm using:

$ make ARCH=x86_64  CF=-D__CHECK_ENDIAN__ CONFIG_DEBUG_SECTION_MISMATCH=y W=1 CHECK='' M=drivers/media

(it is not a full build, but it should be enough to get warnings at the
media subsystem)

Thanks,
Mauro
