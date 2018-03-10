Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641504-2-15387379203092241353
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
    t=1520641503; b=i/RVO7y8Ol91oTqHg2DaGNcWGlqxENHuJywqKrRfhsd2Q4G
    DZBlFTNbn0HThoZwmv92iidkkgC8KUd+jF6a/yoJ7S1az7lPvje/VVlkwI/31FG6
    bhY7iYFXdyXSyCjZgGpQTI1NDFrXL+REkY3Ik91U4IAmPUQRkLs8aeNci6JlFRL5
    iRI2pDvdpeWvxNAwki9oQb4/MkU4o5KHjY8mXjouwwZRAFqV2/Q5puuhvz2Dv8c4
    xrelHYEaWmB2rFdnLp96uXUKLZq17wG3wGF6WssAPZqPDXG2Ik0Vm17s33KjFr/o
    qgxO8dENvvWdfZHzpaHocowPPN/kYJFRKU2IQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641503; bh=UMhp8YryDIeu2azFNz7LL91KZ8
    R09OzJu+SMfXU4DDs=; b=UxDPu5vhdBJ0d440jhiBmDY6COv1Jdread/N5hANmi
    uh0HgKkLCGqvSeR3+jb/DMh5eOqYYnw/94nukSaIvCMVUyvn5tOSdHsfFVgKTd0I
    +995JHmrVwDWVu9alvU1U6RNV5d7c2bINorKKhRG1O8ment5TOsbu5zVVVQOAYLH
    hpi35TvMmYt78MIPcN7iAp9TVzv9gkX1z+NXLOPQifkI60MuJ+Aqci0N8pOGqw3/
    viFxvIP5MOo9bH4X2mvnn6yt8Y6pKR974Dz4SLaezLz1GgkUplZZAum7JpZPrw/A
    ewY8W3OPUR5EArnLdecBNBFP6r0J/E4OIhjpWXcfs2nw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S933657AbeCJAYg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:24:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934185AbeCJAXu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Eric
        Dumazet" <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4.15 06/11] bpf: add schedule points in percpu arrays management
Date: Fri,  9 Mar 2018 16:19:20 -0800
Message-Id: <20180310001834.899044596@linuxfoundation.org>
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
@@ -26,8 +26,10 @@ static void bpf_array_free_percpu(struct
 {
 	int i;
 
-	for (i = 0; i < array->map.max_entries; i++)
+	for (i = 0; i < array->map.max_entries; i++) {
 		free_percpu(array->pptrs[i]);
+		cond_resched();
+	}
 }
 
 static int bpf_array_alloc_percpu(struct bpf_array *array)
@@ -43,6 +45,7 @@ static int bpf_array_alloc_percpu(struct
 			return -ENOMEM;
 		}
 		array->pptrs[i] = ptr;
+		cond_resched();
 	}
 
 	return 0;
