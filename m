Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C5C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B2121920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545431098;
	bh=SwQOcWERL7EJwd43LXg8u0TCfoGYoS0lA0RO/ydYGCw=;
	h=Subject:Cc:To:From:In-Reply-To:References:Date:List-ID:From;
	b=J2GY30yG/mbsa2rkUB8CG74ymP4Vn8GcQAeUkdgHNa2laU/zBDnjLSDbWky7awIhn
	 IRFoXQzi4tP6+DDpGYvhdXVW4Dqp2IR3jKX0hObXR3eAEiDaS8Wa89IYOYuKO1YLnC
	 uQ2RSd8teIeYfCY6+MNn2CRCvndRf+zklmtu/x54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404621AbeLUWY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730887AbeLUWY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:24:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5774F21920;
        Fri, 21 Dec 2018 22:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545431096;
        bh=SwQOcWERL7EJwd43LXg8u0TCfoGYoS0lA0RO/ydYGCw=;
        h=Subject:Cc:To:From:In-Reply-To:References:Date:From;
        b=AryT69FKwnfM8l/GMYXzkyCEUepTNWGeBtUCKL66W42Ziw/tBfxBy25cM4+8hBXQN
         Q8FFjMa7PZbvv6XIO9qHdlq/yGUj67CaI9EXTnqNZLpt5pQOK+T8xnc4lhP6xmw+Pd
         kvLURBXzKMv8pVKRNX7g04FYtMXh2RUCVuCv2RaE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "clk: fix __clk_init_parent() for single parent clocks"
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <7e6f1ce65a59f7ad7c3d0da7f8d4b41c93346c2b.camel@baylibre.com>
User-Agent: alot/0.8
References: <20181204163257.32085-1-jbrunet@baylibre.com> <154394675320.88331.12449582989130694425@swboyd.mtv.corp.google.com> <807f2924b67239f61c6d93de7f7b124f8a1f195a.camel@baylibre.com> <154399647605.88331.115722031910044874@swboyd.mtv.corp.google.com> <98e430d7a96fa6b4f0225e57820a4a677108a052.camel@baylibre.com> <154413410087.88331.10879623310968389005@swboyd.mtv.corp.google.com> <63f9b6f613cab0db91c8363635aa673a11f75fba.camel@baylibre.com> <154509805561.19322.14057956205431846882@swboyd.mtv.corp.google.com> <7e6f1ce65a59f7ad7c3d0da7f8d4b41c93346c2b.camel@baylibre.com>
Message-ID: <154543109549.13075.4102525082189864496@swboyd.mtv.corp.google.com>
Date:   Fri, 21 Dec 2018 14:24:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-12-21 08:03:29)
> On Mon, 2018-12-17 at 17:54 -0800, Stephen Boyd wrote:
> >=20
> > Ok. Thanks for the explanation. What should the framework do when the
> > parent is not known? Mark the clk as not an orphan but parent it to
> > NULL? That might work here.
>=20
> I don't really get the difference in the framework ATM. Is this linked to=
 the
> 'orphan probe defer logic' WIP you have been mentionning ?

Yes, we have orphan marking logic, but we haven't finished the topic and
returned PROBE_DEFER for orphaned clks. It was blocked on some Allwinner
drivers having problems but that was over a year ago so I don't see
anything blocking us now. I really want to do it soon so now is the time
to fix all of this and see what breaks.

>=20
> All this below is very interresting but it looks like a very complex way =
to
> solve what was initially a very simple problem, with considerations that =
are
> still WIP a this stage.
>=20
> Even with these future constraints in mind, I don't understand how the
> proposed patch changes anything to the situtation. A clock with a get_par=
ent()
> callback (and several known parents) may still return an out of bound val=
ue
> ... CCF will still have to deal with this case gracefully, as it is curre=
ntly
> doing

Ok. I think the problem you see is that the clk provider doesn't know
anything besides parent name is a string? And so you're not sure how the
provider can return NULL for "this clk won't ever appear", vs. an error
pointer for "things failed while reading"?

I think you understand I'm not trying to change clk_ops::get_parent().
I'm sidestepping the problem and other problems that we have with the
return type of that clk_op (u8) by introducing a new clk_op that can
return an error pointer for exceptional cases. Drivers would need to
migrate to this new clk op to fix the problem you're solving, and those
drivers will also need to know what their clk parents are and what the
clk_hw pointers are for them.

