Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C617C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7C920863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddYje/Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7C920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeK2JJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbeK2JJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:09:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F50E2081B;
        Wed, 28 Nov 2018 22:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543442812;
        bh=KrsGISj7ZENgpGpLWVt8/KZ+K2g/bU25TO6MfWgXWfs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ddYje/ZnIBXqricYZc2lQcr8/dZ8eV65hZ4f0+eQao0SWNmbX9uJnu2i3hTD4CUPg
         IfvCmJKiPTGOBUWXOteQgT7OkP9fvvHTNN8dfgdNYfhN7ji4zfHc9BjnckbIF6NZgz
         7K5QRbZ6XlM8cZX0TMJXQeBvPazwiDmXWQLKoRhU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     David Lechner <david@lechnology.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542994408-28466-1-git-send-email-hofrat@osadl.org>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
References: <1542994408-28466-1-git-send-email-hofrat@osadl.org>
Message-ID: <154344281182.88331.6325160815919343344@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: davinci: check for devm_kasprintf() failure
Date:   Wed, 28 Nov 2018 14:06:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Mc Guire (2018-11-23 09:33:28)
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignment to  lpsc->pm_domain.name  is not safe if not checked. On =

> error davinci_lpsc_clk_register() returns a pointer to davinci_lpsc_clk
> which is checked with IS_ERR() so returning ERR_PTR(-ENOMEM) should be =

> fine here.
> =

> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: c6ed4d734bc7 ("clk: davinci: New driver for davinci PSC clocks")
> ---
> =

> Problem located with experimental coccinelle script
> =

> Patch was compile tested with: davinci_all_defconfig
> =

> Patch is against 4.20-rc3 (localversion-next is next-20181123)

There are a bunch of other allocation issues with this driver so I'd
rather not expend the effort to review the one coccinelle script fix
here and instead I'd like to see the whole fix to this driver. Please
add proper lifetime management for all the allocations in this code.

