Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA68C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715DD208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544144724;
	bh=LmQLAxD5dcpUb5bcZCbF4H2WTDi3iiY0N41mjwIz0ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oZGM8a8u6KWlQbyZSQuHUUoa/THYF6HgOokm8kf5fC4hKAyBiO5r58BW3teYl6X18
	 wIVekbY0/aNyPIjis2KCO7+EulIbM4f+xSsAIEdrHF71pdmao+8bYmTi5HdproWBEB
	 SqHniDw4ERrvcWU7q40r2Cwz9Qa3AZKi4ljhlkUw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715DD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLGBFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:05:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43684 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGBFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:05:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so1038618pfk.10;
        Thu, 06 Dec 2018 17:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BtGHKtYDTzNFJUt1eBRms3d5e4/6p0S1oQLAEY5BMfA=;
        b=TAe2PxbPCWumwlWWWyOpFlK1vkLj4Le5NI2UzagxT41pAj1e3K1NJOWIaspjgqJv+w
         QfTqXJMWnpUyv4n5JxY9Ndnt6qIKsYdDDE99T1D+52MoPZm7ymwxGhgJtZFayAVfRbqF
         s3R6GtdTcnlRLq3LxWXwN1IF4aaLYy1iWgjaGgK1TPcTXStjItk79VyZ6mdjLYLxEqe5
         DLMHaAmtT2i4rzxEpL0IwLNrssT1bnnf6QIJHxZPyl4h39Yh+GRkZ/9C6ofl1b3385zB
         qKN76elfPQ5Sc/nWo11fKboM8xEBHq7QuXW07EXWQ8edWwSrWa88D29slFmjhcf4v8QQ
         9jrA==
X-Gm-Message-State: AA+aEWZwTSxf2ylBDCdLxJBb7NkQnHj3/9aVmS88xiaEkP7DuQ5sn9mK
        H372cVUfw9WRfz1aoCuMlQQ=
X-Google-Smtp-Source: AFSGD/VsM2uh1aXAil++LELS059rM65epjxzwrT75t+0xn232fCiFIX7AvGHJLZ/rsxV982ITcp9sQ==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr145272pgo.221.1544144721655;
        Thu, 06 Dec 2018 17:05:21 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id c20sm2642880pfc.92.2018.12.06.17.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 17:05:20 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 06 Dec 2018 17:05:17 -0800
Date:   Thu, 6 Dec 2018 17:05:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>, jeffm@suse.com,
        Sasha Levin <Alexander.Levin@microsoft.com>,
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
        Felix Guo <felixguoxiuping@gmail.com>,
        Petr Mladek <pmladek@suse.com>, fsdevel@vger.kernel.org
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181207010517.GH28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
 <20181204204701.GT28501@garbanzo.do-not-panic.com>
 <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 12:32:47PM +0000, Kieran Bingham wrote:
> My main initial idea for a libumlinux is to provide infrastructure such
> as our linked-lists and other kernel formatting so that we can take
> kernel code directly to userspace for test and debug (assuming that
> there are no hardware dependencies or things that we can't mock out)

The tools/ directory already does this for a tons of things. Its where
I ended up placing some API I tested a long time ago when I wanted to
test it in userspace, and provide the unit test in userspace (for my
linker table patches).

> Now we just have to start the race to see who can tweak the kernel build
> system to produce an output library first :)

Should be relatively easy if the tools directory used. Yes, there is
an inherent risk of duplication, but that was decided long ago.

  Luis
