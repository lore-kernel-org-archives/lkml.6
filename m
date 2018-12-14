Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCAAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4188221473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790261;
	bh=SFyOMnrpJRRej8iGYJzSEjQkNY17opt/5SqP/mn+BNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mTENImgmXuYYTyMX1PVLRVSUo+DYPn1jYU+GELc7G1jE5NYB0p5fQZW4HIF+yXSi6
	 iBhl14J9lmPj+8KyPiCL4sQbFCsFvr+sellzH0hhTABwtYueX5XsYqXNVUBXeKe1Oo
	 ypzs58yT29RHoiZ7QQqhIwtuLMW42sSPcDm/nZF8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4188221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeLNMNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:13:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732052AbeLNMNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:13:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D67A2133F;
        Fri, 14 Dec 2018 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789585;
        bh=SFyOMnrpJRRej8iGYJzSEjQkNY17opt/5SqP/mn+BNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdDEziSsPIUF8Jk3QG/+uIzzxl9VRhW3bj2vC/PQHldNXGkVm7NoJaWlvcaGW+S7u
         CKFPEvvK90b3kexlAz8Ld72V18VHSTQaueFpSYKLe41Cr2nGSnxt8OCHmxkaJiGdP5
         g4pkQ3mF5FHDYKiw7H3q/Wv/v86XddPLB7fiRVX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 50/51] pstore: Convert console write to use ->write_buf
Date:   Fri, 14 Dec 2018 13:00:52 +0100
Message-Id: <20181214115717.488579918@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

[ Upstream commit 70ad35db3321a6d129245979de4ac9d06eed897c ]

Maybe I'm missing something, but I don't know why it needs to copy the
input buffer to psinfo->buf and then write.  Instead we can write the
input buffer directly.  The only implementation that supports console
message (i.e. ramoops) already does it for ftrace messages.

For the upcoming virtio backend driver, it needs to protect psinfo->buf
overwritten from console messages.  If it could use ->write_buf method
instead of ->write, the problem will be solved easily.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/platform.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -584,8 +584,8 @@ static void pstore_console_write(struct
 		} else {
 			spin_lock_irqsave(&psinfo->buf_lock, flags);
 		}
-		memcpy(psinfo->buf, s, c);
-		psinfo->write(PSTORE_TYPE_CONSOLE, 0, &id, 0, 0, 0, c, psinfo);
+		psinfo->write_buf(PSTORE_TYPE_CONSOLE, 0, &id, 0,
+				  s, 0, c, psinfo);
 		spin_unlock_irqrestore(&psinfo->buf_lock, flags);
 		s += c;
 		c = e - s;


