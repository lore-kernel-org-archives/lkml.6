Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708844-2-5036073517218575355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708843; b=lhSpaSKpwfuOCvInuk1IRuWzbifY8jkne79LviAKBi0GGT4
    nW14xeY4I31Td0ZslWJSh26oWNUvznVFFIbMiFH3i1w3jr42ke/bNouuRuieWa7L
    rNGxw4uWm3u1ktPhAJtPHxB1PU2njS8qU8DXiJSAVKrADssTUSS9ZyniJBgzwlsl
    vQ2I5tOklMI+rnkHPh4rd23a1JbAVGgItHW+pTdCkhKVCCDo2JCJcVsFYlgn/jmF
    bOWLY09I0tlCiOocajArwh85yJlErINkIdrgAXYS4psFsF8hXApjQoUm0Yc1/XJ/
    xw4lFDo19lw/J6E7LkyA4kEeoM4vqht/LCzaIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708843; bh=H3FKGATp/xql+/aeBLLu9YTuQQ
    5u9w2ouIyb5T0GSDw=; b=Mj8hx5pVIEbyHA3LUxveMvRGWCUtV7MRYAMWsmwetL
    BiNIUa3s8YVBzslxmW4+o4x92wEzg7eL9bAOtjFtbI4f2cNyQg4/yIgSIWD7UiTI
    ITuCkyllXO6JtRwdogixDK/kIpPf8YL8lCbIumdn66lpOYlS9o5DgnUb705AyNRm
    uU5cbUK/oKAq6+IehRCUIEOtaenGBn1KiHZFvegBF8PhNGivK+3hKwUQqwJZabfh
    0PJ30ncU2hC/UPGPJGRyiImoedThMd+YGaFBB9Q7WAB1SuzcZLlhCOh++VoO754G
    JljfpMxspl9+l2x3Oj1CXxmMNJwWrl1qPXpjFqYEuaMA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164993AbeBOPeA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:34:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165004AbeBOPd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:33:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 100/195] ubi: fastmap: Erase outdated anchor PEBs during attach
Date: Thu, 15 Feb 2018 16:16:31 +0100
Message-Id: <20180215151710.698553675@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
