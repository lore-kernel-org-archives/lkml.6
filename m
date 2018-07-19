Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1BBECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6C22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHdFzjK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6C22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeGSDy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:54:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41577 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbeGSDyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:54:25 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so2932599ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 20:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U0VR0N16rYKwBr4VTWX+/iATtfJpQvWQNZEP91IwEm4=;
        b=aHdFzjK2M/H/gGON6QJPWcItxE53X1oUkh/0lmFBWo0YIakAoCSLrJ1uLURNpTJ6NF
         46h+SjeIPKigwj5/8YQv6Xjat0Kiuu33Ye13i6xIwdNSUOCmSyy7xCM03xdWaWOg6u0N
         Rg8mA+A8tM3SQCAz8oq8sMsC+yaDL2qcaHfu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U0VR0N16rYKwBr4VTWX+/iATtfJpQvWQNZEP91IwEm4=;
        b=TZxnM8FYkIMeLB4aLYKbqDtleYrc+jIu0T+1V0jreAp6EvBtDKg6oaoXdmkxqaLpwx
         4LKGjLBrVEwTPrj89RnrpdVgDnk2qVeNfAwxuVLi4r/uiiLHvZlojv5jxWoOyqK6UMGW
         wGZoRLNSasMNwZ6ipflI9h1CRX/XI2pCA44rRW3fPVvkZKrwOmb2b74iEDLvwPOBBCm6
         JcLjtlBIfLri04dU1n4TIDsEiLfCokbTOB/pzh6s/sogl3Y8Xds9ryfNpUzG/f07KL72
         EQUUjunvGW8cOI+lGcJnmT7AGPfxcMHPDh/CcJar1faLtvnyZbwLCxoI0q8u1CF2uTqm
         GHVg==
X-Gm-Message-State: AOUpUlGJh00TT+yIkNjJkEqOzxIo5zDxz/Yk9GMoUkvLk0to6M17bttE
        4OQmijtKMMpBH5xCnWh4UzFQ3A==
X-Google-Smtp-Source: AAOMgpfAXW9YqcsTYiPYOD4oJVW2Om1TPz99ZO9C927aBMR4FLoNBu7kl0rgScTtQAi0k/UcBT6C+w==
X-Received: by 2002:a17:902:760d:: with SMTP id k13-v6mr8261622pll.56.1531970010914;
        Wed, 18 Jul 2018 20:13:30 -0700 (PDT)
Received: from [192.168.43.86] (om126204197014.6.openmobile.ne.jp. [126.204.197.14])
        by smtp.gmail.com with ESMTPSA id d132-v6sm8678373pgc.93.2018.07.18.20.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 20:13:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <CAGXu5jJyyi1FvT9PytMkU_rPeSqMSHR7asjn8ykShZGGRPPRDg@mail.gmail.com>
Date:   Thu, 19 Jul 2018 12:13:27 +0900
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9125A0C-45C8-45FF-93F6-B7AD9DC86347@linaro.org>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
 <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com>
 <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com>
 <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com>
 <CAKv+Gu-cOV6uo6MpLxr9uQSTT-ku_wn9+D7CC4+3maJtvcaGoA@mail.gmail.com>
 <CAKv+Gu8e9sm42NKwQvQzD33JTHSaEY2q7sm0W0065dDz_rzSaA@mail.gmail.com>
 <CAGXu5jLuWfZFTs390c3WSAReLrQ6_KOOvr0FYjXhUQ5h5b8xWA@mail.gmail.com>
 <B278D0F7-71B6-4F3D-B625-D8B0298CE5B4@linaro.org> <CAGXu5jJyyi1FvT9PytMkU_rPeSqMSHR7asjn8ykShZGGRPPRDg@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 19 Jul 2018, at 12:09, Kees Cook <keescook@chromium.org> wrote:
>=20
> On Wed, Jul 18, 2018 at 7:55 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> I have only build tested it, so if you make sure that it does not break a=
nything, please go ahead.
>=20
> I can give it a spin; what's the best way? Is CONFIG_CRYPTO_MANAGER=3Dy
> sufficient?
>=20

You should be able to test ccm(aes) with tcrypt, yes=
