Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A81C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004592086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9ibnA6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004592086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbeK1ERD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:17:03 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42666 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeK1ERD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:17:03 -0500
Received: by mail-yb1-f196.google.com with SMTP id o204-v6so9366307yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iLwNo5aAgJoO8A/cQoo9064ETdaZXAxtr4dUxtDa69w=;
        b=M9ibnA6ASmSTYjR5IFCm+HNSGKOaPDY9bmLWq6LFNPOe87RR5IjNj+xpniycTh2GpY
         kvICKSBm9rYWrtM+lf9Fv6e7q1L/iGwDpCrIsjcle4F6ZVWwAYnVfD/yNkyr6OH7W6Pz
         WknVUVsobihyDH/46Eh1Myye6NYd9V2k234u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iLwNo5aAgJoO8A/cQoo9064ETdaZXAxtr4dUxtDa69w=;
        b=eJORuf7xeFX0qKGFt1RosxZcQuA78k0Xoy4E9gMwcYOEaXw46lpJ5Tcc6Tmd0FeiE1
         e+gmVQhGGj2OZQkRald7VNWWUTgOuCBuBAXPwQyHdUixYSADK+LOnXXoKqALVr9fymUW
         1mf9FcmgQ5sYLovpuD9GJRjJQEjCGRmdIA3pj2kZ8JPydV8GF1rxbKSeSEayxMurOG+p
         ochV2BpLh4+9bk6UxmaYs1MHpVCBYZ1XBaYH6kRzpLDEoHxLk+w46Cu1YyZmArleq2cg
         Iy5cRwfWw68JWOv99+zw/yw+finudMbv3qGCr9MW2tOrZyPubGCpp5SPW7hgtM7Qabhr
         8e/Q==
X-Gm-Message-State: AA+aEWbC8agJm7Df2XolzRm0m+y3/oGnNiKFT65wUkxXqJPJjQ4TCBzB
        PP/xTYkyFETBjtFU3My2avmWsQvN8/o=
X-Google-Smtp-Source: AFSGD/WcA0fNVEEb0Yt6SFw2mg8bHdFiUa7DG17LQ2V2ARyh3CDZaZIBvHsCg8aNtkb/63r+L2L/Lw==
X-Received: by 2002:a25:728b:: with SMTP id n133-v6mr33761973ybc.160.1543339107750;
        Tue, 27 Nov 2018 09:18:27 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id i128sm1381203ywb.82.2018.11.27.09.18.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:18:26 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id o204-v6so9366263yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:18:26 -0800 (PST)
X-Received: by 2002:a25:1cc1:: with SMTP id c184-v6mr34646520ybc.421.1543339106062;
 Tue, 27 Nov 2018 09:18:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 09:18:25
 -0800 (PST)
In-Reply-To: <20181127074327.GD13965@kroah.com>
References: <edfe11c6d1f9bb0a7c2cee655895dfeedc1dda5e.1541613057.git.christophe.leroy@c-s.fr>
 <20181127074327.GD13965@kroah.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 09:18:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK3GMAjaHgZ-iDwBogXSt1OQpo_+Bav6OMqz5fRiRf5EA@mail.gmail.com>
Message-ID: <CAGXu5jK3GMAjaHgZ-iDwBogXSt1OQpo_+Bav6OMqz5fRiRf5EA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: print real addresses
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:43 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 07, 2018 at 08:14:10PM +0000, Christophe Leroy wrote:
>> Today, when doing a lkdtm test before the readiness of the
>> random generator, (ptrval) is printed instead of the address
>> at which it perform the fault:
>>
>> [ 1597.337030] lkdtm: Performing direct entry EXEC_USERSPACE
>> [ 1597.337142] lkdtm: attempting ok execution at (ptrval)
>> [ 1597.337398] lkdtm: attempting bad execution at (ptrval)
>> [ 1597.337460] kernel tried to execute user page (77858000) -exploit attempt? (uid: 0)
>> [ 1597.344769] Unable to handle kernel paging request for instruction fetch
>> [ 1597.351392] Faulting instruction address: 0x77858000
>> [ 1597.356312] Oops: Kernel access of bad area, sig: 11 [#1]
>>
>> If the lkdtm test is done later on, it prints an hashed address.
>>
>> In both cases this is pointless. The purpose of the test is to
>> ensure the kernel generates an Oops at the expected address,
>> so real addresses needs to be printed. This patch fixes that.
>
> I am pretty sure this is intentional.  Kees?

I've gone back and forth on this and in the end I decided I'd wait and
see if anyone was bothered by it besides just me. :) But, yes, for
lkdtm do really do want a "real" view of the pointer because we're
comparing it against page tables and/or kernel section layout, etc.

I've applied this to my lkdtm -next tree. Thanks!

-- 
Kees Cook
