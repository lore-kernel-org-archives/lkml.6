Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19686C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 22:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC092087F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 22:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="JrkEPAK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfAZWCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:02:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39300 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfAZWCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 17:02:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so5601151pgl.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 14:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZQALRatgGYbV9MY7AZa7uBN2jjfiu74zaU+cT5Nuvk8=;
        b=JrkEPAK13maqpDGaY5iT2Os1IHmAkd3ui2sZkZwh3Vp/rrrR5CAY252Ug8iYUEuVQZ
         /NFoYK1sMzMT7K6Rd+ZcPjy4iEG682ulDX3KXM0bJmkL6i1yJwTMUyeYcxqneVgP1K+2
         eoTXFb2gQmQfNAqzjgzVpUyt6L8XOdPf28+pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZQALRatgGYbV9MY7AZa7uBN2jjfiu74zaU+cT5Nuvk8=;
        b=t5LMgLaSx886rzvl8Fkt2HRWSFRHVeJKCP8MuEradHBq1Ftb7rXJL1Lq8ttT/IYwO/
         03PpuOVmSNfdU9xqcT94mrV6Tw5jJxi6o16KwkZwjY1zVsibpkjhOGP/E8xjwi6joHBJ
         hfBkLE7v42ZaQcXS2txe4+vfLJ7rvbUaEwhcN3byFUo0nu6j6G+aicyv4vR6kN33g9pF
         YqM6zS+4iLOC18MDJLfKpQiZH3BcPxKZSLeyBGRt3zG4aO8JeESzYM1MXEJUJLBYPfuv
         wLEjr1vD/LI16/Mrb+oxnJiZoJ2045Up/OZDB3vrrT1uYr1ohV4oK5GSCmjoT6VCAV1k
         +hlw==
X-Gm-Message-State: AJcUukfusIk2w3d0a2X8MwUMtd5jVecpOJ7XvJpVzYFGA9/CV/FAU13q
        nIY7gieyVjxYTGbyaitl7Zye
X-Google-Smtp-Source: ALg8bN49XPEHwxF3LkAYky1Y6Fu2tMEvs+rMyr27LxnflTESJUAzgeABKdsfpTbGh6Uaz21ep8KGJQ==
X-Received: by 2002:a62:1c0a:: with SMTP id c10mr16231264pfc.213.1548540170527;
        Sat, 26 Jan 2019 14:02:50 -0800 (PST)
Received: from dhcp-128-189-224-133.ubcsecure.wireless.ubc.ca (dhcp-128-189-224-133.ubcsecure.wireless.ubc.ca. [128.189.224.133])
        by smtp.gmail.com with ESMTPSA id q1sm35553923pgs.14.2019.01.26.14.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 14:02:49 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [v2 PATCH] rhashtable: Still do rehash when we get EEXIST
From:   Josh Elsasser <jelsasser@appneta.com>
In-Reply-To: <D5A6C2E7-2AB1-46D0-8876-2D6AAAA3937F@appneta.com>
Date:   Sat, 26 Jan 2019 14:02:48 -0800
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Elsasser <jelsasser@appneta.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A247F887-832E-44AD-AC41-C22E124E44EE@appneta.com>
References: <20190123211758.104275-1-jelsasser@appneta.com>
 <20190124030841.n4jtsqka5zji3e62@gondor.apana.org.au>
 <D5A6C2E7-2AB1-46D0-8876-2D6AAAA3937F@appneta.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2019, at 7:40 PM, Josh Elsasser <jelsasser@appneta.com> =
wrote:
> On Jan 23, 2019, at 7:08 PM, Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
>=20
>> Thanks for catching this!
>>=20
>> Although I think we should fix this in a different way.  The problem
>> here is that the shrink cannot proceed because there was a previous
>> rehash that is still incomplete.  We should wait for its completion
>> and then reattempt a shrinnk should it still be necessary.
>=20
> I can't test this right now because our VM server's down=20

Got one of the poor little reproducer VM's back up and running and =
loaded
up this patch. Works like a charm. For the v2 PATCH, can add my:

Tested-by: Josh Elsasser <jelsasser@appneta.com>=
