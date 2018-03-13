Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+GGtqYPVvDlMSuZvVrNLUyOv/NHU9Zf3V3UQOYENy+h5Tiu+PhXCh+zjsu+yd7viqrPv/
ARC-Seal: i=1; a=rsa-sha256; t=1520955009; cv=none;
        d=google.com; s=arc-20160816;
        b=PFyllvbzNGyImoz+y3k71c+JZaKCQbREEv6o67OHwj0wNg/MxqDALk3d+6tFVMu5cD
         nC9z0s0JTitZoO9mo0trE46yJVSiC7dSBY2f6ENoJfze5bYxWEv5AgW3BaZHAHXuuKV5
         uCdzj4RGoM5NjGG9FlV3scntf/Pk3bbnRuwZsZXaJqfU8QGHclIH9vtKNh8JwMhc593K
         p25wHBxSHu3fdUs3h2oXAu/XS5DzqOIGDXPFhFqL80zg3ej1CS0KKP7P+Lsaik9GhfU4
         lwQKChYj5GZIaeySHfa5dBMaHihQcqjxQ9hdxGh2HMMuVLFuu0iOCJpPi/3WBUQ9pRRb
         WqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hl6rGKB+b2raa3Azo2qrSmf2AnDhywENun5LEPgJySs=;
        b=Pw990RE4EwEef2UE9Pt+49US10Cl09zaPrijiqpUPEYP8G9HDZWmEvFEvmNuFxeufW
         HEu3f1OwlbxG+vFwE1YGslyXUddlcgsJX1AaIv6tfc2Prm3X5xpE8iCY68F8zkQAWO3P
         LYGPelHLWWDuSX+F6Xs6fjnmAaUuvQYldfpa4dccG39P+vaFdZ8u7Ks9FEOVyMvPTYk+
         pQ7jfoRb0pE16TeadNuVcBCTEtmLOSkAWgtEPAXvb9Xq7SdYLAhJuljSDEXeik8wjKY8
         Uyv3INjgQbOBw/99nqzU5Eii4XV6rnp4WR2sTfy8CEyUjyJqoJOnTUrWTNmVBQlEPgUK
         B/Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.15 058/146] dm bufio: avoid false-positive Wmaybe-uninitialized warning
Date: Tue, 13 Mar 2018 16:23:45 +0100
Message-Id: <20180313152325.139039692@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836920413426807?=
X-GMAIL-MSGID: =?utf-8?q?1594836920413426807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 590347e4000356f55eb10b03ced2686bd74dab40 upstream.

gcc-6.3 and earlier show a new warning after a seemingly unrelated
change to the arm64 PAGE_KERNEL definition:

In file included from drivers/md/dm-bufio.c:14:0:
drivers/md/dm-bufio.c: In function 'alloc_buffer':
include/linux/sched/mm.h:182:56: warning: 'noio_flag' may be used uninitialized in this function [-Wmaybe-uninitialized]
  current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
                                                        ^

The same warning happened earlier on linux-3.18 for MIPS and I did a
workaround for that, but now it's come back.

gcc-7 and newer are apparently smart enough to figure this out, and
other architectures don't show it, so the best I could come up with is
to rework the caller slightly in a way that makes it obvious enough to
all arm64 compilers what is happening here.

Fixes: 41acec624087 ("arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()")
Link: https://patchwork.kernel.org/patch/9692829/
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[snitzer: moved declarations inside conditional, altered vmalloc return]
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-bufio.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -386,9 +386,6 @@ static void __cache_size_refresh(void)
 static void *alloc_buffer_data(struct dm_bufio_client *c, gfp_t gfp_mask,
 			       enum data_mode *data_mode)
 {
-	unsigned noio_flag;
-	void *ptr;
-
 	if (c->block_size <= DM_BUFIO_BLOCK_SIZE_SLAB_LIMIT) {
 		*data_mode = DATA_MODE_SLAB;
 		return kmem_cache_alloc(DM_BUFIO_CACHE(c), gfp_mask);
@@ -412,16 +409,15 @@ static void *alloc_buffer_data(struct dm
 	 * all allocations done by this process (including pagetables) are done
 	 * as if GFP_NOIO was specified.
 	 */
+	if (gfp_mask & __GFP_NORETRY) {
+		unsigned noio_flag = memalloc_noio_save();
+		void *ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
 
-	if (gfp_mask & __GFP_NORETRY)
-		noio_flag = memalloc_noio_save();
-
-	ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
-
-	if (gfp_mask & __GFP_NORETRY)
 		memalloc_noio_restore(noio_flag);
+		return ptr;
+	}
 
-	return ptr;
+	return __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
 }
 
 /*
