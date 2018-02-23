Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415848-2-383699635600196882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415847; b=GEfArWYgDBt9rg28+KahWKhbiKaSQxm93i2H2dAT8EzdBgb
    nTjAjHcEooFhY/K6jGC3mhPvSnW8zTshYjzNkkDasZJ54PZe6z9EUhCXCg0fO8hz
    sbkckgv+OZ3M7ppPVdlggcJW6zGFh7b2yufLmzuvnHlCL+yiLPzhVtSFB6xTFySU
    iH7xmg/7S+kN0t5KDCPrGwTIt4Dh+NJtsm7Ya9PC+RMKIHJ4b6I2H3C5qaqLujD5
    eY2EQ7VX6JeLrcHtIl/LE8syb5BBSsA75uewNr7WfpulQM4beVFuAd4paVOhSjhQ
    0+4m3fq8bnGoIH8g2M4nqncuYIPNuhXIkyzYOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415847; bh=aMW1Yu4FWiLDecw/jk6lScSPCO
    8dERFEDn8GVida3M4=; b=fTSfiPeOSfe2K4/y7kYSuilFyq8FVB3JfonSnV8dMf
    4GufPkFhnn8TEblFaUe/0pmHXZBLP3JoD+VT9Guxh3UShxUgyOfrsIDFIw9M5iV2
    n0tq7I8wx37IK6HLXLCbo2YnydaQMzY9yNFIwW0rbJhM/oAPojTphyGSmW8dHjZe
    c0xTOAfqpyQdIHFXJn6hok5Bjo4mJF059jsQSQEOm4pxVtcQVBzvEK8yQlAF3a2E
    RcDBWjoB+5WE76Rb7HY9I/6N4h7enwATIt85/QNp8G+KDFiZ766MrxBpHwbi23TO
    M67dt30jJR1J20JTgF1keVss3Lq0EaAUEv85S3efsZwA==
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
        id S1754791AbeBWT5M (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:57:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933591AbeBWSoc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 055/145] i40iw: Correct ARP index mask
Date: Fri, 23 Feb 2018 19:26:01 +0100
Message-Id: <20180223170731.995033360@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mustafa Ismail <mustafa.ismail@intel.com>


[ Upstream commit a283cdc4d3670700182c820b59078387f9a01a30 ]

The ARP table entry indexes are aliased to 12bits
instead of the intended 16bits when uploaded to
the QP Context. This will present an issue when the
number of connections exceeds 4096 as ARP entries are
reused. Fix this by adjusting the mask to account for
the full 16bits.

Fixes: 4e9042e647ff ("i40iw: add hw and utils files")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_d.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -1102,7 +1102,7 @@
 #define I40IWQPC_VLANTAG_MASK (0xffffULL << I40IWQPC_VLANTAG_SHIFT)
 
 #define I40IWQPC_ARPIDX_SHIFT 48
-#define I40IWQPC_ARPIDX_MASK (0xfffULL << I40IWQPC_ARPIDX_SHIFT)
+#define I40IWQPC_ARPIDX_MASK (0xffffULL << I40IWQPC_ARPIDX_SHIFT)
 
 #define I40IWQPC_FLOWLABEL_SHIFT 0
 #define I40IWQPC_FLOWLABEL_MASK (0xfffffUL << I40IWQPC_FLOWLABEL_SHIFT)
