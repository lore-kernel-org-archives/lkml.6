Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496CC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A8A2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277578;
	bh=CIiS7iLR1rQGn7Apl+5l7l7tXuR+RxtVus88uiIRO6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ebr8BnFdvC03H72wLcykNPXjtN4Fl6dKgL+qyOlUBKbbY3rbI4YRfGc6lY+JWAiY/
	 8oj1+QY57ibkag8P88GrqFobmd8vZAo8J+VP3wB9oVkYzPOgHaMvYSBxHZKIArMNlj
	 9roi+4KJLW10h4t+OfwgnpfQW9EmnyvCO5m74rUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbfBDKw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732683AbfBDKwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA0F2070C;
        Mon,  4 Feb 2019 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277573;
        bh=CIiS7iLR1rQGn7Apl+5l7l7tXuR+RxtVus88uiIRO6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nweLt8s+9qfBiIjLeaeQQu8wAqjaRqNApc4+eoDoThD+ePjiirK9CkMCNDdfky12l
         y4eqUTcG9VX8NMBcZsAPHatD0NkzJaOawGRmZtbab2klNzTOIv4BiVsiImzyD+hf2k
         PSgK842Ohj0iIMZHy7sTtgzEq68MzDaO2WNOXaeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>,
        Paulo Alcantara <palcantara@suse.de>
Subject: [PATCH 4.20 38/80] CIFS: fix use-after-free of the lease keys
Date:   Mon,  4 Feb 2019 11:36:58 +0100
Message-Id: <20190204103625.309741167@linuxfoundation.org>
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

From: Aurelien Aptel <aaptel@suse.com>

commit d339adc12a4f885b572c5412e4869af8939db854 upstream.

The request buffers are freed right before copying the pointers.
Use the func args instead which are identical and still valid.

Simple reproducer (requires KASAN enabled) on a cifs mount:

echo foo > foo ; tail -f foo & rm foo

Cc: <stable@vger.kernel.org> # 4.20
Fixes: 179e44d49c2f ("smb3: add tracepoint for sending lease break responses to server")
Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Paulo Alcantara <palcantara@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4339,8 +4339,8 @@ SMB2_lease_break(const unsigned int xid,
 	rc = cifs_send_recv(xid, ses, &rqst, &resp_buf_type, flags, &rsp_iov);
 	cifs_small_buf_release(req);
 
-	please_key_low = (__u64 *)req->LeaseKey;
-	please_key_high = (__u64 *)(req->LeaseKey+8);
+	please_key_low = (__u64 *)lease_key;
+	please_key_high = (__u64 *)(lease_key+8);
 	if (rc) {
 		cifs_stats_fail_inc(tcon, SMB2_OPLOCK_BREAK_HE);
 		trace_smb3_lease_err(le32_to_cpu(lease_state), tcon->tid,


