Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB89C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93307214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbeLXWqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:46:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37718 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:46:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CDD5214178D07;
        Mon, 24 Dec 2018 14:46:35 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:46:35 -0800 (PST)
Message-Id: <20181224.144635.854624726050744324.davem@davemloft.net>
To:     mironov.ivan@gmail.com
Cc:     netdev@vger.kernel.org, ariel.elior@cavium.com,
        sudarsana.kalluru@cavium.com, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org, skalluru@marvell.com
Subject: Re: [PATCH v2] bnx2x: Fix NULL pointer dereference in
 bnx2x_del_all_vlans() on some hw
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181224151305.31027-1-mironov.ivan@gmail.com>
References: <20181224151305.31027-1-mironov.ivan@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Dec 2018 14:46:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Mironov <mironov.ivan@gmail.com>
Date: Mon, 24 Dec 2018 20:13:05 +0500

> This happened when I tried to boot normal Fedora 29 system with latest
> available kernel (from fedora rawhide, plus some unrelated custom
> patches):
 ...
> After some investigation I figured out that recently added cleanup code
> tries to call VLAN filtering de-initialization function which exist only
> for newer hardware. Corresponding function pointer is not
> set (== 0) for older hardware, namely these chips:
> 
> 	#define CHIP_NUM_57710			0x164e
> 	#define CHIP_NUM_57711			0x164f
> 	#define CHIP_NUM_57711E			0x1650
> 
> And I have one of those in my test system:
> 
> 	Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PCIe [14e4:1650]
> 
> Function bnx2x_init_vlan_mac_fp_objs() from
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h decides whether to
> initialize relevant pointers in bnx2x_sp_objs.vlan_obj or not.
> 
> This regression was introduced after v4.20-rc7, and still exists in v4.20
> release.
> 
> Fixes: 04f05230c5c13 ("bnx2x: Remove configured vlans as part of unload sequence.")
> Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>

Applied, thanks.
