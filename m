Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218858-2-15713371502176876297
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
    t=1519218857; b=HHEI930Ojis/HhGoe5dGNoW7Tx+1OUIH0AvJbDIcniqB4iV
    mE3HGKroGWbenGyw8mOATT/zHehQ02fpO281FeqbCVXJeoDiO5sAhyuJyY2z9Eup
    RWHVUwvG32yo71z0APlCfJqa+gGMA302OmscH9R7+uxNuZtfc7qM4FgsHaoWXmQ0
    iDew19DYSuiCyjbfk/7bBqZFEyzhmLTQyueGsAdYh3SMYfsboizMoSPx436U864O
    Fk2LMjlLdbnJYoXvenhKZAYn0Re9BYbI7984yZH7qJdV60G/XCwsDJG4DUuZ0wdy
    yz5GkTYOFJElORjSMQ/dwgZ+WbbK81jASmvTUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218857; bh=O9DPCyTsY3vqHtNmCu2CMvnWek
    K7mTkRpyWSOYgeiWg=; b=kpiwPnaJKTiFVwY+9OWo9TTjJApheGWPVQNcdMjU4g
    Cki9V4fDa+HdZm8a/kcRn5pIcjt2NagCKthdQxcFdwWwxsoQiH5gUADVbI0K9d5c
    csgP4ZNUwux4ZwkdZLO1IWIB7vbb6AmgYIbmqnst8y255dUU4xS33Ra6+lHf3AdV
    shR4SBzvpzvkfCDIY7cRuwUviuWAfC+w59aBblpjNNAg5um0iiMuMM9WAfQ+zYp4
    xr0JV6gBK4ZmhF7MdqvDoPYnKAJuy/7c9KcRh+kETuvYogDc2EBPuXjd3OcYpqvn
    HH5jPqmbt2cVDFjZGbW3n7Ixog09J3MnmM/TPpfJnluQ==
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
        id S965743AbeBUNNc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:13:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965740AbeBUNNb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:31 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.15 129/163] xprtrdma: Fix calculation of ri_max_send_sges
Date: Wed, 21 Feb 2018 13:49:18 +0100
Message-Id: <20180221124537.261537429@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

commit 1179e2c27efe21167ec9d882b14becefba2ee990 upstream.

Commit 16f906d66cd7 ("xprtrdma: Reduce required number of send
SGEs") introduced the rpcrdma_ia::ri_max_send_sges field. This fixes
a problem where xprtrdma would not work if the device's max_sge
capability was small (low single digits).

At least RPCRDMA_MIN_SEND_SGES are needed for the inline parts of
each RPC. ri_max_send_sges is set to this value:

  ia->ri_max_send_sges = max_sge - RPCRDMA_MIN_SEND_SGES;

Then when marshaling each RPC, rpcrdma_args_inline uses that value
to determine whether the device has enough Send SGEs to convey an
NFS WRITE payload inline, or whether instead a Read chunk is
required.

More recently, commit ae72950abf99 ("xprtrdma: Add data structure to
manage RDMA Send arguments") used the ri_max_send_sges value to
calculate the size of an array, but that commit erroneously assumed
ri_max_send_sges contains a value similar to the device's max_sge,
and not one that was reduced by the minimum SGE count.

This assumption results in the calculated size of the sendctx's
Send SGE array to be too small. When the array is used to marshal
an RPC, the code can write Send SGEs into the following sendctx
element in that array, corrupting it. When the device's max_sge is
large, this issue is entirely harmless; but it results in an oops
in the provider's post_send method, if dev.attrs.max_sge is small.

So let's straighten this out: ri_max_send_sges will now contain a
value with the same meaning as dev.attrs.max_sge, which makes
the code easier to understand, and enables rpcrdma_sendctx_create
to calculate the size of the SGE array correctly.

Reported-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Fixes: 16f906d66cd7 ("xprtrdma: Reduce required number of send SGEs")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/rpc_rdma.c |    2 +-
 net/sunrpc/xprtrdma/verbs.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -143,7 +143,7 @@ static bool rpcrdma_args_inline(struct r
 	if (xdr->page_len) {
 		remaining = xdr->page_len;
 		offset = offset_in_page(xdr->page_base);
-		count = 0;
+		count = RPCRDMA_MIN_SEND_SGES;
 		while (remaining) {
 			remaining -= min_t(unsigned int,
 					   PAGE_SIZE - offset, remaining);
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -509,7 +509,7 @@ rpcrdma_ep_create(struct rpcrdma_ep *ep,
 		pr_warn("rpcrdma: HCA provides only %d send SGEs\n", max_sge);
 		return -ENOMEM;
 	}
-	ia->ri_max_send_sges = max_sge - RPCRDMA_MIN_SEND_SGES;
+	ia->ri_max_send_sges = max_sge;
 
 	if (ia->ri_device->attrs.max_qp_wr <= RPCRDMA_BACKWARD_WRS) {
 		dprintk("RPC:       %s: insufficient wqe's available\n",
