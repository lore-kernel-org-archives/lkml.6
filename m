Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B1C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1815821479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107554;
	bh=FYRap+lsLgoCN6FIe3il7/Yt7+4UAyjg3gOMucrhRsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jGdZUTsFT3825zUyDNGOCEkApEsRrOZVoxtuyq0qbRCOjeWtQVpq+iPSwN04+5kmF
	 UdMCp5WyM3llSKUXVh/TxeSxsnWy4wMtkolhlbNktQgRIOdZYA7LAFnSd4b4GmZnQ6
	 G8JAWyOOp8CZ+mWTCAE0mhiYbttOW/e17wdlBnkc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1815821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbeLFOpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730625AbeLFOpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BFC20661;
        Thu,  6 Dec 2018 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107549;
        bh=FYRap+lsLgoCN6FIe3il7/Yt7+4UAyjg3gOMucrhRsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXZOJ6n4fhcMIhmMEzUMhcynTF1WtcjbRomuFXFa4Q/YvkZncnlEcebCJI6/1hkK8
         Ine3nsYCcT7dWSNXqMZtXbpHgxQ5copTbmMQse+BBjxAsXK6WvuzTq2K2B7K6k/OXW
         bePMJ6g7GvKMDt7q2vrcJ0MW1LqCdevXA3nWi5xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 049/101] libceph: no need to drop con->mutex for ->get_authorizer()
Date:   Thu,  6 Dec 2018 15:38:48 +0100
Message-Id: <20181206143014.373934330@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

From: Ilya Dryomov <idryomov@gmail.com>

commit b3bbd3f2ab19c8ca319003b4b51ce4c4ca74da06 upstream.

->get_authorizer(), ->verify_authorizer_reply(), ->sign_message() and
->check_message_signature() shouldn't be doing anything with or on the
connection (like closing it or sending messages).

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1405,15 +1405,9 @@ static struct ceph_auth_handshake *get_c
 		return NULL;
 	}
 
-	/* Can't hold the mutex while getting authorizer */
-	mutex_unlock(&con->mutex);
 	auth = con->ops->get_authorizer(con, auth_proto, con->auth_retry);
-	mutex_lock(&con->mutex);
-
 	if (IS_ERR(auth))
 		return auth;
-	if (con->state != CON_STATE_NEGOTIATING)
-		return ERR_PTR(-EAGAIN);
 
 	con->auth_reply_buf = auth->authorizer_reply_buf;
 	con->auth_reply_buf_len = auth->authorizer_reply_buf_len;


