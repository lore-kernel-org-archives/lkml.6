Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8147DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ED02064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMpW9BN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19ED02064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeKAGlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:41:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35952 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeKAGlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:41:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so18945553qth.3;
        Wed, 31 Oct 2018 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=W3CM3NiosFdHk74uJIXTT440tefWWp3Ua/amACkjsgk=;
        b=NMpW9BN7GCqFbpIssucYjhXz5b0C7S88nrGlWua14iUaGBRvTP6v8dX/kyRK8yMkJG
         pQMfeN9FaaKwd9zO7pDvhymLbFWWosCIvUSuzEV5ax/vPhPo6wR8Go396mEuSPhnrQyk
         Whz2ERSMwDvpXcLLm/QdsgAZ3CA/KM4ZUSRTa1QVldIJuM479PXCQmyJmaFGGN8gaZW4
         P2HY8ClhWGMBPZoXTWuOv+0yXa7TpgcOV+ZgL971stYE5/31TYACx3RAQ/129frU3BXN
         UtPbIeIBhi8G3HnUV9B7Xr8tyWpPDXt4YGMGweYL04ZoeryRL7Vnst/lpPwBmxq8zaHI
         Ko4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=W3CM3NiosFdHk74uJIXTT440tefWWp3Ua/amACkjsgk=;
        b=tMwW+yVRmazLKz+xSHBamDcyVnPtFeCh7xTvJvdhkklI0/d/25bA32RfZTWhTFHGMg
         iDK+ZZHTF721N9PLK0UN/6UBusWM9NOAf+z2JiY+3r6JU5pTOxkv8sHdZehxxSyVmks+
         OQe2sdGtnlv08GoM8hN1kUY6gX1XnLdZXlOk05LQYdkWuU7fN9Qm0iYWL0WKE4ruTvf4
         QVg5YXL1mPIFuS7vNw6vn7aIKgweAE/jvKuH0oCAPo7Z8td+Qf52mu/ESY+6yFWZSal3
         o0GPj8oHeGKdOoGD64Ad77HoT1+iS24lU2TDYx1hIeD2AY1cSstNpcrgOk1R4l9NEUIa
         /aww==
X-Gm-Message-State: AGRZ1gIvKp72B8ZQHbBWtXvcnLdkpXhXEJK00LKvqTO1O9oUivGl/Hhj
        KxyvqwQQEoVl8y9st2uem40tRFWstvJDssRNEZs=
X-Google-Smtp-Source: AJdET5dA5rS9hBwN+SabRBcC9ej1KkGxHV+k9BbA4n1f30oERnUEylsZ8ZkBmDiI6CPtnWb5r5MfR9bVYZuD0vIkEpE=
X-Received: by 2002:aed:2ba7:: with SMTP id e36mr2074089qtd.319.1541022080893;
 Wed, 31 Oct 2018 14:41:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 14:41:20
 -0700 (PDT)
In-Reply-To: <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
References: <20181031145907.1ee2e866@canb.auug.org.au> <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 31 Oct 2018 22:41:20 +0100
X-Google-Sender-Auth: uCg1GheRz0LsBhrXNeZh6n-uNQI
Message-ID: <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/30/18 8:59 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Please do not add any v4.21/v5.1 code to your linux-next included trees
>> until after the merge window closes.
>>
>> Changes since 20181030:
>>
>
>
> on i386:
>
> ld: drivers/virt/vboxguest/vboxguest_core.o: in function
> `vbg_ioctl_hgcm_call':
> vboxguest_core.c:(.text+0x212b): undefined reference to `vbg_hgcm_call32'
>
>
> Full randconfig file is attached.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

I ran into the same thing, and lots of others like it; they all go back to
the -Og compiler option introduced in commit 94c7dfd01652 ("kernel
hacking: support building kernel with -Og optimization level").


I have patches for most of these, but I'd prefer if we could leave
that patch out of 4.20 for now, and have it in linux-next for merging
into the next merge window, to give us more time to fix up all the
regressions. This particular instance is fixed by the patch below.

Other symptoms caused by the change are tons of 'section mismatch'
warnings for functions that are no longer automatically inlined, and
sprintf format string overflow warnings when gcc fails to propagate
an upper bound on an integer argument that is printed into a fixed
length string.

     Arnd
---
From 8172e650c6797b9cc64c6f7b1c9e5433156290cc Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 31 Oct 2018 16:24:35 +0100
Subject: [PATCH] vbox: fix link error with 'gcc -Og'

With the new CONFIG_CC_OPTIMIZE_FOR_DEBUGGING option, we get a link
error in the vboxguest driver, when that fails to optimize out the
call to the compat handler:

drivers/virt/vboxguest/vboxguest_core.o: In function `vbg_ioctl_hgcm_call':
vboxguest_core.c:(.text+0x1f6e): undefined reference to `vbg_hgcm_call32'

Another compile-time check documents better what we want and avoids
the error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/virt/vboxguest/vboxguest_core.c
b/drivers/virt/vboxguest/vboxguest_core.c
index 3093655c7b92..1475ed5ffcde 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
 		return -EINVAL;
 	}

-	if (f32bit)
+	if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
 		ret = vbg_hgcm_call32(gdev, client_id,
 				      call->function, call->timeout_ms,
 				      VBG_IOCTL_HGCM_CALL_PARMS32(call),
