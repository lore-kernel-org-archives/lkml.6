Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519981535-2-3103839257103021221
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
    t=1519981534; b=LFOzU6kbRaWyxkO31NneqXy5C8XeXvn3LgSFcwh/c/VrEpd
    F6ul7I1ysPnTw2AEBDwSdkBi0nhgzPrQputCKmq3jOUsPngqc2iIWlEwNgB4Dd41
    0KPwdSIhbCXKg3MRajGoCrsowpGjFSa6bPHejVQybtFXZ6/5akBp4RFbMmjuVP1u
    RY6/o8uUnOB//FhXDtoi0ephf7R85ECknxu735EVxGUfc6E9fk4HmYZLSRF6frj+
    4E5JMtFHcfhkgiTkJqHFPaCWk4LRWeognr9wAL9RPr8KUs/0rH92ezUI5Jnm16QG
    tbPTGqqKePRZz+pnxgS0u1xhTOMAO0++FS8l6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981534; bh=xDriADyrzI0RZND/PifLw3jd1P
    e6xWGXTYyZ0PhuBx0=; b=DBvonrnh4BrnWtkg7Z8HZ+SHNF3aeNq2ixHDzYKolp
    C3g3rilhf6/xx10D5gz89lceOvaUxSctuNGu/TRlLGJjj66RYMZ+JUQkikYQdXlb
    4fJIKG6O+SuP/vnxYaJ9uyagfe7y/EpJE/Rl1VblzzZBQ1UIlz/x6nFxNhc0lJbF
    N6O3wImixghZ8poRqfMqOVT1KmvV3hdW9vfQ7IGTfkAmZ5Wxm4K+L4gHEI0u0p+6
    N90h8NvaUdw8eC5/dzhUsr4kJsvrdIWEZloaoV7bJ/7rgUk4UVWSpl3snSzBvfMV
    TNCipNNP1NUmzy3OJbRMEfN5KtjepFm+A+g4yKKFFGVQ==
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
        id S1425232AbeCBJFX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:05:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425230AbeCBJFT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:05:19 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 100/115] xen/gntdev: Fix off-by-one error when unmapping with holes
Date: Fri,  2 Mar 2018 09:51:43 +0100
Message-Id: <20180302084507.888043822@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit 951a010233625b77cde3430b4b8785a9a22968d1 ]

If the requested range has a hole, the calculation of the number of
pages to unmap is off by one. Fix it.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/gntdev.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -380,10 +380,8 @@ static int unmap_grant_pages(struct gran
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
