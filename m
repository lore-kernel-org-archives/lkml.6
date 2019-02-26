Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6DCC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6794E217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PJJsUkox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfBZADk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:03:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37090 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfBZADj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:03:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so12896628qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nTyz3nhhRJAnQKCmBEdqx7AWOxz2VXU5sIgb32iHM/w=;
        b=PJJsUkox6+CF/dkHN/mWvihVRBMQXaHtCiEK3yJYAb26Tnfg3gdEmPvv/P7OJSRryw
         EwoaelNhNXnt48CV6HmkElLK/lu0JFMFftzxEkZbHBXWOO/u4FrvWRouZOm2jiDUMDK+
         8t6zAp0mzvSZYCxIae8QNfmbe1iV1FXNJ+J6XXCXi6wiK2VDHqFxNAAYEWH5XEqm7Nsn
         9wcxN8A9r66KZTvMxvKt0fX1Fv/jQrIRUNQVcBefS6kjMtPnlv8uLO8iwOeIprTMyG/u
         cyc70TkE9lmuapdwSWKEFkF9aSaZB1N1gFpyD/yCaAdnI18EaAm9qdFR8A0Z/GXzDCEq
         6BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTyz3nhhRJAnQKCmBEdqx7AWOxz2VXU5sIgb32iHM/w=;
        b=IQJGKgbLo2XCC8x1KvqoMUQmUbqQr6x+zjJssEHFiAnsya/C8CHHvCDzcmtvHHR25N
         pqM0rtNNYvV4nGro4qXAna/F3aZU8d1C/Q7TTEXv0AqPAgAncpux2OnmINz7NdTrIC/H
         KttrDLut4g8f85mC11MmgXUtE+XN0zwcwjOtZmpzG7y4iWV73OVxZ/oLmSvJYG+qPi/9
         9UJ0j81TuOYPXN4Vejkc4+cANp2LbZXkum6WKFfpj14CbiLPKzUqXuL1FK1RTViRC5w4
         fSCgOe/gEfPSK0mkYUy45s2dMFlDPM8Z6RgZNVVNvpTKwep5xwFxKpc0bmgaSDiapq91
         Hing==
X-Gm-Message-State: AHQUAubzwEERy4fcaJCm7DPzuRsBbQtQGWKbXdtens/Hxb/QScEbMuCT
        v5oOa8egGyh4CI9vtEG77yafVTOouz4=
X-Google-Smtp-Source: AHgI3IY3Rv9382UHR/eB55SAV2oFmZhY4NP5S3bSRzOz/Z3hwV7neRHhA0HwE0IAIdN7HevRouSW8Q==
X-Received: by 2002:ac8:1e15:: with SMTP id n21mr16392133qtl.342.1551139418281;
        Mon, 25 Feb 2019 16:03:38 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z140sm6241992qka.81.2019.02.25.16.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:03:37 -0800 (PST)
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190221222123.GC6474@magnolia>
 <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
 <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
 <alpine.LSU.2.11.1902251214220.8973@eggly.anvils>
 <CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com>
 <CAHk-=wiwAXaRXjHxasNMy5DHEMiui5XBTL3aO1i6Ja04qhY4gA@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <86649ee4-9794-77a3-502c-f4cd10019c36@lca.pw>
Date:   Mon, 25 Feb 2019 19:03:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiwAXaRXjHxasNMy5DHEMiui5XBTL3aO1i6Ja04qhY4gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/19 6:58 PM, Linus Torvalds wrote:
> On Mon, Feb 25, 2019 at 2:34 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Mon, Feb 25, 2019 at 12:34 PM Hugh Dickins <hughd@google.com> wrote:
>>>
>>> Seems like a gcc bug? But I don't have a decent recent gcc to hand
>>> to submit a proper report, hope someone else can shed light on it.
>>
>> I don't have a _very_ recent gcc either [..]
> 
> Well, that was quick. Yup, it's considered a gcc bug.
> 
> Sadly, it's just a different version of a really old bug:
> 
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501
> 
> which goes back to 2004.
> 
> Which I guess means we should not expect this to be fixed in gcc any time soon.
> 
> The *good* news (I guess) is that if we have other situations with
> that pattern, and that lack of warning, it really is because gcc will
> have generated code as if it was initialized (to the value that we
> tested it must have been in the one basic block where it *was*
> initialized).
> 
> So it won't leak random kernel data, and with the common error
> condition case (like in this example - checking that we didn't have an
> error) it will actually end up doing the right thing.
> 
> Entirely by mistake, and without a warniing, but still.. It could have
> been much worse. Basically at least for this pattern, "lack of
> warning" ends up meaning "it got initialized to the expected value".
> 
> Of course, that's just gcc. I have no idea what llvm ends up doing.
> 

Clang 7.0:

# clang  -O2 -S -Wall /tmp/test.c
/tmp/test.c:46:6: warning: variable 'ret' is used uninitialized whenever 'if'
condition is false [-Wsometimes-uninitialized]
        if (inode->i_nlink) {
            ^~~~~~~~~~~~~~
/tmp/test.c:60:9: note: uninitialized use occurs here
        return ret;
               ^~~
/tmp/test.c:46:2: note: remove the 'if' if its condition is always true
        if (inode->i_nlink) {
        ^~~~~~~~~~~~~~~~~~~~
/tmp/test.c:37:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 warning generated.
