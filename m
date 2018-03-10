Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641386-2-727662218549042021
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
    t=1520641385; b=nCGBs8OU5tFqd79UXG8G4MIDUusvoievhbij8JhCtKz7ptb
    FBvVT/NFv7EjfkQahw6h6lVo7s0WogcqRr2e35oaLqwRgYyuvwL7nvwlyxajQcxQ
    F4ZdB1zsNhY2LmprmGCi7+FfiFwEsPZqj7wR10JDaGJHVvGVJuRtQWO12N426q6a
    V2o5LUJ7NnB28zZhsag4w8w8mTqjt4y/nQMMPVuQXeGziuJIpYC6rILr4D8xq3FM
    XvuVyOLbad1i+8jEr/18eS/g2f/9xJZ2SAI/vNiwUFqH2LlP/iF06voKoxQo3hi1
    WJhg19bypJZhlO7g1WWTMPf677G/m7PUVFv72ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641385; bh=rOlN72Wrqt3iRvO/8cjcePeqTa
    bflSSFFTo9eohfR+Q=; b=Je/RO6XL7E+qVKyuAu8UvYtf9uVLLLIlcAsnFrAvMG
    q6kEJJ+pVwPAPaxarear87oQ0tUZcK13M7F4O56tbua+23O2u/xC9nmvG5HBqkcf
    78SJFKQFxKTfAft1OCtz08tm9aMk6TSYrlRM8QwpT7FQq2oG70i9BFem/emaJxoJ
    D1G7jvB16BCn9b61gtRhgD8UYw2izyt1eegDVI2ppEmn4S/ccoRIq79K/HDo91Vo
    sCV+fI39JcDSiEbtYXvBuqzkgHRNP/azFyCwQ7v7X2qLruhQWyYITmzOpdpQlpKJ
    mvCJsLdPPXSt//eTDbpZgaiUnRIu6QVOxqIJv8n/TD4w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S933946AbeCJAXA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:23:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933647AbeCJAW6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:22:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        "David S . Miller" <davem@davemloft.net>,
        Jarno Rajahalme <jarno@covalent.io>
Subject: [PATCH 4.9 59/65] bpf: fix wrong exposure of map_flags into fdinfo for lpm
Date: Fri,  9 Mar 2018 16:18:59 -0800
Message-Id: <20180310001830.032356503@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit a316338cb71a3260201490e615f2f6d5c0d8fb2c ]

trie_alloc() always needs to have BPF_F_NO_PREALLOC passed in via
attr->map_flags, since it does not support preallocation yet. We
check the flag, but we never copy the flag into trie->map.map_flags,
which is later on exposed into fdinfo and used by loaders such as
iproute2. Latter uses this in bpf_map_selfcheck_pinned() to test
whether a pinned map has the same spec as the one from the BPF obj
file and if not, bails out, which is currently the case for lpm
since it exposes always 0 as flags.

Also copy over flags in array_map_alloc() and stack_map_alloc().
They always have to be 0 right now, but we should make sure to not
miss to copy them over at a later point in time when we add actual
flags for them to use.

Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
Reported-by: Jarno Rajahalme <jarno@covalent.io>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/arraymap.c |    1 +
 kernel/bpf/stackmap.c |    1 +
 2 files changed, 2 insertions(+)

--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -107,6 +107,7 @@ static struct bpf_map *array_map_alloc(u
 	array->map.key_size = attr->key_size;
 	array->map.value_size = attr->value_size;
 	array->map.max_entries = attr->max_entries;
+	array->map.map_flags = attr->map_flags;
 	array->elem_size = elem_size;
 
 	if (!percpu)
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -88,6 +88,7 @@ static struct bpf_map *stack_map_alloc(u
 	smap->map.key_size = attr->key_size;
 	smap->map.value_size = value_size;
 	smap->map.max_entries = attr->max_entries;
+	smap->map.map_flags = attr->map_flags;
 	smap->n_buckets = n_buckets;
 	smap->map.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
