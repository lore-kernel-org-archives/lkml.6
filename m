Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9636C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9636C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966615AbeFRI2Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:28:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966579AbeFRI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:28:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F09CECEF;
        Mon, 18 Jun 2018 08:28:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 248/279] afs: Fix address list parsing
Date:   Mon, 18 Jun 2018 10:13:53 +0200
Message-Id: <20180618080619.024537548@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 01fd79e6de74a447c5657913a335d9ce6508cdb1 ]

The parsing of port specifiers in the address list obtained from the DNS
resolution upcall doesn't work as in4_pton() and in6_pton() will fail on
encountering an unexpected delimiter (in this case, the '+' marking the
port number).  However, in*_pton() can't be given multiple specifiers.

Fix this by finding the delimiter in advance and not relying on in*_pton()
to find the end of the address for us.

Fixes: 8b2a464ced77 ("afs: Add an address list concept")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/addr_list.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -121,7 +121,7 @@ struct afs_addr_list *afs_parse_text_add
 	p = text;
 	do {
 		struct sockaddr_rxrpc *srx = &alist->addrs[alist->nr_addrs];
-		char tdelim = delim;
+		const char *q, *stop;
 
 		if (*p == delim) {
 			p++;
@@ -130,28 +130,33 @@ struct afs_addr_list *afs_parse_text_add
 
 		if (*p == '[') {
 			p++;
-			tdelim = ']';
+			q = memchr(p, ']', end - p);
+		} else {
+			for (q = p; q < end; q++)
+				if (*q == '+' || *q == delim)
+					break;
 		}
 
-		if (in4_pton(p, end - p,
+		if (in4_pton(p, q - p,
 			     (u8 *)&srx->transport.sin6.sin6_addr.s6_addr32[3],
-			     tdelim, &p)) {
+			     -1, &stop)) {
 			srx->transport.sin6.sin6_addr.s6_addr32[0] = 0;
 			srx->transport.sin6.sin6_addr.s6_addr32[1] = 0;
 			srx->transport.sin6.sin6_addr.s6_addr32[2] = htonl(0xffff);
-		} else if (in6_pton(p, end - p,
+		} else if (in6_pton(p, q - p,
 				    srx->transport.sin6.sin6_addr.s6_addr,
-				    tdelim, &p)) {
+				    -1, &stop)) {
 			/* Nothing to do */
 		} else {
 			goto bad_address;
 		}
 
-		if (tdelim == ']') {
-			if (p == end || *p != ']')
-				goto bad_address;
+		if (stop != q)
+			goto bad_address;
+
+		p = q;
+		if (q < end && *q == ']')
 			p++;
-		}
 
 		if (p < end) {
 			if (*p == '+') {


