Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E332C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA47B2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+RpU6zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA47B2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbeK3Bhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeK3Bhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4074F2146D;
        Thu, 29 Nov 2018 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501932;
        bh=0wOU+lNkClp/YzxVUBS3hbEg3mAL/DQsJv2FbtZUvMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+RpU6zVYWO5S1GJRmO6tGOKwAZOofUrD4DS1bfnjgqctWXhwNuRc6TfNUhOQQqKS
         MXDKn24WMVcWSrr/Zx+UlldxCS+fwlsvXqxEXgbA399tp2VR3KbKLiK1KBQMpeahRT
         0DlUtSuPo90hKLdp7+63JA74uAQpYCl+wn1TeFEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, aszlig <aszlig@nix.build>,
        Milan Broz <gmazyland@gmail.com>,
        Daniel Zatovic <daniel.zatovic@gmail.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4.19 101/110] tty: wipe buffer.
Date:   Thu, 29 Nov 2018 15:13:12 +0100
Message-Id: <20181129135925.328866336@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/tty/tty_buffer.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -468,11 +468,15 @@ receive_buf(struct tty_port *port, struc
 {
 	unsigned char *p = char_buf_ptr(head, head->read);
 	char	      *f = NULL;
+	int n;
 
 	if (~head->flags & TTYB_NORMAL)
 		f = flag_buf_ptr(head, head->read);
 
-	return port->client_ops->receive_buf(port, p, f, count);
+	n = port->client_ops->receive_buf(port, p, f, count);
+	if (n > 0)
+		memset(p, 0, n);
+	return n;
 }
 
 /**


