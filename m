Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519416487-2-16523874835147424776
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
    t=1519416486; b=KsOL3CtkgcMsF0DKnxZZ5Rp2xTtxzWvmgoExgw07TyYIsGL
    z4IvY+IS6uDki9TwV3waaS9cZPqBvPzfFskYyP9NHgpnr3d5dr1h8l/ZGErY8msB
    uMx7pDU1A1/MsJOMiW6a/+gJEo9n2k28NxQPP6RyWU7mXwf1kRys5ux5Nifrvhto
    NQKhnZ6eluLPnKLwAAhWjkjv2T3dQozwtIuBEuK6PKSX4HVkYzHCsgjJyW1Jix+P
    ls6amjTKEmrMQypqOd2rCHf8tnh1vECENibvFeeOPof2l+L0jBrCXmtOi/eQznzG
    eYQnoYG4pAzvmj2mou9+4iQ72rclBUt9VghuQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416486; bh=yfVbQbtIQgVMFoZBH2deTnToOu
    kNst57HM9Dfc4h114=; b=W2pgXz++VNYVs/O4SOoiEqiXCS7ALgfjmXj7hVOiRm
    YIhFWRUXnOWOQJmA26HEbIESISwPG0j1XwEqh3NSTFev7KU+mtbVh+akdp7xw+uV
    Z22+nPu7tTK4/caHQk3l1Z44KQdgiSqf62Hk1Jbr4J2w3Es1CWoWjdqmYebY2aND
    hY4HlUW+JSxFezVpXwHLr1kWJQTsWwD4GVAfWkirckG5F3Aa1iR3UgUkW0LtMzkP
    0QWiMvsTKcBFpnI9bZ2xPbsXCBFqau/3Lw9YleSOVndtXJ1z5vaywFLDVfh01iW1
    PynrM5ImMSsKckd0WCpX4WmoEvRdDwnp7wPZd2lZ1kfg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeBWSmj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:42:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeBWSme (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller-bugs@googlegroups.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <james.l.morris@oracle.com>
Subject: [PATCH 4.9 015/145] selinux: skip bounded transition processing if the policy isnt loaded
Date: Fri, 23 Feb 2018 19:25:21 +0100
Message-Id: <20180223170726.643099866@linuxfoundation.org>
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

From: Paul Moore <paul@paul-moore.com>

commit 4b14752ec4e0d87126e636384cf37c8dd9df157c upstream.

We can't do anything reasonable in security_bounded_transition() if we
don't have a policy loaded, and in fact we could run into problems
with some of the code inside expecting a policy.  Fix these problems
like we do many others in security/selinux/ss/services.c by checking
to see if the policy is loaded (ss_initialized) and returning quickly
if it isn't.

Reported-by: syzbot <syzkaller-bugs@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/services.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -854,6 +854,9 @@ int security_bounded_transition(u32 old_
 	int index;
 	int rc;
 
+	if (!ss_initialized)
+		return 0;
+
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
