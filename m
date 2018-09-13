Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D86C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726EC20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726EC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbeIMSrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:47:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeIMSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:47:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF773D19;
        Thu, 13 Sep 2018 13:37:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 49/78] smb3: fix reset of bytes read and written stats
Date:   Thu, 13 Sep 2018 15:31:36 +0200
Message-Id: <20180913131810.731604705@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

[ Upstream commit c281bc0c7412308c7ec0888904f7c99353da4796 ]

echo 0 > /proc/fs/cifs/Stats is supposed to reset the stats
but there were four (see example below) that were not reset
(bytes read and witten, total vfs ops and max ops
at one time).

...
0 session 0 share reconnects
Total vfs operations: 100 maximum at one time: 2

1) \\localhost\test
SMBs: 0
Bytes read: 502092  Bytes written: 31457286
TreeConnects: 0 total 0 failed
TreeDisconnects: 0 total 0 failed
...

This patch fixes cifs_stats_proc_write to properly reset
those four.

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifs_debug.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -284,6 +284,10 @@ static ssize_t cifs_stats_proc_write(str
 		atomic_set(&totBufAllocCount, 0);
 		atomic_set(&totSmBufAllocCount, 0);
 #endif /* CONFIG_CIFS_STATS2 */
+		spin_lock(&GlobalMid_Lock);
+		GlobalMaxActiveXid = 0;
+		GlobalCurrentXid = 0;
+		spin_unlock(&GlobalMid_Lock);
 		spin_lock(&cifs_tcp_ses_lock);
 		list_for_each(tmp1, &cifs_tcp_ses_list) {
 			server = list_entry(tmp1, struct TCP_Server_Info,
@@ -296,6 +300,10 @@ static ssize_t cifs_stats_proc_write(str
 							  struct cifs_tcon,
 							  tcon_list);
 					atomic_set(&tcon->num_smbs_sent, 0);
+					spin_lock(&tcon->stat_lock);
+					tcon->bytes_read = 0;
+					tcon->bytes_written = 0;
+					spin_unlock(&tcon->stat_lock);
 					if (server->ops->clear_stats)
 						server->ops->clear_stats(tcon);
 				}


