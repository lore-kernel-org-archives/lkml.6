Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B0F218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548362773;
	bh=33B3tHv3KBJZmutUadt0ldtSw/Pke2WuM4YHA/JcnuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ajPGKV8QyGhex//eaDfNLycrJ0xSyobe9JCWXYC2qW2HuFrQNUI1Kdy9am4uQ22Ed
	 QP68PpN1ZncJNMoXayMUP75MdfwblG1JQzK/NQ160oh0jXME10fhk3e5TIYoLJcpfE
	 L31/hksNQxEF52Tj+vdbP7aA1tKj1MXDm/Gl7zv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfAXUqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfAXUqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:46:04 -0500
Received: from atull-730U3E-740U3E.fm.intel.com (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22871218F0;
        Thu, 24 Jan 2019 20:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548362763;
        bh=33B3tHv3KBJZmutUadt0ldtSw/Pke2WuM4YHA/JcnuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7gl8auOYSxqSpqQbwnOXoMHj421HiAtkVQeaVr4ltVK3GRXq7CEcLIfUX2iC285J
         DVT0BAyPhBTZtKZan8p231mMpBevE5HELMHG/+DGobGxwWWcMAeXbPHOPinHU9sLKQ
         EQdsPwsVBxCf3ApVYuobDopokAmA4DW2QPc9ehEk=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 3/3] fpga: mgr: altera-ps-spi: make array dummy static, shrinks object size
Date:   Thu, 24 Jan 2019 14:45:54 -0600
Message-Id: <20190124204554.5438-4-atull@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124204554.5438-1-atull@kernel.org>
References: <20190124204554.5438-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array dummy on the stack but instead
make it static. Makes the object code smaller by 26 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   7371	   2032	      0	   9403	   24bb	drivers/fpga/altera-ps-spi.o

After:
   text	   data	    bss	    dec	    hex	filename
   7281	   2096	      0	   9377	   24a1	drivers/fpga/altera-ps-spi.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-ps-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 8c18bee..678d011 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -205,7 +205,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
 				    struct fpga_image_info *info)
 {
 	struct altera_ps_conf *conf = mgr->priv;
-	const char dummy[] = {0};
+	static const char dummy[] = {0};
 	int ret;
 
 	if (gpiod_get_value_cansleep(conf->status)) {
-- 
2.7.4

