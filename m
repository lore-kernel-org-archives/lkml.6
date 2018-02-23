Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414674-2-15511616705031031690
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
    t=1519414674; b=O6lrKEgNevNOXqeLU2LtLBJsI5htp+g5sAa85S12d01x8Q1
    BP3Mb2XU3jeeYI49GNCVDwccudU+MkOxpJEE6TL4g/kGa7yjtH0P8PQpVTklMfDa
    PSTVm7imu1fIxrf3kotoQqz8r5k0Q8I6EGEjTpasZdKeqPAHjUlTnukjxQYIJarJ
    7FD5vtdAkfIb0J8ra4FzQDHquSJNmx7KAjwNiNxY6JgKDPPLTcqy1Jq8vxiEwDgK
    TLaePmFy9NCK0d06FrkXV5tW87Upkp/sSPS2agU7wS1W7fdpUXz5Sy1/q/eGZoos
    8ca0uEsYMaUHn94UKZI1OrA8U/78Bis0jO0zMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414674; bh=+2zEvDLFXc2r+hnVzrH3IMgCCr
    OSSnywxXqhRXC1tvg=; b=SNL7LAfJWxsLbJ8DctVZyiFsSi6n2nnCpACq7BwJbn
    KJpPUeQ2eaGhKNC8TFnmOdCDDK/j+n9a9mCK1IjLib+3qjt4NVgObmKRYu1cJX1d
    4o9dLO2Zx57+hRoxD7aXgAJohULFzqoLljB0bhfg7XDEk3apbUzYHrURjY24ulsF
    FQ9l9rJd2z7XD/6moRlfl3ok+wffioy2tOCyAKpBA3jASP6bunpUGYxQb7HEM8ue
    2vOjvx+X9Z8sbGS2aI916DaHm/gNf1ZEt/SHVh0B2yvKKw8QS7+Vep8xnAy1ZkEL
    /tPIpwRX0Qyr2Jb/zmtF+S40M2SgXOeriGPh/UE/JZcg==
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
        id S1754222AbeBWThg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:37:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934691AbeBWSuQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:50:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller-bugs@googlegroups.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <james.l.morris@oracle.com>
Subject: [PATCH 4.14 027/159] selinux: skip bounded transition processing if the policy isnt loaded
Date: Fri, 23 Feb 2018 19:25:35 +0100
Message-Id: <20180223170746.479384159@linuxfoundation.org>
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
@@ -867,6 +867,9 @@ int security_bounded_transition(u32 old_
 	int index;
 	int rc;
 
+	if (!ss_initialized)
+		return 0;
+
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
