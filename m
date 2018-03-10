Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641543-2-8779351722663997864
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
    t=1520641542; b=okt31/jraG4p8Eq7IlXc4a/l7E2i8AOUGNm/Bf2VeARy7hr
    lwqGn9WiEPCuBvDzvvHlp//dw80R6tQf7rO5beAgc1Xhwx4VxvdeqAHsUQnEhhB0
    njpyhUur8Fg6nT3W/yldTmBGImPYCA7GbH11Q1sxRV5Vu0NMEx2tgs92L/LV6hC5
    H7qzOhfl/41iayCgUaTL++bQBscRbNwZiGc5PFkPKqzqEbg5rQeVjgs+fjXeIWd5
    Hrj2a+zozp2b8l4NtFrNaG34FT+x89Xvl6qJjSoGiKw6n2cSUMDlAEbzqSfHzzMB
    7wD8jkXuyCyqTAqb70sQvQAzX4SN7d/zEB+RKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641542; bh=5b9vnqoqctf1aAClg7PPSGu82+
    aMkUatAq7AHzutA/M=; b=wln/AsIKwK1cizw4XVGhY1ptZF3W9PZsmoZZJA+gOU
    xQue6+HPgRMvcLoh7RIPlZjqp0j97yiISPUAxFb9BVtP0wGYnaHjVMjfWtw00tPM
    /mCKY8oT61JZmuJqur/IDU6mUHxnTji56PbboOL1YOwzzY/dCVUhV6PO9jHdLzqD
    HJsfPko4cbz73/nUdiulB1nt9UMfVHQ8vgmbRTpsCajRtf7x8FdAoxS8ZzEKgDUS
    qIq1mZyEZwES0BFTtzcngkBQ1onB9LoI8wKCWe1WhhjGwn6rm3e8H5nugHMYv6sv
    3ozpitgt/QQZ72s0lG6M3Q/UGZ3wbEe3b2Uq8fYHhmDw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933868AbeCJAXo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:23:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbeCJAXm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Yonghong
        Song" <yhs@fb.com>, Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 4.15 02/11] bpf: fix memory leak in lpm_trie map_free callback function
Date: Fri,  9 Mar 2018 16:19:16 -0800
Message-Id: <20180310001834.664221516@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
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

From: Yonghong Song <yhs@fb.com>

[ upstream commit 9a3efb6b661f71d5675369ace9257833f0e78ef3 ]

There is a memory leak happening in lpm_trie map_free callback
function trie_free. The trie structure itself does not get freed.

Also, trie_free function did not do synchronize_rcu before freeing
various data structures. This is incorrect as some rcu_read_lock
region(s) for lookup, update, delete or get_next_key may not complete yet.
The fix is to add synchronize_rcu in the beginning of trie_free.
The useless spin_lock is removed from this function as well.

Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
Reported-by: Mathieu Malaterre <malat@debian.org>
Reported-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/lpm_trie.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -560,7 +560,10 @@ static void trie_free(struct bpf_map *ma
 	struct lpm_trie_node __rcu **slot;
 	struct lpm_trie_node *node;
 
-	raw_spin_lock(&trie->lock);
+	/* Wait for outstanding programs to complete
+	 * update/lookup/delete/get_next_key and free the trie.
+	 */
+	synchronize_rcu();
 
 	/* Always start at the root and walk down to a node that has no
 	 * children. Then free that node, nullify its reference in the parent
@@ -574,7 +577,7 @@ static void trie_free(struct bpf_map *ma
 			node = rcu_dereference_protected(*slot,
 					lockdep_is_held(&trie->lock));
 			if (!node)
-				goto unlock;
+				goto out;
 
 			if (rcu_access_pointer(node->child[0])) {
 				slot = &node->child[0];
@@ -592,8 +595,8 @@ static void trie_free(struct bpf_map *ma
 		}
 	}
 
-unlock:
-	raw_spin_unlock(&trie->lock);
+out:
+	kfree(trie);
 }
 
 static int trie_get_next_key(struct bpf_map *map, void *key, void *next_key)
