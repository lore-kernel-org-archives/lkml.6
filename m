Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711078-2-5023222986167830767
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
    t=1518711078; b=j5hpef7jMjJpaUVe6LxxdhdktDdP8Vxx35fQfErORJd2oEP
    xVpEk6sh7wsd2aubWnLK/bNM1ruhEP9uTzIq/W9rU8d1jnkswQTQgGOq1rXcmcld
    WJkolgq+TeUfq+TytVl1UmCKlh6x1AC3KXO+gghAChOgnpioLZb2N7yteMRIUeaM
    fHVVv8KBjmVv18uA6sKk9yawgny/Rxs2UuShTUIdosdCs71kQozoDXSbUBMBK140
    rtcM/KJ4lkIaYhP1IfoGY/zWK3qLO+KuSW/W/QLRr5+HMt+n8D+oAViZpX4HfzGq
    J4ITKe0pyw//T3AYrBQ9nkFR8PeCVrklT3e0USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711078; bh=tD+uVOejeHY8yVUeROfRx1ObQL
    wBvzRsIIycHiCbDLM=; b=TStNpT5fnJsgC37Aiy1Zh/HB0YIdJo/S+McJLxWUzS
    MfNw2u0Qn2CwCK5Aeovlv0bLTYNVfTwrpondN++QufAACJX5LBuENxh8UtiOJb3M
    l2nqmxqhuX48TqKNtik7QsvOXpeBanI801rzOyzYTlWie6O2Y0YNoZhQ/Dx2aKPm
    XcZyu+HDWgydrdl8pQyU5uxgSSFA3eh86q5KCRAVNT1nHVZkVBQCdXRbkQGJVFOy
    2FQE8DlppI9iY7AtUI9yIFTi7eGCV2bqBN8Bpox+d4jRH/Wf9WSs3LtiPeJwyh5n
    SxlS1ZIRUWkwkJVDzJhlf6xVozMcIDV9ibMEIeTmMNDw==
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
        id S1424417AbeBOPpW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424457AbeBOPpV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 147/202] Btrfs: raid56: iterate raid56 internal bio with bio_for_each_segment_all
Date: Thu, 15 Feb 2018 16:17:27 +0100
Message-Id: <20180215151720.708394341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
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

From: Liu Bo <bo.li.liu@oracle.com>

commit 0198e5b707cfeb5defbd1b71b1ec6e71580d7db9 upstream.

Bio iterated by set_bio_pages_uptodate() is raid56 internal one, so it
will never be a BIO_CLONED bio, and since this is called by end_io
functions, bio->bi_iter.bi_size is zero, we mustn't use
bio_for_each_segment() as that is a no-op if bi_size is zero.

Fixes: 6592e58c6b68e61f003a01ba29a3716e7e2e9484 ("Btrfs: fix write corruption due to bio cloning on raid5/6")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/raid56.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1435,14 +1435,13 @@ static int fail_bio_stripe(struct btrfs_
  */
 static void set_bio_pages_uptodate(struct bio *bio)
 {
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct bio_vec *bvec;
+	int i;
 
-	if (bio_flagged(bio, BIO_CLONED))
-		bio->bi_iter = btrfs_io_bio(bio)->iter;
+	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
-	bio_for_each_segment(bvec, bio, iter)
-		SetPageUptodate(bvec.bv_page);
+	bio_for_each_segment_all(bvec, bio, i)
+		SetPageUptodate(bvec->bv_page);
 }
 
 /*
