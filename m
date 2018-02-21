Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2242590hQqsspV63i8J7jJLoAhLDJsZ8CdxmH3tXjbwhLsBOHZWkZFR1yRsLaqqqYzYtuw0I
ARC-Seal: i=1; a=rsa-sha256; t=1519218531; cv=none;
        d=google.com; s=arc-20160816;
        b=uVOO2Cbk7mUY02RbDD7Ko+rn5d811fM+2EFJcFQ+Fp5i6UqLJhtCre4EiNSlgKdizL
         mzcO7yK5rSqv0szgWFyWHfGdS/ZWzEVm7IGF6JgVYN4iDFgA57RNa+26Z6hCFjbmnZVc
         dq0CqgFPnbLUIb2GNC3Ms+T91kd6rYHIbfoEoDRqTqL+ses8T4B/4CiRBFPLHztdaNCJ
         0iIGoZJYa6CGb/gluvOWqoZRtElLHp97Wm4ZIlerAKHpsrhNu3DxURJCy6JqoD8VltPg
         LHvV3/m5nLWpb44cScnbvFcGwy1GlYPamnF1c0M7idOb3dkS/BlLBMwH1Rq3UrVPzfXE
         HqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rz5MshDy8zEB+rPDtuXCDPczHieCfYcqEV7sROw+BgI=;
        b=ncjNvuLG4CTXd2MjC7MfYYfVuCuzc5Y0JLnF6PIEwIPtkNhjFtBjGPGg+uORV039VJ
         wpPnPxjCwTlsfhWjYt3KxqmG7JAKXeHdgeFmiqvJJwT3Wf2vWGo2uYKy5mLUXU7LN1Cq
         lsToJCHAucR6laHsAfHzfBoRGM9VOD6xDMZb8qciMfqsFd2lTfYahjUms8duz2RO4tT2
         QnXrMzrd0FY3g32FDBVueqHYObJnWHVj7BUmU09baVh8QuqZurG7Glf8Ilm7gGOTOb6h
         I221mHZXCTXmXzJYjci6sVG+HNa6eta0HGMgJe1ybLJoIspyh1SJtzB4+lDwdM4JyYBo
         KR6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.15 073/163] gfs2: Fixes to "Implement iomap for block_map"
Date: Wed, 21 Feb 2018 13:48:22 +0100
Message-Id: <20180221124534.510590725@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593016090861214809?=
X-GMAIL-MSGID: =?utf-8?q?1593016090861214809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 49edd5bf429c405b3a7f75503845d9f66a47dd4b upstream.

It turns out that commit 3974320ca6 "Implement iomap for block_map"
introduced a few bugs that trigger occasional failures with xfstest
generic/476:

In gfs2_iomap_begin, we jump to do_alloc when we determine that we are
beyond the end of the allocated metadata (height > ip->i_height).
There, we can end up calling hole_size with a metapath that doesn't
match the current metadata tree, which doesn't make sense.  After
untangling the code at do_alloc, fix this by checking if the block we
are looking for is within the range of allocated metadata.

In addition, add a BUG() in case gfs2_iomap_begin is accidentally called
for reading stuffed files: this is handled separately.  Make sure we
don't truncate iomap->length for reads beyond the end of the file; in
that case, the entire range counts as a hole.

Finally, revert to taking a bitmap write lock when doing allocations.
It's unclear why that change didn't lead to any failures during testing.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/bmap.c |   43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -736,7 +736,7 @@ int gfs2_iomap_begin(struct inode *inode
 	__be64 *ptr;
 	sector_t lblock;
 	sector_t lend;
-	int ret;
+	int ret = 0;
 	int eob;
 	unsigned int len;
 	struct buffer_head *bh;
@@ -748,12 +748,14 @@ int gfs2_iomap_begin(struct inode *inode
 		goto out;
 	}
 
-	if ((flags & IOMAP_REPORT) && gfs2_is_stuffed(ip)) {
-		gfs2_stuffed_iomap(inode, iomap);
-		if (pos >= iomap->length)
-			return -ENOENT;
-		ret = 0;
-		goto out;
+	if (gfs2_is_stuffed(ip)) {
+		if (flags & IOMAP_REPORT) {
+			gfs2_stuffed_iomap(inode, iomap);
+			if (pos >= iomap->length)
+				ret = -ENOENT;
+			goto out;
+		}
+		BUG_ON(!(flags & IOMAP_WRITE));
 	}
 
 	lblock = pos >> inode->i_blkbits;
@@ -764,7 +766,7 @@ int gfs2_iomap_begin(struct inode *inode
 	iomap->type = IOMAP_HOLE;
 	iomap->length = (u64)(lend - lblock) << inode->i_blkbits;
 	iomap->flags = IOMAP_F_MERGED;
-	bmap_lock(ip, 0);
+	bmap_lock(ip, flags & IOMAP_WRITE);
 
 	/*
 	 * Directory data blocks have a struct gfs2_meta_header header, so the
@@ -807,27 +809,28 @@ int gfs2_iomap_begin(struct inode *inode
 		iomap->flags |= IOMAP_F_BOUNDARY;
 	iomap->length = (u64)len << inode->i_blkbits;
 
-	ret = 0;
-
 out_release:
 	release_metapath(&mp);
-	bmap_unlock(ip, 0);
+	bmap_unlock(ip, flags & IOMAP_WRITE);
 out:
 	trace_gfs2_iomap_end(ip, iomap, ret);
 	return ret;
 
 do_alloc:
-	if (!(flags & IOMAP_WRITE)) {
-		if (pos >= i_size_read(inode)) {
+	if (flags & IOMAP_WRITE) {
+		ret = gfs2_iomap_alloc(inode, iomap, flags, &mp);
+	} else if (flags & IOMAP_REPORT) {
+		loff_t size = i_size_read(inode);
+		if (pos >= size)
 			ret = -ENOENT;
-			goto out_release;
-		}
-		ret = 0;
-		iomap->length = hole_size(inode, lblock, &mp);
-		goto out_release;
+		else if (height <= ip->i_height)
+			iomap->length = hole_size(inode, lblock, &mp);
+		else
+			iomap->length = size - pos;
+	} else {
+		if (height <= ip->i_height)
+			iomap->length = hole_size(inode, lblock, &mp);
 	}
-
-	ret = gfs2_iomap_alloc(inode, iomap, flags, &mp);
 	goto out_release;
 }
 
