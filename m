Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53EAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707E32543E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="neEzZA2M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YJ08I1B1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707E32543E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeGBMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:13:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52604 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeGBMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:13:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 311ED607DC; Mon,  2 Jul 2018 12:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530533580;
        bh=Ql+TztfPbdYbf+Bn5SmIzIwXr8q1nG9pok5uc/ECPk4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=neEzZA2M2sZVHnYQ+uAo/0yLAdYZ21BmJQ+Idnj0Kdpw5leTGFuMTsErpnF0e4iiq
         ej2IZxfUdk42wflypwB5sY7m8rLb49JNOnfhaSgf5aKnxSCChnNUj3vT9VBELhBv7r
         +1PX44jKkkZ1AN4KCChC6/1xTS3S7X523AXwZr00=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E610605A4;
        Mon,  2 Jul 2018 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530533579;
        bh=Ql+TztfPbdYbf+Bn5SmIzIwXr8q1nG9pok5uc/ECPk4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YJ08I1B1ZpfblvFk9tyMI7LVPGqbgLJt4+w7NOtMLbO44PCAGooi8BOehjG+WS935
         6RVVnCfEGkVHcfvDrGJPEymCrp3MXABejc/a/2yrHKY9X1VW3L27oAAwkrSUVEK1ML
         OTMicA+pgpoR+V1XH5Gedju9/9SlZo1NR52DUCt8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E610605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, kt.liao@emc.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        ulrik.debie-os@e2big.org, phoenix@emc.com.tw,
        aaron.ma@canonical.com, josh.chen@emc.com.tw
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with middle key
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
        <20180529180506.GB167092@dtor-ws>
        <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
        <20180622001632.GI79890@dtor-ws>
        <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
        <20180701234419.GA250349@dtor-ws>
        <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
        <A5DA555C-6131-4F7B-82F2-A06C12E23CAF@gmail.com>
Date:   Mon, 02 Jul 2018 15:12:55 +0300
In-Reply-To: <A5DA555C-6131-4F7B-82F2-A06C12E23CAF@gmail.com> (Dmitry
        Torokhov's message of "Sun, 01 Jul 2018 17:12:37 -0700")
Message-ID: <87sh5196pk.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On July 1, 2018 5:00:03 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>On Sun, Jul 1, 2018 at 4:44 PM Dmitry Torokhov
>><dmitry.torokhov@gmail.com> wrote:
>>>
>>> The reason it got messed up is I switched to pulling patches from
>>> patchwork.kernel.org as it collects Acked-by and Reviewed-by tags so
>>I
>>> do not have to add them manually, but unfortunately it does not do
>>> proper UTF-8:
>>
>>Ugh.
>>
>>I made an 'issue' of it for patchwork:
>>
>>  https://github.com/getpatchwork/patchwork/issues/194
>>
>>and hopefully that can be fixed. It's sad when we corrupt names like
>>this.
>
> Might not even be an issue with recent patchwork, but unfortunately
> the version that is running on kernel.org is ancient as far as I know.

FWIW I use patchwork.kernel.org and I don't have any issues with UTF-8
characters in the From header. For example, here's one patch which I
recently applied:

https://git.kernel.org/linus/88001968245c

But of course it depends on what tools you use (I have my own patchwork
script which downloads and applies the patch) or what characters there
were etc. 

Also I heard that we should get an upgrade to patchwork.kernel.org in
the near future, which is great. The current version has some quirks
which are quite annoying.

-- 
Kalle Valo
