Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF84C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8839525E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJTTEno6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8839525E5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbeFYQhx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932315AbeFYQht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:37:49 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC0E25C50;
        Mon, 25 Jun 2018 16:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529944669;
        bh=8BmREDQSPd6cPCyXu/Z52hUi1hslr49rvqxyn5IlAkU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=SJTTEno6cLfPjq8o0AhQ0u4MzaSzc54whb3UI0tuQ0G7XajQ6MC+csKATC89WUyKH
         UOQmTQLQBth8dmU7mrYb6n61IRn/PtbmVX+x4h9ddMFkhjlelujed0NINVcKW2WuTY
         VcnTQlOnbWY+R+/zULJFrAsaa107T58p/kmtQBV8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAJZ5v0gA76NwwgRnuztY+dUOKXS+__-7Ghw7Azb-84h_eMRt4w@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
 <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
 <CAJZ5v0gA76NwwgRnuztY+dUOKXS+__-7Ghw7Azb-84h_eMRt4w@mail.gmail.com>
Message-ID: <152994466823.143105.11787470853817181844@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: ACPI support in common clock framework
Date:   Mon, 25 Jun 2018 09:37:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2018-06-16 08:50:18)
> On Fri, Jun 15, 2018 at 7:43 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Is this for clk_enable/disable? What about clk_set_rate() or
> > clk_set_phase()? Is ACPI's AML taking care of that?
> =

> That's for clk_enable/disable AFAICS.
> =

> AML doesn't manage device performance states at all.

Alright. We may need to add a better way for device drivers to get
handles to clk pointers on ACPI firmware so they can change frequencies
or phase, etc. Right now it's all through clkdev and it looks to be
mostly based on string matching of connection names instead of
associating clks with devices.

