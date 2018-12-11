Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E754AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C552084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544496576;
	bh=nmRn5PYV+FDErFccqUr/NhgLVTQjTK6NW6we9P51rFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N/o4ljbd3fXEePYHyKhkXBaEgXggR79wgLSTD02lr7qukBA9eDvw0IZgTWdEvOPl0
	 MwdRwccslyjl76FOpJRvPgQwhCrF4fzoZ+tD3h8Yvq5VNfRW9W68F3YdRUUVfMMpum
	 w0dFxIBJCP285q+2QzPtccnET7VtyqrB+eSSH+Ns=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C552084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeLKCtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbeLKCtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:49:35 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE3E20645;
        Tue, 11 Dec 2018 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544496574;
        bh=nmRn5PYV+FDErFccqUr/NhgLVTQjTK6NW6we9P51rFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJ0Bl0Gn09CzlA7CIJej7DpZzgEQY875mizQtDfTK/Wt4zpqFJFk5Aq1F6+PxzLYL
         Nb+rOt4uIsQrsoIN5+B5gcpL3aMo8VwZ+Yud7huaOgh4E1oW2YNPW0+JFpNSk6ijFp
         ViLhNBobiJnKV6UC8xukObEOyzgx1uszctBp/1+A=
Date:   Tue, 11 Dec 2018 10:48:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>, linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx: fix dependencies on imx7ulp
Message-ID: <20181211024837.GT3987@dragon>
References: <20181210204816.2516007-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210204816.2516007-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 09:47:59PM +0100, Arnd Bergmann wrote:
> The i.MX7D configuration was reworked, but that change did
> not get propagated into the newly added i.MX7ULP, which now
> produces a Kconfig warning:
> 
> WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
>   Depends on [n]: CPU_V7 [=n]
>   Selected by [y]:
>   - SOC_IMX7ULP [=y] && ARCH_MXC [=y] && (ARCH_MULTI_V7 [=n] || ARM_SINGLE_ARMV7M [=y])
> 
> Change it to work the same way as i.MX7D.
> 
> Fixes: 1a1f919eb52e ("ARM: imx: Provide support for NXP i.MX7D Cortex-M4")
> Fixes: acb83c0eb036 ("ARM: imx: add initial support for imx7ulp")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fixup, Arnd.  Applied.

Shawn
