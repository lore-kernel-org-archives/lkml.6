Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B89C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC3D217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277572;
	bh=4joJXo5qbg/U2hIfxSQ9Bv+JGxWWwCs+dQhBcRoAo3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhAEQa41E/TJs7lRHhRZrZCZUOoV6BBaMVZrtjes+G5Ro50iT2YIRk1KuX0mp84PN
	 8JiO19MYHeyWlQIJe+hd173SxKmkiPMYaUuclv7De3tk5O/garShxBF/U6s6z4tA6+
	 /8IUPjL+QvGCI5bIutwGm9qA1NSb5QYjt2r+5PfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbfBDKwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732658AbfBDKwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDBAF217D6;
        Mon,  4 Feb 2019 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277567;
        bh=4joJXo5qbg/U2hIfxSQ9Bv+JGxWWwCs+dQhBcRoAo3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNzJjK6OsUOuHkg5fw5qYO5WdDZQTFvRijAE5P+YkXVChhaA7G/pLKgsCPS0cY6xe
         Nf2sOX76LO6PoIBMklP8C0xZBgPi3uZLmnDl4CqicHdcufTK+caWf90c3Eu3qdHGL+
         qBuLEOEZjIBbuUM/xoJqKa4g5h58fwhBs+PPUv4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 36/80] CIFS: Fix possible oops and memory leaks in async IO
Date:   Mon,  4 Feb 2019 11:36:56 +0100
Message-Id: <20190204103625.004117157@linuxfoundation.org>
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

commit 9bda8723da2d55b1de833b98cf802b88006e5b69 upstream.

Allocation of a page array for non-cached IO was separated from
allocation of rdata and wdata structures and this introduced memory
leaks and a possible null pointer dereference. This patch fixes
these problems.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2670,6 +2670,7 @@ cifs_write_from_iter(loff_t offset, size
 
 			rc = cifs_write_allocate_pages(wdata->pages, nr_pages);
 			if (rc) {
+				kvfree(wdata->pages);
 				kfree(wdata);
 				add_credits_and_wake_if(server, credits, 0);
 				break;
@@ -2681,6 +2682,7 @@ cifs_write_from_iter(loff_t offset, size
 			if (rc) {
 				for (i = 0; i < nr_pages; i++)
 					put_page(wdata->pages[i]);
+				kvfree(wdata->pages);
 				kfree(wdata);
 				add_credits_and_wake_if(server, credits, 0);
 				break;
@@ -3360,8 +3362,12 @@ cifs_send_async_read(loff_t offset, size
 			}
 
 			rc = cifs_read_allocate_pages(rdata, npages);
-			if (rc)
-				goto error;
+			if (rc) {
+				kvfree(rdata->pages);
+				kfree(rdata);
+				add_credits_and_wake_if(server, credits, 0);
+				break;
+			}
 
 			rdata->tailsz = PAGE_SIZE;
 		}
@@ -3381,7 +3387,6 @@ cifs_send_async_read(loff_t offset, size
 		if (!rdata->cfile->invalidHandle ||
 		    !(rc = cifs_reopen_file(rdata->cfile, true)))
 			rc = server->ops->async_readv(rdata);
-error:
 		if (rc) {
 			add_credits_and_wake_if(server, rdata->credits, 0);
 			kref_put(&rdata->refcount,


