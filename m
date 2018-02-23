Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519416445-2-6205736458876871211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519416445; b=Ioj15O6MPwlLPAO/3gbKADqW2otM04votQUb5ayQz7GYKLx
    YArG5F/7W6d1o2hSqCa7g3h3sXbwoD6Ta+ACzFgi8vzyzFsZQukUc827r3gwT30J
    tSvk1JJ0ZNR3BHI82lootvWSUbMMQeOm4Eh4J1NAoLwJZtLnQmop7XCG4je8jDwT
    O53uET+RP3v7XhAqcDfXDkDfhY1BWGSmhIs93P4XEoW0cAk9oaO5kHlXy7rB8lgy
    bIPRhX3UtpkoZ+oeOn2duN2cfkgihHh+wmK4TXQiZTI7C9o09qDxbKcBtWRj/zxB
    vVJjlKy+0yUzY7T0UX/erf2r3zCddK1r1LD7J1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416445; bh=rds9WsaNyHcs/6DJWnfH8Gq/yQ
    nfNeAobPgoZn/0l9k=; b=LnKtVEv6PgechhPFdtnMbBNUEWFY2tUn+RQ96JBiqJ
    DIx/lcKMZM2cr8t6T4UZiP6bjQ/vYhR9AgDeAITeueodMzAnZF2rb8Lq+wgGXAW2
    MaLbDPGTZujW41KD4+M5CcVMfQiasXDgdu5vmTMzsAX3r496RlnvKgCpNRCsNm1S
    PoV2TQHjzdgIjCIE+pXW6QrQ+Aq4gpmXm30X2zUp6/nHjHRzNgkYvc11PV1d3LGj
    X5tGe/gQsWauv45eoIB2giKaYlRMa1lZUrWlC2ytYyFfldUcKxhzjoedoHy9Iv9P
    5W92X3Md0HBj7zaPebBpW6NNvrijBkyPdQ9oPRwIzbeA==
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
        id S1755111AbeBWUHO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:07:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932769AbeBWSmy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1ddfb3357e1d7bb5b5d3@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 004/145] cfg80211: check dev_set_name() return value
Date: Fri, 23 Feb 2018 19:25:10 +0100
Message-Id: <20180223170725.307645045@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

commit 59b179b48ce2a6076448a44531242ac2b3f6cef2 upstream.

syzbot reported a warning from rfkill_alloc(), and after a while
I think that the reason is that it was doing fault injection and
the dev_set_name() failed, leaving the name NULL, and we didn't
check the return value and got to rfkill_alloc() with a NULL name.
Since we really don't want a NULL name, we ought to check the
return value.

Fixes: fb28ad35906a ("net: struct device - replace bus_id with dev_name(), dev_set_name()")
Reported-by: syzbot+1ddfb3357e1d7bb5b5d3@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -421,6 +421,8 @@ struct wiphy *wiphy_new_nm(const struct
 		if (rv)
 			goto use_default_name;
 	} else {
+		int rv;
+
 use_default_name:
 		/* NOTE:  This is *probably* safe w/out holding rtnl because of
 		 * the restrictions on phy names.  Probably this call could
@@ -428,7 +430,11 @@ use_default_name:
 		 * phyX.  But, might should add some locking and check return
 		 * value, and use a different name if this one exists?
 		 */
-		dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
+		rv = dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
+		if (rv < 0) {
+			kfree(rdev);
+			return NULL;
+		}
 	}
 
 	INIT_LIST_HEAD(&rdev->wiphy.wdev_list);
