Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B11C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB27020865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocdTkfBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB27020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeKYOtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 09:49:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36804 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeKYOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 09:49:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so13124361edb.3;
        Sat, 24 Nov 2018 19:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+VbIPcUA0nJnu19TEKgDmZfhoeqvq+Zc/bRRQahK3k=;
        b=ocdTkfBE5AFtLyhSSV8CuyIFXHG7GlsaOSO2j0zy3JdpMsb0At1PKZh1bBgvl+syDO
         lx45TU5Phwa8H6BdHwH+Bf6IJPf7HRQ/yOAe7fZjbM8U51f6xAyBZi8Po1l7EBMRCzXq
         zhCEziYoT2r3r1dgupyt6RCI4LoeiJ0GexBWvcivKlOZZzLssK2SAjLMwh0svjbJdzxw
         cvwHa4m9XqlCttALqA20+fJbDiTTaX7Pa7FnMBLyJZCAeKGWLPMbuN6ZU1K3cOxPMaBp
         W40LpbtMifYMNHlQ6g7X4/cSupZ5xareMupm50/a4TGfR3zSOJJjJ5JoV+UbmSWqYB6N
         oloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+VbIPcUA0nJnu19TEKgDmZfhoeqvq+Zc/bRRQahK3k=;
        b=rf4ycBIExnB310tBUrsSRN29v55DQhlsNXHlf1s40PdSw0OLJXuPNwnPojIMXUchvY
         eL60tR74n1o7r1lACwbae2K1nQBfQMeAedtS9Dqcq6g3V5LNRZbKTikT5p1eTN+phaaw
         P0Eg/Tno7AS8x7/hs3InmprhG+Y+NBQeIENxLBDCIhmEt9nkaQkQFijkRoGNQif/WIzR
         BnvBtBOWGHMqkoiB7sgfEUqZuY+3mvOUuyWSI5TGyl6NP+Vi1ZyiRVu76vKBQy9QDJ17
         ciAhNRzmHYFB7G2PwGf2bDpTm8IyxGu8Ql0fdqQTPGug5WW1DM1UYQQJey89npl8xH+w
         SNVg==
X-Gm-Message-State: AGRZ1gKpxGZO+Lopj4JpOMtUCF7tFlGikdRir2L/Drxt2b+xZRY9n3vb
        KQP6ULYVU7YrOp7XFtbOQz7uSHzTTqhtsp5yoeM58A==
X-Google-Smtp-Source: AJdET5fP384hUZ9MCTMYcaTg+4qb4i0FIO8NdOS/IfPbEZfc1J9ZA3JA647zCPwROOGuZcyrIWGP021BQcn7w8N3H5Q=
X-Received: by 2002:a17:906:4a4b:: with SMTP id a11-v6mr16244194ejv.68.1543118357002;
 Sat, 24 Nov 2018 19:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com> <20181124022035.17519-3-deepa.kernel@gmail.com>
In-Reply-To: <20181124022035.17519-3-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 22:58:39 -0500
Message-ID: <CAF=yD-KfxXK=Ta=+a8UYMcmUYzN=UokotfzSno2-xi=JeS6=0g@mail.gmail.com>
Subject: Re: [PATCH 2/8] sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Helge Deller <deller@gmx.de>,
        David Howells <dhowells@redhat.com>, jejb@parisc-linux.org,
        ralf@linux-mips.org, rth@twiddle.net,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING options, the
> way they are currently defined, are not y2038 safe.
> Subsequent patches in the series add new y2038 safe versions
> of these options which provide 64 bit timestamps on all
> architectures uniformly.
> Hence, rename existing options with OLD tag suffixes.

Why do the existing interfaces have to be renamed when new interfaces are added?
