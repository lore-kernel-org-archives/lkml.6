Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591501-2-5178292561591601816
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
    t=1517591500; b=jNV2oO50mYSXQpuGvsAz6BfVitLq9PStYvxF/GatX9OdZ89
    cjBzl/ZgEizZkzCweo9hmFKhNkkP2eZcmZha2fDNwrUtYEgeAJ1dYB1mBFQK9/fL
    aa/eUBI0oTeCc62MmNJtR/vP7gm6Fv0QM07O6qbrCFR/egUt/RubBIJm3lSHQ9Je
    dmQ7TQjSm8YklFoTRSUcBAPzkce1pirUDDGu13JFCBQA1i2NW1k2OK+pCATevw1f
    0hn8pOcMMrMPZHDUe4VQApl1TUkfkdb9VxAclj8Z4uiew0YReOcbyD06ZjikKv8R
    E8PhupWZ3fTO4+0qbhGl+j7OSjLK8jQtoWaO9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591500; bh=dQS7uZqbbMwupFoLN9fkGwUAlW
    XxdvVz4jWwxa1aN6c=; b=kMDT0Oxyg2FxMz1XNCLjHE+FZASa1cQEaf1hI0lQQB
    JbXOFfo8ebqVCInRwbLCYDs4ncBQSuTSupTwT4naPN3b4rnGZAvVJKjpZaM7mqAv
    7Tr5vNBDcD2R3ghbtoT/kOyUECSCzbiFWGm96M9vYkf+z0rKvC1lNrat2iuam8Xo
    YjC5uvJjGmvfjeRJY2YkEPgmmN2kWbr+Sa64JEnAW2aicZJZ3DxdJ5B/g9bgp7gi
    08DOpqLmRbIHaa0m/JwQRX8nIIkfO/cqKWO5MlDBfuYD0jEEKe7Kdjl5rCzM/T90
    VzMTE1J/GXuoxQ+qkZuiryhVrkHntXg4Lzg05BnwhUag==
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
        id S1753147AbeBBRLg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:11:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeBBRLc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:11:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 097/156] nvme-pci: fix NULL pointer dereference in nvme_free_host_mem()
Date: Fri,  2 Feb 2018 17:57:58 +0100
Message-Id: <20180202140844.607338782@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
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

From: Minwoo Im <minwoo.im.dev@gmail.com>


[ Upstream commit 7e5dd57ef3081ff6c03908d786ed5087f6fbb7ae ]

Following condition which will cause NULL pointer dereference will
occur in nvme_free_host_mem() when it tries to remove pci device via
nvme_remove() especially after a failure of host memory allocation for HMB.

    "(host_mem_descs == NULL) && (nr_host_mem_descs != 0)"

It's because __nr_host_mem_descs__ is not cleared to 0 unlike
__host_mem_descs__ is so.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1617,6 +1617,7 @@ static void nvme_free_host_mem(struct nv
 			dev->nr_host_mem_descs * sizeof(*dev->host_mem_descs),
 			dev->host_mem_descs, dev->host_mem_descs_dma);
 	dev->host_mem_descs = NULL;
+	dev->nr_host_mem_descs = 0;
 }
 
 static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
