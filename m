Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803776-2-11158229115411612189
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
    t=1521803776; b=qrXPMcSqebQVEVnoaRNyQCzVVPx3qgHEuo2xoRgNxuSD5Wa
    boe2faYyiEE239pvmCwPX7/RWE5hoaCDsi4QnmmQtsv3NnSgvgT7vaHgI8oqsCGa
    SKiLzn8ly2e6Rwr6irf6IVrpCdxBN+i3syo1BFbak20r1EDzU5AkUfHioETKZB/H
    u1wirxXwIkOawfoUjfP/HMfXKfMaxq9RYUP+yweW75TYE6bxsKo4s5sX9UBr7nNH
    b1Dht+a5EPGxWpUslG7iRfMIzep6aza66FnTIgvFeabGA2ck1TjEsVb2gg2gev7v
    tt1dpuDdlT24c3a1QHgTmJwtWFGgWfAMf/mAHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803776; bh=yaGZrTepnydE5JcqnflQdmfMWC
    +J22YpmTNlljoo2wI=; b=a7NnMxtSAkLNcCdUN9kVsI4Wk/+Ez7YwTRtTxBmpVu
    ZDHwepnROc68FJrQobi9GPXugksRUNs55fhFxMBSGBCno30IUHbCu/9oyO0jaqx6
    7y1kb2GnRLhyCe84pUpkTL4dPxUBPE4eAehTkm1r6FFHrgWktKnS+ROplS72cUVi
    SgTfZvMa2eGTxyqGHm+oeGx8osaS2QPvk6/w/o1AJ4dRSxGeimZOPtMvG2q67mfF
    gVJ+QxLzHbq0+WCIlLc0nC1yrDJn7WvMnQuvYIOfjqnARbmHk69rGzssr7xqKXWt
    /5cN4eG6bwikXn3DMJ5tqicJMCnimSsvJ21UDGRrz+/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S932483AbeCWKJs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbeCWKJr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Yuval Mintz <Yuval.Mintz@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 109/177] qed: Unlock on error in qed_vf_pf_acquire()
Date: Fri, 23 Mar 2018 10:53:57 +0100
Message-Id: <20180323094210.087859774@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 66117a9d9a8ca948680d6554769ef9e88f936954 ]

My static checker complains that we're holding a mutex on this error
path.  Let's goto exit instead of returning directly.

Fixes: b0bccb69eba3 ("qed: Change locking scheme for VF channel")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -204,7 +204,7 @@ static int qed_vf_pf_acquire(struct qed_
 		/* send acquire request */
 		rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
 		if (rc)
-			return rc;
+			goto exit;
 
 		/* copy acquire response from buffer to p_hwfn */
 		memcpy(&p_iov->acquire_resp, resp, sizeof(p_iov->acquire_resp));
