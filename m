Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B979BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C77621104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG6n3fAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C77621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbeK3BV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbeK3BV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3DB3205C9;
        Thu, 29 Nov 2018 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500986;
        bh=kojQc/HYdMpd9qwLRrqjHc2HY9wwKNZS1sVHnDwxllE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qG6n3fAvYXHTxV5VtSTeJe+fNba8fvoY+v8aWuQa3UOkzWQNKk/8QJd/N4KQq18Rt
         twdKyT4mhWFb6CrMzSTgmoritXzjkqp7jEdUNFDbk8kaWi8+N3VC91GpFISmtQy6dK
         4ZYhGXI2Zl+WSStnsTMKPOLtySwr3O1w6Siu9MmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, aszlig <aszlig@nix.build>,
        Milan Broz <gmazyland@gmail.com>,
        Daniel Zatovic <daniel.zatovic@gmail.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.18 80/83] tty: wipe buffer.
Date:   Thu, 29 Nov 2018 15:12:38 +0100
Message-Id: <20181129140142.597059653@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit c9a8e5fce009e3c601a43c49ea9dbcb25d1ffac5 upstream.

After we are done with the tty buffer, zero it out.

Reported-by: aszlig <aszlig@nix.build>
Tested-by: Milan Broz <gmazyland@gmail.com>
Tested-by: Daniel Zatovic <daniel.zatovic@gmail.com>
Tested-by: aszlig <aszlig@nix.build>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_buffer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -415,6 +415,8 @@ receive_buf(struct tty_struct *tty, stru
 			disc->ops->receive_buf(tty, p, f, count);
 	}
 	head->read += count;
+	if (count > 0)
+		memset(p, 0, count);
 	return count;
 }
 


