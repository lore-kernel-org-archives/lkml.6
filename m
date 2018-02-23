Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519419187-2-14910824122504266805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519419187; b=kVZojAlcmx/3jtFKhoTHfFeEPU56WhAf2kYfEGiuLW8w9aI
    mixMzUzMKRFBdtvM6VogxjVx1bGbMjQzsCeNj9qlvzrqMrwpuJeyefIAbXpU2rXc
    A9UxwbTU8cGc6ibyXNcxQSvUt2BonzAksKW1/mK2IfcapWi8vQIbSauuw+tJDcuG
    nRGmCKWC7jIfM0V/cd3ucAulvpzTaqkEPEGLIISu7uJ+fui4fXXiY55WypyrzZ1O
    NaP46fUiefK+ElE1jNqZKhjrxNndGCu8velJjIdFoKr4epT3XY6+5QS71WBdo2SI
    heFXkrJvzSX5Oge9vsStTlIJgykfFWd3cZUeJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419187; bh=OLdbvvhSDjf5dC4JL44DywnOJ+
    ETpYS+o8vcOowVPDU=; b=ER9SI9kXUSgXnbz6hW1lwckgvo+aTKBU7wHfw+BJfp
    lbgg9Ux1jeFmF59xGv4pAa30tJCsrioWuGwGYssfC2wnKesLkKWkxZLDY4Ra7zll
    FPqO+Yj5UfS8dNgcvhGxQTcn806/VXK/pFiCFJv3NVTkPixjdXXqE5saRxYF1Lx5
    x+4KYkw54NINmUqxbuwc0ulD7xcw8bRzObn9RfwDYlO+QaeWJ6a2K8SSFk/NijJz
    M9BgwBikM/nFEmo4YV0U+Gai7z2lVHW0sZ9YphXdJblitbiJX3gjGNG0jiytSaXF
    SfS/IoG/rxgvr6Ql4o4+1k12rhJGDlS027sN6xl2EbEA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeBWUwv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:52:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeBWSam (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:30:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4396883fa8c4f64e0175@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 23/58] netfilter: x_tables: fix int overflow in xt_alloc_table_info()
Date: Fri, 23 Feb 2018 19:26:22 +0100
Message-Id: <20180223170210.546663387@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit 889c604fd0b5f6d3b8694ade229ee44124de1127 upstream.

syzkaller triggered OOM kills by passing ipt_replace.size = -1
to IPT_SO_SET_REPLACE. The root cause is that SMP_ALIGN() in
xt_alloc_table_info() causes int overflow and the size check passes
when it should not. SMP_ALIGN() is no longer needed leftover.

Remove SMP_ALIGN() call in xt_alloc_table_info().

Reported-by: syzbot+4396883fa8c4f64e0175@syzkaller.appspotmail.com
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -38,8 +38,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_DESCRIPTION("{ip,ip6,arp,eb}_tables backend module");
 
-#define SMP_ALIGN(x) (((x) + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1))
-
 struct compat_delta {
 	unsigned int offset; /* offset in kernel */
 	int delta; /* delta in 32bit user land */
@@ -951,7 +949,7 @@ struct xt_table_info *xt_alloc_table_inf
 	int cpu;
 
 	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
-	if ((SMP_ALIGN(size) >> PAGE_SHIFT) + 2 > totalram_pages)
+	if ((size >> PAGE_SHIFT) + 2 > totalram_pages)
 		return NULL;
 
 	newinfo = kzalloc(XT_TABLE_INFO_SZ, GFP_KERNEL);
