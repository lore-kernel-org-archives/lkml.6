Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807383-2-14198554276613752089
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
    t=1521807382; b=A33DTljy079BwTHkUdhgJviW9qEcf1l5QctQn8eTmgWEsAq
    X3dPELkkSdeUOyXk1bru7E6F+s5TXKrciOmqPPthmn+SlYb0SKCtbSax/5QlA4iF
    bdsR5ca5+4hywnGSWM4e4lN+KbLoJpiw27XIKIWf6Ce9RuoIGuCZ6D+BpsdTvX26
    IHbeKvKuJm79z/mtG5V62RAXh2SrQcpbl8T7cZ0qkHmHKGHP92vM1w+D1wte2pws
    Ygf6tUp+fVvz+XhZ/y9OYjsvZFkkrOXAGkMAw9eYakL0lBpX3eBO022aAfrdRg2n
    XT5gKS4KSbKEZWepD7D2OqVNWPQKvErweilaLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807382; bh=cZEUx+kSxp/l2Lms5PeTpFSJTy
    631FWEvRlYSl98I/0=; b=FJsVAOGWmnWYOJLhAEkQ0O6fbbCjCF/DCfdyLPW5jZ
    RtEAvQ7Vp8PFRxLps2Gq54R9l5NLx/Twp0larDQsi4DMwD0H0hNFnnP8Qi5TIhPQ
    BBVckigx5hZ6pDro9aW2jt/2TIWF2t7yLANNgrVCUFYsAJwTRJjdp0ZwCMttrlxs
    0dskKI7ymuAJX6XRLQdLXpBqhH3ivAiq6G11XhCO7qCTOnNph4B4/1ci0uwdU0g1
    6aI97Stth2ddBRQh8owWR/EjE7w0spj7Vq7JhGrJ2s1eEfsehKzbfB1fQw6AtnQ2
    1r4r7wARZiyQrA9U687Juts+4WFGOa+aVerF8zaaVQjw==
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
        id S1751896AbeCWJ4h (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:56:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeCWJ4g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prakash Kamliya <pkamliya@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 08/84] drm/msm: fix leak in failed get_pages
Date: Fri, 23 Mar 2018 10:53:22 +0100
Message-Id: <20180323095413.168467339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
