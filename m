Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519416010-2-18397345181953813694
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
    t=1519416009; b=MDupuu/pEcQmIEtdXAnvjPF+sk8bX2splXsJBs2iMvtWPpx
    Mtljw7/46IENdtjDyBK6hCYLOB6aK93o4eOPzMctxzmqr2+6KaJxPJV1wLwij8xL
    BmoC1o2xWrBiDKM9SehLQxbmuO+EaexH232ElunOnd59prCX319Bp8UXg8ZQ/jBj
    EVVukyXn2FmzZWUwAwONjO3KzWIN6+u+3wFDrzvL2SXKtaPvmb+MjiL0lnYDYuV5
    0nk+BrM/RpBfLj4d+NmMBpCuWmsmlvkKKaTufHJ64lr0+cBbA7AxRbFmqQNlCbCq
    ySdy+PX5pviovk5v05t3smAnmnOjPAIR8R/7nLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416009; bh=4nuGZZ3Rw9BAqghrK3cDjXZvyU
    u1kPumnq3JXjqhf2I=; b=Uggwz8AMm6+SdUpHVet0JYN6QytaZXezyS0zWREeai
    vnjZjxpHiBC4km+GmgAVDYnimoPWTMb6fFlMD1E/qPZhfomnJdmraqL6+kiqRSj3
    0bc2LusCYKcsKr2RZnrSLXBr4hoR5Ocyx4bteg0PggnK6pbTOStw7K5P5Lv384sr
    S2H7EA9lAg0R2Q8jRJM+VADsizYSvCs9MBQGFmanY5IBx24YiXhh7x06PHO8U8EI
    47MveUqSv2/x3YMNiRDWdqeThpSSqekYH0r8RNaEIi9jx0yp8AOh5Y9W73O6o/4A
    0zyKkspwQINE5amLs8YjWVuHRauGZtikY+PGFipOoijA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeBWT7z (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:59:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933386AbeBWSnq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 037/145] staging: android: ashmem: Fix a race condition in pin ioctls
Date: Fri, 23 Feb 2018 19:25:43 +0100
Message-Id: <20180223170729.749650378@linuxfoundation.org>
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

From: Ben Hutchings <ben@decadent.org.uk>

commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652 upstream.

ashmem_pin_unpin() reads asma->file and asma->size before taking the
ashmem_mutex, so it can race with other operations that modify them.

Build-tested only.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ashmem.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -719,30 +719,32 @@ static int ashmem_pin_unpin(struct ashme
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
 
+	mutex_lock(&ashmem_mutex);
+
 	if (unlikely(!asma->file))
-		return -EINVAL;
+		goto out_unlock;
 
-	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
-		return -EFAULT;
+	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
 
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
 
 	if (unlikely((pin.offset | pin.len) & ~PAGE_MASK))
-		return -EINVAL;
+		goto out_unlock;
 
 	if (unlikely(((__u32)-1) - pin.offset < pin.len))
-		return -EINVAL;
+		goto out_unlock;
 
 	if (unlikely(PAGE_ALIGN(asma->size) < pin.offset + pin.len))
-		return -EINVAL;
+		goto out_unlock;
 
 	pgstart = pin.offset / PAGE_SIZE;
 	pgend = pgstart + (pin.len / PAGE_SIZE) - 1;
 
-	mutex_lock(&ashmem_mutex);
-
 	switch (cmd) {
 	case ASHMEM_PIN:
 		ret = ashmem_pin(asma, pgstart, pgend);
@@ -755,6 +757,7 @@ static int ashmem_pin_unpin(struct ashme
 		break;
 	}
 
+out_unlock:
 	mutex_unlock(&ashmem_mutex);
 
 	return ret;
