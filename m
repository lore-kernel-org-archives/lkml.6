Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989503-2-7625777375929529610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989503; b=g+oar+qIklkuZRkSCAR4SlZAYEKUYBERlNx+WJ6OTXZQJST
    3KMvQmZcpaBwJgc+ZE2xeHtALt3DdKYxEhPSHkF/CxOJ0S6/E/aODecGIzjEkRA1
    +m/3AxSzcf1ShpZd3whBnJXvNrhJMoaaQaniXIIhYR8ABcLcEj/vTfgWxthyv36r
    QkTlJJrm4p3SpWVycVZiRaPismqSj31l7R4SOf6SU+P36hkSVbJ+sLEfBsuJd0B/
    6yvlLeFjfdLLPOy8lCdZDy1g31QFECksytX0kDLQrxadrX9ftyVgVu6pfSRKk5Gc
    CiqRzwdnm0ahxKMpd3vXx6lWfpZAbnkK6kz3+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989503; bh=Nf5pVkj81vJSwn99NNZaCfIknY
    culC9WeDhj1+Wftf0=; b=nN+05ly55fa1Ic8q1LCU/ixO3jBlsOTi0s+/6XvyeR
    N013tkniViIoIqX6FArGlQf2jen3ZMA4uHUK07lZK9/k8D6Vn26BcV9/e5bCH6wq
    Gp4p3LC/G1eujwNQzqRohO23ycrMzSRRIVxzy6NLZ+tS0SQkXvsOgWJsRFGu3v44
    qZS2pJfC4RTIiLITM4lyONAnEDb58q7xfpRg2B9JHkt57fTremo5bdEleopAEGGE
    cFXaiVi/ytvf5gedXSznY6pZgCkO9CTIgjz/3td75MfabqsawO0a+S8oGxXBLVcm
    xnJq2SRB93cZdW7dFeKadHqNS5j3R8tJDbAi3M/7rIww==
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
        id S1423337AbeCBIxg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:53:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423321AbeCBIxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:53:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 21/24] xen/gntdev: Fix off-by-one error when unmapping with holes
Date: Fri,  2 Mar 2018 09:51:18 +0100
Message-Id: <20180302084240.180620324@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit 951a010233625b77cde3430b4b8785a9a22968d1 ]

If the requested range has a hole, the calculation of the number of
pages to unmap is off by one. Fix it.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/gntdev.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -348,10 +348,8 @@ static int unmap_grant_pages(struct gran
 		}
 		range = 0;
 		while (range < pages) {
-			if (map->unmap_ops[offset+range].handle == -1) {
-				range--;
+			if (map->unmap_ops[offset+range].handle == -1)
 				break;
-			}
 			range++;
 		}
 		err = __unmap_grant_pages(map, offset, range);
