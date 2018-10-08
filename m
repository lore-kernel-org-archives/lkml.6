Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B75C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D821479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2xpc9l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5D821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbeJICCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D13214C4;
        Mon,  8 Oct 2018 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024548;
        bh=Fn5gEE+s5YnT98NaZWaXowX8USnsTFaQuJSauAmgg/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2xpc9l9G23O+M9bufk8l3UsnfkLrLkCRK/CSSBGkGRiy2yk6VCI0b8cmpL8TLRCf
         BorHyH5lhMJiXmQ+dKVMd74TJQrMYIssV6OVlQllfLRuyPxvZky/FOtecvtqJEUzgx
         GtUegtwQafERPi0qaqmsUBbJoUN7kfDQt9rckUms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 076/168] afs: Fix cell specification to permit an empty address list
Date:   Mon,  8 Oct 2018 20:30:56 +0200
Message-Id: <20181008175622.960987459@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit ecfe951f0c1b169ea4b7dd6f3a404dfedd795bc2 ]

Fix the cell specification mechanism to allow cells to be pre-created
without having to specify at least one address (the addresses will be
upcalled for).

This allows the cell information preload service to avoid the need to issue
loads of DNS lookups during boot to get the addresses for each cell (500+
lookups for the 'standard' cell list[*]).  The lookups can be done later as
each cell is accessed through the filesystem.

Also remove the print statement that prints a line every time a new cell is
added.

[*] There are 144 cells in the list.  Each cell is first looked up for an
    SRV record, and if that fails, for an AFSDB record.  These get a list
    of server names, each of which then has to be looked up to get the
    addresses for that server.  E.g.:

	dig srv _afs3-vlserver._udp.grand.central.org

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/proc.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -98,13 +98,13 @@ static int afs_proc_cells_write(struct f
 		goto inval;
 
 	args = strchr(name, ' ');
-	if (!args)
-		goto inval;
-	do {
-		*args++ = 0;
-	} while(*args == ' ');
-	if (!*args)
-		goto inval;
+	if (args) {
+		do {
+			*args++ = 0;
+		} while(*args == ' ');
+		if (!*args)
+			goto inval;
+	}
 
 	/* determine command to perform */
 	_debug("cmd=%s name=%s args=%s", buf, name, args);
@@ -120,7 +120,6 @@ static int afs_proc_cells_write(struct f
 
 		if (test_and_set_bit(AFS_CELL_FL_NO_GC, &cell->flags))
 			afs_put_cell(net, cell);
-		printk("kAFS: Added new cell '%s'\n", name);
 	} else {
 		goto inval;
 	}


