Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C83EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545722073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545722073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeI2CBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:01:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42394 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeI2CBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:01:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id z8-v6so7884777qto.9;
        Fri, 28 Sep 2018 12:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuipmkcWw7YmnYotTmKn82b9WhCKH+SyD3YXfchbLl0=;
        b=GWgOXfiLQgew/L3UtiHMJyAayNe0a0DxqW/Lnck26AVg4vK7YzEYlLCXII1Yttr9pE
         RuRJFxgQ45XEq1c2Hus+UVRmFwL5/pitFsMEJufxdz17oe368ihTdcRDKxreOPneMN0m
         DjI3/ct44EiHMvzSGxOzp9BPfstivRAC1iqhLrGvlIVk1FK56aHskY777PDEakQY4sTS
         +fnEeR5Gzq3yQJe6UDtqrAQwYgqPDgzjndcbQYadXYKon2t7hmJDOmbPriBIGo8za3o+
         l4y6cVqgMqNbmpI+MMDEJ+vuGUqZjkqQAXUdUwRF3GoDy+JSXaRwKriz76p8aG6ysuyl
         tqQQ==
X-Gm-Message-State: ABuFfoiMtXjr7YbuIWKq485nHocfvLeGqYt3u2rK2LVK0Vi1jGXohai5
        Fy4i/avwKmxR7hwvq6uRH/Cxw1EZ6xZxbplPgtM=
X-Google-Smtp-Source: ACcGV61zbmw03+G5aUTkBUJtC5JmcGSjBRO8b7t8higVrA/ba990BJuyKgMZlwHxMAOadMMN720EWw1bP38vYW/UT0Q=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr54588qtf.185.1538163390547;
 Fri, 28 Sep 2018 12:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <1538117388-11945-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538117388-11945-1-git-send-email-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Sep 2018 21:36:14 +0200
Message-ID: <CAK8P3a16pR5e1js7JiGreqHqxv5RNJZZY=JLFwLRE8i3nbg5hQ@mail.gmail.com>
Subject: Re: [PATCH] samples: run headers_install for host arch instead of
 target arch
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andy Gross <andy.gross@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 8:51 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Some samples search headers in $(objtree)/usr/include, which is made
> available by "make headers_install".  It is not kernel-space code but
> host programs that need this header search path.
>
> Commit 3fca1700c4c3 ("kbuild: make samples really depend on
> headers_install") is wrong because it installs headers of the target
> architecture.  Besides, UML fails to build with CONFIG_SAMPLES=y
> because UML does not support headers_install.
>
> Invoke "make headers_install" for the _host_ architecture in the
> prepare stage.  Introduce CONFIG_HOST_HEADERS_INSTALL so that this
> happens only for samples that need it.
>
> I also removed 'Documentation/: headers_install', which I guess is
> stale code.
>
> Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: David Howells <dhowells@redhat.com>

I don't understand this one. Why would we want to build the samples for
the host architecture rather than the target architecture?

I would think that the bug is that we try to build them using
HOSTCC, and they end up being unusable on the target as
a consequence.

        Arnd
