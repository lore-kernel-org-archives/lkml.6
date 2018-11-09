Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA85C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D052081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pl78IHcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D052081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeKJE0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:26:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55874 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJE0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:26:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so2930087wmc.5;
        Fri, 09 Nov 2018 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yU46RUwW3ShWzI88dU131V4UCp8+XGffSAvlQF+mFzo=;
        b=pl78IHcv0ovrDMBkDOFfrnGfjtAmLlr4s+clvGb5ojkWJkfcwCucYeYG3u1lIhVJHV
         THN4zyb8pDgHkm7iLTYWY+SCgOwgVJ06BPTgaU69tq9aRdHUKdwmPw7t9ahQkCJWdgr9
         nfI3IKnVZ33clbrsb3/RQM/YucVsnOncoO6m0A1RKVGAalUhICc8FZVix3eGl8KnwqLR
         sQDcD3YT17lwaU1SLiLp6cM5Sdya6SCn5pc/X8I0afrMVaJkQHeywAhdjoPb1ZVNR5Im
         Sq2vcbzzlnj0tVKdbJFH3MNHsdrbbnX4IUTVTJctA631Bw53jgIZScQMYyq34z09v+Jo
         +tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yU46RUwW3ShWzI88dU131V4UCp8+XGffSAvlQF+mFzo=;
        b=E9Grn9W1+mo/JAZh3z+ctSC8OltRE4D/KC70XFuH5oykDBzmyeUaKybxEluUFAun3U
         WQH91n6Xh2kBw9bON+Aydq3E1WmJ6+mM6glhc/mmrhcMViJLswdilNzLLk0z85/1fqSi
         d8XfNYB36HIOeSSTXc1C9umNMZgDRjAmYt8DH2eXqBjvsQSW6LXj78ZUuDreg3Cw99CZ
         xHU4FXKyQaX5/7vxgvm0buEz3yD1Cd77CImDNLzded5jyHw3g48aLFEyqBG26M387Sn3
         QGdWAP3k3fs1zokZGffhgmYtnIMYK2obOSoHEv9t+xCjhvM+53l/Cdh5f/fYzQ0RxprL
         8LZA==
X-Gm-Message-State: AGRZ1gIKsJYLffKn3cqCaxSkfNmC6XwBBC8NMi0o2JSMGC5Gw4qvMAii
        wNtbxqvic1/5dfJ17UIXGj4=
X-Google-Smtp-Source: AJdET5chCnQhI6qEmxQlWwycYK8xSIHxQ/NelIzFsw4J67PN0ZIXZGNmOYiwtatJ2a0lFsHXbHe8CQ==
X-Received: by 2002:a1c:4407:: with SMTP id r7-v6mr452139wma.16.1541789067756;
        Fri, 09 Nov 2018 10:44:27 -0800 (PST)
Received: from [172.20.10.2] ([2.48.42.190])
        by smtp.gmail.com with ESMTPSA id j25-v6sm5557057wrd.30.2018.11.09.10.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 10:44:27 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Smartlabs LLC
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <ae4a4f99-eecc-7a71-5007-d171449c8619@suse.de>
Date:   Fri, 9 Nov 2018 13:44:01 -0500
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5327F4D2-7348-4D5F-A077-D66D4ACB7553@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
 <1541706240-30036-2-git-send-email-christianshewitt@gmail.com>
 <ae4a4f99-eecc-7a71-5007-d171449c8619@suse.de>
To:     =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Nov 2018, at 1:29 pm, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>=20
>> Smartlabs LLC are a professional integrator of Interactive TV =
solutions
>> and IPTV/VOD devices (https://www.smartlabs.tv/en/about/).
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt =
b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 4b1a2a8..c424fe0 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -357,6 +357,7 @@ sirf	SiRF Technology, Inc.
>> sis	Silicon Integrated Systems Corp.
>> sitronix	Sitronix Technology Corporation
>> skyworks	Skyworks Solutions, Inc.
>> +smartlabs	Smartlabs LLC
>=20
> You added the LLC but did not upper-case the L - intentional?

Not intentional. I=E2=80=99ll correct this (and another mention in the =
dts) in v4.

Christian=
