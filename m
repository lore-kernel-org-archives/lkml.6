Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719458-2-75477530165576606
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
    t=1518719458; b=U7uav2hHaYMCtq/IOmFPQIcCdi6Mwj5FoWhmbpUZ9rKLtwg
    FPzQX+mra+dFVECtMpeMJKERMWob75sgZlrbUGALslQtxyAx+MoksURswGE1sSNU
    glYvyE50fQwReAEGKZpK5G1trqen/75JJUD7QLphIfkcapP2FRQyZB1dwYQf2RhY
    H6Ri8SWb4GobuK+cKIYEVjUl2HDfuuFX9Jk525tsf2ZbEPN0kyZ6A6KjO0AJbNPv
    tzzD5G/Toux1vE55FT9p10biZPYt6ocHxkmz3GJcCtO/7Ctg2wBPbbeClNML2U0l
    3bQupKvc23RbuB2dCPbl5dvUXMNtTPJWWvSXqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719458; bh=S8zTDCY+MwesjenmKex3UdJbg9
    k+9LLuUvMMI2PVxZE=; b=DIg7X8kZBAajr+NO+4VBOIhWhcQQ6Qh3/SRmUWu5Vd
    y1bjdNDpbN7jLsV9GAfgrkx/HJ4+aTxHPmFHHpw7Nb3NxqhOfZpPeHJKYGDiptnO
    NdRjAO9ZgcyKoFPo6syyPkz+XTR+C9XsR5HdtaKDYf6YsKhILfFfj4v1m7/7BEWX
    m7orGXWNs31A9vrCl9TXnI8uanxHR55YIJf3tzkE/c6op7K14BTBgPtI011gDpE0
    sh2wpVTQyEkXb+NKW3nJ+eYcU6bka9rIv+ZIv5UXSRlDAYrq2Dh5cetdjyY4pEN3
    QaJVWt3NEE8gVKovt2qHSo6jMLD+skGLVUlk/aMBh8rA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163078AbeBOPZH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:25:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162134AbeBOPZE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:25:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.4 104/108] nvme: Fix managing degraded controllers
Date: Thu, 15 Feb 2018 16:17:41 +0100
Message-Id: <20180215151236.792034374@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 5bae7f73d378a986 upstream

Upstream is a near rewrite of the async nvme probe that ultimately didn't
even cleanly merge in 4.5. This patch is a much smaller change targeted
to the regression introduced in 4.4.

If a controller is in a degraded mode that needs admin assistence to
recover, we need to leave the controller running. We just want to disable
namespace access without shuting the controller down.

Fixes: 3cf519b5a8d4("nvme: merge nvme_dev_start, nvme_dev_resume and nvme_async_probe")

Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/pci.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2976,10 +2976,16 @@ static void nvme_dev_shutdown(struct nvm
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-static void nvme_dev_remove(struct nvme_dev *dev)
+static void nvme_remove_namespaces(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
 
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
+		nvme_ns_remove(ns);
+}
+
+static void nvme_dev_remove(struct nvme_dev *dev)
+{
 	if (nvme_io_incapable(dev)) {
 		/*
 		 * If the device is not capable of IO (surprise hot-removal,
@@ -2989,8 +2995,7 @@ static void nvme_dev_remove(struct nvme_
 		 */
 		nvme_dev_shutdown(dev);
 	}
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
-		nvme_ns_remove(ns);
+	nvme_remove_namespaces(dev);
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -3174,7 +3179,7 @@ static void nvme_probe_work(struct work_
 	 */
 	if (dev->online_queues < 2) {
 		dev_warn(dev->dev, "IO queues not created\n");
-		nvme_dev_remove(dev);
+		nvme_remove_namespaces(dev);
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);
