Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951739-1517591769-2-6441134880161995708
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
    t=1517591768; b=sdFmKNLbPBAI3bmuOKK74qSxTPrG3fGGkb8TTMSratkuFd6
    avV4fFwcBIO+Gr9Ww4Ljecm0k5D7AUvV439JGghbom/eI+H+XLQ13KMwL2BtD+S1
    cE6LOM/f7mZZRwp79nUUtUg99nWNTLPfYZM7kf8YzKFbpYo/avBvnYkaQkGwZVZp
    xMbx6KzbTeFgXJiPW9jKephWfo8l/C9uFZmYc2UXJNj3npZpN3r3QDL1vkmL9mk3
    D6NosZSHe23RtXpUqpR7+N6vwCSXRMwxpDjySaFfhcFeLknX3fG2LElU5IudlH5N
    3JSptyL5gSGLKTT0i0ghyj1yiYQ8pZzRqyBm+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591768; bh=zajTn7hLNBZl2GtKW9tBZ4gBLU
    cxmfT5j7Qa3WbWBr8=; b=wkxFCjCfqhNOPR8W8ygXiGaP5aGiq3Xf6gCNeh1LK2
    Y1r4vWqcdTa0mMjmmdpwXVj6BOa5VZtUNUlciA2alKLiSx4ftIjmP9juRNxXHxRj
    fI0fVfhlkWScDgB5aa5xDqtDfJZZk4WyWeLQg/2amBnvD+F2DMvJmWkwNKG4ii08
    77X8cdbNIthIOYKx1o8tZB7ndg/3F2hpQ+7LNCh03d/xUhR8XVn97DjAcCcpG2xi
    A+g4tTU1dxf7AuWYgWUqf3rCDeFgoukbnVqD/ATeFgIF5y3tOI9BnsaZ567SwEjJ
    APgJGdUxU1WQX1V5RF48Vyp0Y4ud7IR41Vc9BkU5TVrA==
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
        id S1753817AbeBBRQC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:16:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753636AbeBBRPz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:15:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.15 33/55] USB: cdc-acm: Do not log urb submission errors on disconnect
Date: Fri,  2 Feb 2018 17:58:51 +0100
Message-Id: <20180202140829.468915914@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -425,7 +425,7 @@ static int acm_submit_read_urb(struct ac
 
 	res = usb_submit_urb(acm->read_urbs[index], mem_flags);
 	if (res) {
-		if (res != -EPERM) {
+		if (res != -EPERM && res != -ENODEV) {
 			dev_err(&acm->data->dev,
 				"urb %d failed submission with %d\n",
 				index, res);
