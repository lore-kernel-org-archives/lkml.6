Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC6C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4122820869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiUZtL64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4122820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbeKGEJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbeKGEJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:09:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EABA22085B;
        Tue,  6 Nov 2018 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541529802;
        bh=Fvx6KjVoFQkLJdzLtzA5KBqCBUDkRGG9CORC6hsc1zk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=HiUZtL64QRz78SCBP9g1hMyRE9gyUR+YsL8UyJaIxGVR1jHaS271u+I+QYFVZygLW
         a93cV/LVwC1kPDlvoXgcqvnnlndHaqY/xpmEinEnsNoLBelAFpuptALnNdw8IdDmzm
         VmRh54ksV6sgMZQsS1tqKlN9Vt4P/aaYc4K6RM1o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181105230820.3562-1-jbrunet@baylibre.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
References: <20181105230820.3562-1-jbrunet@baylibre.com>
Message-ID: <154152980131.88331.14307558394241579493@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
Date:   Tue, 06 Nov 2018 10:43:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-11-05 15:08:20)
> From: Christian Hewitt <christianshewitt@gmail.com>
> =

> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
> with reboot; e.g. a ~60 second delay between issuing reboot and the
> board power cycling (and in some OS configurations reboot will fail
> and require manual power cycling).
> =

> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
> Co-Processor seems to depend on FCLK_DIV3 being operational.
> =

> Until commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
> meson: add fdiv clock gates"), this clock was modeled and left on by
> the bootloader.
> =

> We don't have precise documentation about the SCPI Co-Processor and
> its clock requirement so we are learning things the hard way.
> =

> Marking this clock as critical solves the problem but it should not
> be viewed as final solution. Ideally, the SCPI driver should claim
> these clocks. We also depends on some clock hand-off mechanism
> making its way to CCF, to make sure the clock stays on between its
> registration and the SCPI driver probe.
> =

> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

I can toss this into clk-fixes?

