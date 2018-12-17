Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08345C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0550206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LemuU5y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbeLQTkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:40:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45538 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeLQTkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:40:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so12058526ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZ+agGPTRrX1qikCatzxzvf/PZbGdL0GHtPG/UUr35A=;
        b=LemuU5y5OA9rp/OiD/Xz+1aoMKz2d/HKfO55wkxHz370Ytih68aRgyRioYsoJJ9oIG
         J9tNsNEUc0F6A4YEPexbzPTr/LvBKgNbEllvWL2D013SKJR+RC2nHwME5G7kd4iPmu7j
         FexAPZn2eguy2UORVq7DOgW6ySihfQi5Wk9mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZ+agGPTRrX1qikCatzxzvf/PZbGdL0GHtPG/UUr35A=;
        b=Z35Yet/RhjXFrtrUcPDwZf1VrBOxzImWbg0jZhMwyt7vtxRoVpX+FtVATt8pWMY/xh
         GlFfFbF83zkyy8NK9/7CC0kjpTmmEDbWBd2f+JMicMQ2z0rQv2tbnhiAsOiBF4XJrs1A
         ANUOtbjp/Gei3xKzHA715OrtPw1KxPJv9g+yFB3YEktGhgFA36Z0JWZHuaRXiAH1nSZ8
         T3BQE+QHO1hRleX3wTltUURjhkcBye7TCEc1F3o1xHIinigIQSxgU8bvYuBhJg30MtHJ
         1lWmy3ERaU/0FCOaJqTIp0i2Kt3YgfbHJXoVWM77AIMCqLqWctPDp0PgqpW75TR7/vuh
         fhtA==
X-Gm-Message-State: AA+aEWY+nIW+iQLY03HV/BHsha3V5oZtG1ozy7pL5iiK12qx/KCn9UsN
        fOtisyKulyywtYymtIPpAy7mW/tSbhg=
X-Google-Smtp-Source: AFSGD/XRuF7ZB8cEx6/fxs7/r4bMH567yuYRRtulE3thh+i8h7WFwMbbSwB0ft2DNsneyWSKcYUA0A==
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr8073061ljz.54.1545075616466;
        Mon, 17 Dec 2018 11:40:16 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id n187sm2874721lfn.59.2018.12.17.11.40.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 11:40:15 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id x85-v6so12100534ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:40:15 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr9223416ljk.80.1545075613759;
 Mon, 17 Dec 2018 11:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com> <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Dec 2018 11:39:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
Message-ID: <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
To:     ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000001c3ace057d3cf3bf"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001c3ace057d3cf3bf
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 17, 2018 at 11:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, for being about "security", all of this code seems to be
> doing some really questionable things with all those Opt_xyz enums.

Yeah, at least security/keys/trusted.c ends up mixing that enum and
just using "int" completely randomly, and you have datablob_parse()
returning either a negative integer _or_ an "Opt_xyz" value, so having
Opt_err be -1 is doubly confusing there (it would also be "-EPERM"
depending on how you treat it).

There doesn't seem to be any _actual_ confusion (because Opt_err is
always turned into an actual real error code), but it's  just another
sign of "those enums should not be negative".

So on the whole, I think that the "Opt_err = -1" is a serious mistake,
but at least for now, ima_policy.c clearly has (bogus) code that
relies on it.

But the two cases that use "test_and_set_bit()" do not seem to have
any reason to use that -1 enum, so while we can't do the "just remove
-1" in general, I do think the proper fix is to just do it for those
two files.

Eric, mind testing a patch like that? Untested patch attached just for
completeness..

                    Linus

--0000000000001c3ace057d3cf3bf
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jpsq0m8p0>
X-Attachment-Id: f_jpsq0m8p0

IHNlY3VyaXR5L2tleXMva2V5Y3RsX3BrZXkuYyB8IDIgKy0KIHNlY3VyaXR5L2tleXMvdHJ1c3Rl
ZC5jICAgICB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2tleXMva2V5Y3RsX3BrZXkuYyBiL3NlY3Vy
aXR5L2tleXMva2V5Y3RsX3BrZXkuYwppbmRleCA3ODM5Nzg4NDJmMTMuLjcwZTY1YTJmZjIwNyAx
MDA2NDQKLS0tIGEvc2VjdXJpdHkva2V5cy9rZXljdGxfcGtleS5jCisrKyBiL3NlY3VyaXR5L2tl
eXMva2V5Y3RsX3BrZXkuYwpAQCAtMjUsNyArMjUsNyBAQCBzdGF0aWMgdm9pZCBrZXljdGxfcGtl
eV9wYXJhbXNfZnJlZShzdHJ1Y3Qga2VybmVsX3BrZXlfcGFyYW1zICpwYXJhbXMpCiB9CiAKIGVu
dW0gewotCU9wdF9lcnIgPSAtMSwKKwlPcHRfZXJyLAogCU9wdF9lbmMsCQkvKiAiZW5jPTxlbmNv
ZGluZz4iIGVnLiAiZW5jPW9hZXAiICovCiAJT3B0X2hhc2gsCQkvKiAiaGFzaD08ZGlnZXN0LW5h
bWU+IiBlZy4gImhhc2g9c2hhMSIgKi8KIH07CmRpZmYgLS1naXQgYS9zZWN1cml0eS9rZXlzL3Ry
dXN0ZWQuYyBiL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC5jCmluZGV4IGZmNjc4OTM2NWExMi4uNjk3
YmZjNmM4MTkyIDEwMDY0NAotLS0gYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQuYworKysgYi9zZWN1
cml0eS9rZXlzL3RydXN0ZWQuYwpAQCAtNzExLDcgKzcxMSw3IEBAIHN0YXRpYyBpbnQga2V5X3Vu
c2VhbChzdHJ1Y3QgdHJ1c3RlZF9rZXlfcGF5bG9hZCAqcCwKIH0KIAogZW51bSB7Ci0JT3B0X2Vy
ciA9IC0xLAorCU9wdF9lcnIsCiAJT3B0X25ldywgT3B0X2xvYWQsIE9wdF91cGRhdGUsCiAJT3B0
X2tleWhhbmRsZSwgT3B0X2tleWF1dGgsIE9wdF9ibG9iYXV0aCwKIAlPcHRfcGNyaW5mbywgT3B0
X3BjcmxvY2ssIE9wdF9taWdyYXRhYmxlLAo=
--0000000000001c3ace057d3cf3bf--
