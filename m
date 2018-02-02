Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591826-2-9304891051445976382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591826; b=NT4di1uJ9zY7Ix8WwdPGTPnEZoQAf74uNYpSLAp8CqdHln0
    g/bJMuVvYFaRN9NHlZ2epylNPfVtAbSq/sco/MjkUIDLwZxY+CSwk3XcKFciqm3G
    1WO5aU61BXPSrZSBon5qnvucN9kJOB5++D6xUo7/87woqd2UgmhUJB3KqMaQramE
    Vdb7ZkbRkM6UsbCFNMkHBqVt7ukWElDqR6S5SJiD37kaUDMH0xeVBme1JyDoaSVn
    Qq37ljwNpRsQFPU1yPYnNHp/gVJYW6yOe2MaU4O+mGBpxnRxUR11t7rowK9gyMit
    i/gF7Y4Qt7xaiLyZBQjQ2e3/lCegc0N/g3VPCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591826; bh=UMTtu99kDFWcoJq54MftRi3cvz
    F2Edgew8Tnj63snvA=; b=by9Q995Thxs2JoDdDdyqf0R1TJYk36T5ivlPzRAXSI
    WBznUU2lCtPVvzcs/L0pN9IDIxVepD0aoBAHU0gfY9k7B4liLcgXwINFv73h7f42
    qY7YsU3l/pEUP9rKX5yNHPfqQZBOAgzdkN3X04YlmW6OXe1LBDPAn0REcFla9wvx
    z/j0RsONY9K6FDbx8SzIf0MJfTC/gvslGnxoCpobBZVROm2iUL8kRHtxApmt6Zwe
    7OHe5eJjU06Rni7j1alBT380n1ykmymwByIkX2BP60a1MwXhj1fuewa1rKhpfkzV
    agRYE5NGMz5V/L74om7Kk011zQruEehaW4FWl3ynz+Zg==
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
        id S1753629AbeBBRQ5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:16:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbeBBRQr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:16:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 4.15 23/55] ima/policy: fix parsing of fsuuid
Date: Fri,  2 Feb 2018 17:58:41 +0100
Message-Id: <20180202140828.602792229@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

commit 36447456e1cca853188505f2a964dbbeacfc7a7a upstream.

The switch to uuid_t invereted the logic of verfication that &entry->fsuuid
is zero during parsing of "fsuuid=" rule. Instead of making sure the
&entry->fsuuid field is not attempted to be overwritten, we bail out for
perfectly correct rule.

Fixes: 787d8c530af7 ("ima/policy: switch to use uuid_t")
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/ima/ima_policy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -743,7 +743,7 @@ static int ima_parse_rule(char *rule, st
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
-			if (uuid_is_null(&entry->fsuuid)) {
+			if (!uuid_is_null(&entry->fsuuid)) {
 				result = -EINVAL;
 				break;
 			}
