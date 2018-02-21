Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218877-2-15056354429176778851
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
    t=1519218876; b=lylYkO4OaA13hcQ1aRRmk0qL8RwuNH5inSaFKi4JTtzo7B1
    rcsPGLEQ1jGLo+reZ8YluW8wffeAkBruYlKO6AXX8dgkw99GOZiDBklPLWIlyHB1
    ZToCjmSBuyLaFPzzoRil6Knnm9UQ0zPIqlcDxxW9WBrb1ZbUSXExOd/YFJW86u5d
    Uh+aEUIGmQR7/VlmeUXOrajZ33BYabpnGjZLog6Zdpqb2PysGf56FvxjAXVoCUP1
    Vn3dZpTpRCLz1rtsvUOksf1H4DvGhWPdxN5Cl6YEu07FvWFs7kiUztKK+3TLiDUd
    kW6UevVXM0ctcI58Kg22QUDBq/nFYR7MnWo8Bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218876; bh=EqL2NqodpN0zK4PCgPnL5Hh6I+
    nVqUiCdh153+9fhZo=; b=tT3HRhxLZhYY5KN9vL3303EAICEHCswyCGZtW/AcGw
    H0yaf5DYgvY1GjvfR0DNUsGdxpwgII5g8jk+cj7CvVCC3nQXfk46pQ/QjFhl2C1V
    rsvlO7d+bsFp66rk5mCEBRKcBCG7Mnu6Ch4SOLQabp8s3hwoI6mXyQlSvZgAQ9HX
    5wEKuRUgWPvloHsLtDEmyfLyc58Q0hmI/3cI6FNSlfuGlhLVBCllAOHLUbmOnkdW
    lC2a81wukTJkiA/Y4+mdZvFFaifblNe4P4u2AVmaqC5UiSl7m70n0ZY9RUng98Un
    pIf2xR3eXg3+tBe9pl/Fhrjh4hVTb1dTVaEEivzI2S7g==
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
        id S1754556AbeBUNN0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:13:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeBUNNY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 137/163] Btrfs: fix extent state leak from tree log
Date: Wed, 21 Feb 2018 13:49:26 +0100
Message-Id: <20180221124537.745508657@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit 55237a5f2431a72435e3ed39e4306e973c0446b7 upstream.

It's possible that btrfs_sync_log() bails out after one of the two
btrfs_write_marked_extents() which convert extent state's state bit into
EXTENT_NEED_WAIT from EXTENT_DIRTY/EXTENT_NEW, however only EXTENT_DIRTY
and EXTENT_NEW are searched by free_log_tree() so that those extent states
with EXTENT_NEED_WAIT lead to memory leak.

cc: <stable@vger.kernel.org>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3049,13 +3049,14 @@ static void free_log_tree(struct btrfs_t
 
 	while (1) {
 		ret = find_first_extent_bit(&log->dirty_log_pages,
-				0, &start, &end, EXTENT_DIRTY | EXTENT_NEW,
+				0, &start, &end,
+				EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT,
 				NULL);
 		if (ret)
 			break;
 
 		clear_extent_bits(&log->dirty_log_pages, start, end,
-				  EXTENT_DIRTY | EXTENT_NEW);
+				  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	}
 
 	/*
