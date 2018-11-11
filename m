Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E324DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4E521527
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBRJZ973"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4E521527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbeKLIe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391134AbeKLIXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:52 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5594B22353;
        Sun, 11 Nov 2018 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975634;
        bh=mURrLoXfQcjsDdeEzi88kUgvXb9e9qPJHJakejtbK+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBRJZ9733Ytn6f5Eh9KmIS1OWo0tie33dQ2EnN1MYUHRqaJ1lx4kSDJCcdBwObR0O
         faB8/JxdA2AvznDScs+3gaouL7qcJAnm/pTqVbVyKJfRznfWtFVKlM81eywlsU3WgT
         9TRF2Hquhq+Lq+n2EK/TPqb0XcwCEmklG41Fok2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 024/141] net: qla3xxx: Remove overflowing shift statement
Date:   Sun, 11 Nov 2018 14:24:43 -0800
Message-Id: <20181111221631.070117912@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8c3bf9b62b667456a57aefcf1689e826df146159 ]

Clang currently warns:

drivers/net/ethernet/qlogic/qla3xxx.c:384:24: warning: signed shift
result (0xF00000000) requires 37 bits to represent, but 'int' only has
32 bits [-Wshift-overflow]
                    ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
                      ~~~~~~~~~~~~~~ ^  ~~
1 warning generated.

The warning is certainly accurate since ISP_NVRAM_MASK is defined as
(0x000F << 16) which is then shifted by 16, resulting in 64424509440,
well above UINT_MAX.

Given that this is the only location in this driver where ISP_NVRAM_MASK
is shifted again, it seems likely that ISP_NVRAM_MASK was originally
defined without a shift and during the move of the shift to the
definition, this statement wasn't properly removed (since ISP_NVRAM_MASK
is used in the statenent right above this). Only the maintainers can
confirm this since this statment has been here since the driver was
first added to the kernel.

Link: https://github.com/ClangBuiltLinux/linux/issues/127
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qla3xxx.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -380,8 +380,6 @@ static void fm93c56a_select(struct ql3_a
 
 	qdev->eeprom_cmd_data = AUBURN_EEPROM_CS_1;
 	ql_write_nvram_reg(qdev, spir, ISP_NVRAM_MASK | qdev->eeprom_cmd_data);
-	ql_write_nvram_reg(qdev, spir,
-			   ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
 }
 
 /*


