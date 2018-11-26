Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0C7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD920855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWUXBf1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACD920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeKZLYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:24:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34409 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKZLYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:24:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so13002123plo.1;
        Sun, 25 Nov 2018 16:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLNxunBKeS7L/2I77pyJftMmlYM6z67XMFy8+TssWFA=;
        b=QWUXBf1igmwgFWdGsPQvWlVBp4QnL1ARION/vG6rpFESa1E0M8LzX5e1/rynTc1POQ
         byQjj+9DUnJ/xbBFTbWe27ZGcKjfzxKhdVOef9OwDBnFDN+txLChLthuhirUBpA1OCvB
         HEKwQQwzsau21NeZwf+saoqQ08sOjAeh3kDGoeHloyT46o+FEMAmNc2dxB75MnrWiUDc
         80PwxyDb/aGMpDwIjvW3vWyM0FwDC5/mD6kz6ijIRmIt70/TI7CRfXnK+6WwPxdvFfLz
         bE8ZGKSQfMhxXquARbKL/vjLSDArZD34RDo6er5fzcMf9LafVNDRsqo9TVDnKgYnxp9U
         m/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLNxunBKeS7L/2I77pyJftMmlYM6z67XMFy8+TssWFA=;
        b=EBmPCjJnwXZfcgotXqfyH0D7mTHz5yoDuW/rfdknORbu+ssr5Emf4uN3EBgdAZ/yOd
         0zQZglQ9hFpu4QOOua+86qACeJGQanb3rxtj1L1OENKajRCsRnEST4p0S6AAsNwzSqiz
         pefzgG4ZDa/9NY45+TxMQHsFR75HcCytqQNqIFtUMyA+1d9n+JbfH6xrWCD5d1kyOfsK
         jxOc4HssNglIYtR3YwXlr+sa+///gEJ5ZKruut8kdAOZcW4GiPRS9i2g6a53oHMIeuXL
         8fVWYeo/v7LOSduek3GvAL3OUOJSMoTQE5Kr2/d0HdFw63nvg5WVmos6FWaeKbcAWpm0
         3Y/Q==
X-Gm-Message-State: AA+aEWZySAT2EAQ6jsS0lNOYiNvzeuZHBQSuaSR2xzAunBzid1Gfbi/s
        P0TX5W1hrxNGE70Eh3lnvYnG2WqOFbZlO1SM9jo=
X-Google-Smtp-Source: AFSGD/WLHHltdnLKvW9aBq/C1YgBit2gZ2HfCq6GmMtQlSKk29/89BwdSuubQdQY9bR4qDuylzP80Kwo7uwEmmWKDU8=
X-Received: by 2002:a17:902:7107:: with SMTP id a7mr25089919pll.290.1543192311905;
 Sun, 25 Nov 2018 16:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20181126111415.5cf17f39@canb.auug.org.au>
In-Reply-To: <20181126111415.5cf17f39@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 25 Nov 2018 18:31:40 -0600
Message-ID: <CAH2r5mvtFzp=nYK+J92vh9y4tsNLT3rD4a2+mB9LMyWcFN-EHA@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sachin Prabhu <sprabhu@redhat.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, keescook@google.com,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of those cases are intentional fallthroughs and there are
existing comments in the code noting the reasons for them to
fallthrough

(also can see the reasoning for these in the commits which introduced
them from Sachin c369c9a4a7c82) and dde2356c84662)
On Sun, Nov 25, 2018 at 6:14 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the cifs tree, today's linux-next build (powerpc
> ppc64_defconfig) produced these warnings:
>
> fs/cifs/sess.c: In function 'cifs_select_sectype':
> fs/cifs/sess.c:527:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    switch (requested) {
>    ^~~~~~
> fs/cifs/sess.c:540:2: note: here
>   case CIFS_NEGFLAVOR_LANMAN:
>   ^~~~
> fs/cifs/connect.c: In function 'cifs_parse_mount_options':
> fs/cifs/connect.c:1825:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (!(tmp_end < end && tmp_end[1] == delim)) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/cifs/connect.c:1832:3: note: here
>    case Opt_pass:
>    ^~~~
>
> Exposed by my use of -Wimplicit-fallthrough
>
> I am not sure why these only turned up now (as opposed to earlier today).
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
