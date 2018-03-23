Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803938-2-14862687219855786340
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
    t=1521803937; b=kcXXw+7ZAC7kYp6yNldlJIpWwRcF2WYULdPZPaXWQ9SRzBj
    o6dtZRPqvRCaMVlxmzDlSjfSap53jEDl8DGDRHgo0HvUagF0pbNpuyECF2Bh/k2O
    foW9ea8/ggJtpzCPXhkWwmDfECRli5IgpTG75s5qLtACjxxktJ38gYJ/gHO3Niw+
    D+vEOSkt2PzaBy4S4uxT4n/ISwrzQjvBasvT2Memf0vgqH7mkUSePazp9wJxAOJp
    lgCFH9G8/LllLaC2u0SNIt5DCadqvDoy2+yjk3IKIZ4Yv4yV1SNdLS5XgC4X+riC
    baukyUPVAqKkEt3qMJtJ0oM/gw3miEizv/hHW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803937; bh=e/dYa0cnOvEo9J6wilYoLGnMFM
    95Qk0QW8DPreYVELE=; b=YkhHypbx/rn1V60tIkqfRYJKyW1M/OD4POhIaPmd74
    b3XVNp2oyZ1htOjQ1vGx0tWBmUnu9NiNRdP3OD8Xw12EyGfRICuKPeJejRVmZL27
    B1XmKgRv2kL42c6OW+S1HjZMkdXsCYF60Ordxp/AlELbMIZQRn4Xr//BSbGAxlJf
    6D7M49SBAToqw3ysy5lSWd57SEETu2WswcCfBrWUH3dgaF3F0lWxOouNWpqjIUkc
    JizfxpRDC0olpAJVkeAFGs8cDoNJ8PXH9jq9ZplrnaLxLyUkUS3C/GQZd3ZQv24l
    sIo6z9t3SkPH4OTGs1Kj1tE3EzrKUHzIoLq4hvsDTBnQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755675AbeCWKJB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755655AbeCWKJA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 093/177] netfilter: x_tables: unlock on error in xt_find_table_lock()
Date: Fri, 23 Mar 2018 10:53:41 +0100
Message-Id: <20180323094209.397050965@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 7dde07e9c53617549d67dd3e1d791496d0d3868e ]

According to my static checker we should unlock here before the return.
That seems reasonable to me as well.

Fixes" b9e69e127397 ("netfilter: xtables: don't hook tables by default")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/x_tables.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1006,8 +1006,10 @@ struct xt_table *xt_find_table_lock(stru
 	list_for_each_entry(t, &init_net.xt.tables[af], list) {
 		if (strcmp(t->name, name))
 			continue;
-		if (!try_module_get(t->me))
+		if (!try_module_get(t->me)) {
+			mutex_unlock(&xt[af].mutex);
 			return NULL;
+		}
 
 		mutex_unlock(&xt[af].mutex);
 		if (t->table_init(net) != 0) {
