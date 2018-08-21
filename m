Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227DAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B3720C01
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LGlYzOkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B3720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeHULam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:30:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54027 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeHULam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:30:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B2F0104DCE;
        Tue, 21 Aug 2018 04:11:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=8XyzREhSl0Uh
        EHtATStEacLqCRw=; b=LGlYzOkqzAGnG6lnJMc8etPs/e91SROeMzps2rqwc5uQ
        ZBRge0YwXBmQFguYGyByXZN4LBxYJIZw4PpylvWx0yrAnMk0fXCKD2VWMMQyD3nV
        DxMb3OJ5bZe/hK8FyNlkekQnEgdXKm/ImJ9ApK0fforS31msQWOR17Kw2vbSZRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P1XHyD
        d2lL/E7mT8mPqKz00t5O0UaFmBU2xcGvsOYlzKZMM78BpkmyCx+RB5KQlkuon75L
        hIVx5Qtu9vWlOGrdQJZLfiS9F5AeArazkyXCle0RAvUCc0QVA6yBlLFPnBpKv6qJ
        5yGpVC/lGciKf72MGgleBa5n4mF6tq8kDjvf8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32421104DCD;
        Tue, 21 Aug 2018 04:11:30 -0400 (EDT)
Received: from [192.168.1.122] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2D2E104DCC;
        Tue, 21 Aug 2018 04:11:28 -0400 (EDT)
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        james.hogan@imgtec.com, joe@ovn.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        George Burgess <gbiv@google.com>,
        James Y Knight <jyknight@google.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <6b25ce92-7ffa-9fdb-c114-e7aa8f987b06@pobox.com>
Date:   Tue, 21 Aug 2018 03:11:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: CECF44EC-A519-11E8-B4A6-063AD72159A7-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/2018 03:25 PM, Nick Desaulniers wrote:
> + gbiv who wrote this cool paste (showing alternatives to
> _Static_assert, which is supported by both compilers in -std=3Dgnu89,
> but not until gcc 4.6): https://godbolt.org/g/DuLsxu
>
> I can't help but think that BUILD_BUG_ON_MSG should use
> _Static_assert, then have fallbacks for gcc < 4.6.

Unfortunately _Static_assert is a woefully inadequate replacement
because it requires a C constant expression.=C2=A0 Example:

=C2=A0=C2=A0=C2=A0 int a =3D 1;
=C2=A0=C2=A0=C2=A0 _Static_assert(a =3D=3D 1, "a !=3D 1");

results in "error: expression in static assertion is not constant."=C2=A0
Language standards tend to shy away from defining implementation details
like optimizations, but we need to have completed a good data flow
analysis and constant propagation in order to do BUILD_BUG_ON_MSG, et.
al.; this is why they only work when optimizations are enabled.=C2=A0 As =
the
optimizer improves, new expressions can be used with BUILD_BUG_ON*.=C2=A0=
 I
did an analysis of this back in 2012 of how various types of variables
could be resolved to constants at compile-time and how that evolved from
gcc 3.4 to 4.7:

https://drive.google.com/open?id=3D1cQRAAOzjFy6Aw7CDc4QauHvd_spVkd5a

This changed again when -findirect-inline was added -- i.e.,
BUILD_BUG_ON could be used on parameters of inline functions even when
called by pointer, although the caller needed __flatten in some cases --
a bit messy.

Daniel
