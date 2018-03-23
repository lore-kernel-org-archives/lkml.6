Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805289-2-17144863661755195081
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
    t=1521805288; b=wLtl1J4zUsaomiCN8tBx6qZf9WZNoIocGT+tEmmR+R1YE+f
    Qjdg8LdgxsD2HTM+w0NbF7A+iXwPB6o9dxdmdPeRc7/9RtAyj5rXcPR/dinySp4h
    Ql0WWqyVDceprprKMJfbiCKIQr/vyHD8mQvJJGQpcemMf68YEa12nYzJRAVMXPi8
    LP/sMo34EOVJRLMXLuvmM7UJv5eR7vpkRQSIQgSRJ6EjQkI/vE/axZbnfABiFzSQ
    GNUBiI+RgeiUdLe6jleF8R9QmSKzzbgNmhRfnk3I5LkeYOAOEW4uQMwFiaZGHJA6
    RobCk0RzsWf8w/8GVG4XJc7eRa7bCvJJUXkYP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805288; bh=TfaUFbH+xK7OKlzWNemA0QGFrs
    /iT73oxruZigbvhws=; b=MH1B/5FEsLZ8W3n+foRzFokAV12WdHoYxSp9+jZ6qQ
    A9LKwNdUHpMpSGh8y8AgOcwj/GjGzlkZvkZ8wK41SKju5Kzu7s5vlD8GcWmDcgdX
    vcX6+qeOw7hJKb8CHP+3/TvsoXm1u35ydu2aDKwN0bFSwT9WhjUz7pEYnfK+gE86
    g/no+b1QDlK6cfbidbDCxKh1xNaOHSGkxZY4yQL01YTYK8mfWGItRHSFb/Z5kjF/
    m4DlR1Tqowro3wCpx0hrUR9ykNnA2mBf6Bi/2PDDxrnJdCdpqas2M7WrtgD+IYEP
    uFlWvdWnIHQ/VZBuXDGM8EiOAZFMC1ASKaHAsbWJpjxw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1754591AbeCWKED (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeCWKEC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 72/77] RDMA/core: Do not use invalid destination in determining port reuse
Date: Fri, 23 Mar 2018 10:54:46 +0100
Message-Id: <20180323094147.103833281@linuxfoundation.org>
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

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

commit 9dea9a2ff61c5efb4d4937ae23b14babd25a5547 upstream.

cma_port_is_unique() allows local port reuse if the quad (source
address and port, destination address and port) for this connection
is unique. However, if the destination info is zero or unspecified, it
can't make a correct decision but still allows port reuse. For example,
sometimes rdma_bind_addr() is called with unspecified destination and
reusing the port can lead to creating a connection with a duplicate quad,
after the destination is resolved. The issue manifests when MPI scale-up
tests hang after the duplicate quad is used.

Set the destination address family and add checks for zero destination
address and port to prevent source port reuse based on invalid destination.

Fixes: 19b752a19dce ("IB/cma: Allow port reuse for rdma_id")
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/cma.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3017,7 +3017,8 @@ static int cma_port_is_unique(struct rdm
 			continue;
 
 		/* different dest port -> unique */
-		if (!cma_any_port(cur_daddr) &&
+		if (!cma_any_port(daddr) &&
+		    !cma_any_port(cur_daddr) &&
 		    (dport != cur_dport))
 			continue;
 
@@ -3028,7 +3029,8 @@ static int cma_port_is_unique(struct rdm
 			continue;
 
 		/* different dst address -> unique */
-		if (!cma_any_addr(cur_daddr) &&
+		if (!cma_any_addr(daddr) &&
+		    !cma_any_addr(cur_daddr) &&
 		    cma_addr_cmp(daddr, cur_daddr))
 			continue;
 
@@ -3326,13 +3328,13 @@ int rdma_bind_addr(struct rdma_cm_id *id
 		}
 #endif
 	}
+	daddr = cma_dst_addr(id_priv);
+	daddr->sa_family = addr->sa_family;
+
 	ret = cma_get_port(id_priv);
 	if (ret)
 		goto err2;
 
-	daddr = cma_dst_addr(id_priv);
-	daddr->sa_family = addr->sa_family;
-
 	return 0;
 err2:
 	if (id_priv->cma_dev)
