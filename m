Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591370-2-12820502008663105033
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
    t=1517591370; b=esIlaYTWM+m3f+gE7MaXwH570lckgrGM1fr6eKOVH8NU27w
    O4Fq23TvygxnvHg4iATBKaAHWdInNp2ipwvUKjHTOqRpanXmmpr2CGq1j86QXAO8
    2wd8KgYYzYvp5jDp2zUINuh+NL+3/nmlJFRZc/uLFR08WVRxKeE6vTcTmP1o6+qL
    Fu34qlkGoHWd8Pe+AIVpbIBVsAtfcVYf6WBzCk85LWrravpWI6w0CkJbMYsttpqc
    eq971IhQ+tgVjAZEmr9BIGvazRwvTQMpDuInlChg6u3cI+mmcKDZINuvy6C1Lu9p
    /hxBaYDacg+P/wwlb8epqPyNBP0/xRl698tRKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591370; bh=cTVkBUdUQGziARIu+eHk6/Gh18
    4WKcVI00U8KAnwJXQ=; b=AE56GlPFdPde/tKaibnAHIQ47ndKmBNDHHAZy4gHTM
    5WOmvxunMYe6dELuczRaDrlGbyKjTDHMD+tCfVyN4r+l9/tyUv9KqcEJeMx68qAf
    ItLB+Ca/QfFv4a+Roi/wwHHfR3/xAVg0MIaWV0LsolAANJQ+RN5tBpJ5oPCokFvP
    v7EC/PQlOgEFL8yg2o45ul2rBGDTlAyCJSlQ2Cdwk6DW6Vtkso/oBmht2eRKxYUm
    8zPQcYa8aMvhA/h1EgDcjcZ49Z0nhSepwKku5BYGLSh6B4exUuDhd8QlWh9mB9Jb
    THMaY0DM2X81GxvYraOQKysPqzqfc4vwkx+oXKfd2efw==
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
        id S1752770AbeBBRJ1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:09:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeBBRJW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:09:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Harald Freudenberger <freude@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 053/156] s390/zcrypt: Fix wrong comparison leading to strange load balancing
Date: Fri,  2 Feb 2018 17:57:14 +0100
Message-Id: <20180202140842.670298822@linuxfoundation.org>
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

From: Harald Freudenberger <freude@linux.vnet.ibm.com>


[ Upstream commit 0b0882672640ced4deeebf84da0b88b6389619c4 ]

The function to decide if one zcrypt queue is better than
another one compared two pointers instead of comparing the
values where the pointers refer to. So within the same
zcrypt card when load of each queue was equal just one queue
was used. This effect only appears on relatively lite load,
typically with one thread applications.

This patch fixes the wrong comparison and now the counters
show that requests are balanced equally over all available
queues within the cards.

There is no performance improvement coming with this fix.
As long as the queue depth for an APQN queue is not touched,
processing is not faster when requests are spread over
queues within the same card hardware. So this fix only
beautifies the lszcrypt counter printouts.

Signed-off-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/zcrypt_api.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -218,8 +218,8 @@ static inline bool zcrypt_queue_compare(
 	weight += atomic_read(&zq->load);
 	pref_weight += atomic_read(&pref_zq->load);
 	if (weight == pref_weight)
-		return &zq->queue->total_request_count >
-			&pref_zq->queue->total_request_count;
+		return zq->queue->total_request_count >
+			pref_zq->queue->total_request_count;
 	return weight > pref_weight;
 }
 
