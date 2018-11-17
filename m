Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC9EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 06:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ECC20854
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 06:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="PASdkFuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48ECC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbeKQRC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 12:02:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39438 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeKQRC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 12:02:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id 192-v6so21481445oii.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 22:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gOwb6rbA/AGKAZ14HGgeubAeMfCDv7k0ew+zR1pUuf4=;
        b=PASdkFuCahWiTBSHhFFNtn0g5J1U9QkS20Og94z5gwbho9Xn2OqNd6mzVZCmIVIZK4
         jHwWDBFPWhHQf37zUSQE/AZH2tt339MFTgphpjfcfMIGK3QLgwQYyEPw3HHRVSvkACIx
         pEbjBqtn+IU6xATGpUw61A8xqS3KerC1DZWKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gOwb6rbA/AGKAZ14HGgeubAeMfCDv7k0ew+zR1pUuf4=;
        b=Moaib8csP/G3TGQXKydHhha4NFT5ED7/gZbbLr+pMGliFL46z55DJSKSa98BJ0PP/0
         KZJ0ppIeJSgM1oX0DBE+9Gykn5AYbqEBLBgGfkTNVgEXn7tfzSWZOg50EDchVymASvYt
         YMqBCXHPeGpJ2qErBHlG21R4O3vHhaDh+O+XXGvDBL+WIu43zKKk676w77kJrqhql7Ld
         Eo8kSfpHJDCOMTeu3gEfaMltCNIKamyu3djLp6E2gRrv1xhfMYVuXBd/ed+MIt2GCzmM
         6b7SIl0f+yEyrj29083Os+9MjsUbHT1A7PqRRRZEkpAsMU7GM9S2OLoVxmySyEiSKa+V
         GYnA==
X-Gm-Message-State: AGRZ1gIcs/VSo9HD/08Mi62wE5w3K2wa2AY8U2fWVr3Dp+qa+YcbStUW
        yydWm2NgcsZzIpvfZ1oP/1v3Yw==
X-Google-Smtp-Source: AJdET5ecB7uesDESzrFfyvfAt0lj9UGagrn3S1/z/j98T9E5K+PL25YC743RgGh6ELBTgy7M6kXZRA==
X-Received: by 2002:aca:4d47:: with SMTP id a68mr2528347oib.43.1542437235365;
        Fri, 16 Nov 2018 22:47:15 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id u19sm1128204oia.31.2018.11.16.22.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 22:47:14 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id w13so8885222oiw.9;
        Fri, 16 Nov 2018 22:47:14 -0800 (PST)
X-Received: by 2002:aca:ec55:: with SMTP id k82mr2085486oih.55.1542437234139;
 Fri, 16 Nov 2018 22:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-2-starnight@g.ncu.edu.tw> <aaee242e-a287-9db6-4374-73f2ee9fc9d2@suse.de>
In-Reply-To: <aaee242e-a287-9db6-4374-73f2ee9fc9d2@suse.de>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Sat, 17 Nov 2018 14:47:15 +0800
X-Gmail-Original-Message-ID: <CAC=mGzh=caPcg-98vCUx+tEsb482cWtw3TonXS=ARhssj3Tcaw@mail.gmail.com>
Message-ID: <CAC=mGzh=caPcg-98vCUx+tEsb482cWtw3TonXS=ARhssj3Tcaw@mail.gmail.com>
Subject: Re: [PATCH V3 1/7] net: lorawan: Add macro and definition for LoRaWAN
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas F=C3=A4rber <afaerber@suse.de> =E6=96=BC 2018=E5=B9=B411=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:12=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Am 14.11.18 um 17:01 schrieb Jian-Hong Pan:
> > This patch adds the macro and definition for the implementation of
> > LoRaWAN protocol.
> >
> > Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> > ---
> > V2:
> > - Modify the commit message
>
> Note that both v2 and v3 don't seem to be based on the latest lora-next
> branch, as your constants are already queued and used there.

Oh!  I see the commits now.  V4 patch set will follow the latest branch.

Thanks,
Jian-Hong Pan
