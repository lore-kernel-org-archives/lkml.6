Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FAD21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864703;
	bh=8F5HsyIgdYko+KDC9Ydp8PAwcUEyTRA8rQETaqJ2KW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GMHSQJ90iHWFBkopnVAf3lRQWyINv9penFvsZP25R5dMEObiKUZYblA74pV7xNCjf
	 n0lnbvmVN6iA/EpXZbllTwOSUt3R/xB/F6d9MeR/f31q0dxhKu+XzyUnkMAkOlquXp
	 junpEPRiOI4aq+gbQxdLLaeQibA8ovm0vuK53Mgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfAGMiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:38:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfAGMiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:38:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7957020859;
        Mon,  7 Jan 2019 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864699;
        bh=8F5HsyIgdYko+KDC9Ydp8PAwcUEyTRA8rQETaqJ2KW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2NQ61BOTbZbrnZf+6xI87wfY70w67tkw1T+8AppOXULaIlu3K2y7F5jgPYvJGu22G
         A3SK7sXxSqQtvgF+jqUGTXfUEZ6PB/9QWqVmu21BBpthZlsB1yWwtrOn+fZzltaJhd
         iW/611b9GhYbP/jCoFp8YBnSITJYAEOHUIf/cuBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 070/145] ocxl: Fix endiannes bug in ocxl_link_update_pe()
Date:   Mon,  7 Jan 2019 13:31:47 +0100
Message-Id: <20190107104446.397241613@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kurz <groug@kaod.org>

commit e1e71e201703500f708bdeaf64660a2a178cb6a0 upstream.

All fields in the PE are big-endian. Use cpu_to_be32() like everywhere
else something is written to the PE. Otherwise a wrong TID will be used
by the NPU. If this TID happens to point to an existing thread sharing
the same mm, it could be woken up by error. This is highly improbable
though. The likely outcome of this is the NPU not finding the target
thread and forcing the AFU into sending an interrupt, which userspace
is supposed to handle anyway.

Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER9")
Cc: stable@vger.kernel.org      # v4.18
Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/ocxl/link.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -566,7 +566,7 @@ int ocxl_link_update_pe(void *link_handl
 
 	mutex_lock(&spa->spa_lock);
 
-	pe->tid = tid;
+	pe->tid = cpu_to_be32(tid);
 
 	/*
 	 * The barrier makes sure the PE is updated


