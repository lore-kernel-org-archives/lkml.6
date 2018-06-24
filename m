Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D981C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD157250F9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD157250F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934280AbeFXPvy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:51:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934006AbeFXPvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:51:52 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 550422C;
        Sun, 24 Jun 2018 15:51:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sachin Prabhu <sprabhu@redhat.com>,
        Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.9 30/39] smb3: on reconnect set PreviousSessionId field
Date:   Sun, 24 Jun 2018 23:24:17 +0800
Message-Id: <20180624152355.362741743@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624152352.038950449@linuxfoundation.org>
References: <20180624152352.038950449@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit b2adf22fdfba85a6701c481faccdbbb3a418ccfc upstream.

The server detects reconnect by the (non-zero) value in PreviousSessionId
of SMB2/SMB3 SessionSetup request, but this behavior regressed due
to commit 166cea4dc3a4f66f020cfb9286225ecd228ab61d
("SMB2: Separate RawNTLMSSP authentication from SMB2_sess_setup")

CC: Stable <stable@vger.kernel.org>
CC: Sachin Prabhu <sprabhu@redhat.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1004,6 +1004,7 @@ SMB2_sess_setup(const unsigned int xid,
 	sess_data->ses = ses;
 	sess_data->buf0_type = CIFS_NO_BUFFER;
 	sess_data->nls_cp = (struct nls_table *) nls_cp;
+	sess_data->previous_session = ses->Suid;
 
 	while (sess_data->func)
 		sess_data->func(sess_data);


