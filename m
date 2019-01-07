Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655EDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D70120449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865174;
	bh=8lHliPCfSEkgao2vXdzB4yvhHuunslKLrAoROSrwutk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HG6sXmyAllPBfxaEstK3P/nMJI8sfEofekbjJF2HBYJi9Wpu1nYVPnyzRjelXbuVb
	 Q2Lwp6o3wfyPVGzOyNBN9i5ZovNRsGHoGoaM0DOd41SBGbmKAaC739EXM+2QrCQ7ec
	 4iIDNaMe/ilwHIU8YkrfTTQf9+OSYR3Q9VnxLylk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfAGMqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbfAGMoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:44:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F7120449;
        Mon,  7 Jan 2019 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865051;
        bh=8lHliPCfSEkgao2vXdzB4yvhHuunslKLrAoROSrwutk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTYKGOYyggrAWaVrT5F/An0Yf9x9NZ7Ul+JTgxi+O/g3TKF8IawaxYXniNSLcj9lG
         vmHAx2DeVC2uYyk9E7p/mmoKLwVS7dnPhUTIpro+6ON3TEh+KPCl4TRyO9znM4tWjU
         65VaE2R46IQtjW68OGTUj30VeiOmVzA1/iA4WE6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murphy Zhou <jencce.kernel@gmail.com>,
        Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 129/145] CIFS: return correct errors when pinning memory failed for direct I/O
Date:   Mon,  7 Jan 2019 13:32:46 +0100
Message-Id: <20190107104454.049462373@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Long Li <longli@microsoft.com>

commit 54e94ff94eac887ddb59cfd46b18896da5695e35 upstream.

When pinning memory failed, we should return the correct error code and
rewind the SMB credits.

Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Murphy Zhou <jencce.kernel@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/file.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2630,6 +2630,9 @@ cifs_write_from_iter(loff_t offset, size
 					result, from->type,
 					from->iov_offset, from->count);
 				dump_stack();
+
+				rc = result;
+				add_credits_and_wake_if(server, credits, 0);
 				break;
 			}
 			cur_len = (size_t)result;
@@ -3313,13 +3316,16 @@ cifs_send_async_read(loff_t offset, size
 					cur_len, &start);
 			if (result < 0) {
 				cifs_dbg(VFS,
-					"couldn't get user pages (cur_len=%zd)"
+					"couldn't get user pages (rc=%zd)"
 					" iter type %d"
 					" iov_offset %zd count %zd\n",
 					result, direct_iov.type,
 					direct_iov.iov_offset,
 					direct_iov.count);
 				dump_stack();
+
+				rc = result;
+				add_credits_and_wake_if(server, credits, 0);
 				break;
 			}
 			cur_len = (size_t)result;


