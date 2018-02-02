Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2844860-1517590945-2-5721876677924674471
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
    t=1517590945; b=nTfBHe9R6SBF5pcqDcTJlkJ9P8OGEM28BQXaGOYTe4+FB+s
    X6FGwfgoed9Sl/Q7CVKKJoYAuqvjrdlTFtgviKBFXlzbhILLuiyHVoBt+Ws0rv5b
    rflFAuMOWDShIM4Czv6Xd4hXH1tv3tHICgXGl4MQEgc/G31Qtojp8gi65fN0AOXj
    9wvLJOj2smV8YxFJmv3V93JeWUeXVEeX+Yq2gUcvXZXnAER+QqYiT/KEltjt1vTz
    0hQPmrhtusQmFz8qlNOnOuKLXSPctl8KII1y+dibR32Rc+/3V/JrSx3q8ULv4dcM
    TwqlvcCCn74Jl12nbnYtEgtfDaRVIMpLiVYGD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590945; bh=n/xZ0jAEsE6m/u7k4ZCQcf9Jp/
    LAXmITOngHyZFoQPc=; b=HbrYUfMYblbqFX6jtzNjLUvfYmI0gwu5oLZf3Y01KX
    7m5C/YpPXY3US+D7lgmNSv3Qaddu4vsLWoBdKMuo60oCwlHJCzYOPqpqMJE3AlFZ
    Mga3a51uIl2QOFTXATdT+sq2ufMH50If8Cbk1DNeDpyADxyuOc1+0NJZegqhccJo
    vm1ruouijqqAQczFMqjEkFZFRZNObWCKgl7grWY1gKQldQ1JxBPRA9Qwuq4NJd4u
    A/Lbdf4PrJmpeXI6IY2dFjei12KrEr5a6ZTUBlDhr+WgjPEW5J87lEp1D6rBQJvV
    XGR3407EQBA5wv5q/aLCSKqRhpEp9ZxHzQNfHWW07Oow==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeBBRCV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:02:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbeBBRCQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:02:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, shaoyun liu <shaoyun.liu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 31/67] drm/amdkfd: Fix SDMA ring buffer size calculation
Date: Fri,  2 Feb 2018 17:58:00 +0100
Message-Id: <20180202140819.024032390@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
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
