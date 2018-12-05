Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999EDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE822087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGAn5quT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE822087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeLEJug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:50:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbeLEJud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:50:33 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C07214DB;
        Wed,  5 Dec 2018 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003432;
        bh=6dlzbb3pVlzwqUWm7sFV84ocEDbNMCtwlJSX4RY6rSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGAn5quTxzxKwdiU/JIDShnJvOmLfjo9GEMA92scC+VcJeHAk4CeFFkmctz2Oqe6e
         +5mh1qyvg2HWrv9NkqCpTcxw9ut4+M8XvVdyw2Z/m99A/6ySXQhLMjieppWj6+kmqZ
         7yRKkH9DJk/zDsEr4NmWpmYRunF0CgFkeIl0Xfvc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        Shantanu Goel <sgoel01@yahoo.com>,
        Daniel Axtens <dja@axtens.net>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 29/45] cachefiles: Fix page leak in cachefiles_read_backing_file while vmscan is active
Date:   Wed,  5 Dec 2018 04:46:50 -0500
Message-Id: <20181205094706.7225-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094706.7225-1-sashal@kernel.org>
References: <20181205094706.7225-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

[ Upstream commit 9a24ce5b66f9c8190d63b15f4473600db4935f1f ]

[Description]

In a heavily loaded system where the system pagecache is nearing memory
limits and fscache is enabled, pages can be leaked by fscache while trying
read pages from cachefiles backend.  This can happen because two
applications can be reading same page from a single mount, two threads can
be trying to read the backing page at same time.  This results in one of
the threads finding that a page for the backing file or netfs file is
already in the radix tree.  During the error handling cachefiles does not
clean up the reference on backing page, leading to page leak.

[Fix]
The fix is straightforward, to decrement the reference when error is
encountered.

  [dhowells: Note that I've removed the clearance and put of newpage as
   they aren't attested in the commit message and don't appear to actually
   achieve anything since a new page is only allocated is newpage!=NULL and
   any residual new page is cleared before returning.]

[Testing]
I have tested the fix using following method for 12+ hrs.

1) mkdir -p /mnt/nfs ; mount -o vers=3,fsc <server_ip>:/export /mnt/nfs
2) create 10000 files of 2.8MB in a NFS mount.
3) start a thread to simulate heavy VM presssure
   (while true ; do echo 3 > /proc/sys/vm/drop_caches ; sleep 1 ; done)&
4) start multiple parallel reader for data set at same time
   find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
   find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
   find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
   ..
   ..
   find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
   find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
5) finally check using cat /proc/fs/fscache/stats | grep -i pages ;
   free -h , cat /proc/meminfo and page-types -r -b lru
   to ensure all pages are freed.

Reviewed-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Shantanu Goel <sgoel01@yahoo.com>
Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
[dja: forward ported to current upstream]
Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/rdwr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 5e3bc9de7a16..8d43306c038b 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -537,7 +537,10 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 					    netpage->index, cachefiles_gfp);
 		if (ret < 0) {
 			if (ret == -EEXIST) {
+				put_page(backpage);
+				backpage = NULL;
 				put_page(netpage);
+				netpage = NULL;
 				fscache_retrieval_complete(op, 1);
 				continue;
 			}
@@ -610,7 +613,10 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 					    netpage->index, cachefiles_gfp);
 		if (ret < 0) {
 			if (ret == -EEXIST) {
+				put_page(backpage);
+				backpage = NULL;
 				put_page(netpage);
+				netpage = NULL;
 				fscache_retrieval_complete(op, 1);
 				continue;
 			}
-- 
2.17.1

