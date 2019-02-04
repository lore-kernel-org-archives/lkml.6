Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7C6C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED53207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278717;
	bh=R5w5dNQg7o66DlSlqbyePCGoVB5X5ZkLty23U61zXeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RGDDAzPlFW/yH86e74Kp6t7G2eMgdIV8nUWnvN/0R3zfzYs0wabLAdtzyX1X9aCqr
	 FQVfdxMhSBRc4bGtO2suluyncOzxNdvU5P1EO8vm2Qp2lrz0UEUzaLlxfUUkCc3yV3
	 46yhOkQupj5VAHfhmBHmWiPtWmhNfDnOL5SarZE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfBDKit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbfBDKiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7262070C;
        Mon,  4 Feb 2019 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276725;
        bh=R5w5dNQg7o66DlSlqbyePCGoVB5X5ZkLty23U61zXeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGZTk7vfb7G+s8ffvMurWhFiBpp/h+3QF2y+DjnnTwqrTsbyOxCp5m9izncQABd4I
         fGyQQNihqD6WPi1Sak8wXdbJnSybMLqrjh/XaMJxLM1aK3Hxoe0mWnMOhKFrCavLSj
         sfoQn7+vuTU9HCXa1mupj18ZrghFH2w+rixmwupc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 3.18 08/31] CIFS: Fix possible hang during async MTU reads and writes
Date:   Mon,  4 Feb 2019 11:36:23 +0100
Message-Id: <20190204103559.731466635@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -143,14 +143,14 @@ smb2_wait_mtu_credits(struct TCP_Server_
 
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
 


