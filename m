Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DF6C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7220849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OmkHa2Vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE7220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeLLV4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:56:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44287 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbeLLV4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:56:45 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so16081460iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+PePm4Q0FdhX4kWFSikQ8CrvGepbxUfAZZXfSN3NPk=;
        b=OmkHa2VhovsJduJVfZEMiT1TzpUW8UcgT4lUeIkNc03ondV3s6bYkpBgwjfR/LpGTV
         QzvoveLe9WBGEl/+RwnSO1LLqyd7pJUkaMCz5IJJCLE5sTrTkVN7rUWyDMnDi7NgcU+3
         8fgt238KhxIgCIUKyo/IsVHVTytZviijuyj64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+PePm4Q0FdhX4kWFSikQ8CrvGepbxUfAZZXfSN3NPk=;
        b=GY9fsBAljHifgXt6J0XqB8nrYAV5d1mRZ4KICT0EnyjAXgzcGRhbtmefBl2tUU3on+
         ng3zLff1ChJywFuoOZ/rjDz6liAEArSphOYPH0RWjNE5xVVAax3blGK3j83t9Fr/hK9R
         uyjV2Y7EUdXflgvnvDu4p57CrR0ax4lbHgmYdUDBr1CXXFX7cvmLYSy65qqP72OFQuIb
         ZqtDY+4I0rRW/bR4a2cx4Ie5YonRo6eiKy2bOciiC6tIoPyf40my3V8eJxcqHtnaeqV3
         Vjjd81UmJ6EMl1sqQ9terE82Dai8R7vHddfpp+WGZU+Kqw9ctQJSH4mTgNfKqS7g54tz
         +wvg==
X-Gm-Message-State: AA+aEWYRxZej9akdIbqoN5hjYySaevAHYBE3qPU/cirmdULON7b8zpTf
        xehX+Zc0QnTaxyYHdA2HWt21d7tq9+AHRdyW6U52qQ==
X-Google-Smtp-Source: AFSGD/Xp+sRGkaoPv/e/bxzaPTAKUCXh4KYJxCReJzR25sSROxatYfpff2kvNrd5qBevqqgRz+W93DvEaQEMcW9ZDQ8=
X-Received: by 2002:a5d:959a:: with SMTP id a26mr5855918ioo.278.1544651804325;
 Wed, 12 Dec 2018 13:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20181127103312.19368-1-murphyt7@tcd.ie> <81c4efd9-2ccd-53ec-98e7-663c95d6d5c4@kernel.org>
In-Reply-To: <81c4efd9-2ccd-53ec-98e7-663c95d6d5c4@kernel.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 12 Dec 2018 22:56:32 +0100
Message-ID: <CAKMK7uF0Anr5+Z+Mnpnch_X5QqMj0gAvX99ifov9cC8rDMigAg@mail.gmail.com>
Subject: Re: [PATCH] fix dma-buf/udmabuf selftest
To:     Shuah Khan <shuah@kernel.org>
Cc:     murphyt7@tcd.ie,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:16 PM shuah <shuah@kernel.org> wrote:
>
> Hi Daniel,
>
> On 11/27/18 3:33 AM, Tom Murphy wrote:
> > This patch fixes the udmabuf selftest. Currently the selftest is broken.
> > I fixed the selftest by setting the F_SEAL_SHRINK seal on the memfd
> > file descriptor which is required by udmabuf and added the test to
> > the selftest Makefile.
> >
> > Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
>
> Does this change look good you? I plan to get this in for 4.21-rc1. Let
> me know if you have any objections.

No idea, would need Gerd's ack I think. And maybe we need to update
MAINTAINERS, to make sure dri-devel gets cc'ed on patches touching the
dma-buf testcases.
-Daniel

> thanks,
> -- Shuah
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
