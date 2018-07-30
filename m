Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2F4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E5920870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="btVqLgMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E5920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeG3Ufq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:35:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53124 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbeG3Ufq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:35:46 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so766311itf.2;
        Mon, 30 Jul 2018 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6J3utehhL+aPCm/q2Mqvjy+w5/MEVNYomLjhlX3GIg=;
        b=btVqLgMeifQt6l8FSL943zenwZTRpLK9LH6yt/XKlfTdcO4y56lvmb8Kx6RuqcrJ0o
         l+IhpTLoMx7L7YCNxOx8s7pGZ2Ltl8jPB6gnCkkjwAdyuLzlciVkugfzkT8cdbsaoEHL
         vPI7vWIo96V1B8svbnbNLfIQzd32BZSVknIkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6J3utehhL+aPCm/q2Mqvjy+w5/MEVNYomLjhlX3GIg=;
        b=cvQlEiFUFRDxIj7lUZ/jMEx2iQkVJnNd/SMa47Mh1SMMMDCttuqXIsRrtIGr7w9MSb
         Mw5Nzyxb6NvLN+3ljpNVMQRIU8W7ci/FQburoaxSJD6ls37h2j+Q4EHjCGH17INQnIIw
         hFD5W7P+Xd+tZ45q//finxg0KWgTNR7b4f2ftg9WQJ7VF6d3fyuaXB6AHLj00XAHxq8c
         E0oLfZcOuezEYEyxwNN6nq6hAAvG65NAuAaTl2Yhug4DtodD6GHIavCIx9bcvVsoBURg
         hta+uX2ATZXsw/b2yE4PpNfN+eoGl9lHnf/uYoKMGF7QldH0OXtqy2sXXxuWAouVAA5c
         MPHw==
X-Gm-Message-State: AOUpUlEisC3E+qYzJYhteQLXXtWvCwVAOCwbJIemdif7b9wfdL1JANzI
        coz1lqn0puvPtPr8uaZ5Ro/l25sldD7xMGSCkdQMt8MY
X-Google-Smtp-Source: AAOMgpdexvbW9YNulKiwKLuC4zmZ+XcbCh4Ql/Dz6qEB0jLtngOefGzKUvN7j4T6dO4zbMqSjUM7z+utfagsh/0wVew=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr494797itb.16.1532977164087;
 Mon, 30 Jul 2018 11:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180729113749.GA7333@amd> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk> <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org> <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com>
 <20180730183847.GB5544@bombadil.infradead.org>
In-Reply-To: <20180730183847.GB5544@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Jul 2018 11:59:13 -0700
Message-ID: <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pavel Machek <pavel@ucw.cz>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:38 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> I wasn't proposing putting gettext in the kernel.  I was reacting to
> Pavel saying "You can't return English strings from the kernel, you have
> to translate numbers into any language's strings".

The problem with gettext() is that if you *don't* have the strings
marked for translated at the source, you're going to have a hard time
with anything but the simplest fixed strings.

When the kernel does something like

     mntinfo("Option %s can not take value %d", opt->name, opt->value);

a gettext() interface inside the kernel (which really would be nasty)
would have seen the format string and the values independently and
would have generated the translation database from that.

But once the string has been generated, it can now be thousands of
different strings, and you can't just look them up from a table any
more.

Real examples from David's patch-series:

                errorf(fc, "%s: Lookup failure for '%s'",
                       desc->name, param->key);

                errorf(fc, "%s: Non-blockdev passed to '%s'",
                       desc->name, param->key);

which means that by the time user space sees it, you can't just "look
up the string". The string will have various random key names etc in
it.

But the alternative to pass things as format strings and raw data, and
having all the rules for a "good gettext interface" are worse. It gets
very ugly very quickly.

So I really think the best option is "Ignore the problem". The system
calls will still continue to report the basic error numbers (EINVAL
etc), and the extended error strings will be just that: extended error
strings. Ignore them if you can't understand them.

That said, people have wanted these kinds of extended error
descriptors forever, and the reason we haven't added them is that it
generally is more pain than it is necessarily worth. I'm not actually
at all convinced that has magically changed with the mount
configuration thing.

             Linus
