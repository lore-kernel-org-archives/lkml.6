Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F98C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DD22083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762787;
	bh=c3VauOQN45qEG/SM+mEC95pDVBUJqXulfmhN7arytrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kRWAUpJ4JG6tnddFYMzJrIiWqV0VBAqDsBwMmL4dExbCgWhmu5HQEyZevC4Kji1qk
	 yfSE8D5TtzzSHTqmVYQ8NbaZNXKoTexfH3DhHGaIGHlHvMnrX7RbTCTfN1EM21bYu4
	 2Mn5Ktdfc5f2kC8Bfhb/ip3RIqA0C/b2rrUawnIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfA2LxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731845AbfA2Lwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:52:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 705FC2083B;
        Tue, 29 Jan 2019 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762757;
        bh=c3VauOQN45qEG/SM+mEC95pDVBUJqXulfmhN7arytrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtGjZj/dsMb5IvGsW2aRR81MYbrycSA2Cl8VUyTLUWQUP9EIrHKUoZ5oHwt2XYRcr
         6mdRqO4WvYSuSJqM2vjzyukj5ZpZobXb/8DA6BACqblxAmXfBoWB3BykZOrZYq7rCu
         oxaExPO2mf2Za9wo9scmlqdHFdwWbRRmMdT1rR34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.9 22/44] CIFS: Fix possible hang during async MTU reads and writes
Date:   Tue, 29 Jan 2019 12:36:17 +0100
Message-Id: <20190129113141.745926602@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <pshilov@microsoft.com>

commit acc58d0bab55a50e02c25f00bd6a210ee121595f upstream.

When doing MTU i/o we need to leave some credits for
possible reopen requests and other operations happening
in parallel. Currently we leave 1 credit which is not
enough even for reopen only: we need at least 2 credits
if durable handle reconnect fails. Also there may be
other operations at the same time including compounding
ones which require 3 credits at a time each. Fix this
by leaving 8 credits which is big enough to cover most
scenarios.

Was able to reproduce this when server was configured
to give out fewer credits than usual.

The proper fix would be to reconnect a file handle first
and then obtain credits for an MTU request but this leads
to bigger code changes and should happen in other patches.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -148,14 +148,14 @@ smb2_wait_mtu_credits(struct TCP_Server_
 
 			scredits = server->credits;
 			/* can deadlock with reopen */
-			if (scredits == 1) {
+			if (scredits <= 8) {
 				*num = SMB2_MAX_BUFFER_SIZE;
 				*credits = 0;
 				break;
 			}
 
-			/* leave one credit for a possible reopen */
-			scredits--;
+			/* leave some credits for reopen and other ops */
+			scredits -= 8;
 			*num = min_t(unsigned int, size,
 				     scredits * SMB2_MAX_BUFFER_SIZE);
 


