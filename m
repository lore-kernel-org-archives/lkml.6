Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1193CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5642073D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spptERYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5642073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLCXyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:54:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36163 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLCXyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:54:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so13469947otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0aGUnRQ7WBb1lfLp4i+zt5n++hUx7uDBLGU6u74xcc=;
        b=spptERYBdnex94wjuZMQzQQBFSJ/ROFZ/z4TVyS2xBT1UKZA7SydtCQ4zZ+PUhUU+2
         9GTMbXJ9b4IhTwIjWplvM9ltn+fHFqnQHcg1icasBNPZuv3nnuugC3tuHzRIgVVxY2vz
         Zu1ael81nirlQDpq/d+MYQOEcPYbyyTDsoaVRSMIdAdkAwys4pznBaFX7k05sYooz+hf
         RXbCyrUthsO5kUrp9c1XcVoEuuCP5dDYiKIoB8zENBZPdF5pq1Ejl1jL0JW80LlhpFvI
         MvA7VrC8r8+A9rltwmP/uZMUJLQkGm67Zs2y0Q9GHmBAeDUedOEwlapnENKM6GpIyZ4S
         nLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0aGUnRQ7WBb1lfLp4i+zt5n++hUx7uDBLGU6u74xcc=;
        b=pC7odseg63YrJN3rLGjgwO233J3rLLUaccVP0UvsIu2KJIWwjS/HfqgYKq1vrCi5i3
         8mChqebBOVB4/OglQojbxk1y5fmLxV895ocXL4+XA7jYXQRMyo54kVDbSAC3gFHkobIO
         73nwQw5EzWy3ZF+0jru2FHhVAeh+USR34fuFbZi3K81hkqklBVEoaEV/aJBAZ9POUO8T
         Gln1z4EytHbvVuwrjAFXSraLfVl0ZFzL/wCnThcFHYeHTdkIDG9JCGkIRl5oGovOfiaj
         AJldigpKtPYUPbAmQG9KPFrRwqLVsd3tSrOFGvm8/Q2en7wXjCxsWAfier70kW5IjlYH
         6ASg==
X-Gm-Message-State: AA+aEWZdiRhfnX2Ej6LP1Ud4pDIk4NbMnr2dxz1df4dL/HxEcuC7prVZ
        2vd4IYOL7u6M8nya1l6AGBQ06AXnz/UrZDf2EEcZeg==
X-Google-Smtp-Source: AFSGD/Vs5kb5jAZ5gYnYZyzZO0nPFPChgoM3aIV5zgrEnbPNFLchXx38YOYzPJ8pu78d3iSxAXtYxQBEElhgB+CrQrQ=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr11632560oth.338.1543881246903;
 Mon, 03 Dec 2018 15:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-15-brendanhiggins@google.com> <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
 <20181130034525.GP18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130034525.GP18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 15:53:55 -0800
Message-ID: <CAFd5g47Cew6pmebsopjzmkd4RpnnC3zLAUfxCybjdhrO35OBpQ@mail.gmail.com>
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
To:     mcgrof@kernel.org
Cc:     kieran.bingham@ideasonboard.com,
        Greg KH <gregkh@linuxfoundation.org>,
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
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Nov 29, 2018 at 01:56:37PM +0000, Kieran Bingham wrote:
> > Hi Brendan,
> >
> > Please excuse the top posting, but I'm replying here as I'm following
> > the section "Creating a kunitconfig" in Documentation/kunit/start.rst.
> >
> > Could the three line kunitconfig file live under say
> >        arch/um/configs/kunit_defconfig?
> >
> > So that it's always provided? And could even be extended with tests
> > which people would expect to be run by default? (say in distributions)
>
> Indeed, and then a top level 'make kunitconfig' could use it as well.

Yep, I totally agree.
