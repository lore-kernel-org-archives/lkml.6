Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E71CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC97C2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="sJzUgmvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC97C2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIBAcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 20:32:22 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41311 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeIBAcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 20:32:22 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2c93ca24;
        Sat, 1 Sep 2018 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=/RfQ6rg7mq3cI1Wv9TWGAieHDMY=; b=sJzUgm
        vPE9tMLXRAdNldL+AnTMv+mVeNwMwtJFf8rvIjklp3WDPh2Diy+jdFl3Na2gaYnG
        msE0IuYQYKgsnNgHBSriJQJrZvbLfCVWUzguosKwwMBwehHgI3QnAr1GuxBspOfK
        smMerGZvZeI0rfv6Mm2AOinoSlXncFrbCaEKzx2MvfQzT8UYTSnY+Yuou3B+3WR4
        dth7yGfe1M9b07fV5hny2GVBAFsaQs+cYGZ8Q7EFF5qhCnvTXIKP6IwSMPwaWPzE
        BqYCj3kuzHdahMtdv/wBIkPRtoA4i4zgToGSdiw6dtIXOjkUlhYm5MKbcN74mKaX
        Onv8gF4rKFaSbesg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e549d606 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 1 Sep 2018 20:03:47 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id m11-v6so27521693oic.2;
        Sat, 01 Sep 2018 13:19:14 -0700 (PDT)
X-Gm-Message-State: APzg51BsLJGiBhX75jOc0ZFIVOMzy7JcxF/OnoCVExsKcfpNX3NdoZlr
        QSf99jTxhpgXa0SoW2WK0YAVvBuFOp5HqgVZZzo=
X-Google-Smtp-Source: ANB0VdbOW51MWPFnCdd1g3PgneFNbm63fo42CWk7uzgstXAn5e9BAviF3+Qnh9sdCPQSn6h/uX30EhYguflL4fz+vxo=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr12311758oif.71.1535833153380;
 Sat, 01 Sep 2018 13:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 1 Sep 2018 14:19:01 -0600
X-Gmail-Original-Message-ID: <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
Message-ID: <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

I'd like to move ahead with my patchset and make some forward progress
in LKML submission. If you've got something brewing regarding the FPU
context on x86 and ARM, I'm happy to wait a bit longer so as to build
on that. But if that is instead a far-off theoretical eventual thing,
perhaps it's better for me to move ahead as planned, and we can switch
to the superior FPU semantics whenever you get around to it? Either
way, please let me know what you have in mind so our plans can stay
somewhat sync'd.

Talk soon,
Jason
