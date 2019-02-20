Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F111C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD07206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="Assm9sHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBTL1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:27:39 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55443 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfBTL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:27:36 -0500
Received: by mail-it1-f196.google.com with SMTP id z131so14357507itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DoGE2pIFq4ubGHfc/mgOwo7hisFsZHMo9JLB0XPojA4=;
        b=Assm9sHJXis3gubTHprb1f2OeaA7YsSyF1G5/c35dzJ+vBl7n/MXSVSn8Tkyw6QNVb
         d6w+ZuEh0hcOmo8sGDBp4KK3RrFla06I1Ta/3TS/xqP4WExgeAHlwFEtxyb9PfGcSkJH
         dLX1/F9qu1hYhV9Dw1Y4eojYniHrLfkdgql7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DoGE2pIFq4ubGHfc/mgOwo7hisFsZHMo9JLB0XPojA4=;
        b=ogjsfzqmQbfVhtbwdLBQ/EuHS9lJW0+MHip0QsVnz79MIVUdaRsP6hIw2XI8AWODC2
         Xh8R6DRYlNjGdHfVIhVLgSd5n1UU1BMJX6KrvEnPFVuAytlFDTZ7Cp98kvZLY3s+yWa9
         nPEWUqXM87GnN/01w69csWmYkkOzWNpzibBrK9X2tWdluxb5B95nOnLpZm/K0ogtm4NR
         xk0JQLzvzWied+g9yGA3Co4HEpNhClSV97FBUgz5kHQH1HH28lIrau4sqeB7P6PUd4lo
         AWb/j0aj7SC9rE7PinZo+TpoikPcoiBN/rZ1zoxG2XXQDxWol+LSMgttMdWV1MRWueXi
         XN5Q==
X-Gm-Message-State: AHQUAuadJdM5cZUqekpaktkCcySdZ7L6/0VtxHKPHtmaeeafx8IAO9rL
        vvgV22OyGdQ61FKUOwJcqz3nlm1NE2s=
X-Google-Smtp-Source: AHgI3Ib1+XEdd824hDstk1vTXp5veGGztXENzrF9jZP8HM/iRcT02NTX0IWZcCW/AFLG26toVmnZRw==
X-Received: by 2002:a24:3dca:: with SMTP id n193mr5672615itn.48.1550662056092;
        Wed, 20 Feb 2019 03:27:36 -0800 (PST)
Received: from [10.10.2.82] (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.gmail.com with ESMTPSA id c31sm2520273itd.25.2019.02.20.03.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:27:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH][udf-next] udf: don't call mark_buffer_dirty on a null bh pointer
From:   Steve Magnani <steve.magnani@digidescorp.com>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <20190220095015.GB27474@quack2.suse.cz>
Date:   Wed, 20 Feb 2019 05:27:34 -0600
Cc:     Colin King <colin.king@canonical.com>, Jan Kara <jack@suse.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9E129B8-B914-4E9B-8AAF-76C64E9D8F8B@digidescorp.com>
References: <20190219114403.24771-1-colin.king@canonical.com> <20190219140240.GA31849@quack2.suse.cz> <aef899da-4dc1-1e40-30c9-fc2ca87f2380@digidescorp.com> <20190220095015.GB27474@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 20, 2019, at 3:50 AM, Jan Kara <jack@suse.cz> wrote:
>=20
>> On Tue 19-02-19 08:17:09, Steve Magnani wrote:
>>> On 2/19/19 8:02 AM, Jan Kara wrote:
>>>> On Tue 19-02-19 11:44:03, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>=20
>>>> There is a null check on the pointer bh to avoid a null pointer derefer=
ence
>>>> on bh->b_data however later bh is passed to mark_buffer_dirty that can a=
lso
>>>> cause a null pointer dereference on bh.  Avoid this potential null poin=
ter
>>>> dereference by moving the call to mark_buffer_dirty inside the null che=
cked
>>>> block.
>>>>=20
>>>> Fixes: e8b4274735e4 ("udf: finalize integrity descriptor before writeba=
ck")
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> Thanks for the patch! In fact it is the 'if (bh)' check that's
>>> unnecessarily defensive (we cannot have sbi->s_lvid_dirty and
>>> !sbi->s_lvid_bh). So I'll just drop that check (attached patch).
>>>=20
>>>                                Honza
>>>=20
>>>> ---
>>>>  fs/udf/super.c | 12 ++++++------
>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>=20
>>>> diff --git a/fs/udf/super.c b/fs/udf/super.c
>>>> index a6940d90bedd..b7e9a83d39db 100644
>>>> --- a/fs/udf/super.c
>>>> +++ b/fs/udf/super.c
>>>> @@ -2336,13 +2336,13 @@ static int udf_sync_fs(struct super_block *sb, i=
nt wait)
>>>>              lvid =3D (struct logicalVolIntegrityDesc *)bh->b_data;
>>>>              udf_finalize_lvid(lvid);
>>>> -        }
>>>> -        /*
>>>> -         * Blockdevice will be synced later so we don't have to submit=

>>>> -         * the buffer for IO
>>>> -         */
>>>> -        mark_buffer_dirty(bh);
>>>> +            /*
>>>> +             * Blockdevice will be synced later so we don't have
>>>> +             * to submit the buffer for IO
>>>> +             */
>>>> +            mark_buffer_dirty(bh);
>>>> +        }
>>>>          sbi->s_lvid_dirty =3D 0;
>>>>      }
>>>>      mutex_unlock(&sbi->s_alloc_mutex);
>>>> --=20
>>>> 2.20.1
>>>>=20
>> Reviewed-by: Steven J. Magnani <steve@digidescorp.com>
>=20
> Is this Reviewed-by for my fixup or the Colin's? Because I've decided to
> rather remove the 'if (bh)' check completely since it is pointless...
>=20
>                                Honza
> --=20

Sorry, I realized on rereading that this could be ambiguous. The R-B is for y=
our patch.

Steve=
