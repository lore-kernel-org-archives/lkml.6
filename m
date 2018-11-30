Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072CEC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C642086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C642086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeK3Oql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:46:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40440 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeK3OpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:45:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so2082355pfo.7;
        Thu, 29 Nov 2018 19:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oExCjExO33D1dIc6U4MglG9722irl81vN62A7Wetias=;
        b=A8IH085URQPPK0Qyc6cXIyskx3VogGpcsnlmenyXX3kmrkouVez4jCgbI5QB8URBta
         CfV/az3KNhM0Aab0WbZ2fz9gi7qwC9/dTAWXF+L8Sciddni550FWIXyJHBfyMmaBLk0V
         v63x7YE1BUIdAhSoBK+PgmPSxIDbioXfOGLyhzWBS/3q0YfsRdsA5TpRCP6LyznuDx/0
         QNUDeOY88RRxX7enP6HmHP7h7MgbfZKovaddLERvjtaqgotwOGsaf3VnrsDgMJsc5pqW
         LBrDfDN5z1GxGgEMBkzzKqL4SXs54RkPfAo6GYKN6HFCGnKGMdP+tO+Qt+4UWflGK3FJ
         +RtQ==
X-Gm-Message-State: AA+aEWbHZw+M2LarDb1UoKSBdm9qgBwJ7NGUGHgoKfquD8W7hDVETi27
        H0tEBi6y2UmbwIarsnfVdZg=
X-Google-Smtp-Source: AFSGD/UJ5cESVg/RMk+VwR6oG5+WwRqPJGdSk2IwXUzyMxB8b1YwxTQdpDFbUSrfj7iyncFifm9h/w==
X-Received: by 2002:a63:e055:: with SMTP id n21mr3508781pgj.397.1543549028713;
        Thu, 29 Nov 2018 19:37:08 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id j70sm5119517pfc.43.2018.11.29.19.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:37:07 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:37:04 -0800
Date:   Thu, 29 Nov 2018 19:37:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20181130033704.GL18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-7-brendanhiggins@google.com>
 <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:26:03PM -0600, Rob Herring wrote:
> On Wed, Nov 28, 2018 at 1:37 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Make minimum number of changes outside of the KUnit directories for
> > KUnit to build and run using UML.
> 
> There's nothing in this patch limiting this to UML. 

Not that one, but the abort thing segv thing is, eventually.
To support other architectures we'd need to make a wrapper to that
hack which Brendan added, and then allow each os to implement
its own call, and add an asm-generic helper.

Are you volunteering to add the x86 hook?

  Luis
