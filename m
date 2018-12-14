Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1E1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED4720892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791120;
	bh=Z5vKT/Ep4xs7jSGva5F4sz9QjugI5zZfWMnMMjhKBxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5z/xJP/byOs5+YvdKffDFzXgPFMRhOqC1C2tlYuYBsWUTjHNbtMXFf63W+VI6tzw
	 tcsDdC2eYNhmxaJe6WohQksHgyzSdg0bAd6Qgv68ct9rT71gJOxuJZVTYXMAN/klq1
	 RpqdU5mSuXy0BYv23oDOqxM9XW39EMOfmkPgStzI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED4720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbeLNMFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbeLNMFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B15214AE;
        Fri, 14 Dec 2018 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789130;
        bh=Z5vKT/Ep4xs7jSGva5F4sz9QjugI5zZfWMnMMjhKBxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mt4YNFZn6Qs7tImcKjNwxS2X/TBndwi//XCwiV5ys24Ls5Zo2DDBrD8HzmZ8ACcEo
         vExBf7fR1JMi15b/9yN7VSSD/wycQfynH30MpCHqQoN3XR+orW5ND/7pT81JhZOXNC
         RWOFGuGSw/1ZCWhLTCdx0vTIo0hPn14/r+0JFIE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Axtens <dja@axtens.net>,
        Shantanu Goel <sgoel01@yahoo.com>,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 106/142] cachefiles: Fix page leak in cachefiles_read_backing_file while vmscan is active
Date:   Fri, 14 Dec 2018 12:59:51 +0100
Message-Id: <20181214115751.294555259@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
-- 
2.19.1



