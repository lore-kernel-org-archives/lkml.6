Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtKTiWcYSMNH+whiYvJ+GgakHztDxTk1yRQpGonFprhcwas3fXxIQBWxlFRDxDQv3f99OjR
ARC-Seal: i=1; a=rsa-sha256; t=1521214810; cv=none;
        d=google.com; s=arc-20160816;
        b=kw7SDZ6E9xvV4zgCAf5ORqVL2zZW89qd8l3DRXivpkI2LdpGu31IeCYswGA+XCxKk9
         Gq5Bc80N7cGHBXhqc6+gVht1EP/Oi/9j5NiO402LG2nDQ2vafXVAO6sMv2KAVMGunWuE
         d1GfJG/Ll1NhQj1oijOiYtXUA9qb+DOnYrvUxtWWElfj74JxQwuWRfHI+f/pPVUN1vEK
         W0ZhgkLX86mEwWGMhD3vogmmXsqUugWmofj4ggnxJZdntvQWhmkXGERK4dBazBpi75Jp
         FWwwSkwq1eOW21G417d5AyGObY8VkEG4Ri2TugDLtD6IROXMur91N6tSCmUUhu9R3VOq
         TAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+4Clv7nN9QRoC5JZ0W6Cat17pSIavgtH64Co+PzMHEo=;
        b=NgpFVSGKTCdixAFxoTbs+g1XcWiPVrAtIHxwnBz+vscQ1MKR4hKQmBiAAs/btZhNXs
         avpeoK4s6L4UXiO0ItS4jKS9lUiK6onHBtaj/EvYs42T/J6t/c5Y1wc4eW88R+6hyD7O
         of064LNLOsGWH8l2uNQhjGRPXgxuPsIoH3mduXRDNUFmb8VnwpbcojvTJacwV0+CfJ4O
         7LFk0m52uQo3cfKmoUKiASwTud5OKrIPMIWLyRTdLO+7rY/kXy26QG+/PknZFFl6JKNU
         OlDCsvqwtYiXwKvZokOLa1ZBHMoslkBrl/vdaVc5lsrmD2u3j/iBODCeOqc4FmbZy9YR
         kTEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.15 026/128] gfs2: Clean up {lookup,fillup}_metapath
Date: Fri, 16 Mar 2018 16:22:47 +0100
Message-Id: <20180316152337.822736897@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109341253291829?=
X-GMAIL-MSGID: =?utf-8?q?1595109341253291829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit e8b43fe0c1e035a135be7ca3791d465fcb1b501e upstream.

Split out the entire lookup loop from lookup_metapath and
fillup_metapath.  Make both functions return the actual height in
mp->mp_aheight, and return 0 on success.  Handle lookup errors properly
in trunc_dealloc.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/bmap.c |   74 +++++++++++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -305,21 +305,22 @@ static void gfs2_metapath_ra(struct gfs2
 	}
 }
 
-/**
- * lookup_mp_height - helper function for lookup_metapath
- * @ip: the inode
- * @mp: the metapath
- * @h: the height which needs looking up
- */
-static int lookup_mp_height(struct gfs2_inode *ip, struct metapath *mp, int h)
+static int __fillup_metapath(struct gfs2_inode *ip, struct metapath *mp,
+			     unsigned int x, unsigned int h)
 {
-	__be64 *ptr = metapointer(h, mp);
-	u64 dblock = be64_to_cpu(*ptr);
-
-	if (!dblock)
-		return h + 1;
+	for (; x < h; x++) {
+		__be64 *ptr = metapointer(x, mp);
+		u64 dblock = be64_to_cpu(*ptr);
+		int ret;
 
-	return gfs2_meta_indirect_buffer(ip, h + 1, dblock, &mp->mp_bh[h + 1]);
+		if (!dblock)
+			break;
+		ret = gfs2_meta_indirect_buffer(ip, x + 1, dblock, &mp->mp_bh[x + 1]);
+		if (ret)
+			return ret;
+	}
+	mp->mp_aheight = x + 1;
+	return 0;
 }
 
 /**
@@ -336,25 +337,12 @@ static int lookup_mp_height(struct gfs2_
  * at which it found the unallocated block. Blocks which are found are
  * added to the mp->mp_bh[] list.
  *
- * Returns: error or height of metadata tree
+ * Returns: error
  */
 
 static int lookup_metapath(struct gfs2_inode *ip, struct metapath *mp)
 {
-	unsigned int end_of_metadata = ip->i_height - 1;
-	unsigned int x;
-	int ret;
-
-	for (x = 0; x < end_of_metadata; x++) {
-		ret = lookup_mp_height(ip, mp, x);
-		if (ret)
-			goto out;
-	}
-
-	ret = ip->i_height;
-out:
-	mp->mp_aheight = ret;
-	return ret;
+	return __fillup_metapath(ip, mp, 0, ip->i_height - 1);
 }
 
 /**
@@ -365,25 +353,21 @@ out:
  *
  * Similar to lookup_metapath, but does lookups for a range of heights
  *
- * Returns: error or height of metadata tree
+ * Returns: error
  */
 
 static int fillup_metapath(struct gfs2_inode *ip, struct metapath *mp, int h)
 {
-	unsigned int start_h = h - 1;
-	int ret;
+	unsigned int x = 0;
 
 	if (h) {
 		/* find the first buffer we need to look up. */
-		while (start_h > 0 && mp->mp_bh[start_h] == NULL)
-			start_h--;
-		for (; start_h < h; start_h++) {
-			ret = lookup_mp_height(ip, mp, start_h);
-			if (ret)
-				return ret;
+		for (x = h - 1; x > 0; x--) {
+			if (mp->mp_bh[x])
+				break;
 		}
 	}
-	return ip->i_height;
+	return __fillup_metapath(ip, mp, x, h);
 }
 
 static inline void release_metapath(struct metapath *mp)
@@ -790,7 +774,7 @@ int gfs2_iomap_begin(struct inode *inode
 		goto do_alloc;
 
 	ret = lookup_metapath(ip, &mp);
-	if (ret < 0)
+	if (ret)
 		goto out_release;
 
 	if (mp.mp_aheight != ip->i_height)
@@ -1339,7 +1323,9 @@ static int trunc_dealloc(struct gfs2_ino
 
 	mp.mp_bh[0] = dibh;
 	ret = lookup_metapath(ip, &mp);
-	if (ret == ip->i_height)
+	if (ret)
+		goto out_metapath;
+	if (mp.mp_aheight == ip->i_height)
 		state = DEALLOC_MP_FULL; /* We have a complete metapath */
 	else
 		state = DEALLOC_FILL_MP; /* deal with partial metapath */
@@ -1435,16 +1421,16 @@ static int trunc_dealloc(struct gfs2_ino
 		case DEALLOC_FILL_MP:
 			/* Fill the buffers out to the current height. */
 			ret = fillup_metapath(ip, &mp, mp_h);
-			if (ret < 0)
+			if (ret)
 				goto out;
 
 			/* If buffers found for the entire strip height */
-			if ((ret == ip->i_height) && (mp_h == strip_h)) {
+			if (mp.mp_aheight - 1 == strip_h) {
 				state = DEALLOC_MP_FULL;
 				break;
 			}
-			if (ret < ip->i_height) /* We have a partial height */
-				mp_h = ret - 1;
+			if (mp.mp_aheight < ip->i_height) /* We have a partial height */
+				mp_h = mp.mp_aheight - 1;
 
 			/* If we find a non-null block pointer, crawl a bit
 			   higher up in the metapath and try again, otherwise
