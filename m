Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0607EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6322086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgMAuchu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfBUK4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:56:06 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39510 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUK4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:56:05 -0500
Received: by mail-vk1-f196.google.com with SMTP id i68so2686818vke.6;
        Thu, 21 Feb 2019 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MIWWjE+tpURFmmaOPnMkvbETR+/IeUD8/hjQ9oSTwrQ=;
        b=IgMAuchuMGqzG9tc6+DxmNVJNB0xIBjXm55Wt//7WXU77b1Y5DykrDMn9nsaANkX+O
         Oipz0VmNn0fVYWacd/QT4QA5dS09ocOypofmGtRZSIHBn6qlDJJTt92gqf39CmbCEGgY
         mxTenwNFJCwqKfMeFvesD3A+Pe6T3x/+YlLJw0Cf77jr1P4f4p+VRd5nDwuYYPpfxeEt
         9AF+2W7eM/IuRBMcyl7ZeXAuWgasvUgnocLfjIdUoWOoLDcW/8ZypZYybVrV6cOyV1yL
         LbpNomhmxPrsaUhGtfws8GZUCercXJzbwkDbgMj2abAzpp+IONDJpzyy+pVAfZ5C4noE
         4Nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MIWWjE+tpURFmmaOPnMkvbETR+/IeUD8/hjQ9oSTwrQ=;
        b=IRccyNixUsNz/eEMObMbHQ3J5vZLB/zBfX0ASdQ/CoTSPY6F7pWfZwP0wkmnof+508
         QgWc8AggWSQ+l+HO/Y8INxo6xeH/xjWeVpJiiGQdMAKu5LdV6CkLZ5iz3k/XTS/9tOtq
         xWsPf2RG3R208CxE0WGlB+DrEuCQIZDqcV7HEfm1yIJO2KBuAymAwBGDVyn+a47QQE2l
         Q/u70xxJYvZ4lf+Wfcjc6PGs7xRoyfkDWnosK8V16crIiVJSHDRMdM6opRAYpVW4BOy6
         x5kbSImvc1rHJ7qocXDdqMDw4/OD23k3kKekPkDkNQB9lcm0GIO/JzOyt5lnO5NEDdVo
         k5Mw==
X-Gm-Message-State: AHQUAua5SYI44o8uOwZbmGji1FMMG1RlhCmgvzEOaMGmBSc32BFxOsFU
        tJKs10OsxAJFihx1V++FDf4jdBN81WagGIVeUdU86rtdbQ==
X-Google-Smtp-Source: AHgI3Ibrp3SQ0Yv71UBajh0aGQ2cFOmIic6Gvgt9MmkdT/2P/+dfM8Fq1ATUHMzLc7sFJ8bn/VEMqOBqWcWkE1VADvo=
X-Received: by 2002:a1f:30c6:: with SMTP id w189mr13050270vkw.57.1550746564833;
 Thu, 21 Feb 2019 02:56:04 -0800 (PST)
MIME-Version: 1.0
From:   Rundong Ge <rdong.ge@gmail.com>
Date:   Thu, 21 Feb 2019 18:55:54 +0800
Message-ID: <CAN1LvyqjHCCNxz30a-SMO3uSBw2WD-Mvn4sR==9SUcJKdqo9vA@mail.gmail.com>
Subject: m88e6390_config_aneg will always reset the phy
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, hkallweit1@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

Before the "net: phy: marvell: Errata for mv88e6390 internal PHYs",
phydev will only be soft reset when register value was changed.
But after this patch, the phydev will always be reset when entering
the "m88e6390_config_aneg".
So is there any side effect of this change?

Thanks
Rundong
