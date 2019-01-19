Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D17C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC882087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547912553;
	bh=ndj4QkCwuR+gsljAaqHBms3oFnudcxB+YK8NiojxcQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=PVXt+vDhIYqbbAiNdX2Rslk1LVsprF0c+TSEXx6aDQ0Glwdcs7Agds54N69yUWcoz
	 CIrdMvVI7UmZnuRA/VMj68Kkaj8VJo4a3+vttGaiPZvXx9SYcZlYwSQMfVHCVPstCo
	 A8QGoQe0AHnUIvun5UB5nrvIuqwv/Zm8PvCDPUAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfASPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfASPmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 10:42:31 -0500
Received: from localhost.localdomain (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5393D2084C;
        Sat, 19 Jan 2019 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547912550;
        bh=ndj4QkCwuR+gsljAaqHBms3oFnudcxB+YK8NiojxcQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=equ15vhqc5vVY2CFv15Man2OxQKTReh/Ur49L1NXCXEPzR8ialGsF5LLN+dDn/p8o
         T33z2k7ITKXkTcyf1ghyotnr+/tZHUBx4pI395Q5YlC7N88002+cAVe1gve9iFcP5o
         AUqQD7m/H9I/s1QunWSnH1RdxGXNG3A4I/LvfssM=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v7,1/5] mtd: spi-nor: add opcodes for octal Read/Write commands
Date:   Sat, 19 Jan 2019 16:42:19 +0100
Message-Id: <20190119154219.3597-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: fcd44b64b1eb0a33f6cc14f21dcb927ffd664af3
In-Reply-To: <1547546584-5254-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 10:05:10 UTC, Yogesh Narayan Gaur wrote:
> - Add opcodes for octal I/O commands
>   * Read  : 1-1-8 and 1-8-8 protocol
>   * Write : 1-1-8 and 1-8-8 protocol
>   * opcodes for 4-byte address mode command
> 
> - Entry of macros in _convert_3to4_xxx function
> 
> - Add flag SPI_NOR_OCTAL_READ specifying flash support octal read
>   commands. This flag is required for flashes which didn't provides
>   support for auto detection of Octal mode capabilities i.e. not
>   seems to support newer JESD216C standard.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
