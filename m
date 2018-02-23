Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413751-2-13921229682471564449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413750; b=eCT+LfEkeutD9TnEXXnqCEcA3826pvC2vKlhrsDabalbwYg
    7xO4zMi06sp2h5sAuNSkKK+eG2cA3SunrxXeI/6BkASh20Ammx2UO9nYtn3UCrz0
    s9ikhF5SuhxCkrI5q+xcPQ8Yl5XZY7y0pk4SGdZ6mEJGSgem0moRE36E6QjBu2ay
    k62Hyavy58bmtPlJ6hV4h1i5PS+Ep1ggKdtucRC2LleFv1rymJlPyCmFYipd4q6A
    HKMzE40m8tFTHvB93sTor6HMxO0fcSZYmz/LDxn4ZzViDMrb5UHByz3AWtuEJxvX
    R7vw4MmdxKD5VAOZNpG/OS00C8sbrREJQo1R/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413750; bh=nIouyHIv9NJ02d+tZkZSkkTlrB
    6x+yIZUfPyfphZGYw=; b=Jany0vjdzikbWjcHwW6vUYUD8olMb0oSO+mfZgooCc
    7tZfYBI5dpfiz4fpuzKFSxjHyQukywGFdTqp+zJ/V1seFss+qrcQxk7CEcFosMRD
    raW2gtWAOMCgjfoqnOwZsh2uHDFDLRbp0UJUgaIsHjq+JQXBzjqQg2dCpY9SyzAR
    xa7hh/SmZSvLTw/o0hOFwNozrF6K2RB5iWZPmztHzYidHcJY9OEOLDNSMdndabAz
    2iVnaKi3+NgUXiUvkA1bjDAp1u6vbwJyYUyUiF7z4/NiquNgIfFiTdnq8EuVPTPq
    AwxES8OE5ri0cO+rLe0ScvoWo7+Edz7laC8G4vXNq0Rg==
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
        id S1754496AbeBWTWO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:22:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935428AbeBWSxo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 098/159] md/raid1/10: add missed blk plug
Date: Fri, 23 Feb 2018 19:26:46 +0100
Message-Id: <20180223170755.356409151@linuxfoundation.org>
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

From: Shaohua Li <shli@fb.com>


[ Upstream commit 18022a1bd3709b74ca31ef0b28fccd52bcd6c504 ]

flush_pending_writes isn't always called with block plug, so add it, and plug
works in nested way.

Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid1.c  |    4 ++++
 drivers/md/raid10.c |    4 ++++
 2 files changed, 8 insertions(+)

--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -810,11 +810,15 @@ static void flush_pending_writes(struct
 	spin_lock_irq(&conf->device_lock);
 
 	if (conf->pending_bio_list.head) {
+		struct blk_plug plug;
 		struct bio *bio;
+
 		bio = bio_list_get(&conf->pending_bio_list);
 		conf->pending_count = 0;
 		spin_unlock_irq(&conf->device_lock);
+		blk_start_plug(&plug);
 		flush_bio_list(conf, bio);
+		blk_finish_plug(&plug);
 	} else
 		spin_unlock_irq(&conf->device_lock);
 }
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -890,10 +890,13 @@ static void flush_pending_writes(struct
 	spin_lock_irq(&conf->device_lock);
 
 	if (conf->pending_bio_list.head) {
+		struct blk_plug plug;
 		struct bio *bio;
+
 		bio = bio_list_get(&conf->pending_bio_list);
 		conf->pending_count = 0;
 		spin_unlock_irq(&conf->device_lock);
+		blk_start_plug(&plug);
 		/* flush any pending bitmap writes to disk
 		 * before proceeding w/ I/O */
 		bitmap_unplug(conf->mddev->bitmap);
@@ -914,6 +917,7 @@ static void flush_pending_writes(struct
 				generic_make_request(bio);
 			bio = next;
 		}
+		blk_finish_plug(&plug);
 	} else
 		spin_unlock_irq(&conf->device_lock);
 }
