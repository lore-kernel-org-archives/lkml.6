Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1045C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4F0206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AOuonb5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4F0206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeIEEoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:44:05 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34279 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeIEEoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:44:05 -0400
Received: by mail-yb1-f193.google.com with SMTP id t10-v6so2026440ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HNQ+hFa1cZOB534eJi2M+lqLNmiq2pfJR2e3g/EqOuE=;
        b=AOuonb5GQtHmK5uE1QQNuKe9WwM9b0O6H6pQ4g6H0YZjHNWeCzUCw9j5BBG4kPClzU
         DJO3TohSgbYP8dIS+IbnmtmufEE8wRTS3fkwtB/hh3si7oGgG595OLu3MQvbIM36OEka
         K6f4EhPyeucBzZyGJJ0XDK8zxZEgcmAxiCbuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HNQ+hFa1cZOB534eJi2M+lqLNmiq2pfJR2e3g/EqOuE=;
        b=tQb91XoOWv3nZDTqRI9KYb3t0wpyM3RI+e89GRxe0j5/rnHEcEF/9/t4zeTuuXMPth
         cNXPZk8WRTtEvBtBesQ6pBK83V4UDNolQllSh6oXJa1GiJNFFkr6sGz6VTLJhp9/Se2Q
         UMaO5j9+Kxl3hTv3lMQBzr6WTYShTdwrnPxSMuvoW2TaRrr6CJUkwhZslh1lRvOdk6GB
         HbBuyL4RHwT2dUu2Jg2eFB9up2OE8FkOOKHDtMnoJs5lJbxZWYn+qPnHUJmeAcueJE+u
         LTDAZd6Ipx+MpFTRGRT8zK21NuzgS5v/FCuEhQbnkOKl44R5TVetbExx8xOreiV5AVCu
         a6Tg==
X-Gm-Message-State: APzg51AQgwbFEv5chBe5K7v1jTGPxzGsgCgcMtl0llDgIrENiYFKnEdP
        PTFRF6EbPXTGa4H0Qa9QyiWauZQiLm0=
X-Google-Smtp-Source: ANB0VdaI5egDQ/p6MzyFbG9FnmvpqmoWLMgPvNUztqGehJmDs5ynBvilLGdDfV12cz8IKhMuWhidDA==
X-Received: by 2002:a5b:652:: with SMTP id o18-v6mr19669482ybq.441.1536106595009;
        Tue, 04 Sep 2018 17:16:35 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id t2-v6sm232790ywd.99.2018.09.04.17.16.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 17:16:33 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id x83-v6so1980369ywd.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 17:16:32 -0700 (PDT)
X-Received: by 2002:a81:6cd2:: with SMTP id h201-v6mr19312680ywc.397.1536106592457;
 Tue, 04 Sep 2018 17:16:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 17:16:31 -0700 (PDT)
In-Reply-To: <20180824094225.68b2adc6@mschwideX1>
References: <20180824094225.68b2adc6@mschwideX1>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 4 Sep 2018 17:16:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJVvWbKnRR_XyBH5yWLzNAEPzuguppBfxXaU4x+tE0M2g@mail.gmail.com>
Message-ID: <CAGXu5jJVvWbKnRR_XyBH5yWLzNAEPzuguppBfxXaU4x+tE0M2g@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 4.19 merge window #2
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 12:42 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> Harald Freudenberger (5):
>       s390/zcrypt: hex string mask improvements for apmask and aqmask.

This (and an earlier 2017 commit) adds VLAs, which are being
removed[1] from the kernel:

drivers/s390/crypto/ap_bus.c:980:3: warning: ISO C90 forbids variable
length array =E2=80=98clrm=E2=80=99 [-Wvla]
drivers/s390/crypto/ap_bus.c:981:3: warning: ISO C90 forbids variable
length array =E2=80=98setm=E2=80=99 [-Wvla]
drivers/s390/crypto/ap_bus.c:995:3: warning: ISO C90 forbids variable
length array =E2=80=98setm=E2=80=99 [-Wvla]

static int process_mask_arg(const char *str,
                            unsigned long *bitmap, int bits,
                            struct mutex *lock)
...
                DECLARE_BITMAP(clrm, bits);
                DECLARE_BITMAP(setm, bits);

Can someone please adjust this to make these fixed size again?

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXydAa=
cU1RqZWA@mail.gmail.com

--=20
Kees Cook
Pixel Security
