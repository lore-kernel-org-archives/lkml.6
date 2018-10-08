Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F201AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA7C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NomxWUiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA7C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJIBr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:47:27 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3443C2089D;
        Mon,  8 Oct 2018 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023664;
        bh=qhQoX2OYGHHdWj5nCO9UDBYQO085+6PPu5742qIHMLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NomxWUiulB8gZTiBAo9CCEDi9dveuU95f7j5Kk5qxoeUTuqDQ55kiddG+YSzznUBG
         5cu3q3fsHr+fr+WhQXmSQtUEU77ebX9/ADC+2AoOp6B4vfkSbo5bUkIVMZb7PoODaW
         784W2QgJ1b4Gh1mOhEj7IQla60YHZlCjVOiZAziQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 041/113] nfsd: fix corrupted reply to badly ordered compound
Date:   Mon,  8 Oct 2018 20:30:42 +0200
Message-Id: <20181008175532.835899081@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit 5b7b15aee641904ae269be9846610a3950cbd64c ]

We're encoding a single op in the reply but leaving the number of ops
zero, so the reply makes no sense.

Somewhat academic as this isn't a case any real client will hit, though
in theory perhaps that could change in a future protocol extension.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1632,6 +1632,7 @@ nfsd4_proc_compound(struct svc_rqst *rqs
 	if (status) {
 		op = &args->ops[0];
 		op->status = status;
+		resp->opcnt = 1;
 		goto encode_op;
 	}
 


