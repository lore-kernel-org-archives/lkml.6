Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0924EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA04420868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPJQmKnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA04420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeLABPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLABPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:15:12 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68DCF2146F;
        Fri, 30 Nov 2018 14:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543586746;
        bh=PoTIaqiHxSur5Uv2gK+uTzhGCQx72ga/gdWkfYh/9Ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mPJQmKnS+LrjOW41EjNzpMiAZl6SZ8AqQiQQW9oTCmN5CDuzMYluWxapEcZkdDqku
         F8fFDoaHysVtHtt9nZCc0NfXv69qdjmGx32+iQJ3AqGC9k0ZYQ4CUB3rvxqNbpQWqG
         NejVxIalTwepHE24v1rE5Ffpdly8WQUn86eu2oBo=
Received: by mail-qt1-f181.google.com with SMTP id p17so5989626qtl.5;
        Fri, 30 Nov 2018 06:05:46 -0800 (PST)
X-Gm-Message-State: AA+aEWZN8ZK5jQ6Olv3O8YONp7NRCE9XCGbnS5ACv4sLFFuZITgqWKOO
        KSiosZMRapOhZShhsu2njw2KRwGuhZ2iwpLbIA==
X-Google-Smtp-Source: AFSGD/VUzsPQpkC1qPgfOMf+rAMf2iGIZ0/2i05uUOD8hy15aSyFx/UpWvJkPmsdHEda2ZqiW5fyRqxINmNqCL5khAc=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr5811141qvl.77.1543586745563;
 Fri, 30 Nov 2018 06:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-7-brendanhiggins@google.com> <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
 <20181130033704.GL18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130033704.GL18410@garbanzo.do-not-panic.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Nov 2018 08:05:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jxHHmT5bLnABnF7S0fSBZvH72nDPyY5LHTn9Zm9hCUw@mail.gmail.com>
Message-ID: <CAL_Jsq+jxHHmT5bLnABnF7S0fSBZvH72nDPyY5LHTn9Zm9hCUw@mail.gmail.com>
Subject: Re: [RFC v3 06/19] arch: um: enable running kunit from User Mode Linux
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:37 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 03:26:03PM -0600, Rob Herring wrote:
> > On Wed, Nov 28, 2018 at 1:37 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Make minimum number of changes outside of the KUnit directories for
> > > KUnit to build and run using UML.
> >
> > There's nothing in this patch limiting this to UML.
>
> Not that one, but the abort thing segv thing is, eventually.
> To support other architectures we'd need to make a wrapper to that
> hack which Brendan added, and then allow each os to implement
> its own call, and add an asm-generic helper.

I've not looked into why this is needed, but can't you make the abort
support optional and arches can select it when they support it. At
least before, the DT unittests didn't need this to run and shouldn't
depend on it after converting to kunit.

Rob
