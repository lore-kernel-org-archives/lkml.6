Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804514-2-1664464424784170119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804514; b=d7Qn+QG9y5HSstdBqvd4mdlgq+zjMRQHgJvY9laJ3u1jCqc
    X/VCwMwuR76K+Z8G+b7NHh8aAfPU+N6dslT1zncjoezOvGVPFRVv9/AV2Mw1fsdx
    XmkqW6H/JFLPfhuTYUKQRHSIlnqcmeO8nY6oQqMptB72JoS/hFbmjbsrmI24udox
    STdyY6kz1RTNGc6/KZvPR8J2Qrgb79vj8Ctc81NEdjrJ+E/zi6awZfmD1JDVnva6
    wK1bQRdNjAmw1BMoLh8goIZmuCxFgBTyOJ4O/m0O/N9/di0IM/frvZhYMfGInByC
    kLwvJ9J9Yk3f20SL8pC4odGCJoNweFhUlNRDL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804514; bh=EHwjIFPI6ZT4W23tylKbsJ804M
    gwm1fy3VRBHdz3dk0=; b=TqF67nPNUuLudmnIm49TAkzjbhGGrq9OP63A0wTE/m
    1YY4eJmsOLvMa2Kd7OgFeweSLMw30OV5k6bEfpJQhOloAp4yL1Ca7ErrodDY+ktZ
    9HtAjneAFCS1/oIrsrqxzBsbAbsny73YS+ow7b6neY9WUBH/s8RlUgaslqGqQHK/
    Hvjb21EMRfCDJquN2H7Q4s32V9Z8F90x2bNWBsQDjHdbBxGg2DJ1r66/1135Lrnl
    JnGRDndXTnlqbJrPxSn8kOEuBk94C8rA0z97c/LB/FD71DQTVf/HZ5tFxtG7umZq
    813Kjq2X45+WNZDmkPkBLWaXlB+hwMUimZfLiH3SBLWw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbeCWKGw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeCWKGt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 040/177] NFS: Fix missing pg_cleanup after nfs_pageio_cond_complete()
Date: Fri, 23 Mar 2018 10:52:48 +0100
Message-Id: <20180323094206.934467472@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Benjamin Coddington <bcodding@redhat.com>


[ Upstream commit 43b7d964ed30dbca5c83c90cb010985b429ec4f9 ]

Commit a7d42ddb3099727f58366fa006f850a219cce6c8 ("nfs: add mirroring
support to pgio layer") moved pg_cleanup out of the path when there was
non-sequental I/O that needed to be flushed.  The result is that for
layouts that have more than one layout segment per file, the pg_lseg is not
cleared, so we can end up hitting the WARN_ON_ONCE(req_start >= seg_end) in
pnfs_generic_pg_test since the pg_lseg will be pointing to that
previously-flushed layout segment.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: a7d42ddb3099 ("nfs: add mirroring support to pgio layer")
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pagelist.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1262,8 +1262,10 @@ void nfs_pageio_cond_complete(struct nfs
 		mirror = &desc->pg_mirrors[midx];
 		if (!list_empty(&mirror->pg_list)) {
 			prev = nfs_list_entry(mirror->pg_list.prev);
-			if (index != prev->wb_index + 1)
-				nfs_pageio_complete_mirror(desc, midx);
+			if (index != prev->wb_index + 1) {
+				nfs_pageio_complete(desc);
+				break;
+			}
 		}
 	}
 }
