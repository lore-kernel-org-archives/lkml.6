Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2314DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B42147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="zcTMgDaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93B42147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeIQKUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:20:21 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:60061 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeIQKUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:20:21 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b7d3c0e0;
        Mon, 17 Sep 2018 04:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=tehqJDwOnRl6tOFqMImaggCXdTE=; b=zcTMgD
        aMutcQYzjb0SBrUEhV3/wrJAcgdjQ9h/mXDDYFS1y+Pu53uPwdEp6SmUyjSkY2Kr
        XHGseMmhTf3EQdOaCsEHuJyHhNLVws7XF5ruuioyCCyYfdAqcUc4WF8IMrZk+GkD
        thU8U//4hQ5Z4DGCRGnEj4/5Naka2iIVnP+FAfCmrkFzwn+8g3wQBQAnNyS9gW11
        lzrWRO59e1LBG/00Ly8dx7EqbA9ojGDf4J3/lFaY0pxBaQD10DVCdgsxJxDzK6bK
        QJrJJpY+xCRLrDnh/ZtGnF5nlY66VjOosNIOHRq+9S88mlBJpnL8ABytzPnJiIq9
        QbzvTePgeN1LV3aA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff30b6b5 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 04:37:16 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id 8-v6so17812126oip.0;
        Sun, 16 Sep 2018 21:54:39 -0700 (PDT)
X-Gm-Message-State: APzg51BhQ54iUjMVssJiW29TwckAoyi9x/EErVraTvFiR6Y//UJBs8hf
        Jo5URHl34RKn7Gb2+V/6wZOJOyYB1guRRnJvX+c=
X-Google-Smtp-Source: ANB0Vdb4rCJ+RILtRrYi3OIyFmZiBR+blgDFHvGuyeoQVxIIAwJkN9IQdOPgtKbk967ZaKe7UIvxYZsvxCfvMSZcc9I=
X-Received: by 2002:aca:e795:: with SMTP id e143-v6mr16651766oih.252.1537160078417;
 Sun, 16 Sep 2018 21:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180914162240.7925-1-Jason@zx2c4.com> <20180914162240.7925-19-Jason@zx2c4.com>
 <72e893e7efbef428d4fd23b7332d9e829acd5e7d.camel@strongswan.org>
In-Reply-To: <72e893e7efbef428d4fd23b7332d9e829acd5e7d.camel@strongswan.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 06:54:26 +0200
X-Gmail-Original-Message-ID: <CAHmME9orPSvUH3dmnBvRfy_TEBoLO5VNHEMXaMo9a1WGP-rcXg@mail.gmail.com>
Message-ID: <CAHmME9orPSvUH3dmnBvRfy_TEBoLO5VNHEMXaMo9a1WGP-rcXg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 18/20] crypto: port ChaCha20 to Zinc
To:     Martin Willi <martin@strongswan.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Martin,

Thanks for running these and pointing this out. I've replicated the
results with tcrypt and fixed some issues, and the next patch series
should be a lot closer to what you'd expect, instead of the regression
you noticed. Most of the slowdown happened as a result of over-eager
XSAVEs, which I've now rectified. I'm still working on a few other
facets of it, but I believe v5 will be more satisfactory when posted.

Regards,
Jason
