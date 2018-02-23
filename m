Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413883-2-4652622786317338792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413882; b=VmLAywxsdYWHkkrQsTmf7RjCWUn6aK7IiKw1r6xgXxWcI8Y
    jhZMfkm6TxS3kw0Ll6YKFVQRTAeq+QYIMdgqeG2QnRmxGK7G9yvhCqnLO78Fhdyl
    3EAAr3OeYsHa8wvFw71LTQ+G8udCiVBaHNhhrrdFpsH7d2bS8JDc0vAOE4FWzhCf
    1eSTtDIgdwVMN7Y7vZMnvVmvLmvfK+7oGYUphRpRQR8MUj3YvtvxhQIZQNDjXewW
    pT8bt9L4SCdDPUA4+UJKmsB4+2Ttym94XQsru6q/8BWwyyB/+zxepefK1SjR6/Cd
    92YYwwPFEgWVKzJNMQQgeVGiUQY9olr+Ord+y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413882; bh=7vBXQ6/nDhPP09/gnQINZKnF7m
    zDCDeB7P9x4nIzt2U=; b=BaXgZNv9ds8fTZeR5xUKqhl3OhA880B5XkgaUVz73g
    5eH9Cr/4neejB437cTMKLSV73KA4Jop8F+BJ1/Us+4VgtZ06+ShyIfUbIo/uNGnS
    u5n7E0rHcwXoOEc0MsXL8DpCdqnThZT4TNsGPM4Y4w3ws7z9yMjxt8z2hpOJILNM
    a5iG4hKRyKrWEUqrMGWJ1g6zYqKsM7VfgUhFcpzqR9nldRMtxl3KkIjTnH/k31lz
    0ltXVt1btaVvwzsllJFw7zwihMrYik4AsvTT7AspGRn5/mR0LPEj5BICfgKF07QA
    W3J9YUzcCoQf7xlJCckUCM0vmYW+B1zZm4KpxQ6QGQIA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935313AbeBWSxH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935312AbeBWSxF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Don Hiatt <don.hiatt@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 086/159] IB/hfi1: Initialize bth1 in 16B rc ack builder
Date: Fri, 23 Feb 2018 19:26:34 +0100
Message-Id: <20180223170753.949193240@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Dennis Dalessandro <dennis.dalessandro@intel.com>


[ Upstream commit 8935780b9f7bbad0f2eb5dd43f61ba7b509a1575 ]

It is possible the bth1 variable could be used uninitialized so going
ahead and giving it a default value.

Otherwise we leak stack memory to the network.

Fixes: 5b6cabb0db77 ("IB/hfi1: Add 16B RC/UC support")
Reviewed-by: Don Hiatt <don.hiatt@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/rc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -815,7 +815,7 @@ static inline void hfi1_make_rc_ack_16B(
 	struct hfi1_pportdata *ppd = ppd_from_ibp(ibp);
 	struct hfi1_16b_header *hdr = &opa_hdr->opah;
 	struct ib_other_headers *ohdr;
-	u32 bth0, bth1;
+	u32 bth0, bth1 = 0;
 	u16 len, pkey;
 	u8 becn = !!is_fecn;
 	u8 l4 = OPA_16B_L4_IB_LOCAL;
