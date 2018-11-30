Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215D6C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AE520673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AE520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLAFcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:32:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34400 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:32:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so2855662pgg.1;
        Fri, 30 Nov 2018 10:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQcUow3rtfROGco5fKqiF8AvO6eLeBwD4In1k1teLIg=;
        b=ph2cCJpqajKOz9PAmyEE71jqwmhGuj6oi1ba5pV8FA3d7at2yW4TJfh7QxAe6UNjGO
         llKL7s2lJbOh+udALjdu0sVdz61EjmMImHk52QSzCUp/ZRNPqVfJ/1C+qfRzEFD9Z1Eg
         VOPZYw83DVUpvxq/rs6BD2OP9dtW3+TYYDL+nI3jK3kN9lI2rH6nzYUeM3bQvAPgUPoF
         +qXpAl6lIEgNsQaTusGnuna2qXrxFJi5lajQtP0s6GTFU8jczCwBcWG3jZy7BHI7nb+R
         jkQCGCFIVzICmvuPz/8popum44e+OLLyJ5Fh2SK/h8abSG2DTdanuLXUiuL59kvrOGGQ
         nEjg==
X-Gm-Message-State: AA+aEWa0t1a63OC8xGIuYor3pxaoBTqtnYrXhg4PuwgjaOoQfGCL56Rc
        Eo+M4tY/uOmyi0KSuWMf7mw=
X-Google-Smtp-Source: AFSGD/UcmEtYJe8mp/VoGjf5O6sYcV5VbFAq5jcWCPggX43KCCGWhQnYWW/41gPVOCkjpzg7aQZXzw==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr4559360pgv.393.1543602128770;
        Fri, 30 Nov 2018 10:22:08 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id d18sm7781998pfj.47.2018.11.30.10.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 10:22:07 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 10:22:03 -0800
Date:   Fri, 30 Nov 2018 10:22:03 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [RFC v3 06/19] arch: um: enable running kunit from User Mode
 Linux
Message-ID: <20181130182203.GS18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-7-brendanhiggins@google.com>
 <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
 <20181130033704.GL18410@garbanzo.do-not-panic.com>
 <CAL_Jsq+jxHHmT5bLnABnF7S0fSBZvH72nDPyY5LHTn9Zm9hCUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+jxHHmT5bLnABnF7S0fSBZvH72nDPyY5LHTn9Zm9hCUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:05:34AM -0600, Rob Herring wrote:
> On Thu, Nov 29, 2018 at 9:37 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 03:26:03PM -0600, Rob Herring wrote:
> > > On Wed, Nov 28, 2018 at 1:37 PM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > Make minimum number of changes outside of the KUnit directories for
> > > > KUnit to build and run using UML.
> > >
> > > There's nothing in this patch limiting this to UML.
> >
> > Not that one, but the abort thing segv thing is, eventually.
> > To support other architectures we'd need to make a wrapper to that
> > hack which Brendan added, and then allow each os to implement
> > its own call, and add an asm-generic helper.
> 
> I've not looked into why this is needed, but can't you make the abort
> support optional and arches can select it when they support it.

Its why I have asked for it to be properly documented. The patches in no
way illustrate *why* such thing is done. And if we are going to
potentially have other archs do something similar best to make it
explicit.

> At
> least before, the DT unittests didn't need this to run and shouldn't
> depend on it after converting to kunit.

  Luis
