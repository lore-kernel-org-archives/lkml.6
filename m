Return-Path: <srivatsa@csail.mit.edu>
X-Google-Smtp-Source: AH8x226/rtI+S+hENVvm5wE4xBkH0zo5gxQWogoRh6xffG7ruIQ0GqteLoDOT9NhTCUVdyjKCgAW
ARC-Seal: i=1; a=rsa-sha256; t=1517883929; cv=none;
        d=google.com; s=arc-20160816;
        b=PGezpuw5hY2jp3cfD2X27irsa2TGYSHPOFdh6Eonsv3IndhtwTMgYFJC8UJRjH9LOn
         nLrEasuVnXCq/1H6OVSJvyxqntxIy3VMBcQlORkHYxRr2PQP5WA0Z7yKEXLUxwnKI3Ue
         2Vrh7wMWf3MI7TRrnF7WvSZt5i20rl5377MaVucQVfjjklZIBKO5DAKLtHobEczKVY+7
         qJkIrnhzSOY5PENbpuDtoDvz2ybRJS3roJKvv0oIHPKCQ2z2TbTsWmkDl2e3+anZnf3v
         Lfgg/gcfq2gjnUgI9CdQ6Lznmp+Od7LKvXkJ8fGVgbHDgtr662RgzZiP08c+wCwPLAKL
         8ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject
         :arc-authentication-results;
        bh=j8FeNfYh288Bn8G0Qcd6CqtxYBMRZoV72TK8w3/AgZM=;
        b=nyjiAz7KmMnza40UNal3a05iATfiH8rpkAodb65hydRar9hFlTdwykrgektoV2r2Uv
         x3X6nTQc14TuXhX2S+gJ8l/1ROMS4CIvk9uzqlbt1QTHl6x/kS8kg4njlMmDlKJSOjd0
         0ZsDvelUXCeXu9LGPUnp8b1odwno7iHRvio/KoR1gupBn7GhoXMRR7IobR8VerNUCsJU
         9n9Q2WfLDDh0jbXkGjmuAuNOAbXnLt3KTKZM0X1Pyn+1L/OKjtMF19ASoUv5vZJOrUs8
         keanhYAGtTFQPHghtTI/7kjpgiamnk5oO9HPnYnbjKAhMa9O0E30XmxPJWge4zH/ArE7
         DmFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Subject: [PATCH 2/2] block,
 char_dev: Use correct format specifier for unsigned ints
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: gregkh@linuxfoundation.org, logang@deltatee.com
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 srivatsa@csail.mit.edu
Date: Mon, 05 Feb 2018 18:25:27 -0800
Message-ID: <151788391701.28069.13145257664735983272.stgit@srivatsa-ubuntu>
In-Reply-To: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
References: <151788389652.28069.6065922071875812126.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591616659826839373?=
X-GMAIL-MSGID: =?utf-8?q?1591616659826839373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srivatsa S. Bhat <srivatsa@csail.mit.edu>

register_blkdev() and __register_chrdev_region() treat the major
number as an unsigned int. So print it the same way to avoid
absurd error statements such as:
"... major requested (-1) is greater than the maximum (511) ..."
(and also fix off-by-one bugs in the error prints).

While at it, also update the comment describing register_blkdev().

Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---

 block/genhd.c |   19 +++++++++++--------
 fs/char_dev.c |    4 ++--
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 88a53c1..21a18e5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -308,19 +308,22 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 /**
  * register_blkdev - register a new block device
  *
- * @major: the requested major device number [1..255]. If @major = 0, try to
- *         allocate any unused major number.
+ * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
+ *         @major = 0, try to allocate any unused major number.
  * @name: the name of the new block device as a zero terminated string
  *
  * The @name must be unique within the system.
  *
  * The return value depends on the @major input parameter:
  *
- *  - if a major device number was requested in range [1..255] then the
- *    function returns zero on success, or a negative error code
+ *  - if a major device number was requested in range [1..BLKDEV_MAJOR_MAX-1]
+ *    then the function returns zero on success, or a negative error code
  *  - if any unused major number was requested with @major = 0 parameter
  *    then the return value is the allocated major number in range
- *    [1..255] or a negative error code otherwise
+ *    [1..BLKDEV_MAJOR_MAX-1] or a negative error code otherwise
+ *
+ * See Documentation/admin-guide/devices.txt for the list of allocated
+ * major numbers.
  */
 int register_blkdev(unsigned int major, const char *name)
 {
@@ -347,8 +350,8 @@ int register_blkdev(unsigned int major, const char *name)
 	}
 
 	if (major >= BLKDEV_MAJOR_MAX) {
-		pr_err("register_blkdev: major requested (%d) is greater than the maximum (%d) for %s\n",
-		       major, BLKDEV_MAJOR_MAX, name);
+		pr_err("register_blkdev: major requested (%u) is greater than the maximum (%u) for %s\n",
+		       major, BLKDEV_MAJOR_MAX-1, name);
 
 		ret = -EINVAL;
 		goto out;
@@ -375,7 +378,7 @@ int register_blkdev(unsigned int major, const char *name)
 		ret = -EBUSY;
 
 	if (ret < 0) {
-		printk("register_blkdev: cannot get major %d for %s\n",
+		printk("register_blkdev: cannot get major %u for %s\n",
 		       major, name);
 		kfree(p);
 	}
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 33c9385..a279c58 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -121,8 +121,8 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 	}
 
 	if (major >= CHRDEV_MAJOR_MAX) {
-		pr_err("CHRDEV \"%s\" major requested (%d) is greater than the maximum (%d)\n",
-		       name, major, CHRDEV_MAJOR_MAX);
+		pr_err("CHRDEV \"%s\" major requested (%u) is greater than the maximum (%u)\n",
+		       name, major, CHRDEV_MAJOR_MAX-1);
 		ret = -EINVAL;
 		goto out;
 	}
