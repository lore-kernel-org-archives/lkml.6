Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF47C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D029C2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D029C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbeKLGEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52968 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729602AbeKLGEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:43 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt6-0000l8-0z; Sun, 11 Nov 2018 19:59:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001V3-QL; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Stephen Johnston" <sjohnsto@redhat.com>,
        "Dave Wysochanski" <dwysocha@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.554007570@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 103/366] NFSv4: Fix possible 1-byte stack overflow in
 nfs_idmap_read_and_verify_message
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfs/idmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/nfs/idmap.c
+++ b/fs/nfs/idmap.c
@@ -339,7 +339,7 @@ static ssize_t nfs_idmap_lookup_name(__u
 	int id_len;
 	ssize_t ret;
 
-	id_len = snprintf(id_str, sizeof(id_str), "%u", id);
+	id_len = nfs_map_numeric_to_string(id, id_str, sizeof(id_str));
 	ret = nfs_idmap_get_key(id_str, id_len, type, buf, buflen, idmap);
 	if (ret < 0)
 		return -EINVAL;
@@ -636,7 +636,8 @@ static int nfs_idmap_read_and_verify_mes
 		if (strcmp(upcall->im_name, im->im_name) != 0)
 			break;
 		/* Note: here we store the NUL terminator too */
-		len = sprintf(id_str, "%d", im->im_id) + 1;
+		len = 1 + nfs_map_numeric_to_string(im->im_id, id_str,
+						    sizeof(id_str));
 		ret = nfs_idmap_instantiate(key, authkey, id_str, len);
 		break;
 	case IDMAP_CONV_IDTONAME:

