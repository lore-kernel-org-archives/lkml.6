Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251EEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4002086C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4002086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeICVnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:43:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbeICVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:43:34 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93191D00;
        Mon,  3 Sep 2018 17:22:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.14 085/165] cifs: check kmalloc before use
Date:   Mon,  3 Sep 2018 18:56:11 +0200
Message-Id: <20180903165659.379463886@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

commit 126c97f4d0d1b5b956e8b0740c81a2b2a2ae548c upstream.

The kmalloc was not being checked - if it fails issue a warning
and return -ENOMEM to the caller.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: b8da344b74c8 ("cifs: dynamic allocation of ntlmssp blob")
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
cc: Stable <stable@vger.kernel.org>`
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/sess.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -398,6 +398,12 @@ int build_ntlmssp_auth_blob(unsigned cha
 		goto setup_ntlmv2_ret;
 	}
 	*pbuffer = kmalloc(size_of_ntlmssp_blob(ses), GFP_KERNEL);
+	if (!*pbuffer) {
+		rc = -ENOMEM;
+		cifs_dbg(VFS, "Error %d during NTLMSSP allocation\n", rc);
+		*buflen = 0;
+		goto setup_ntlmv2_ret;
+	}
 	sec_blob = (AUTHENTICATE_MESSAGE *)*pbuffer;
 
 	memcpy(sec_blob->Signature, NTLMSSP_SIGNATURE, 8);


