Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591049-2-9021858142165337283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591048; b=jXpbe2rph1LQEiKe7CjYeATonICiSAfQPis6lMqoviDyXAX
    3vu0qB75uFm1/ngTOPSvrm3Jhp30AhMG+qVMLXpSaWiyoQanBFr0BRvQ0h2T3bkp
    lTt/B7yGO3FwDjcPNEe0M28BeC5s9ofraVkzlQQ7vhrsFxNMaiIL1B4h1J5q3bFx
    klV6M65NysAO2Pj6+PdPp9DUqaup9n4sne0sbfkN8vDmPPkZxC81wfhi1SOuXBBL
    eUm+k/lQtDdbm8uZd1sSVPVtEe7QpucBJ5j/uSTxzAAv1tYo4WTLcdGGMZ4CjwnH
    7nzwX6MLv6yDPdVuaimbUCMj2QSotTte5kiEYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591048; bh=zl4cfRT67YE12QMGTJNW7lteIO
    e8cO7NJ6RkYQ7pnv0=; b=KRrLlw3QLnkAt7l6I+z6L1Wg1LKB2S9Nc/uXaBV1hU
    /QB/mj8ikBV3ChSsK9rEjTKHuVfyHfkCqaKN8mmBFIiGcrWg5KHDD4rvzqt4JbJi
    CwLJXBDXQdGLaUKPUqHbv1BJOI6wTcuAESosQhTrLW7SdHwuZJU1hhDy72uSOZH+
    mJD1nazvBUcIV8oOHlA00nW5PwEkvyDSi1N8oS9JcKuZPiynTo2h6hsR99yaTkBj
    umNHeD9k+Trh2XgFZfT132Z9Df4ViIKAxwleiB82JWeWNSgPtj0kYCBct3dX8UMx
    AhwN88+6Zylh99krqNnsaC+EsVBpD9ygOEF3/2ZnkBaA==
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
        id S1752702AbeBBREF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:04:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbeBBRDz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:03:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, shaoyun liu <shaoyun.liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 30/86] drm/amdkfd: Fix SDMA ring buffer size calculation
Date: Fri,  2 Feb 2018 17:57:50 +0100
Message-Id: <20180202140825.373070844@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: shaoyunl <Shaoyun.Liu@amd.com>


[ Upstream commit d12fb13f23199faa7e536acec1db49068e5a067d ]

ffs function return the position of the first bit set on 1 based.
(bit zero returns 1).

Signed-off-by: shaoyun liu <shaoyun.liu@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -215,8 +215,8 @@ static int update_mqd_sdma(struct mqd_ma
 	BUG_ON(!mm || !mqd || !q);
 
 	m = get_sdma_mqd(mqd);
-	m->sdma_rlc_rb_cntl = ffs(q->queue_size / sizeof(unsigned int)) <<
-			SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
+	m->sdma_rlc_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
+			<< SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
 			q->vmid << SDMA0_RLC0_RB_CNTL__RB_VMID__SHIFT |
 			1 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
 			6 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT;
