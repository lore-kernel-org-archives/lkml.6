Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591680-2-9090911287205881041
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
    t=1517591679; b=hs1XyTZd+tI3GAL9ukb66FwgmYn8Ire04KIqyh1cbh2uHtP
    TADVw6CxCl039faTiplIKPtAoqpTSK5FOpZe9asitkxQWSsOYUuEic8tTEvt3cNl
    EvQKYinzkslkCrz5R1q1bJRw/WXrsasPhL/GR3/ORX//VhqSH2DF8ppvFZqzfZko
    rOKq2UO23ezfmkdp1CoR6igbeGPzn+mvxLVj5OWaJ1Yt2MzD8UzTcPOsPQV7Su2r
    ufMudde0ZI/fONL6s7xnlMmFVYUzVBqqP/gcoxso2WfK+P3UmCHyP2HPHl813CyK
    /p0ykRx/lkUOnSP8qv+XjHnf1ewQHevwSY1Xzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591679; bh=wxottuDx7W9Lj3xIsDRsfxMVfb
    35sxZ6TzNosesXljw=; b=Wu6W3oE5/GspuYi00DCDqMLsKIx5iV4KtxKO39APCj
    HUYOeXiWlFlSNMPCGPavXyk9IA/eARNRAmg7gycsRkzVNTQhfye4MpWVruvmNf3U
    WANvSPpm4xnHZLwQXQCSeJZbiJ33LxHYZSDxFbYEYB41gyBs1H2Rot4xNLwAyp5A
    5xO/KjQFbOnLNRBq1kZbUFKUtWZal8wMkve903SST09YZGdC9ea6HNRPaoRt+O/Z
    +NKkU8kkZi1iiDo6G9hWGOa4N7Q67wAGncyrPCGGhkKSp5IA8EjbfVELFVh7nfMn
    dhM/M5HeVDgNIL0Goi/RpWjfMOnDRhPSyRL0BjC84yiQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeBBROg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:14:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbeBBROY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:14:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 135/156] USB: cdc-acm: Do not log urb submission errors on disconnect
Date: Fri,  2 Feb 2018 17:58:36 +0100
Message-Id: <20180202140846.489102757@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit f0386c083c2ce85284dc0b419d7b89c8e567c09f upstream.

When disconnected sometimes the cdc-acm driver logs errors like these:

[20278.039417] cdc_acm 2-2:2.1: urb 9 failed submission with -19
[20278.042924] cdc_acm 2-2:2.1: urb 10 failed submission with -19
[20278.046449] cdc_acm 2-2:2.1: urb 11 failed submission with -19
[20278.049920] cdc_acm 2-2:2.1: urb 12 failed submission with -19
[20278.053442] cdc_acm 2-2:2.1: urb 13 failed submission with -19
[20278.056915] cdc_acm 2-2:2.1: urb 14 failed submission with -19
[20278.060418] cdc_acm 2-2:2.1: urb 15 failed submission with -19

Silence these by not logging errors when the result is -ENODEV.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -438,7 +438,7 @@ static int acm_submit_read_urb(struct ac
 
 	res = usb_submit_urb(acm->read_urbs[index], mem_flags);
 	if (res) {
-		if (res != -EPERM) {
+		if (res != -EPERM && res != -ENODEV) {
 			dev_err(&acm->data->dev,
 				"urb %d failed submission with %d\n",
 				index, res);
