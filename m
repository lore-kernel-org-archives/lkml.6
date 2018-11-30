Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC2BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA6620868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA6620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeLADu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:50:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeLADu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:50:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 546874E937;
        Fri, 30 Nov 2018 16:40:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 769C65EE03;
        Fri, 30 Nov 2018 16:40:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/7] cachefiles: Fix page leak in
 cachefiles_read_backing_file while vmscan is active
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Daniel Axtens <dja@axtens.net>, Shantanu Goel <sgoel01@yahoo.com>,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        Daniel Axtens <dja@axtens.net>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 16:40:33 +0000
Message-ID: <154359603369.18703.763590641473461495.stgit@warthog.procyon.org.uk>
In-Reply-To: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
References: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 30 Nov 2018 16:40:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

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
---

 fs/cachefiles/rdwr.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 40f7595aad10..db233588a69a 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -535,7 +535,10 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
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
@@ -608,7 +611,10 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
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

