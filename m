Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE5C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A2D20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277837;
	bh=icgqQ9TuPabK3SG+76AQGLp30QxJRC/Uw2As0WswRl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TE35DeIRIxP3W4qYtQHApNRAicqpdieIGOTwKHvkVfk3p8IzzBSuVGjDR00e9Ev6o
	 LxjPWNGog7Az9Qj8WJ7H6jKT3w0yywSI9qzwrzt2TkjJIhGB91eMgBLz6/Leu6GI/+
	 ajOF8C3ad+Ve8OZTl5gpXgY28+6edHYhKAlvnVcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfBDK5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbfBDKv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA3D2070C;
        Mon,  4 Feb 2019 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277519;
        bh=icgqQ9TuPabK3SG+76AQGLp30QxJRC/Uw2As0WswRl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bvp0iDxd1SxDsq7OF5KoefsfaglFYXHmH0LT7UwJFgU9euBLgYmR+6Z5ybwG3r6ty
         OlHgIxEupnzwXZRThqE1geanvfb+h5MkXm3Us6eYUhq0H9vf0Uj/+3OPj2fy57CR/P
         A1PBhEQ/LAyeyD0B9WqZKOcdjiyQl2Blyd9EhdSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 39/80] CIFS: Do not consider -ENODATA as stat failure for reads
Date:   Mon,  4 Feb 2019 11:36:59 +0100
Message-Id: <20190204103625.404265064@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 082aaa8700415f6471ec9c5ef0c8307ca214989a upstream.

When doing reads beyound the end of a file the server returns
error STATUS_END_OF_FILE error which is mapped to -ENODATA.
Currently we report it as a failure which confuses read stats.
Change it to not consider -ENODATA as failure for stat purposes.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3139,7 +3139,7 @@ smb2_readv_callback(struct mid_q_entry *
 		rdata->mr = NULL;
 	}
 #endif
-	if (rdata->result) {
+	if (rdata->result && rdata->result != -ENODATA) {
 		cifs_stats_fail_inc(tcon, SMB2_READ_HE);
 		trace_smb3_read_err(0 /* xid */,
 				    rdata->cfile->fid.persistent_fid,


