Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436F5C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BC72086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762508;
	bh=WsSIkIxkUch3UxoQV10QzzILtiWYQRksiTAhvgqU5U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v+3zKH/OKKZEWMDRJnNNoLCQDpDj7gJx9fr8zSGMi/FErpKj/tHpJDEvV3VWobAkO
	 LTqjYJAFCYdx56jJh4blvT9IEc/B51n7Nm4A7Z+gomy2soTL3P4VTDq/wAQw4zAF2z
	 NXtoJ7gjjIDXsR3d/0kBwoUj5aEruMQTaBraumqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfA2Ls0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfA2LsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:48:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C115D2086C;
        Tue, 29 Jan 2019 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762498;
        bh=WsSIkIxkUch3UxoQV10QzzILtiWYQRksiTAhvgqU5U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXX68Ruel4aUkhHPkDwOTFRvAXYvfHr9peo7ezPxtfaKARZLfTIuKouzlUup+gAII
         zSWYuaNq4HQ8EOuWGeKAAgMcCXdZft78oglfbCQsPZcv8If7JZPUlavlGefJJ7Gtsy
         9Sm+uA2hEfmvW+D8roDDyCWmhRcPqM9oK1MlhsDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH 4.14 25/68] tty: Handle problem if line discipline does not have receive_buf
Date:   Tue, 29 Jan 2019 12:35:47 +0100
Message-Id: <20190129113133.736772342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 27cfb3a53be46a54ec5e0bd04e51995b74c90343 upstream.

Some tty line disciplines do not have a receive buf callback, so
properly check for that before calling it.  If they do not have this
callback, just eat the character quietly, as we can't fail this call.

Reported-by: Jann Horn <jannh@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2180,7 +2180,8 @@ static int tiocsti(struct tty_struct *tt
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return -EIO;
-	ld->ops->receive_buf(tty, &ch, &mbz, 1);
+	if (ld->ops->receive_buf)
+		ld->ops->receive_buf(tty, &ch, &mbz, 1);
 	tty_ldisc_deref(ld);
 	return 0;
 }


