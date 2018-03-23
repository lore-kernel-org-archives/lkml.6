Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804421-2-422324832200402308
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
    t=1521804421; b=oM4iew2r41bR+3K6+VWirpxegzVG2bGJH2O54oyfT3wIo5U
    g2LXuFJxgoX/mtNAFAwXAR+OSUAemliSVQBAcXx075jAshrIxXfR9Y+EjFp6rT+w
    ho95ougqpTiLXptSbx73QIvg+3Yqc+ZG6PPOCLuRH8b+nsp53DoWNN3X5A8mt+E+
    0vpxRl7RWmiqnoVPdWEQXvyW6xDIehDqVeR+oNK1ZOiX+CYiK2Df/FTkddDfG160
    DNFPl19E0Gekom6d9QwbWPs8f8xuCZTs+L35gPUkbpNTfwCOnhoq94Qw1hUVkGl1
    VG50Mv/jhul6E9plZz0bRbVEZK7kkgBqnpr1caQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804421; bh=E11eB6qTOqc+oJ2rHDDJnOwtwK
    jaW3eckG8zI7pE4zk=; b=bYlNrt1S520om8dFdmRsgu+jaAo4gLaUuabc7RvMNH
    CcUaIrOfjt/J9uB71k4Lv2RMBOZn6anLDmT48lj0jhAJwCnX0ug9U+Tv6oHacUk8
    20M+8AFEcqEQFdMwyhW3icXnvvsWSM7SVoOYV92SUkBFIgunTA+Zg0s+uGNslZz/
    sI7bisFNgzTBcyC7yg1xaKDcRGf2YQAhrtEskd5a+/rWAZbjUFePliY3xU1ylE9S
    0T3y0cEiCj9uVSpZZFULwU89ZXyp3s+/r26Wnt/quk3Hd2f+Erkb1L1S9VfoXZEk
    imFwFnG7cNCGBznf58ucMNC6LDuQ6jO6DaPqKOn3GolA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S932365AbeCWKHM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbeCWKHG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 069/177] pNFS: Fix use after free issues in pnfs_do_read()
Date: Fri, 23 Mar 2018 10:53:17 +0100
Message-Id: <20180323094208.373666529@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 6aeafd05eca9bc8ab6b03d7e56d09ffd18190f44 ]

The assumption should be that if the caller returns PNFS_ATTEMPTED, then hdr
has been consumed, and so we should not be testing hdr->task.tk_status.
If the caller returns PNFS_TRY_AGAIN, then we need to recoalesce and
free hdr.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pnfs.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2308,10 +2308,20 @@ pnfs_do_read(struct nfs_pageio_descripto
 	enum pnfs_try_status trypnfs;
 
 	trypnfs = pnfs_try_to_read_data(hdr, call_ops, lseg);
-	if (trypnfs == PNFS_TRY_AGAIN)
-		pnfs_read_resend_pnfs(hdr);
-	if (trypnfs == PNFS_NOT_ATTEMPTED || hdr->task.tk_status)
+	switch (trypnfs) {
+	case PNFS_NOT_ATTEMPTED:
 		pnfs_read_through_mds(desc, hdr);
+	case PNFS_ATTEMPTED:
+		break;
+	case PNFS_TRY_AGAIN:
+		/* cleanup hdr and prepare to redo pnfs */
+		if (!test_and_set_bit(NFS_IOHDR_REDO, &hdr->flags)) {
+			struct nfs_pgio_mirror *mirror = nfs_pgio_current_mirror(desc);
+			list_splice_init(&hdr->pages, &mirror->pg_list);
+			mirror->pg_recoalesce = 1;
+		}
+		hdr->mds_ops->rpc_release(hdr);
+	}
 }
 
 static void pnfs_readhdr_free(struct nfs_pgio_header *hdr)
