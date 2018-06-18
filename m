Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F11BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAE520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAE520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936150AbeFRI1P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:27:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965815AbeFRI1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:27:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 55FB9C94;
        Mon, 18 Jun 2018 08:27:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 254/279] afs: Fix afs_find_server search loop
Date:   Mon, 18 Jun 2018 10:13:59 +0200
Message-Id: <20180618080619.247614803@linuxfoundation.org>
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

From: Marc Dionne <marc.dionne@auristor.com>

[ Upstream commit f9c1bba3d392843f046d2ee27b4dfcec989d8a4b ]

The code that looks up servers by addresses makes the assumption
that the list of addresses for a server is sorted.  It exits the
loop if it finds that the target address is larger than the
current candidate.  As the list is not currently sorted, this
can lead to a failure to find a matching server, which can cause
callbacks from that server to be ignored.

Remove the early exit case so that the complete list is searched.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/server.c |   13 -------------
 1 file changed, 13 deletions(-)

--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -66,12 +66,6 @@ struct afs_server *afs_find_server(struc
 							      sizeof(struct in6_addr));
 					if (diff == 0)
 						goto found;
-					if (diff < 0) {
-						// TODO: Sort the list
-						//if (i == alist->nr_ipv4)
-						//	goto not_found;
-						break;
-					}
 				}
 			}
 		} else {
@@ -85,17 +79,10 @@ struct afs_server *afs_find_server(struc
 							(u32)b->sin6_addr.s6_addr32[3]);
 					if (diff == 0)
 						goto found;
-					if (diff < 0) {
-						// TODO: Sort the list
-						//if (i == 0)
-						//	goto not_found;
-						break;
-					}
 				}
 			}
 		}
 
-	//not_found:
 		server = NULL;
 	found:
 		if (server && !atomic_inc_not_zero(&server->usage))


