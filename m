Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC839C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD3820881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763609;
	bh=IAcDttCNvqEzgDmArvDkThj5YO4oST0LUIwQq5kPb9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2MxUWW0CP663K67CaoUIV+0gbSOb11KySTdNnN+4IQ6pHHyOJDbIk868uQMc9IgB7
	 YTakxmPcx2/yygkv0j5h1Q7GySJg2d9OzqnQmtQtWXtXhvOLZeU/6xwhwkZGPo6lw+
	 FqVuB6kJwgvs37JI5UeTFGavtwWCal5JKZW8OF84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfA2Lk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfA2Lkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70AC720857;
        Tue, 29 Jan 2019 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762052;
        bh=IAcDttCNvqEzgDmArvDkThj5YO4oST0LUIwQq5kPb9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOAHiSgSrmSzwAvb8xKiJoAy9wL4Q5e3VEgVzETkM16lBSvK/K8p0wXsgAC9E9pCk
         Jw7ELdc7W3Rh1kyC+DbmvlxsooE6nwqL11GSe7ag1Py+Uk2XjC4ynz+r1nrItqBBdG
         MaFEnUt9zrSkqM13Ey5SqpSnoe51VNh8+vnx2098=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 065/117] smb3: add credits we receive from oplock/break PDUs
Date:   Tue, 29 Jan 2019 12:35:16 +0100
Message-Id: <20190129113210.867093660@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Ronnie Sahlberg <lsahlber@redhat.com>

commit 2e5700bdde438ed708b36d8acd0398dc73cbf759 upstream.

Otherwise we gradually leak credits leading to potential
hung session.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2misc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -648,6 +648,13 @@ smb2_is_valid_oplock_break(char *buffer,
 	if (rsp->sync_hdr.Command != SMB2_OPLOCK_BREAK)
 		return false;
 
+	if (rsp->sync_hdr.CreditRequest) {
+		spin_lock(&server->req_lock);
+		server->credits += le16_to_cpu(rsp->sync_hdr.CreditRequest);
+		spin_unlock(&server->req_lock);
+		wake_up(&server->request_q);
+	}
+
 	if (rsp->StructureSize !=
 				smb2_rsp_struct_sizes[SMB2_OPLOCK_BREAK_HE]) {
 		if (le16_to_cpu(rsp->StructureSize) == 44)


