Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C177C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F34F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cKMNfX7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F34F20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJOMbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:31:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40719 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeJOMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:31:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so18185106wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=/9lxciINDX88fH/9J5BZq5qgIoY6YTMx4c34oaO8upc=;
        b=cKMNfX7yr+e9wRclpgAwKH/aJxT/6RAFAX6YVLsoctbDeZHExu1hWDHQOOyVL/KSDy
         /VoNUctaKaVOjnCEZ4m7nn2XACepqTPOeA3tK6BjUHzskbobWOFsZKBeJ0WfJzlqZ0tn
         RLBeru3ONS4VOBPyIRGvW+29yHwN+/Jkbb/uo3LlSpoSvq5vlDbZnmD8vRu8G6+s64om
         uam4SB3ZYEQiqbfOZCdrObJxwIJ9oAibyp2tw1ZafVZaGfQrv6kPpwio/yjTgB0dK3DD
         uYkz2RwkNtESYNmwP3QKl8dCumybr1OP6aEMLYpKQ/GD3jxOJ9cX4wYviBsvGSUU06H9
         cFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=/9lxciINDX88fH/9J5BZq5qgIoY6YTMx4c34oaO8upc=;
        b=F0/lPiH8nuOaMFTowORyTCOhRc84xv7EE1/vC9Ir6pE0OROvhHzN/tNpIEZ4AcolcP
         hsFqoTe0nGKYxh5J+0MfeYp3c9nwpgL3Pj0iaa+1seVtr/pfLD1kQqY3oAt0csstGFK7
         l2sbhXPcowFk2fxpxhOeKNKbQ16jE16uoqBFh1Wpe+XkK/dSTIr38HMYwOzrzbyR0Vbs
         XVBT9Uvs48iqiOeSKQRGfKjHXz3XkLXM8bd1FPB3qwVdY7W9tq3dH8F3tGiv9gbnrVMh
         wkiPuKnn7LiQx2CtpSReqe2aBL7pkcbeAovuB4J5cKJ1dz2SP8sJTv7gyjWbPIwmfqup
         GUwg==
X-Gm-Message-State: ABuFfojKAUoaBxFs9OZEpAgD8O5HeXS6io2BirP4DtUD7YaiE2LvLG5u
        N3Wn0DulshpRvtZKX/QrnyRz2A==
X-Google-Smtp-Source: ACcGV62DUbZKrnjzPJKvsUET+8Fy5tlAg0YSG+n1ccWdyoUqRYQbLrg/pN5x38zZQzDYY6QabnbiPw==
X-Received: by 2002:a1c:5f54:: with SMTP id t81-v6mr12561016wmb.67.1539578867887;
        Sun, 14 Oct 2018 21:47:47 -0700 (PDT)
Received: from ?IPv6:2a02:8070:8895:9700:5890:9a92:fdcf:6ccd? ([2a02:8070:8895:9700:5890:9a92:fdcf:6ccd])
        by smtp.gmail.com with ESMTPSA id 64-v6sm7746746wrr.64.2018.10.14.21.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 21:47:47 -0700 (PDT)
Date:   Mon, 15 Oct 2018 06:47:44 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20181015000310.GX32577@ZenIV.linux.org.uk>
References: <20181014132510.25943-1-christian@brauner.io> <20181014132510.25943-2-christian@brauner.io> <20181014171855.GW32577@ZenIV.linux.org.uk> <20181014185345.o6uokigiytqugg6v@brauner.io> <20181015000310.GX32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] sysctl: add overflow detection to proc_get_long()
To:     Al Viro <viro@ZenIV.linux.org.uk>
CC:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <81C57381-F8F8-467B-84DF-8948F44B242F@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 15, 2018 2:03:10 AM GMT+02:00, Al Viro <viro@ZenIV=2Elinux=2Eorg=
=2Euk> wrote:
>On Sun, Oct 14, 2018 at 08:53:46PM +0200, Christian Brauner wrote:
>
>> > Yecchh=2E=2E=2E  First of all, the cast back to unsigned long long is
>completely
>> > pointless=2E  What's more,
>>=20
>> Sorry, seriously asking: why? This was meant to handle the case where
>> sizeof(unsigned long long) !=3D sizeof(unsigned long) and I just looked
>at
>> _kstrtoul() which does the same:
>>=20
>> int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
>> {
>> 	unsigned long long tmp;
>> 	int rv;
>>=20
>> 	rv =3D kstrtoull(s, base, &tmp);
>> 	if (rv < 0)
>> 		return rv;
>> 	if (tmp !=3D (unsigned long long)(unsigned long)tmp)
>> 		return -ERANGE;
>> 	*res =3D tmp;
>> 	return 0;
>> }
>>=20
>> Sorry, if I'm being dense here=2E
>
>C quiz:
>	given that type of e1 is unsigned long long and type of e2 -
>unsigned long, what conversions are going to happen in e1 =3D=3D e2?

Yeah, I know that=2E
As I said in my reply to Alexey before: I=20
thought you were saying the whole right=20
side of the disjunction was not needed=2E

I also do like the explicit recast and
followed what all of the other kstr*()
functions are doing=2E
Alexey sent a fix for all of them just
a few hours ago [1] which - imho - is=20
really not necessary=2E There's no harm=20
done by this and it's a fairly widely used
pattern=2E

That being said, happy to remove the
second explicit cast=2E

[1]: https://lkml=2Eorg/lkml/2018/10/15/22

>
>[relevant part of C standard: 6=2E5=2E9 (Equality operators),
>6=2E3=2E1=2E8 (Usual arithmetic conversions)]

