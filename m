Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9420C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0712087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547912522;
	bh=pd3JnVRvx9qXga1PfmEpbi76HIFcTcq5J/fGSAxb3fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=Hw9joNv2BQv5QYZjkPppUZw4Z0Y9I/QAYXQ8NAo3iuTrOfLUD1c9+QDlkZO+Gk8qU
	 48VP2d7KX4RUhXwLfPLvbxBdt9pJxHeEFYT/H0CbwKQRjDk+86Ur6OgbxT1qbWWe7K
	 Eky2FRYrCOU8St323ceRolc5LyXnhdEwVlaH7rJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfASPmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfASPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 10:42:00 -0500
Received: from localhost.localdomain (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6822F2084F;
        Sat, 19 Jan 2019 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547912519;
        bh=pd3JnVRvx9qXga1PfmEpbi76HIFcTcq5J/fGSAxb3fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=bL2GNqGt6U/MR0TQLIcVRdOoga6bmlPU4Vkc2c+9qy6OYKdYRRN7blMOA5v2mFSrc
         Rp9yVHctUiEmxdfjs2CO6owa/AAbGpa3ofXXEevtUdVyHUjojeaK9wL48inQcnF5Tb
         FAfFL25UScLUwgIUZBDI2RBO27sGBTCCqnwZ1Vwg=
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
Subject: Re: [v7,3/5] mtd: m25p80: add support of octal mode I/O transfer
Date:   Sat, 19 Jan 2019 16:41:49 +0100
Message-Id: <20190119154149.3451-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 0837ae46ff003fed44bfead23c590e7105f47623
In-Reply-To: <1547546584-5254-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 10:05:22 UTC, Yogesh Narayan Gaur wrote:
> Add support for octal mode I/O data transfer based on the controller (spi)
> mode.
> Assign hw-capability mask bits for octal transfer.
> 
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
