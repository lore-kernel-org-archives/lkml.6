Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF422C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7AB21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5WdBc2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbeLUOpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:45:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40211 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:45:44 -0500
Received: by mail-io1-f68.google.com with SMTP id a11so1236075ioq.7;
        Fri, 21 Dec 2018 06:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+d5cq6+Gipg5CJs6ghUdmYEstVOCzPPpZ5UIF9kCKdM=;
        b=Z5WdBc2lGcD75rgk25bxRr6b7Og+kexwAsd3wkn9/eObCixuM2ZL3fDQpqDw7VWaj3
         Y2Z8Y6heDpPKgyvJy65xXroTaxb1cz3EPc99+weiMlktiyQkejX0Cf/S3iFC+rxF3eqj
         fJ5CRmbPx/LxJH4tz6eVcp6YcWxV96yMWFNNdg1eyOpmvRf4E1Ad4+Fijkmps2sSV6TQ
         gV0p1KpFiSucIosA601f7oseBbAUKgIG8YPhjb1jnaM7nrhmWvYROjGfsm1dNxgHBHJW
         H3IGET9Hbk2Edvt4Blablko6H6XXUmEvFH83g0bbcpyFzV/0tPoiSHa2jThEwjnJIMZL
         3bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d5cq6+Gipg5CJs6ghUdmYEstVOCzPPpZ5UIF9kCKdM=;
        b=QxYlMPrLOdJ/gcSa6z1E3sPmb8dIY0seyEUN60q++XJaEyO1gWuQs5IZqCZKJcmfef
         pCpUVFm6wX+ain5R40NkWkdXBUfRydQ1Ons1wyhbm+BxkCtuIj0nHnL+3W+He+d/rNyZ
         6TTFw3c34OilRNlPJk4ShiWBtrtq6BAK0yNG98bjmcJscuupdEIyZh0dRpL2zrLlg0QC
         yyKeamsYaW/d7gg+oW2jy3IWmNdsa4b2PuCOaICW3/6DOMg6PvhKn1lFhaEzjF7Yytz5
         PraowhlKM5fQLVxhobPovIV1u22e5KlJqzLl+kHLvaA6R4/yi2LA2kJr3oCcU1murkt5
         9sgw==
X-Gm-Message-State: AJcUukcO+IdC9PdWw6PtsyLM2r30TYqCZ7ksXjzq7qI6KeoPbMnrrbtb
        OWlBXGEdssAGRNYFAvrYUlcFbDKcOnoUBFp1hbU=
X-Google-Smtp-Source: ALg8bN45zXo9rmryMn3pJahXa5JtoSyRCs6KWfESTSV7GH9umTTV1L4Mh8TVr1Qk+jWbD+uOeEnqn4n/neHAItM7pwk=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr1689365iom.7.1545403543843;
 Fri, 21 Dec 2018 06:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20181215090846.28009-1-tiny.windzz@gmail.com> <20181221084212.GG211587@dtor-ws>
In-Reply-To: <20181221084212.GG211587@dtor-ws>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 21 Dec 2018 22:45:33 +0800
Message-ID: <CAEExFWu7EY=OLLzHnzNjRFJ9J7TB+NwPy6=A+6NvBsbprd_z0Q@mail.gmail.com>
Subject: Re: [PATCH v5] Input: i8042 add i8042_is_mr_coffee() helper to avoid
 refconut leak
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 4:42 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Dec 15, 2018 at 04:08:46AM -0500, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node returned by
> > it and that reference needs to be dropped by its caller. Add
> > i8042_is_mr_coffee() helper to avoid refconut leak.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > changes in v5:
> > -fix typo
>
> Has this at least been actually compiled by you?
Sure!!!
On ubuntu 18 machine.

MBR,
Yangtao
