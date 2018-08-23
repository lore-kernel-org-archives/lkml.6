Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FFF20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FFF20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbeHWMVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeHWMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:54 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 29998C5C;
        Thu, 23 Aug 2018 08:53:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauricio Vasquez B <mauricio.vasquez@polito.it>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 178/324] bpf: hash map: decrement counter on error
Date:   Thu, 23 Aug 2018 09:54:04 +0200
Message-Id: <20180823075005.116295573@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Vasquez B <mauricio.vasquez@polito.it>

[ Upstream commit ed2b82c03dc187018307c7c6bf9299705f3db383 ]

Decrement the number of elements in the map in case the allocation
of a new node fails.

Fixes: 6c9059817432 ("bpf: pre-allocate hash map elements")
Signed-off-by: Mauricio Vasquez B <mauricio.vasquez@polito.it>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/hashtab.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -743,13 +743,15 @@ static struct htab_elem *alloc_htab_elem
 				 * old element will be freed immediately.
 				 * Otherwise return an error
 				 */
-				atomic_dec(&htab->count);
-				return ERR_PTR(-E2BIG);
+				l_new = ERR_PTR(-E2BIG);
+				goto dec_count;
 			}
 		l_new = kmalloc_node(htab->elem_size, GFP_ATOMIC | __GFP_NOWARN,
 				     htab->map.numa_node);
-		if (!l_new)
-			return ERR_PTR(-ENOMEM);
+		if (!l_new) {
+			l_new = ERR_PTR(-ENOMEM);
+			goto dec_count;
+		}
 	}
 
 	memcpy(l_new->key, key, key_size);
@@ -762,7 +764,8 @@ static struct htab_elem *alloc_htab_elem
 						  GFP_ATOMIC | __GFP_NOWARN);
 			if (!pptr) {
 				kfree(l_new);
-				return ERR_PTR(-ENOMEM);
+				l_new = ERR_PTR(-ENOMEM);
+				goto dec_count;
 			}
 		}
 
@@ -776,6 +779,9 @@ static struct htab_elem *alloc_htab_elem
 
 	l_new->hash = hash;
 	return l_new;
+dec_count:
+	atomic_dec(&htab->count);
+	return l_new;
 }
 
 static int check_flags(struct bpf_htab *htab, struct htab_elem *l_old,


