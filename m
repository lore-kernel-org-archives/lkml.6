Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E723206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897263;
	bh=nFNLTX0R5C+smZTDbQBKQ6nW982cDG4l+SCvVBFbLL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sCZgBtzLp1nz6bvkMq21AaF2BpXKgfxyTOMw+NcqmFWE8CU7SlOdoaCJ4t1ZvKGl+
	 /KjK+P1jHXR3e+jZ3GxlUv91WElpA/fsFhZuDNofpBOF1OXxwdQSZCvM4sJYl3rcbo
	 0LSRrfW4ge37xNKA1fr6xNn2aKU5stJ4qjOhFX4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbfBKPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390097AbfBKPA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:00:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91220222A4;
        Mon, 11 Feb 2019 15:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897259;
        bh=nFNLTX0R5C+smZTDbQBKQ6nW982cDG4l+SCvVBFbLL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+OnUAs6BnPvCtllFe/Zr2n48t273jE70WVm/Mk/DqLU3mESoBai6drY/VJWTe/C7
         AMPMg2RFlSJTmg4IiQPHubOuztQKJvIm+Yi34RvMM1QpsU6Xpi3dnOtg0V4PJHicpt
         EyZF1bsfkLhMsug6y9wCWmMO2vI8uvYBrHB7x6Iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 142/205] cifs: check ntwrk_buf_start for NULL before dereferencing it
Date:   Mon, 11 Feb 2019 15:19:00 +0100
Message-Id: <20190211141837.664712281@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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



