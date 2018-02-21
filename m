Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218235-2-13293787296632105621
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
    t=1519218234; b=YtTNgP97uclaeqti+KAG+xxj4Laf5BssHsyJc2F0ID3dfFb
    ybmX5GjXxAYXajOGADF9Zq8QWM5VKpbGh6WSbWNy3H7Dp2TLurort24GPHc1i+4y
    q/kmOalHHuJXCkujKCVLAndGjUdSS4uDCJvvLlhWCfiTMnXKA8IC+r1mF2/lEjDQ
    sVBO9LmB0FuV8B9P1vPUtx+cZR2huI4P/nzVirG7cfuGJkwSArBhoxtqERncdBWg
    PmF1dTGkQywPLSLPWijgrMcUUMPcysnpLHdZZ2IZ3Hpf+f8AVLTGQeOfyWUgTpuZ
    jE5J0wbOEbTKhjca+HxdgAs2PiLyE02NYUJ7ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218234; bh=8mwOYAofiad7/eUfluETeo7B/M
    tX+q9YE4HpOXwBZbk=; b=ccd+ruyrdffUXHkd8Zvf4wq04ej/ESOWYf3GV71tJ6
    7R68jaunnbVA0SdA37s+GBnOJdyFj8HcagLyytMEBbVagncqTug7ZTd6f3DS4FtP
    GExqebhI1SzkPmIttQzh2KO5I88uc+KLs3oQA89Yo8YJyjSlparrse2gp8LlJxlg
    yQtjwx2O3Pfw0gdArI8aXT3mjg3v1vAIEz+U734z68NpkML7EIjwSXtqWJWhkjK4
    iDU40ysPYDvOqTSe7Y5VHhJDd7IaPPWshFVNF4Cx+2iYCBriufmUZ4nfFwdaXXX8
    g6ZDCyJS1loo9RNYTBapLwZgjLi0sxD7Ps/33HjFgC6w==
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
        id S933311AbeBUNDl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:03:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933197AbeBUNDj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:03:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.14 129/167] xprtrdma: Fix BUG after a device removal
Date: Wed, 21 Feb 2018 13:49:00 +0100
Message-Id: <20180221124531.669976701@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

commit e89e8d8fcdc6751e86ccad794b052fe67e6ad619 upstream.

Michal Kalderon reports a BUG that occurs just after device removal:

[  169.112490] rpcrdma: removing device qedr0 for 192.168.110.146:20049
[  169.143909] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
[  169.181837] IP: rpcrdma_dma_unmap_regbuf+0xa/0x60 [rpcrdma]

The RPC/RDMA client transport attempts to allocate some resources
on demand. Registered buffers are one such resource. These are
allocated (or re-allocated) by xprt_rdma_allocate to hold RPC Call
and Reply messages. A hardware resource is associated with each of
these buffers, as they can be used for a Send or Receive Work
Request.

If a device is removed from under an NFS/RDMA mount, the transport
layer is responsible for releasing all hardware resources before
the device can be finally unplugged. A BUG results when the NFS
mount hasn't yet seen much activity: the transport tries to release
resources that haven't yet been allocated.

rpcrdma_free_regbuf() already checks for this case, so just move
that check to cover the DEVICE_REMOVAL case as well.

Reported-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Fixes: bebd031866ca ("xprtrdma: Support unplugging an HCA ...")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/verbs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1331,6 +1331,9 @@ __rpcrdma_dma_map_regbuf(struct rpcrdma_
 static void
 rpcrdma_dma_unmap_regbuf(struct rpcrdma_regbuf *rb)
 {
+	if (!rb)
+		return;
+
 	if (!rpcrdma_regbuf_is_mapped(rb))
 		return;
 
@@ -1346,9 +1349,6 @@ rpcrdma_dma_unmap_regbuf(struct rpcrdma_
 void
 rpcrdma_free_regbuf(struct rpcrdma_regbuf *rb)
 {
-	if (!rb)
-		return;
-
 	rpcrdma_dma_unmap_regbuf(rb);
 	kfree(rb);
 }
