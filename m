Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D12C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B72222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897976;
	bh=qBMg/ow5Qnmm3YDqhiLuw1VzhfdG8pYUQVzlZyLt9zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AiWT5YQHQCg+4k5sUiBbL/8HyG+7rb2k7dpVjfxxBHeCfUzVu4OC4U43nU/Bt/zP7
	 4kpGWsAz1NiD+2CrtWqGZs70cwU9nTXn6zDirr/qdpQyVV+z7Qta4pQyYhdv3a0WVA
	 cgZGZOG8KWPNs6G4kHBfm+W6Y2o6uC7zUiPZE+W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391687AbfBKPMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:12:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391718AbfBKPJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:09:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF2B222B5;
        Mon, 11 Feb 2019 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897794;
        bh=qBMg/ow5Qnmm3YDqhiLuw1VzhfdG8pYUQVzlZyLt9zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yAWR/qOFoKGy6G93i/O82cMAuQKwZeYy5xYW9gUrCzyD6hpPY3zSWKVl2vLl/aFXA
         BwtvtOnYDtD7avICnJYt5sIVichzpmwvS/+DZfbFX2/9Q70pjt/V1nYHPcv94YxujX
         2K7yMoFunywUUuQqvyQi3Ze8Ssej1o8FkjtxBLfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 087/137] cifs: check ntwrk_buf_start for NULL before dereferencing it
Date:   Mon, 11 Feb 2019 15:19:28 +0100
Message-Id: <20190211141820.103282230@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

[ Upstream commit 59a63e479ce36a3f24444c3a36efe82b78e4a8e0 ]

RHBZ: 1021460

There is an issue where when multiple threads open/close the same directory
ntwrk_buf_start might end up being NULL, causing the call to smbCalcSize
later to oops with a NULL deref.

The real bug is why this happens and why this can become NULL for an
open cfile, which should not be allowed.
This patch tries to avoid a oops until the time when we fix the underlying
issue.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/readdir.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index ef24b4527459..68183872bf8b 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -655,7 +655,14 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 		/* scan and find it */
 		int i;
 		char *cur_ent;
-		char *end_of_smb = cfile->srch_inf.ntwrk_buf_start +
+		char *end_of_smb;
+
+		if (cfile->srch_inf.ntwrk_buf_start == NULL) {
+			cifs_dbg(VFS, "ntwrk_buf_start is NULL during readdir\n");
+			return -EIO;
+		}
+
+		end_of_smb = cfile->srch_inf.ntwrk_buf_start +
 			server->ops->calc_smb_size(
 					cfile->srch_inf.ntwrk_buf_start);
 
-- 
2.19.1



