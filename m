Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4EC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB502082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB502082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeLAOYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:24:01 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38668 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLAOYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:24:01 -0500
Received: by mail-pf1-f182.google.com with SMTP id q1so3717002pfi.5;
        Fri, 30 Nov 2018 19:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ry31ERUK+wtDIewdxNghiOP8fuEXHvwiCvVigDDY34I=;
        b=f//6EqDhk5dzkqRdbjagl1Z/6R1ssoEcaiCG6NNtnDkA9Q0L0Ji0J7Au3X3Et1u3of
         DSd+T23rFSaYIVq2BFgVuTJjwxDZNBWg31VfKVMR/ToIPnK1s11uUENL+WKqvQE4DhDq
         JDntmjZNemX6ej3TwOFzrPXpXwhIXfGbd2KsEkuuVzBqjUyRIIdm/iCsGGieBzrhl31a
         ENGvNxxxvSavMJiAKfPsyxnIzrd2/XtUxDNX4C9ELjRtCA3YiDTgX4w34R1udNpu+N3O
         Rj9oWsBCji9lIb5Vhyl/RgAXngwu08oPESVe9muiGKqcecHW2EZFROJ6VULlf9TJDah9
         aVUg==
X-Gm-Message-State: AA+aEWaqB6ibVPQsjPJY2ba3ZJZKnjgA/t5PpuaUGUNZKk58ENMtfrKN
        DC6fXkAf7acevKwGehi4ppo=
X-Google-Smtp-Source: AFSGD/WsXbYQYcJWC9TdIQziqG7iith9VJLXC10z1Br9IjBjH4nBvKg5+57C9FCmx4rEbgubJPe0xQ==
X-Received: by 2002:a63:801:: with SMTP id 1mr6718436pgi.275.1543633952617;
        Fri, 30 Nov 2018 19:12:32 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id c20sm10450893pfc.92.2018.11.30.19.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 19:12:31 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 19:12:28 -0800
Date:   Fri, 30 Nov 2018 19:12:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     pmladek@suse.com, Greg KH <gregkh@linuxfoundation.org>,
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
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [RFC v3 03/19] kunit: test: add string_stream a std::stream like
 string builder
Message-ID: <20181201031228.GM28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-4-brendanhiggins@google.com>
 <20181130032924.GH18410@garbanzo.do-not-panic.com>
 <CAFd5g46AXpnoWpm+aFNfvNm2-As5RCO7QdMPhcOMXWRPwHqrGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46AXpnoWpm+aFNfvNm2-As5RCO7QdMPhcOMXWRPwHqrGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 06:14:17PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 11:36:20AM -0800, Brendan Higgins wrote:
> > > A number of test features need to do pretty complicated string printing
> > > where it may not be possible to rely on a single preallocated string
> > > with parameters.
> > >
> > > So provide a library for constructing the string as you go similar to
> > > C++'s std::string.
> >
> > Hrm, what's the potential for such thing actually being eventually
> > generically useful for printk folks, I wonder? Petr?
> 
> Are you saying you think this is applicable for other things? 

Yes.

> This doesn't belong here.

  Luis
