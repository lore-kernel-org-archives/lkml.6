Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A19EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBDB2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sC5fcPJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBDB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeLCXvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:51:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40986 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLCXvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:51:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so12651499oii.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsWUe022LF/t0itiCLuHiX3UzdU7WKeYTHhtphhD+gI=;
        b=sC5fcPJ9QNh+3sCv7cmIwYT6GBlanFtBcl5o+cyqcWamfC1qRrFSeAtSPOZt30HWbn
         EvcF8VPN3lqxI1Jb1o/jSSUEtKUGGj2x056LmfX6XwMJm5Ty26FvV99swyG+pTu7TQIM
         pVSWQALb5ZgSIY5E67FbnmC8NBHpzhMHve1t+qC66EQUiJ1PiaE0JcI2lRKlfdWTZWwE
         q4M4dTCz9y8dEwV7hCDhjtQNbKEt6ZBNKBNFstl29Z9dfJc1GbtdlVbiY8/hdKfh2gqZ
         9KNd4EV9EERCktPRvM4IrnAwuhLLxd+RUIBqrbPTMR59+k3mRwdLDmDsKwD3wfSwNH73
         cw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsWUe022LF/t0itiCLuHiX3UzdU7WKeYTHhtphhD+gI=;
        b=b92UCFtKsqhq+NW1jq4MdStI1Zbs9gFS/eomTZYrcxf15cP1d0Z2HnSf75SNS/2d9a
         ejfArUn7Vx8J07XkWBA6gsu6E0kqo6RdAY1uWsiD1fW98YD4U8Ihc4ze9Fj+3ZkGOext
         ZMA8L8flgFexNQYdg3tqCEp1IAL0ffhaZYh0XSMIAEOvr1aOm0Yq+maGOK+TVRJYwuJR
         SAK5CF4ahqQ1J0aU0wKGHuFkteg9g5FRAAnTjulSFT4FKqsWHPymEslFrWjus979qX/5
         XnZofvcer3pgPb8Px0+gqyeX+hIajR7GDkfTtXFROGgUdRn4LRZckdu59J9ja5MFGudY
         JmIg==
X-Gm-Message-State: AA+aEWb1gWjlIN/4CkmsaMeH+j7ql+a1YbNFxJYsZUKJPXHrLSX8rb+o
        eZUkEoTzu/60D6xRDjB3tejXKpF8pW9JsIiykz/tcA==
X-Google-Smtp-Source: AFSGD/VHvULRfcK0dCnZrO6cOol0p/59wC5J8IAX6ZLqaBaf60vfwj2xmA7+upwyHrMq/A0Oe1NWsi7Hk0L/IdNbiig=
X-Received: by 2002:aca:54c4:: with SMTP id i187mr10673903oib.238.1543881060114;
 Mon, 03 Dec 2018 15:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com> <20181130034425.GO18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130034425.GO18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 15:50:48 -0800
Message-ID: <CAFd5g44L1dV61CPm9GUvOgs-tH_urN-Twm-fj=Pw6h-kgfZ5rQ@mail.gmail.com>
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
To:     mcgrof@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:28AM -0800, Brendan Higgins wrote:
> > The ultimate goal is to create minimal isolated test binaries; in the
> > meantime we are using UML to provide the infrastructure to run tests, so
> > define an abstract way to configure and run tests that allow us to
> > change the context in which tests are built without affecting the user.
> > This also makes pretty and dynamic error reporting, and a lot of other
> > nice features easier.
> >
> > kunit_config.py:
> >   - parse .config and Kconfig files.
> >
> >
> > kunit_kernel.py: provides helper functions to:
> >   - configure the kernel using kunitconfig.
>
> We get the tools to run the config stuff, build, etc, but not a top
> level 'make kunitconfig' or whatever. We have things like 'make
> kvmconfig' and 'make xenconfig', I think it would be reasonable to
> add similar for this.

Are you just asking for a defconfig for KUnit, or are you asking for a
way to run KUnit from make?
