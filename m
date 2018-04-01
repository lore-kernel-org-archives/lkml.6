Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeDAUnc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754147AbeDAUn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:29 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 32/45] C++: __to_fd() needs to reduce the size of v for
 struct fd::flags
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:27 +0100
Message-ID: <152261540772.30503.1698627927664620191.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__to_fd() needs to reduce the size of v before it assigns the computed
value to fd::flags or suffer a warning about reduction of size of integer.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/file.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 279720db984a..9807271c850a 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -49,7 +49,7 @@ extern void __f_unlock_pos(struct file *);
 
 static inline struct fd __to_fd(unsigned long v)
 {
-	return (struct fd){(struct file *)(v & ~3),v & 3};
+	return (struct fd){(struct file *)(v & ~3), (unsigned int)v & 3};
 }
 
 static inline struct fd fdget(unsigned int fd)
