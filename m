Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806208-2-15213050434953590070
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806207; b=bL4ohO5jy2eC3mtsW23yMlCXYysZzYxxQec8dXYMT7QSw3a
    15kKNEp6yk2+JQP/XN5l+hdJheWZCMnXOYNr9rplqtk7nwSUwrbLWfqLYGrtgZJ8
    khGAa8zDSIL6ZHIC4obtiwqRmN0l9bevsOlxwHwwrNEfgC/QfNUzbdtFMtV7ZieU
    9Yw00bsqRiY3RC5w0aMiw0fxYb15R0jGkmOMkWg7P2pZy35zwTqKGKaU9JnLlWI8
    thuKuSISdVTOr3k2rfyRbt/bHN+ETg2sy/f7GK2SJukx0DLQDul+8X4JbN0y4ytB
    HgWGl6LTJ1HThpgt0w0wkODFYtXUs61ISHPsDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806207; bh=4bLDYZzlKMc1Qdu0+1kZyjxO83
    AsndnWf3ESqr8tB4w=; b=YzpHv937DtptdVzOtD2Ni5/MJFCd6yotnb6nhFDo0F
    rd+KI1nXkokTmu5YcpNE9q8q+azsv9IffD1I9mtnT8VyFRLfY+qXbwDQXjf/t2DI
    scTGA0aHIxp2X8uUdUrEsZY34/8kIsuJdTJ+Ub7xshIKRc3xVWxpO+0oJKaUkzr1
    f+bmZoTkNrO6ymS5DJQ1ddrE37bfq0AVqkU+l4eDdPziSacFvNxTMXLd4yEp3X7s
    CwxLHeMEg/Cpzb+mBRWKQWM9xo4vxjdYhuk6d8V0/zs0g6wEfL2ZG0sU1nAXqal9
    J5LgmMHFfdIDetTBSWOlgPdsE8eXuX1ZAubshS2uk8Hg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeCWKAv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:00:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753708AbeCWKAp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prakash Kamliya <pkamliya@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 07/77] drm/msm: fix leak in failed get_pages
Date: Fri, 23 Mar 2018 10:53:41 +0100
Message-Id: <20180323094142.696900704@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prakash Kamliya <pkamliya@codeaurora.org>


[ Upstream commit 62e3a3e342af3c313ab38603811ecdb1fcc79edb ]

get_pages doesn't keep a reference of the pages allocated
when it fails later in the code path. This can lead to
a memory leak. Keep reference of the allocated pages so
that it can be freed when msm_gem_free_object gets called
later during cleanup.

Signed-off-by: Prakash Kamliya <pkamliya@codeaurora.org>
Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_gem.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -93,14 +93,17 @@ static struct page **get_pages(struct dr
 			return p;
 		}
 
+		msm_obj->pages = p;
+
 		msm_obj->sgt = drm_prime_pages_to_sg(p, npages);
 		if (IS_ERR(msm_obj->sgt)) {
+			void *ptr = ERR_CAST(msm_obj->sgt);
+
 			dev_err(dev->dev, "failed to allocate sgt\n");
-			return ERR_CAST(msm_obj->sgt);
+			msm_obj->sgt = NULL;
+			return ptr;
 		}
 
-		msm_obj->pages = p;
-
 		/* For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
@@ -135,7 +138,10 @@ static void put_pages(struct drm_gem_obj
 		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
 			dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
 					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
-		sg_free_table(msm_obj->sgt);
+
+		if (msm_obj->sgt)
+			sg_free_table(msm_obj->sgt);
+
 		kfree(msm_obj->sgt);
 
 		if (use_pages(obj))
