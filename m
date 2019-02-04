Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B22C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6352070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277290;
	bh=Fg0Q2XKHGpEbY6cG3nK+/SjYCnw2qGDC7c+PMeaC+CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lM6Y91MQVgZ+bKakt11DHWyFfVKgcOjBY4eSl7bJs3mUNNbs7lVs0VExJ0vGImLSV
	 8JgY0ATz/ZPa7OYRMde05hHKUqeqm8UYNilEkmKNS1TM7e7aKkgGRzFWiWapztDTl+
	 mjtsWaNpmmj49gLNMU+NEpqZ6GNp9fQh/M3rtgCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfBDKsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfBDKsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE682070C;
        Mon,  4 Feb 2019 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277281;
        bh=Fg0Q2XKHGpEbY6cG3nK+/SjYCnw2qGDC7c+PMeaC+CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gc5gPe/fv0n6Vs+3Gvu7JopfUdslezwZg1juaVUvOLT3/oGZhWjjj/Yrg3d9FNt32
         Rsp9qNhaWUjVOPdyEb9QIxLH3qho2Krt0DB9COtPayZie19k0plBVf6PTkeVVmeXtR
         bVxqAFl19MO9TvFnKWen4mKNkqr2v4laH3PsAfoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 35/74] CIFS: Do not consider -ENODATA as stat failure for reads
Date:   Mon,  4 Feb 2019 11:36:48 +0100
Message-Id: <20190204103623.964836373@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3127,7 +3127,7 @@ smb2_readv_callback(struct mid_q_entry *
 		rdata->mr = NULL;
 	}
 #endif
-	if (rdata->result) {
+	if (rdata->result && rdata->result != -ENODATA) {
 		cifs_stats_fail_inc(tcon, SMB2_READ_HE);
 		trace_smb3_read_err(0 /* xid */,
 				    rdata->cfile->fid.persistent_fid,


