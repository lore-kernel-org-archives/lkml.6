Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7251C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E8E2534F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN1RW+of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E8E2534F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965989AbeF2SYn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965535AbeF2SYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:24:41 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F232534F;
        Fri, 29 Jun 2018 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530296681;
        bh=2fBMJ9EY2c8IBvG1oWjK6SoSr/cOV1ZzZ8PKx0W6tmM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=nN1RW+ofbeMTzEdzOOTiYDeUH19ft5nBFJ8Qfdk0OGRcqi1NgRbsMwZ4T1Azg7Z8u
         9TpSQ+M3ZLGU6jssFdO9pxfarP16e4r5O1/qt9R9J4ThTM9HLOkM0yfy4AllRi6d5+
         ZejXtx+/r4/buqr1N4Gl40TxLc+PR6LkRY40+yiQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Raman Banka <raman.k2@samsung.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528105245-26623-1-git-send-email-raman.k2@samsung.com>
Cc:     alim.akhtar@samsung.com, shaik.ameer@samsung.com,
        m.szyprowski@samsung.com, krzk@kernel.org, s.nawrocki@samsung.com
References: <CGME20180604095335epcas2p4131d5a7ea0c6091c3e2f17bd98847efa@epcas2p4.samsung.com>
 <1528105245-26623-1-git-send-email-raman.k2@samsung.com>
Message-ID: <153029668040.143105.2059491089047180792@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] Add more debugfs features in CCF.
Date:   Fri, 29 Jun 2018 11:24:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Raman Banka (2018-06-04 02:40:45)
> Currently there is a directory hierarchy in debugfs for visualizing the
> clk tree structure. Each clock has a directory in debugfs which contains
> read-only members that export information specific to that clk node:
> clk_rate,clk_flags, clk_prepare_count, clk_enable_count &
> clk_notifier_count.
> =

> Change the member clk_rate from read-only to read-write,
> writing some other rate to clk_rate calls clk_core_set_rate()
> of the corresponding clock.
> =

> Change the member clk_prepare_count from read_only to read_write,
> writing to which calls clk_core_prepare() or clk_core_unprepare()
> of the corresponding clock depending on the value written.
> =

> Change the member clk_enable_count from read_only to read_write,
> writing to which calls clk_core_enable() or clk_core_disable()
> of the corresponding clock depending on the value written.
> =

> Add a new read-write member named clk_parent reading which exports
> the name of the parent clock and writing a different name for parent
> clock searches for that clock and calls clk_core_set_parent_nolock().
> =

> Signed-off-by: Raman Banka <raman.k2@samsung.com>
> ---
>  drivers/clk/clk.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 164 insertions(+), 5 deletions(-)
> =

> I was working on some internal project where there was a requirement to p=
rovide
> debugfs entries for controlling clock operations. So I thought allowing to
> change rate, parent, enable_count and prepare_count of clocks through deb=
ugfs
> may be a desirable feature. I felt debugging is much easier with these fe=
atures
> as one need not boot the kernel every time he/she wants to test a clock,
> especially helpful in case of booting linux on an emulator where it takes
> hours to finish booting. Being new to linux, I'm not sure whether it is d=
esirable
> or not. Hence I request for comments.

Historically we've avoided allowing userspace to change clk settings,
even in debugfs[1]. That's best left up to drivers so that drivers don't
get confused or have trouble when they try to operate on things and
their clk frequency changes underneath them. It also opens up a way for
bad userspace applications to exist and start writing into debugfs to do
userspace clk control, which is something we really want to avoid at all
costs.

I can understand on an emulator it is hard to get things right
initially, and you may not even have drivers for certain devices that
are using the clks, and hours to reboot takes time to fully test a clk
driver, but then you can just make a patch like this and apply it to
your tree and do rapid debug and development until things are sorted
out. I've experienced this first hand and carried around a patch to do
just this for a long time.

We have discussed adding "dead" code to the kernel to support read/write
like this underneath some #ifdef guard, like you see regmap do with
their #ifdef REGMAP_ALLOW_WRITE_DEBUGFS code. I would be open to that
sort of patch that I can then easily add a special define to enable the
super dangerous mode. As long as it isn't exposed as a Kconfig we're
pretty safe from non-developers finding it.

[1] https://lists.linaro.org/pipermail/linaro-kernel/2013-August/006226.html

