Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641655-3-6223268237441073153
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
    t=1520641654; b=pZikO0h+ywUxT0423Iy+3m8NrY84QW1rg85fLR35kmMToG3
    9zSupVhJ7A965WDif7fXeDsHa+5/3Fip3IB2VYANtzTy/lZ1izRWg30Wlf2jBtg2
    USxW72fGBsZgCbjWMns0q8lCBarR/7zg+Iw26+UpOt+ehaczvdDumFst+mbD+ZKH
    KecRxczW2mNt6osgZmkEujGcovXTXlsBFeGtOvbFveDLR1NMbx8hxonNAd08H9T7
    XofLN8+Rjp+7Wkv85ZBE061Zrkk4M60qDPR3Qe+47UBv4VrFHiglAeOs6XZSEjKZ
    4K4AgxVBLubCsKaUttv20hgiJGxJ0h2KwaxXAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641654; bh=+p0MPH4ahO3zy/Nlx1vrPzW1Bp
    DZvTQVBC9aoDM5in0=; b=qrni2i+xyQZ1IsTNrE3wCLLggvVsPnCKhr63fYrg3V
    Wp0wy1GWAnqVGefgmBaHdG9fwaKNRAOnr0SG9vES1nqLhMy4KNL05tlYg+hfMF1n
    6F6Cr6s+INiQGa7M355f8+1htTZPow62wmSKzksttd8TR4tNwK07Kz1Rfjyss29y
    Hz2p67xEsGPAquod6Adzhs7Ho2jqERnN4aeKoSmJUCG+tK97B/IkA7b+nV6C8tUN
    ddbX8vhPCdPrE1qcTDMg5r98+k65q7XKeTDuctq3THqVE/eTImJ+iRXiNiubJzQG
    WmVyUv222eYKw/OVTx7EvKYY/7NS9o4b/CqkH8mOAL2g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S932701AbeCJAXV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:23:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbeCJAXT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:19 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Yonghong
        Song" <yhs@fb.com>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 4.14 3/9] bpf: fix rcu lockdep warning for lpm_trie map_free callback
Date: Fri,  9 Mar 2018 16:19:08 -0800
Message-Id: <20180310001828.719440361@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001828.476933393@linuxfoundation.org>
References: <20180310001828.476933393@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yhs@fb.com>

[ upstream commit 6c5f61023c5b0edb0c8a64c902fe97c6453b1852 ]

Commit 9a3efb6b661f ("bpf: fix memory leak in lpm_trie map_free callback function")
fixed a memory leak and removed unnecessary locks in map_free callback function.
Unfortrunately, it introduced a lockdep warning. When lockdep checking is turned on,
running tools/testing/selftests/bpf/test_lpm_map will have:

  [   98.294321] =============================
  [   98.294807] WARNING: suspicious RCU usage
  [   98.295359] 4.16.0-rc2+ #193 Not tainted
  [   98.295907] -----------------------------
  [   98.296486] /home/yhs/work/bpf/kernel/bpf/lpm_trie.c:572 suspicious rcu_dereference_check() usage!
  [   98.297657]
  [   98.297657] other info that might help us debug this:
  [   98.297657]
  [   98.298663]
  [   98.298663] rcu_scheduler_active = 2, debug_locks = 1
  [   98.299536] 2 locks held by kworker/2:1/54:
  [   98.300152]  #0:  ((wq_completion)"events"){+.+.}, at: [<00000000196bc1f0>] process_one_work+0x157/0x5c0
  [   98.301381]  #1:  ((work_completion)(&map->work)){+.+.}, at: [<00000000196bc1f0>] process_one_work+0x157/0x5c0

Since actual trie tree removal happens only after no other
accesses to the tree are possible, replacing
  rcu_dereference_protected(*slot, lockdep_is_held(&trie->lock))
with
  rcu_dereference_protected(*slot, 1)
fixed the issue.

Fixes: 9a3efb6b661f ("bpf: fix memory leak in lpm_trie map_free callback function")
Reported-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/lpm_trie.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -484,8 +484,7 @@ static void trie_free(struct bpf_map *ma
 		slot = &trie->root;
 
 		for (;;) {
-			node = rcu_dereference_protected(*slot,
-					lockdep_is_held(&trie->lock));
+			node = rcu_dereference_protected(*slot, 1);
 			if (!node)
 				goto out;
 
