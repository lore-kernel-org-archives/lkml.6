Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48KpYe9/EjDoK0e1lJa7qQVLsNeJWK5XMzHZfmTIx4CVOIyOs058L+Up5hUz+SQ5S6R2GGv
ARC-Seal: i=1; a=rsa-sha256; t=1523007190; cv=none;
        d=google.com; s=arc-20160816;
        b=pRofTXQ9vHntmbL5EqJWaWmUHLh7BZNms3J9eU1H/7Chio5cFE7srUzGR5r9Vt7yC0
         rVf1GdcrCO0JuPL561DTY8TH6e0jASbr9uU6G/cF6Re5FlD8vo05P0le46OK9iPVaP4F
         pQ/VlfhadF43zY0jk6Yhj6/P5vpuCkuYcJlwCU1ExOI9m+xmt6Gw8k4HxR2plvyoYr3K
         kVQv8B6PjLtoJN508EAt+3Q6zO8kM1DR5BsJIOuDSigDrI1jNJ/hlUpHdmKgYOXklEbm
         6Vun2tNld4IGU2qiUgrN2565sG0YKgDUq7/vBKHR9sj6444WjJN8sdJN34bpNpAH1aZG
         J/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=CZcAD/ncLFgQbRzlf/vxFAWND31FfgeOsDzx4y+DKCk=;
        b=LUxULR84qns2uGUq+B/IorLWwMPUX5ePcsz4mEOU3ALbk3pg2LS8ZAcDjaJjkNYniY
         YOhO/2cw9R7uwi5Anj+y7EFrEn4nXYhgKFYe3snOnNb4xFhmK1q73cIkv/XvNNw0Khph
         6qSSJajzim78vnpDcsRz7biBnlYdKjLoYFclOZYceAYBm0DdAKQDq00VtLrfJRtM55tU
         yiyjBhdosb0n9SPbPMjQPP1cr/a9XsQfrI411CVFsFvwLDzU3x1b/LbT/I8up+FIeOjx
         fgsZp1U1AtOQL0ONHCTIRQvisU43BotMiS3QSlqY/8I3rtu7WRlwwQFYil6UH7f21Nbz
         AP3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeDFJdJ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 6 Apr 2018 05:33:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751329AbeDFJdJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Apr 2018 05:33:09 -0400
Date: Fri, 6 Apr 2018 11:33:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        qemu-devel@nongnu.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK"
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2] Add udmabuf misc device
Message-ID: <20180406093307.s7wkhpmddd5d4r7a@sirius.home.kraxel.org>
References: <20180316074650.5415-1-kraxel@redhat.com>
 <7547e99b-0e3c-264e-e52b-40ad5d52b49a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7547e99b-0e3c-264e-e52b-40ad5d52b49a@gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595079572079958094?=
X-GMAIL-MSGID: =?utf-8?q?1596988788257572332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  Hi,

> The pages backing a DMA-buf are not allowed to move (at least not without a
> patch set I'm currently working on), but for certain MM operations to work
> correctly you must be able to modify the page tables entries and move the
> pages backing them around.
> 
> For example try to use fork() with some copy on write pages with this
> approach. You will find that you have only two options to correctly handle
> this.

The fork() issue should go away with shared memory pages (no cow).
I guess this is the reason why vgem is internally backed by shmem.

Hmm.  So I could try to limit the udmabuf driver to shmem too (i.e.
have the ioctl take a shmem filehandle and offset instead of a virtual
address).

But maybe it is better then to just extend vgem, i.e. add support to
create gem objects from existing shmem.

Comments?

cheers,
  Gerd

