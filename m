Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D7FECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D11020850
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzIoneVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D11020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeGSDF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731001AbeGSDF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:05:26 -0400
Received: from dragon (unknown [45.56.152.101])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 774C72084E;
        Thu, 19 Jul 2018 02:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531967081;
        bh=SSfs6jZ17kCCrceMd2t1hjgmevR9MeAqLkYwdv33LEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzIoneVz4yTW/sfK5lFnrvmaYXqItlps1IevSB4iZ8IXL8nL315rrFhe288vk9Zmb
         pdT4qcFTY/81u9Jp8rhUTeaP1z3UsmdlYOnoLenCEk8Ep5YAvQkhrz/6A+7B4MfNAS
         j2Ac+Qj9PMh/fp3q8O3IstJFRiwV680YoBzMAZ2A=
Date:   Thu, 19 Jul 2018 10:24:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] soc: imx: gpc: restrict register range for regmap
 access
Message-ID: <20180719022424.GO4576@dragon>
References: <1531798126-24360-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531798126-24360-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:28:46AM +0800, Anson Huang wrote:
> GPC registers are NOT continuous, some registers are
> reserved and accessing them from userspace will trigger
> external abort, add regmap register access table to
> avoid below abort:
> 
> root@imx6slevk:~# cat /sys/kernel/debug/regmap/20dc000.gpc/registers
> [  108.480477] Unhandled fault: imprecise external abort (0x1406) at 0xb6db5004
> [  108.487985] pgd = 42b54bfd
> [  108.490741] [b6db5004] *pgd=ba1b7831
> [  108.494386] Internal error: : 1406 [#1] SMP ARM
> [  108.498943] Modules linked in:
> [  108.502043] CPU: 0 PID: 389 Comm: cat Not tainted 4.18.0-rc1-00074-gc9f1f60-dirty #482
> [  108.509982] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
> [  108.516123] PC is at regmap_mmio_read32le+0x20/0x24
> [  108.521031] LR is at regmap_mmio_read+0x40/0x60
> [  108.525586] pc : [<c059cf74>]    lr : [<c059d1ac>]    psr: 20060093
> [  108.531875] sp : eccf1d98  ip : eccf1da8  fp : eccf1da4
> [  108.537122] r10: ec2d3800  r9 : eccf1f60  r8 : ecfc0000
> [  108.542370] r7 : eccf1e2c  r6 : eccf1e2c  r5 : 00000028  r4 : ec338e00
> [  108.548920] r3 : 00000000  r2 : eccf1e2c  r1 : f0980028  r0 : 00000000
> [  108.555474] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  108.562720] Control: 10c5387d  Table: acf4004a  DAC: 00000051
> [  108.568491] Process cat (pid: 389, stack limit = 0xd4318a65)
> [  108.574174] Stack: (0xeccf1d98 to 0xeccf2000)
> 
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
