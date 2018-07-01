Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C130C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A5D24461
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A5D24461
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeGAQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:19:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbeGAQTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:19:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0733949B;
        Sun,  1 Jul 2018 16:19:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Wysochanski <dwysocha@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.4 091/105] NFSv4: Fix possible 1-byte stack overflow in nfs_idmap_read_and_verify_message
Date:   Sun,  1 Jul 2018 18:02:41 +0200
Message-Id: <20180701153155.979014291@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Wysochanski <dwysocha@redhat.com>

commit d68894800ec5712d7ddf042356f11e36f87d7f78 upstream.

In nfs_idmap_read_and_verify_message there is an incorrect sprintf '%d'
that converts the __u32 'im_id' from struct idmap_msg to 'id_str', which
is a stack char array variable of length NFS_UINT_MAXLEN == 11.
If a uid or gid value is > 2147483647 = 0x7fffffff, the conversion
overflows into a negative value, for example:
crash> p (unsigned) (0x80000000)
$1 = 2147483648
crash> p (signed) (0x80000000)
$2 = -2147483648
The '-' sign is written to the buffer and this causes a 1 byte overflow
when the NULL byte is written, which corrupts kernel stack memory.  If
CONFIG_CC_STACKPROTECTOR_STRONG is set we see a stack-protector panic:

[11558053.616565] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ffffffffa05b8a8c
[11558053.639063] CPU: 6 PID: 9423 Comm: rpc.idmapd Tainted: G        W      ------------ T 3.10.0-514.el7.x86_64 #1
[11558053.641990] Hardware name: Red Hat OpenStack Compute, BIOS 1.10.2-3.el7_4.1 04/01/2014
[11558053.644462]  ffffffff818c7bc0 00000000b1f3aec1 ffff880de0f9bd48 ffffffff81685eac
[11558053.646430]  ffff880de0f9bdc8 ffffffff8167f2b3 ffffffff00000010 ffff880de0f9bdd8
[11558053.648313]  ffff880de0f9bd78 00000000b1f3aec1 ffffffff811dcb03 ffffffffa05b8a8c
[11558053.650107] Call Trace:
[11558053.651347]  [<ffffffff81685eac>] dump_stack+0x19/0x1b
[11558053.653013]  [<ffffffff8167f2b3>] panic+0xe3/0x1f2
[11558053.666240]  [<ffffffff811dcb03>] ? kfree+0x103/0x140
[11558053.682589]  [<ffffffffa05b8a8c>] ? idmap_pipe_downcall+0x1cc/0x1e0 [nfsv4]
[11558053.689710]  [<ffffffff810855db>] __stack_chk_fail+0x1b/0x30
[11558053.691619]  [<ffffffffa05b8a8c>] idmap_pipe_downcall+0x1cc/0x1e0 [nfsv4]
[11558053.693867]  [<ffffffffa00209d6>] rpc_pipe_write+0x56/0x70 [sunrpc]
[11558053.695763]  [<ffffffff811fe12d>] vfs_write+0xbd/0x1e0
[11558053.702236]  [<ffffffff810acccc>] ? task_work_run+0xac/0xe0
[11558053.704215]  [<ffffffff811fec4f>] SyS_write+0x7f/0xe0
[11558053.709674]  [<ffffffff816964c9>] system_call_fastpath+0x16/0x1b

Fix this by calling the internally defined nfs_map_numeric_to_string()
function which properly uses '%u' to convert this __u32.  For consistency,
also replace the one other place where snprintf is called.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Reported-by: Stephen Johnston <sjohnsto@redhat.com>
Fixes: cf4ab538f1516 ("NFSv4: Fix the string length returned by the idmapper")
Cc: stable@vger.kernel.org # v3.4+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4idmap.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -343,7 +343,7 @@ static ssize_t nfs_idmap_lookup_name(__u
 	int id_len;
 	ssize_t ret;
 
-	id_len = snprintf(id_str, sizeof(id_str), "%u", id);
+	id_len = nfs_map_numeric_to_string(id, id_str, sizeof(id_str));
 	ret = nfs_idmap_get_key(id_str, id_len, type, buf, buflen, idmap);
 	if (ret < 0)
 		return -EINVAL;
@@ -626,7 +626,8 @@ static int nfs_idmap_read_and_verify_mes
 		if (strcmp(upcall->im_name, im->im_name) != 0)
 			break;
 		/* Note: here we store the NUL terminator too */
-		len = sprintf(id_str, "%d", im->im_id) + 1;
+		len = 1 + nfs_map_numeric_to_string(im->im_id, id_str,
+						    sizeof(id_str));
 		ret = nfs_idmap_instantiate(key, authkey, id_str, len);
 		break;
 	case IDMAP_CONV_IDTONAME:


