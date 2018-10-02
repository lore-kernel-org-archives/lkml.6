Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DFFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D1520666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wf5x1Y3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D1520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeJBKAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:00:06 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46423 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeJBKAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:00:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2df64f0d;
        Tue, 2 Oct 2018 03:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Dbb/vV91vK4zck0wMbIfg2nFqn4=; b=Wf5x1Y
        3GWW6UQf9hGyiJMheZTbsHTb8MlVX2f+jZRpkqCke8VPnmpy1Ywu7uF/exgcE9q0
        bX3qacIT+JWfaWXKXLC5b5hJ+FnJxD1ZTBT5bVTfHa+eGlRE4j1M2h04ibRetcNA
        j4laLqchoLxFH6w+lHMKxecijWYKMmxYAgxW4zbW1q8QZvTzSFeZXuB+izP6MhQt
        TDeJ3Dnxfeo7tO9GiYHfV/aMhV6q5a/GteeeWfPUcZtfKKABT4Jmc9aXzRRS+vfj
        cWsyE/UOzm40KDWEPbf1SsYBPr3LOnwJSFQNJbGe1d/LUH2aqHoOqNNyQCKQxs8c
        CPgTfz4v6FFHEiQw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bc1d6ed6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 2 Oct 2018 03:19:04 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id a203-v6so407820oib.0;
        Mon, 01 Oct 2018 20:19:04 -0700 (PDT)
X-Gm-Message-State: ABuFfog5aW4jtiPfYOwx34ViRYMLeeAUMPtD5kJ6wOets8+t1hzqTJ6X
        VZVFmSbw+2FNYJpCOw9A3UPlD/npDaznmLQbQwE=
X-Google-Smtp-Source: ACcGV61EIUUiApx6asQRXYWbfT2pKkZrg71ZvN56aJRnGOH7BbC6p1ZI1fMS/ZzDxuZsCNO5jT+iYZ/+QXHtiBFZ5Ho=
X-Received: by 2002:aca:ce4c:: with SMTP id e73-v6mr6065045oig.225.1538450330758;
 Mon, 01 Oct 2018 20:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-4-Jason@zx2c4.com> <20181002031542.dbxu44gvqrughlgw@gondor.apana.org.au>
In-Reply-To: <20181002031542.dbxu44gvqrughlgw@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 05:18:38 +0200
X-Gmail-Original-Message-ID: <CAHmME9qo0cBnptzSe=G=L0uzvOj1-LN=8-Z-osHcE=0XS4N0zw@mail.gmail.com>
Message-ID: <CAHmME9qo0cBnptzSe=G=L0uzvOj1-LN=8-Z-osHcE=0XS4N0zw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 03/23] zinc: ChaCha20 generic C implementation
 and selftest
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Tue, Oct 2, 2018 at 5:15 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> I don't have any problems with this interface.
>
> However, I'm very unhappy about the fact that this adds another
> copy of the chacha20 implementation to the kernel.  Either this
> is better than the one that we already have or it isn't.
>
> So if it's better please replace the existing chacha20 C
> implementation with this or otherwise just adapt the existing
> implementation to this interface.
>
> If we're replacing the existing one then you can either replace
> it directly within this patch or in a subsequent patch but please
> do it in the same series because otherwise we could wind up with
> two implementations for years to come.

Indeed this series takes care of removing the other implementation later on.

In case it helps to see things visualized, here's the layout of the
whole series:
https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log/?h=jd/wireguard

Note that comments on this are probably a bit more useful than on the
version posted to the mailing list, since I've already started
incorporating quite a bit of feedback from v6, and so v7 will be
posted sometime later containing these.

Jason
