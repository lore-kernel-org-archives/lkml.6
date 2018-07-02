Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F85FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB091255AB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULa8AWbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB091255AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeGBAMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:12:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39375 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeGBAMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:12:43 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so7038064plq.6;
        Sun, 01 Jul 2018 17:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=5FEIAL/TUjLtICR48hur9kUozIq4AKaz+YxEjnFY7Oc=;
        b=ULa8AWbHrCMa4pQ1VgZa8Z/Ut0cb2WFLobWIsbhNEyT9y6Rl1EU1r4eExnoTuo7ZPP
         mSaFD0uDXQRPf4/b+hDaN4ePa1UgvsRSyCq0QP0lcodENnWt7HnixB8b71XOmjzi9MVl
         fvaJBEhltwe8E0l1AvSKL1IDo/Nmrz6PQ8SffhhDY3qBNb5rBlFCJXhytXN9wAkz9bRU
         fSS9Yh0xD6cOv8YJfSYVtyj7kkGCfxwybESSXGzXXxamv3ZzsBBr7R/TE1qbwb9kPX0q
         s8LPXffqyrLYiiygDmmN6TSMJ69TEJhgp/VZqymFJOsaNc9VJWBSw8VRg0r33PAaKijZ
         dRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=5FEIAL/TUjLtICR48hur9kUozIq4AKaz+YxEjnFY7Oc=;
        b=um3E4ZKhnuQRYb7daZb5B7dn/EMaiu+9Rl7xq9ao/MV/EkqNq3B80vA6n6y0uQuMas
         EYnH1lYhCyqU3eLQRrNt8QE/L58nRnrRW/9o8dou9NC7q4pgKMNqFf1ok9l+nw38pTLY
         iCFWtHFxsIHOznYLt/I2VJq7Qpe2nVS6LAKaLNxkBcaQiI8eo/Hdt/RvetgBz98ZaNj9
         804rIYE0oW7/pc6kb4JHlsl2SnuU5pY7fkUFeRrLKvB2NWJHfdGEnrHbQC3rAQ3vxBiw
         43IIMri+mOJEzHGoNHEAZYVdU3GX8vjdgfFY/Nh/7EHzMkPCtwbu8HubqNi6Al/noJ0r
         BceA==
X-Gm-Message-State: APt69E0T+m8KsEHQ7UU6zkIowwFP1/JHbFSooGjF8zmwXkjb0+DmPwsC
        u50N+/cmAHomKrX6q8AVq9U=
X-Google-Smtp-Source: AAOMgpd2Vu1r4N0E2RaUnZqF9mPG8bRd1UVKdXp/tOLBQdVT0YUauhxzxF5ro5Zzu9p1NvVV/zOacQ==
X-Received: by 2002:a17:902:d692:: with SMTP id v18-v6mr16464984ply.59.1530490362129;
        Sun, 01 Jul 2018 17:12:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4001:5a00:6d23:90c7:3039:df6a? ([2601:647:4001:5a00:6d23:90c7:3039:df6a])
        by smtp.gmail.com with ESMTPSA id r6-v6sm13978902pgv.0.2018.07.01.17.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 17:12:40 -0700 (PDT)
Date:   Sun, 01 Jul 2018 17:12:37 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw> <20180529180506.GB167092@dtor-ws> <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw> <20180622001632.GI79890@dtor-ws> <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com> <20180701234419.GA250349@dtor-ws> <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with middle key
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     kt.liao@emc.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        ulrik.debie-os@e2big.org, phoenix@emc.com.tw,
        aaron.ma@canonical.com, josh.chen@emc.com.tw
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <A5DA555C-6131-4F7B-82F2-A06C12E23CAF@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 1, 2018 5:00:03 PM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Sun, Jul 1, 2018 at 4:44 PM Dmitry Torokhov
><dmitry=2Etorokhov@gmail=2Ecom> wrote:
>>
>> The reason it got messed up is I switched to pulling patches from
>> patchwork=2Ekernel=2Eorg as it collects Acked-by and Reviewed-by tags s=
o
>I
>> do not have to add them manually, but unfortunately it does not do
>> proper UTF-8:
>
>Ugh=2E
>
>I made an 'issue' of it for patchwork:
>
>  https://github=2Ecom/getpatchwork/patchwork/issues/194
>
>and hopefully that can be fixed=2E It's sad when we corrupt names like
>this=2E

Might not even be an issue with recent patchwork, but unfortunately the ve=
rsion that is running on kernel=2Eorg is ancient as far as I know=2E


Thanks=2E

--=20
Dmitry
