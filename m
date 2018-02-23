Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413962-2-15979306258506001370
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
    t=1519413962; b=spOdH+zK34FS69PaijSTgfqgpJc1DgX8cdIV+rPuSehwtc6
    dN2lYLA6Y/hItIsBL6sIatfDnHwGw4+TyGAH+Q4T1R7NW3t4bHCXqsySi+xrmmaA
    SJ0yVPZQzqUn7R6q2tTNSCSCXNEsmWtOzDMtJMiVTDXgpJaQp7+XYY7NkaO5kCp5
    v/rMuv/IINcYyrKQl4QsxKODnHyCh8lfwAkmhzHs/6MV2c5n0rNcnMgnU2/H3EWZ
    RGkPAGavivVYpNXoxNjQ82nYTd7UhRZVue42aMGQwslSU3cIBR2So20Md8ATstzV
    I6odRhxEZ4D2zDOtpqOmeVSU2IHhjEAfMu4fRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413962; bh=aJpB0hDRdSdp0UtnlvXA4fdCXb
    us8Rt1kz2QhzYIaEM=; b=nLfmPpNeSfl/vchfte3+hBh7I87X5hcZ2FgAXPVPuI
    FkJZthufkc4C+YekaaBJPik9sKHFVoVK2/Q6pn0Mc6wJfm8oqGwQtwd0JbN473z4
    XDWObzPy70vzeoGZbuVmq8bOGHF8m6VMScQFQBykEBJqF9wUAWXAdT1Xw7srT90a
    2Z32RYwvh+VQHlVmIlS5yuAQXjvBeEroeeU+YEP5EAOMD02nJA3bhbe3oZP3Q5YT
    qNHPnpeFFdz2wvOVyUQLxzS3KF+itD9xqv5vD+JL21MsIdQHMrJIS2oUwR2ox8wW
    itCxvVWuVfE/0dEUqQu50oefLGgGWnjULsb3E6wBzX3w==
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
        id S935216AbeBWSwu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935166AbeBWSwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 032/159] blk_rq_map_user_iov: fix error override
Date: Fri, 23 Feb 2018 19:25:40 +0100
Message-Id: <20180223170747.146310231@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Douglas Gilbert <dgilbert@interlog.com>

commit 69e0927b3774563c19b5fb32e91d75edc147fb62 upstream.

During stress tests by syzkaller on the sg driver the block layer
infrequently returns EINVAL. Closer inspection shows the block
layer was trying to return ENOMEM (which is much more
understandable) but for some reason overroad that useful error.

Patch below does not show this (unchanged) line:
   ret =__blk_rq_map_user_iov(rq, map_data, &i, gfp_mask, copy);
That 'ret' was being overridden when that function failed.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-map.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -126,7 +126,7 @@ int blk_rq_map_user_iov(struct request_q
 	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
 	struct bio *bio = NULL;
 	struct iov_iter i;
-	int ret;
+	int ret = -EINVAL;
 
 	if (!iter_is_iovec(iter))
 		goto fail;
@@ -155,7 +155,7 @@ unmap_rq:
 	__blk_rq_unmap_user(bio);
 fail:
 	rq->bio = NULL;
-	return -EINVAL;
+	return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_user_iov);
 
