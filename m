Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414842-2-399967384613194161
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414842; b=Fzti4XN/DhLU1cDuAKK2aWDX1LHHZP2Qlt0liuO8g0cRASI
    aU/0dJYoYglXEKLQxguQG4RJ/Cjqxva8/ZKMRQEyc+t950nVaOHPf25Qp1Eksj+z
    KEFhQgJIBS+Z3OkXzvlb4mcp/z3D5a+JhQCnwdlv4LxwXYxy/+wgfKa6XU7euWDG
    0FAcbaPGdX746Xe+9W84+VhcqCvISE2ne+thFJkSgdhl8BX2i5MH0KqAumX2DNws
    vQ6BmqI1VLWszSjAKWGj2iLDjmQpg9YevbrIOeDNAiyLK6oyzxiFZabhXDzP94bJ
    D1Aw22dpLwt8Dw+QlHXHbUNheFtuSUAlJ6766mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414842; bh=iLtjd20SHaFlAZ3LR+oKKplS/m
    lOvvwjtZqi62p2R7E=; b=kswX9239QECVMaPnlDhMEXgHk1S0u2lyQmImdPtUTG
    8LU1Hkd60KFpcIX39PamsgFWUrx9X9jt9fCGGfHI4Lmk90kjXGycJ2qa0alt8ZaM
    Fit52ZFTr1vFXLtfSxuDN8juROYfrjZkyEjVZvDlpJU19CnnK9wLzHtGV5AgZgJI
    KWagNrWZyNwIqD3b8sbC0ZuSmkMwzzy6oPpgl77pA93Kbw1u7xDovmGOFtsdw4iI
    ELUy57MTfDAxsvIntX80VbezZvrWG7Ki3xOUM6ab77kG8X+goOgoOYwtYT2ZGgx/
    zN4AiskoAPlVOsvrpBJOp2VaEgtmpLJ1OlBmn4F11MOA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934265AbeBWStY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934016AbeBWStX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+ca425f44816d749e8eb49755567a75ee48cf4a30@syzkaller.appspotmail.com,
        Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.14 010/159] xfrm: fix rcu usage in xfrm_get_type_offload
Date: Fri, 23 Feb 2018 19:25:18 +0100
Message-Id: <20180223170744.432128760@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

commit 2f10a61cee8fdb9f8da90f5db687e1862b22cf06 upstream.

request_module can sleep, thus we cannot hold rcu_read_lock() while
calling it. The function also jumps back and takes rcu_read_lock()
again (in xfrm_state_get_afinfo()), resulting in an imbalance.

This codepath is triggered whenever a new offloaded state is created.

Fixes: ffdb5211da1c ("xfrm: Auto-load xfrm offload modules")
Reported-by: syzbot+ca425f44816d749e8eb49755567a75ee48cf4a30@syzkaller.appspotmail.com
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -313,13 +313,14 @@ retry:
 	if ((type && !try_module_get(type->owner)))
 		type = NULL;
 
+	rcu_read_unlock();
+
 	if (!type && try_load) {
 		request_module("xfrm-offload-%d-%d", family, proto);
 		try_load = 0;
 		goto retry;
 	}
 
-	rcu_read_unlock();
 	return type;
 }
 
