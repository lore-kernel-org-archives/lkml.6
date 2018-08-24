Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C05C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640B221477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g4B78Ips"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640B221477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeHXS0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:26:34 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43266 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeHXS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:26:34 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so3162880ywb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzKGFlDNHuLyMb4EdZsUr83JhXdMkQM/MCQ2lZTLPys=;
        b=g4B78IpsOFwK5M2d5205Jk29/kP5x+R7jBzyXmNQ8JKfJPKOlavjxH9pHGUu3vbYRy
         M0vQObkQmSesQMwZQ0+z00DtzfzlomP9fPCNnPkgVsB9YgJ80nQ78xEP3Ym0ceLYmYrp
         Af2WnfR6mx9X39s6mRfeyb15TxbustDLHYdRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzKGFlDNHuLyMb4EdZsUr83JhXdMkQM/MCQ2lZTLPys=;
        b=IF3Lo3HtL0iFiMiryoIk4+2FCILjsBH+Y+lrBu+9+53kY5hBOFsU24QEMednHp7o3b
         o6A8vpX3Z92d8ZJmFtOZ642J30N3xXwZPW9QsVPcx8aXEWvyOtrOBFr8huIzajp6xxHG
         MVan1tl4AZzOCaDwTHjYJMKS340JJskRafy7+P1Yc2/vRgPLPpFEpcmV2QKaaNX7qGlP
         CN1DshRYhGP5gDZRj/Fw36V7kSoyS5xhmZHCyubjvwdNU71nCFq0UuCthr5wWTwZZIE0
         w+DIKorjynJYqVJeZy5QtpWAofoXEBwwvQgaUg3J9FITfLWaFonHjXQa008UMTAfUrXq
         MFEg==
X-Gm-Message-State: APzg51ChpjZrAe1I5WOdywMDDsVwVtLQVOEk3iXg3LAr9zB/KB0AqCgu
        iin6DqbYptAqlOp5YagUjZFhb31umpU=
X-Google-Smtp-Source: ANB0VdZXddFeEJR2MBidGEOaORC2owrS+J0mklGx68bbgMSXQpG9EAMwMnEjtEs39uxXYOp20hcFXA==
X-Received: by 2002:a0d:cfc2:: with SMTP id r185-v6mr1218815ywd.337.1535122295258;
        Fri, 24 Aug 2018 07:51:35 -0700 (PDT)
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com. [209.85.213.175])
        by smtp.gmail.com with ESMTPSA id o74-v6sm10539252ywo.54.2018.08.24.07.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 07:51:34 -0700 (PDT)
Received: by mail-yb0-f175.google.com with SMTP id z12-v6so3564271ybg.9;
        Fri, 24 Aug 2018 07:51:34 -0700 (PDT)
X-Received: by 2002:a25:b305:: with SMTP id l5-v6mr1159000ybj.479.1535122293905;
 Fri, 24 Aug 2018 07:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313724861.13253.3837522702693613670.stgit@warthog.procyon.org.uk>
In-Reply-To: <153313724861.13253.3837522702693613670.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 24 Aug 2018 16:51:22 +0200
X-Gmail-Original-Message-ID: <CAELBmZCv3uAmXiSEk3vdYEy8wn_mP8Rs6qzMqSa56_kPsb_=aA@mail.gmail.com>
Message-ID: <CAELBmZCv3uAmXiSEk3vdYEy8wn_mP8Rs6qzMqSa56_kPsb_=aA@mail.gmail.com>
Subject: Re: [PATCH 30/33] vfs: syscall: Add fspick() to select a superblock
 for reconfiguration [ver #11]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 5:29 PM David Howells <dhowells@redhat.com> wrote:

> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -351,6 +351,11 @@ typedef int __bitwise __kernel_rwf_t;
>
>  #define FSMOUNT_CLOEXEC                0x00000001
>
> +#define FSPICK_CLOEXEC         0x00000001
> +#define FSPICK_SYMLINK_NOFOLLOW        0x00000002
> +#define FSPICK_NO_AUTOMOUNT    0x00000004
> +#define FSPICK_EMPTY_PATH      0x00000008

This caught my eye:  why aren't we using the AT_ constants?  Adding an
AT_CLOEXEC sounds less horrible than duplicating all the lookup
related flags for FSPICK...

Thanks,
Miklos




> +
>  /*
>   * The type of fsconfig() call made.
>   */
>
