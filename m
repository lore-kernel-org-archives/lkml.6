Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2C0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFD8222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550165207;
	bh=LacniE1A58vVqPHr8Mt2uhP6HHf8ipUuCq3wIgk/0Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jKODwZyGPtjjOzilv0Ri+rw3KSk3WhYZzwBkn8P4PzO02406UP+4bQbJRBccokyCm
	 inLj2UBKd+dl9Nxzd/gQmBcvdLSlhk41kBYau9Au9FBcyscXAMmAWwgbV5AAo1vNA0
	 PWnEYxySrdGBI/1Rq6WdbES2I98yxFfWQ6cQ8HRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392343AbfBNR0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:26:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46904 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391592AbfBNR0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:26:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so3404492pfh.13;
        Thu, 14 Feb 2019 09:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/NObAkhvzcQY08E2b5gCOLNcBbX1oSktpDTQaSRAU8=;
        b=XniTh4HKdC9DQXSTC2szp5Eyfk4WsRjcmU8JvtHAOQFW/dsBm8zjQcYmAyokJl9FoV
         A0q9T1ZOlJghabfb1P+E2bo3c0rogJiyUYLQaUdqbhwx0p4vRCAJ3WIaFUrPTGI9MPrO
         AggJpxEdK3nkVSV+kvg8W9adOmKzR24zTEAe6Mho1pG+tIGKJ2mvcKsPaJK+6dfAUFz7
         9VS0R4dKpGKrffa6eEkdXJojdMp8N+BvQN2JzT3Gafv4ygdZqdRKxg7N75vfi82WiKok
         UxWMv75r4BPkaiznW0uIjktmnEdW2SpSCjdlH1vtFyXhdsVW+yFcisZuTWU4Y6SAbP4H
         2z6g==
X-Gm-Message-State: AHQUAuZnWZzpwMVvPUOX74QZsppL+ft2KuBH5MYUX7I68Qv6+kbvSwrP
        ONVdi/TSxWFezIx42IirH+w=
X-Google-Smtp-Source: AHgI3IZjZr//1SOb5TTNJFasagBUegKVWjMEnU02uQuP9AfuwAunP6J+8FYn3rqcR8D4qbLALR/obA==
X-Received: by 2002:aa7:85d1:: with SMTP id z17mr5104337pfn.226.1550165204459;
        Thu, 14 Feb 2019 09:26:44 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id c4sm2944876pgq.85.2019.02.14.09.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 09:26:43 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 14 Feb 2019 09:26:39 -0800
Date:   Thu, 14 Feb 2019 09:26:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
Message-ID: <20190214172639.GD11489@garbanzo.do-not-panic.com>
References: <20181128193636.254378-15-brendanhiggins@google.com>
 <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
 <20181130034525.GP18410@garbanzo.do-not-panic.com>
 <CAFd5g47Cew6pmebsopjzmkd4RpnnC3zLAUfxCybjdhrO35OBpQ@mail.gmail.com>
 <0927c42a-8e65-f410-e6ed-27576572577f@ideasonboard.com>
 <CAFd5g44fKzriEs_pGyANxe7GuC9Ji2SD7EEz76__h8q9jjg8yA@mail.gmail.com>
 <57c3dc86-236f-e981-249a-8bbfe5c19f0e@ideasonboard.com>
 <CAFd5g46AEquMKzfrjLDVi+PP5-7aGs6C6pCunGAXDn3VRkJP+g@mail.gmail.com>
 <eade3052-0aa4-90b4-d55b-8c44556f98bc@ideasonboard.com>
 <CAFd5g46cO_rZYjqKu6CooKcV-uAsCUJjuib38cQv6WHQS3ooaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46cO_rZYjqKu6CooKcV-uAsCUJjuib38cQv6WHQS3ooaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:17:13PM -0800, Brendan Higgins wrote:
> On Wed, Feb 13, 2019 at 1:55 PM Kieran Bingham
> <kieran.bingham@ideasonboard.com> wrote:
> Oh, yep, you are right. Does that mean we should bother at all with a defconfig?

If one wanted a qemu enabled type of kernel and also for kuniut one
could imply run:

make kvmconfig
make kunitconfig

That would get what you suggest above of default "bells and whistles"
and keep the kuniut as a fragment.

Hm, actually the kvmconfig doesn't really enable the required fragments
for qemu, so perhaps one would be good. It would have the serial stuff
for instance.

> Luis, I know you said you wanted one. I am thinking just stick with
> the UML one? The downside there is we then get stuck having to
> maintain the fragment and the defconfig. I right now (in the new
> revision I am working on) have the Python kunit_tool copy the
> defconfig if no kunitconfig is provided and a flag is set. It would be
> pretty straightforward to make it merge in the fragment instead.

Up to you in the end.

  Luis
