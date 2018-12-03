Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95F420850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLCXoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:44:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32844 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLCXoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:44:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so7204426pfb.0;
        Mon, 03 Dec 2018 15:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jrJx3DVXI1JbGUdrWG6c8UAKSg4ERii95TRhbwbS/rQ=;
        b=Cr1epAAs9Lky6V0n2dnXwxZjmULBfbLX/xRpAHiRLh2p+2dTRNGwoiyhTomTqRvcL+
         w4LAgi+fVrp1T73pK1y2aXaqF1i+86KZ9t9I2GetvoA4aXwjoU7ezwOcec3LhgiE+ytz
         GcJ43TBFU2jnHhX/vDWAMKNKD1QWkfToN5BCkYVl6MK01CDNNKevyGImM4642xTu0HOc
         dT4nSHWF8eQ1N1zMMLof4yJsW4038yiV1cns1Tx6ggBRos5DjxtCK2D/7kDAR2nk98FO
         s63itXGwN4d50+Ru5S3W5dgYIjrbIGVYmvPZuqgJJm0TKcyq8OcSu8Z4e+L3TxS032A1
         E67g==
X-Gm-Message-State: AA+aEWYk730xf6VWKSpiJpFFU0821d8beOvM8fvh9PdYxbCc0YkZs59w
        ruMWpqrSMP9jJAdC3iCiMS40IQ77
X-Google-Smtp-Source: AFSGD/Uf/VZYD6mky8e9lyvm4r0v1X6zd9cafPdk1Zh/7IHSygW0IqvFGsi6NrBL29BsdDEZI7dL+Q==
X-Received: by 2002:a63:4566:: with SMTP id u38mr14894260pgk.4.1543880641253;
        Mon, 03 Dec 2018 15:44:01 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id y1-v6sm19736459pfb.81.2018.12.03.15.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:43:59 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 03 Dec 2018 15:43:55 -0800
Date:   Mon, 3 Dec 2018 15:43:55 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
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
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [RFC v3 07/19] kunit: test: add initial tests
Message-ID: <20181203234355.GQ28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-8-brendanhiggins@google.com>
 <20181130034001.GM18410@garbanzo.do-not-panic.com>
 <CAFd5g47CJnfE3Gqc03onidd5FiZSW43-6_dA5czb30-Rb3dyfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47CJnfE3Gqc03onidd5FiZSW43-6_dA5czb30-Rb3dyfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:26:26PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 11:36:24AM -0800, Brendan Higgins wrote:
> > > Add a test for string stream along with a simpler example.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > >  kunit/Kconfig              | 12 ++++++
> > >  kunit/Makefile             |  4 ++
> > >  kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
> >
> > BTW if you need another more concrete but very simple example I think it
> > may be possible to port tools/testing/selftests/sysctl/sysctl.sh +
> > lib/test_sysctl.c into a kunit test. Correct me if I'm wrong.
> 
> I think that is pretty doable. I don't know that I want to shoot for
> that on the next revision. But I can definitely do it in a later
> revision, or a later patchset, unless you would strongly prefer it
> now, that is.

No rush on my end, just figured I'd mention a simple candidate in case
you needed another one to evaluate.

  Luis
