Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD4EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA7720848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XX9eoE0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA7720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJZSVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:21:17 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46655 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeJZSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:21:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so189498ywa.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7jrDlWrR87OXQWP4EW7ozj7IY2FG5rNJPWASi2+6LvM=;
        b=XX9eoE0yYvT46SdS0Pp049Q/2PjNt6Hii6SCcHjPoQ4Lv4xzNQGjtZc4wbZUlBXzu5
         2eJkgHY+8oIV1uuPS4vF1b+P41QM7kYNCcbGdDCNb7z0Iq0i3n8Sxo9+pJvI0ORfg2E3
         rx/9GBrc5JQkRCbJMtCxf0u6HMY6WhgK9sNno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7jrDlWrR87OXQWP4EW7ozj7IY2FG5rNJPWASi2+6LvM=;
        b=k3Q3Da57VW24DqC/sTGKDa0Z+pDgYzIRCswWN1RgGh8XV+4hTBMTDK4oDgIV2Ii4CA
         ebbKMu4D+LocqtzoNgwCpMARG+vn6tYrVxnnbxjPA5QN4qiVl99kWfIe50fxf7Fppawp
         l1KvfTTGty7v3ZuVhX6WhTA3o5YNGC6Yz57qfX/c39NlNmHOz9UtLgg2kTdQp2y90Yzk
         2JgtQoIEgiOY92LDyM3LWzeV9MSmMOIN/kZX2JznN9Dsj/2La4Ixp70L4BYR3jKlZnhi
         NfAFUOpDRg5pnbUEr6JEys+AFO8SH0IsFfGF5kbD5uq3aVs7BRxC65cyC6+Oc9+4CRA7
         1wDQ==
X-Gm-Message-State: AGRZ1gIw+sBsSHGXHsJJF9w1JqqrN5Kus2blm6868G3p7NFHUdhZxXPH
        79eyR7I7qGwtWD0QAHLIURd8XSf4NKQ//w==
X-Google-Smtp-Source: AJdET5dwdjcW267kqhnVRkncwM1DMt0NTyTf3/LvHVykemX9Qasc5E/g2mAAZSP2PEvqj06kVd4NMw==
X-Received: by 2002:a0d:c704:: with SMTP id j4-v6mr2715316ywd.466.1540547092626;
        Fri, 26 Oct 2018 02:44:52 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id q6-v6sm3135762ywh.41.2018.10.26.02.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 02:44:51 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id i78-v6so216567ybg.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 02:44:50 -0700 (PDT)
X-Received: by 2002:a25:7643:: with SMTP id r64-v6mr2686841ybc.403.1540547090108;
 Fri, 26 Oct 2018 02:44:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 02:44:48
 -0700 (PDT)
In-Reply-To: <1540525277916.97809@xiaomi.com>
References: <1540525277916.97809@xiaomi.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 10:44:48 +0100
X-Gmail-Original-Message-ID: <CAGXu5jJtwLgrMVvXR+C8oSKPus+iVdYsYn4Q2+8FjRbgpL+jNA@mail.gmail.com>
Message-ID: <CAGXu5jJtwLgrMVvXR+C8oSKPus+iVdYsYn4Q2+8FjRbgpL+jNA@mail.gmail.com>
Subject: Re: [PATCH] pstore: Remove duplicate invoking of persistent_ram_zap()
To:     =?UTF-8?B?UGVuZzE1IFdhbmcg546L6bmP?= <wangpeng15@xiaomi.com>
Cc:     "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 4:41 AM, Peng15 Wang =E7=8E=8B=E9=B9=8F <wangpeng15=
@xiaomi.com> wrote:
> From: Peng Wang <wangpeng15@xiaomi.com>
>
> When initialing przs with invalid data in buffer(no PERSISTENT_RAM_SIG),
> function call path is like this:
>
> ramoops_init_prz ->
> |
> |-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
> |
> |--> persistent_ram_zap

There does appear to be a duplicate call to persistent_ram_zap() in this ca=
se.

> As we can see, persistent_ram_zap() is called twice.
> We can avoid this by removing it in ramoops_init_prz(),
> and only call it in persistent_ram_post_init().

However, I think the proposed fix doesn't work the way it should.

There are two prz init paths: ramoops_init_prz() (a single prz) and
ramoops_init_przs (multiple przs). The "dump" and "ftrace" cases use
the latter. In those, there is no call to persistent_ram_zap() if the
buffer is valid.

In other words:

ramoops_init_prz() unconditionally calls persistent_ram_zap(). (And
may call it twice if there is a mismatch of the magic header.)

ramoops_init_przs() only calls persistent_ram_zap() when the magic
header is wrong.

The proposed patch unconditionally zaps all regions, which means we'd
lose "dump" and "ftrace" across the next reboot.

Perhaps we could make it an option to persistent_ram_new()?

--=20
Kees Cook
