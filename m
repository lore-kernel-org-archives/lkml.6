Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641620-2-1224162394863138989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641619; b=Z269eZwSgnWwJKgHixzWaSWdvs4uyKG+mjaEonFzAVKoj+S
    nsS9rx+7XT1o+hU5WJxKCZa4TtVIw+WiWEn8j+yBY+pKbGPT37PP7cXACIUzbUwY
    ABvHoABobDGFXyeTLvkTv6IRxffB/scq1l5fgUN2IdMd0eBHX/d9kBXn5ZoNo7rP
    0bE7e/Id+x9cVxHsduAK3Wph/N2+0dFiLHsrsUqBxKS68x6MXq1zMpbp/7w3ClCg
    Cimk5GOJIqYw98IRgJfiQmZPtLetOShEvlk1uCmPXM94/I72xU88Lr813feTIvIp
    K9nbhiH3aoZgexE5bntSOtqIpawEc1UaF/XCtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641619; bh=OTvMlwM+CDUqsMpwghjiCY2jri
    XdO4uFx2AfcDtpBM0=; b=lbtH2xR9QB8u5EkqZS1GeEEhzhFWuvSFeK6gPCjVUH
    OEzzms7/+etTCy3LfpPpqO3Vd1V4fSs4LT8S/TdwQCcHaEUUhU5YDIGolnLQpyxg
    HW5BSe5FeGGhmXnCr0sYNr1gWixO7DkZ6Ckn9FFtbmfjyjBRUyZp4mfoL0QOakB3
    OahSCxk66boyXZbu7S7VWgeq+dPGHKBUD9Um4PoYXRfBm/vgDyItEDaEnA0kDa0L
    Is9sdHT8rKAHtzTVIgCGCz+BM/20G8byppa7J3KAbeRxxBi0RtbOb+baMTwSn3PZ
    D1ShkEYLsPS/ftm0pYIqsqhlK7ZqOg6SNfhkBKfL4c6A==
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
        id S932801AbeCJAX0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:23:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbeCJAXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Eric
        Dumazet" <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4.14 6/9] bpf: add schedule points in percpu arrays management
Date: Fri,  9 Mar 2018 16:19:11 -0800
Message-Id: <20180310001828.968408143@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ upstream commit 32fff239de37ef226d5b66329dd133f64d63b22d ]

syszbot managed to trigger RCU detected stalls in
bpf_array_free_percpu()

It takes time to allocate a huge percpu map, but even more time to free
it.

Since we run in process context, use cond_resched() to yield cpu if
needed.

Fixes: a10423b87a7e ("bpf: introduce BPF_MAP_TYPE_PERCPU_ARRAY map")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/arraymap.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -23,8 +23,10 @@ static void bpf_array_free_percpu(struct
 {
 	int i;
 
-	for (i = 0; i < array->map.max_entries; i++)
+	for (i = 0; i < array->map.max_entries; i++) {
 		free_percpu(array->pptrs[i]);
+		cond_resched();
+	}
 }
 
 static int bpf_array_alloc_percpu(struct bpf_array *array)
@@ -40,6 +42,7 @@ static int bpf_array_alloc_percpu(struct
 			return -ENOMEM;
 		}
 		array->pptrs[i] = ptr;
+		cond_resched();
 	}
 
 	return 0;
