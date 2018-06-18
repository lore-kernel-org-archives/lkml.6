Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0576BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F4B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F4B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966405AbeFRI1K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:27:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965815AbeFRI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:27:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB4EEC8D;
        Mon, 18 Jun 2018 08:27:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 252/279] afs: Fix VNOVOL handling in address rotation
Date:   Mon, 18 Jun 2018 10:13:57 +0200
Message-Id: <20180618080619.174542365@linuxfoundation.org>
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

[ Upstream commit 3d9fa91161387ee629e7a07c47934d119910c8ae ]

If a volume location record lists multiple file servers for a volume, then
it's possible that due to a misconfiguration or a changing configuration
that one of the file servers doesn't know about it yet and will abort
VNOVOL.  Currently, the rotation algorithm will stop with EREMOTEIO.

Fix this by moving on to try the next server if VNOVOL is returned.  Once
all the servers have been tried and the record rechecked, the algorithm
will stop with EREMOTEIO or ENOMEDIUM.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/rotate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -179,7 +179,7 @@ bool afs_select_fileserver(struct afs_fs
 			 */
 			if (fc->flags & AFS_FS_CURSOR_VNOVOL) {
 				fc->ac.error = -EREMOTEIO;
-				goto failed;
+				goto next_server;
 			}
 
 			write_lock(&vnode->volume->servers_lock);
@@ -201,7 +201,7 @@ bool afs_select_fileserver(struct afs_fs
 			 */
 			if (vnode->volume->servers == fc->server_list) {
 				fc->ac.error = -EREMOTEIO;
-				goto failed;
+				goto next_server;
 			}
 
 			/* Try again */


