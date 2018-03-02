Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519981321-2-547810571500370932
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981321; b=nx0VcT0mhukfaBQ243PLtvi/1FrdQgWnaymGf215+NMM51l
    t1TuYcaWLbXxhhuD8JERMXGz7CYN/voIhhTT04UwXFO11/gyT+6YgmoJFuBOLHSr
    SJycgKLX/vGqn5qMWsUVzwfyWxvwzOyXszed7Ylc/bFe9g3OcH8AfJXIwFglmRLu
    B+Lp6KFfzTFLHj6Vi3iN2i+d5taEUj0cAIsTSuGXoBJ2So5WZHJu6zYmyfNKuB08
    vbEYT7aQBvfrdUJkZNBZEBj3T0z1CLfe+j3k16ikV+VHvvuslIPYNTznr0WDwSYA
    oIZBbzgazoawvTaeH6TgrbOuZpFavHiGG6lUfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981321; bh=Sd8keOvDx2mt+cTw5aqrQIqzQi
    UTmQnEPnrWzoPE1IE=; b=q17krb7bPAhDyZGSBf4Y4eeKXbJwcBjBM/iWWuUCJt
    Pvg2f6jAyUxIPbD7znlqeGAUmTwnKa3esU+oinG9zF/tmuOpS2JIpTQYL866qsdl
    4yDcHPDpwzCHuCHI/NWOz8eG2bR4XEVAbEZdLEU58seSOPEa04g6/Y2bMjrMNdO9
    jbtgF1mpX04MNcNebw51/OmJ9hp+rSJ4k9Tcq28uTI80LSs/KNo0JNscoZT+Rzef
    cLTMPRBOuhSVkRJPR3nW1GlMSs5DPvqzGXRdO7heMy0L7FRsz3j+1/QeKjkvkl7U
    I6brNNeXfYoT2BJEP1nJrjjZipPZdcEanANL7h0U2agw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424795AbeCBJB7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:01:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424433AbeCBJB5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:01:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 055/115] netfilter: nf_tables: fix potential NULL-ptr deref in nf_tables_dump_obj_done()
Date: Fri,  2 Mar 2018 09:50:58 +0100
Message-Id: <20180302084506.107331139@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>


[ Upstream commit 8bea728dce8972e534e6b99fd550f7b5cc3864e8 ]

If there is no NFTA_OBJ_TABLE and NFTA_OBJ_TYPE, the c.data will be NULL in
nf_tables_getobj(). So before free filter->table in nf_tables_dump_obj_done(),
we need to check if filter is NULL first.

Fixes: e46abbcc05aa ("netfilter: nf_tables: Allow table names of up to 255 chars")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4596,8 +4596,10 @@ static int nf_tables_dump_obj_done(struc
 {
 	struct nft_obj_filter *filter = cb->data;
 
-	kfree(filter->table);
-	kfree(filter);
+	if (filter) {
+		kfree(filter->table);
+		kfree(filter);
+	}
 
 	return 0;
 }
