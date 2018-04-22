Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48/RjGFfxrUAxSGppy271Ojl/6ErmdcXb1AiBqaDz9LqJW1WwtVVb2uFnBkskaBA6eDnqqz
ARC-Seal: i=1; a=rsa-sha256; t=1524406023; cv=none;
        d=google.com; s=arc-20160816;
        b=FqN69ajE3BT4mdDXQnnHnDhsVSDk5Id3rhk03SoMzM+61IhA4BfOxOcNm/fdNs9LkR
         g7cN26AFGrkFPGO6ZliWlFZAhhXonhU4eXrDDE5tOtyuAIj0OK8oJHYV+4+FiFuXQvxz
         8HnN6BLxoLfeNOx2GplMyIXLh3pDJCaGwAnAPQsQOPLSZ7xi6MTIyRY1N4WLI7vhCXe4
         YdI+GJEGuG98o7kU0IbroD435X4B3oDavRXJd5QLzqE1RhSCydJtrp0iumzfQgctLoyK
         pRP+AzzNSAGWfPuLl4ZkNApisFAjWZFMri3Erl57H+PbWk4oOFNnIMrNJBdFUmfgaFCr
         5XIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=493UxNzBq9Ob7hIdI6j3ZX40I/FVDF8kmOS2URa7yDQ=;
        b=L22Pst23HORkp6KawnVtPXjWWzs+4qWUtty9xwrjxWRaukfwEv3az9UssxbfWnrRZP
         fWTd94bU72Un6uXeBrd0YnY/ntiVWlalTWyZQzjeogRxdXGw2Z+sxAuRbmzYKrL1Qm3p
         8hbHE3C4cfom0x4ry6f8oVQ4AxNEiqn2BilljFQzCw3zXYUrHmoSrfBGMzR2ZqdB++lt
         p35DNEKhrV8Gq/X82Sg4MaI2U3xEPI6EMACFnz5JyOyFX4FOQtSvEPzhdWGa1ZoNkkWl
         CqwOuQjiCsJxjYXRrRjQtOvZHBdxDct7u64TSOw1IzT1wqObpeJe0iUgDfzaMN00YbZr
         4VVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 085/164] dm crypt: limit the number of allocated pages
Date: Sun, 22 Apr 2018 15:52:32 +0200
Message-Id: <20180422135138.908144029@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455055708179128?=
X-GMAIL-MSGID: =?utf-8?q?1598455570576233758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 5059353df86e2573ccd9d43fd9d9396dcec47ca2 upstream.

dm-crypt consumes an excessive amount memory when the user attempts to
zero a dm-crypt device with "blkdiscard -z". The command "blkdiscard -z"
calls the BLKZEROOUT ioctl, it goes to the function __blkdev_issue_zeroout,
__blkdev_issue_zeroout sends a large amount of write bios that contain
the zero page as their payload.

For each incoming page, dm-crypt allocates another page that holds the
encrypted data, so when processing "blkdiscard -z", dm-crypt tries to
allocate the amount of memory that is equal to the size of the device.
This can trigger OOM killer or cause system crash.

Fix this by limiting the amount of memory that dm-crypt allocates to 2%
of total system memory. This limit is system-wide and is divided by the
number of active dm-crypt devices and each device receives an equal
share.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -148,6 +148,8 @@ struct crypt_config {
 	mempool_t *tag_pool;
 	unsigned tag_pool_max_sectors;
 
+	struct percpu_counter n_allocated_pages;
+
 	struct bio_set *bs;
 	struct mutex bio_alloc_lock;
 
@@ -219,6 +221,12 @@ struct crypt_config {
 #define MAX_TAG_SIZE	480
 #define POOL_ENTRY_SIZE	512
 
+static DEFINE_SPINLOCK(dm_crypt_clients_lock);
+static unsigned dm_crypt_clients_n = 0;
+static volatile unsigned long dm_crypt_pages_per_client;
+#define DM_CRYPT_MEMORY_PERCENT			2
+#define DM_CRYPT_MIN_PAGES_PER_CLIENT		(BIO_MAX_PAGES * 16)
+
 static void clone_init(struct dm_crypt_io *, struct bio *);
 static void kcryptd_queue_crypt(struct dm_crypt_io *io);
 static struct scatterlist *crypt_get_sg_data(struct crypt_config *cc,
@@ -2156,6 +2164,43 @@ static int crypt_wipe_key(struct crypt_c
 	return r;
 }
 
+static void crypt_calculate_pages_per_client(void)
+{
+	unsigned long pages = (totalram_pages - totalhigh_pages) * DM_CRYPT_MEMORY_PERCENT / 100;
+
+	if (!dm_crypt_clients_n)
+		return;
+
+	pages /= dm_crypt_clients_n;
+	if (pages < DM_CRYPT_MIN_PAGES_PER_CLIENT)
+		pages = DM_CRYPT_MIN_PAGES_PER_CLIENT;
+	dm_crypt_pages_per_client = pages;
+}
+
+static void *crypt_page_alloc(gfp_t gfp_mask, void *pool_data)
+{
+	struct crypt_config *cc = pool_data;
+	struct page *page;
+
+	if (unlikely(percpu_counter_compare(&cc->n_allocated_pages, dm_crypt_pages_per_client) >= 0) &&
+	    likely(gfp_mask & __GFP_NORETRY))
+		return NULL;
+
+	page = alloc_page(gfp_mask);
+	if (likely(page != NULL))
+		percpu_counter_add(&cc->n_allocated_pages, 1);
+
+	return page;
+}
+
+static void crypt_page_free(void *page, void *pool_data)
+{
+	struct crypt_config *cc = pool_data;
+
+	__free_page(page);
+	percpu_counter_sub(&cc->n_allocated_pages, 1);
+}
+
 static void crypt_dtr(struct dm_target *ti)
 {
 	struct crypt_config *cc = ti->private;
@@ -2182,6 +2227,10 @@ static void crypt_dtr(struct dm_target *
 	mempool_destroy(cc->req_pool);
 	mempool_destroy(cc->tag_pool);
 
+	if (cc->page_pool)
+		WARN_ON(percpu_counter_sum(&cc->n_allocated_pages) != 0);
+	percpu_counter_destroy(&cc->n_allocated_pages);
+
 	if (cc->iv_gen_ops && cc->iv_gen_ops->dtr)
 		cc->iv_gen_ops->dtr(cc);
 
@@ -2196,6 +2245,12 @@ static void crypt_dtr(struct dm_target *
 
 	/* Must zero key material before freeing */
 	kzfree(cc);
+
+	spin_lock(&dm_crypt_clients_lock);
+	WARN_ON(!dm_crypt_clients_n);
+	dm_crypt_clients_n--;
+	crypt_calculate_pages_per_client();
+	spin_unlock(&dm_crypt_clients_lock);
 }
 
 static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
@@ -2643,6 +2698,15 @@ static int crypt_ctr(struct dm_target *t
 
 	ti->private = cc;
 
+	spin_lock(&dm_crypt_clients_lock);
+	dm_crypt_clients_n++;
+	crypt_calculate_pages_per_client();
+	spin_unlock(&dm_crypt_clients_lock);
+
+	ret = percpu_counter_init(&cc->n_allocated_pages, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto bad;
+
 	/* Optional parameters need to be read before cipher constructor */
 	if (argc > 5) {
 		ret = crypt_ctr_optional(ti, argc - 5, &argv[5]);
@@ -2697,7 +2761,7 @@ static int crypt_ctr(struct dm_target *t
 		ALIGN(sizeof(struct dm_crypt_io) + cc->dmreq_start + additional_req_size,
 		      ARCH_KMALLOC_MINALIGN);
 
-	cc->page_pool = mempool_create_page_pool(BIO_MAX_PAGES, 0);
+	cc->page_pool = mempool_create(BIO_MAX_PAGES, crypt_page_alloc, crypt_page_free, cc);
 	if (!cc->page_pool) {
 		ti->error = "Cannot allocate page mempool";
 		goto bad;
