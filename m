Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2241sUp0N/ZqAFdXosqEf792htS+P6tQTqklfwwB+BfODa9tfGcpxroRUWBAt1BErDE2t/CG
ARC-Seal: i=1; a=rsa-sha256; t=1518708421; cv=none;
        d=google.com; s=arc-20160816;
        b=WWWaQ7NjHWoAin59EEZWpXQsaJSe/o8rgESNhuFxjBwFB++NKK8VKq8ril0OZ5cPs1
         mcWjSkLTvEGlLXMq9DoghAdBH1tudLMZCKUsOG8qnUC2v7sQuXJkRVLBbCtrz0MaFauf
         5Axg826sWjw71mxvs5sWb53P6Ng9/IY2/m7HDcfjYlJ9TICPGQSkNtHqQTB3Hwu9nogO
         eDNn83k7L4qbE4FuZmfgNOatC3cXb/gAre5W10G3fc+0XXmQ0q6H8JdTM19DcR1Yr5xN
         2lc4qZVRScRNf33a/m3ogots1H274Hfg9eA5FcZvJJt9GlXixGZxXGYA5rZpeRb1uqt7
         p11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j27L/KH08fJyWyxIumVUBE6/ETjmwUW0XIFvx2SX5fo=;
        b=MrM+ZsJgcPqajNMIQ4mCm0s5Ui4G0w6T+ZAaGyhsnpsYYhO4/OzwolZ4yqaI8QGXz8
         2ybaqBMn/T/oD8h2xBVakSrUfyuNojKKVSgUtWoWP6uxm4V3enOGUiX3wVgS7Ky1puQF
         RcxMCKMDYfqUGkH2LaPkNiIsHfxq+VpAEa2LA+mI9gm1DZCvLLq2kDeL5vklQvsk1uSa
         /odU1ywZdQqXmFeFNkd5SIQ+bTBFYdQsoJi6b9RRXD85akddogWr60J3Em/1oNEC/5/W
         jagFwJq6CHGenAalqKtRJ5ChTyRigzoqWX2f9jK+xTQpXfDC8z10VQDXx7Bo0Ziuey3N
         4QpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.9 19/88] ubi: fastmap: Erase outdated anchor PEBs during attach
Date: Thu, 15 Feb 2018 16:16:46 +0100
Message-Id: <20180215151225.399051475@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481201846066006?=
X-GMAIL-MSGID: =?utf-8?q?1592481201846066006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sascha Hauer <s.hauer@pengutronix.de>

commit f78e5623f45bab2b726eec29dc5cefbbab2d0b1c upstream.

The fastmap update code might erase the current fastmap anchor PEB
in case it doesn't find any new free PEB. When a power cut happens
in this situation we must not have any outdated fastmap anchor PEB
on the device, because that would be used to attach during next
boot.
The easiest way to make that sure is to erase all outdated fastmap
anchor PEBs synchronously during attach.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Richard Weinberger <richard@nod.at>
Fixes: dbb7d2a88d2a ("UBI: Add fastmap core")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/wl.c |   77 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 20 deletions(-)

--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1529,6 +1529,46 @@ static void shutdown_work(struct ubi_dev
 }
 
 /**
+ * erase_aeb - erase a PEB given in UBI attach info PEB
+ * @ubi: UBI device description object
+ * @aeb: UBI attach info PEB
+ * @sync: If true, erase synchronously. Otherwise schedule for erasure
+ */
+static int erase_aeb(struct ubi_device *ubi, struct ubi_ainf_peb *aeb, bool sync)
+{
+	struct ubi_wl_entry *e;
+	int err;
+
+	e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
+	if (!e)
+		return -ENOMEM;
+
+	e->pnum = aeb->pnum;
+	e->ec = aeb->ec;
+	ubi->lookuptbl[e->pnum] = e;
+
+	if (sync) {
+		err = sync_erase(ubi, e, false);
+		if (err)
+			goto out_free;
+
+		wl_tree_add(e, &ubi->free);
+		ubi->free_count++;
+	} else {
+		err = schedule_erase(ubi, e, aeb->vol_id, aeb->lnum, 0, false);
+		if (err)
+			goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	wl_entry_destroy(ubi, e);
+
+	return err;
+}
+
+/**
  * ubi_wl_init - initialize the WL sub-system using attaching information.
  * @ubi: UBI device description object
  * @ai: attaching information
@@ -1566,17 +1606,9 @@ int ubi_wl_init(struct ubi_device *ubi,
 	list_for_each_entry_safe(aeb, tmp, &ai->erase, u.list) {
 		cond_resched();
 
-		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
-		if (!e)
-			goto out_free;
-
-		e->pnum = aeb->pnum;
-		e->ec = aeb->ec;
-		ubi->lookuptbl[e->pnum] = e;
-		if (schedule_erase(ubi, e, aeb->vol_id, aeb->lnum, 0, false)) {
-			wl_entry_destroy(ubi, e);
+		err = erase_aeb(ubi, aeb, false);
+		if (err)
 			goto out_free;
-		}
 
 		found_pebs++;
 	}
@@ -1635,6 +1667,8 @@ int ubi_wl_init(struct ubi_device *ubi,
 			ubi_assert(!ubi->lookuptbl[e->pnum]);
 			ubi->lookuptbl[e->pnum] = e;
 		} else {
+			bool sync = false;
+
 			/*
 			 * Usually old Fastmap PEBs are scheduled for erasure
 			 * and we don't have to care about them but if we face
@@ -1644,18 +1678,21 @@ int ubi_wl_init(struct ubi_device *ubi,
 			if (ubi->lookuptbl[aeb->pnum])
 				continue;
 
-			e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
-			if (!e)
-				goto out_free;
+			/*
+			 * The fastmap update code might not find a free PEB for
+			 * writing the fastmap anchor to and then reuses the
+			 * current fastmap anchor PEB. When this PEB gets erased
+			 * and a power cut happens before it is written again we
+			 * must make sure that the fastmap attach code doesn't
+			 * find any outdated fastmap anchors, hence we erase the
+			 * outdated fastmap anchor PEBs synchronously here.
+			 */
+			if (aeb->vol_id == UBI_FM_SB_VOLUME_ID)
+				sync = true;
 
-			e->pnum = aeb->pnum;
-			e->ec = aeb->ec;
-			ubi_assert(!ubi->lookuptbl[e->pnum]);
-			ubi->lookuptbl[e->pnum] = e;
-			if (schedule_erase(ubi, e, aeb->vol_id, aeb->lnum, 0, false)) {
-				wl_entry_destroy(ubi, e);
+			err = erase_aeb(ubi, aeb, sync);
+			if (err)
 				goto out_free;
-			}
 		}
 
 		found_pebs++;
