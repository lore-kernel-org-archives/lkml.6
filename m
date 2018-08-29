Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189ACC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7D420644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGjVqfEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7D420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeH3Ch1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:37:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44285 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeH3Ch1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:37:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so2942564pgp.11;
        Wed, 29 Aug 2018 15:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QUC+zu03Ys8NwoGYGSRew4rLmTQGVI1WF6OOL6Zrlc0=;
        b=CGjVqfEkCNmboQ9QLOqEt+0JsUitE18CR6y49Nr14xj7sItDA0Cf09UGJ0oUBWQlzC
         UDAqniilVnIEoWpDPjKh78kniLakCoxcY6ZSmcl7GUiOObMFdCTAx+AFWeAlflSUZrDv
         beNHszianJUr3BYQgTTH8+qw0DtdLAYv0xVgE/oc7Cn5JhklbxTS7gxl+67ME5qqnQBI
         AXxhyfdT5Jcjwk+GhMNWdFSoaFtQZA+1VstIvRlfVq00CC2RDv3Se37Qu+fBjYwl7IqD
         lSP/sKPI8BYg3fSy4Uw2OQCWijG2t3nQVRy5rpKvq5yoINdid7AicMSAWgUltik5U6r0
         e7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QUC+zu03Ys8NwoGYGSRew4rLmTQGVI1WF6OOL6Zrlc0=;
        b=DQkVAoLbL5sZSPA2bCwdKY29L2TOhxV9Iam1yRj5HAS3tBc5bT8pgSemYtWo81DRPK
         CeX7Jo+NVnUjPfyN+uSqX6//mrSBPl06X9ffUFGIMHik8llBP8bV2t/tA/Ey8LmZ7ZDh
         KSqn8zlMqeXXVPZt/9yuDkDk3v9L09/Tf88+vUwIhop27eCc/FnmzG9khMJ/B3fyhIMd
         sxPp8yJxww2lef5T5x1DdEx3s3q0/gMM/uNc8ZOTIb+aHe9FYh2BW6N6mhMx+7Ijtf5m
         ZmuvnmOz7e9mFxXN66rUV1ys08HjlK60Er6CIOXy8viENeuHoE3mdi0Yu/FPmGXfNbQm
         jhtQ==
X-Gm-Message-State: APzg51CyqrmarPuEgfA/5/NDcFbtPBKp0wW0kQCMHT9fWdqTGh4bi85t
        FIcz1eTXsAgf5Voh5EJu7j4=
X-Google-Smtp-Source: ANB0VdZGNIIKvpBBx/W3r8/z0HmoF4Iz0x/kGjjXrXxbzsMfAB1NKfregBXFWEbgQnxkPIdS2ghupw==
X-Received: by 2002:a62:9f4c:: with SMTP id g73-v6mr7763760pfe.142.1535582304220;
        Wed, 29 Aug 2018 15:38:24 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 82-v6sm9194613pfw.159.2018.08.29.15.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 15:38:23 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:38:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Meelis Roos <mroos@linux.ee>,
        Linus Walleij <linus.walleij@linaro.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: various dma_mask fixups
Message-ID: <20180829223821.GA29499@roeck-us.net>
References: <20180829062401.8701-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:23:58AM +0200, Christoph Hellwig wrote:
> Fix warnings and regressions from requiring a dma mask.

With this series applied, I see the following in my sh4 boot tests.

sb 1-1: new full-speed USB device number 2 using sm501-usb
sm501-usb sm501-usb: OHCI Unrecoverable Error, disabled
sm501-usb sm501-usb: HC died; cleaning up

This is a persistent problem. Reverting upstream commit 2f606da7823
("mfd: sm501: Set coherent_dma_mask when creating subdevices") does not
make a difference.

The problem is gone if I do not apply 'driver core: initialize a default
DMA mask for platform device'.

On the plus side, the sparc warnings are gone.

Guenter
