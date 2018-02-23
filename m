Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519410640-2-2596540347975566581
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519410639; b=PxXMiggojJMyZbcwvxuuMUgMDOpcgJjIZ+y30Jvyhd+B5zs
    xrqbd/LpD+Q6xWm95khWN4We+iJQWNMxIW0ySFiQkvvgvf8bIPtwi1KDPd6oI5KQ
    ej6yDWwTBRLcOxjmVq+GBmEoSL9j5R4IohIJ+NEGjflcn20K30Clj4Mng7IQBzhE
    abiT4xLGuAOc75sTzQfT85qQYwWkHsHPba7hbeUGIGidNXC4iotOoUs7GqQ38ZMY
    RXCEpk2PL67GQbO8ugRiMGPDzZGznvKtxXJdpeqg86cF4Lq6LcJxH+zaYCRiCX0T
    40FqSwFClR0rqddvO0pgpcbBNKqRqSIkjwugyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410639; bh=Hv8M+729u6RP77wpDV2B32Bg9h
    tGnLl40vlteDvpJ+A=; b=xDTSoE/4kcK0b+9DcsnjNKhA6/RNoSz+nf3W5oC1ZV
    Ttz0WcqmMZp8A9AhYceXBVTyCjg4o1+2gh8IG05V/iCiBx5kK6Czr0QoZxRoEmOu
    vR62jCCikzFUevbUNqkEWxPfLlGI4sSSpeH6b91YjMohM0CEdgkQh74rQ/QcOTnk
    +k/Pqwc0WuO8+KGC2iVuwhaPf+rRHZhEeqyBqtAkkY0Qtu0kPPUD47JWc9L4bC4B
    jElX2IsvXYAPkLaaSgpkKQZUODyZf/H9+pUPUMTqHMJqfOwyw4vG7DjlkMBTnsag
    UxWHhubeZPLUy8J3P9l6upMc+f9K/lKggpVo5Xp7FkKw==
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
        id S1752293AbeBWSaf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:30:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34588 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBWSae (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:30:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 3.18 03/58] s390: fix handling of -1 in set{,fs}[gu]id16 syscalls
Date: Fri, 23 Feb 2018 19:26:02 +0100
Message-Id: <20180223170207.193044849@linuxfoundation.org>
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

From: Eugene Syromiatnikov <esyr@redhat.com>

commit 6dd0d2d22aa363fec075cb2577ba273ac8462e94 upstream.

For some reason, the implementation of some 16-bit ID system calls
(namely, setuid16/setgid16 and setfsuid16/setfsgid16) used type cast
instead of low2highgid/low2highuid macros for converting [GU]IDs, which
led to incorrect handling of value of -1 (which ought to be considered
invalid).

Discovered by strace test suite.

Cc: stable@vger.kernel.org
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/compat_linux.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -110,7 +110,7 @@ COMPAT_SYSCALL_DEFINE2(s390_setregid16,
 
 COMPAT_SYSCALL_DEFINE1(s390_setgid16, u16, gid)
 {
-	return sys_setgid((gid_t)gid);
+	return sys_setgid(low2highgid(gid));
 }
 
 COMPAT_SYSCALL_DEFINE2(s390_setreuid16, u16, ruid, u16, euid)
@@ -120,7 +120,7 @@ COMPAT_SYSCALL_DEFINE2(s390_setreuid16,
 
 COMPAT_SYSCALL_DEFINE1(s390_setuid16, u16, uid)
 {
-	return sys_setuid((uid_t)uid);
+	return sys_setuid(low2highuid(uid));
 }
 
 COMPAT_SYSCALL_DEFINE3(s390_setresuid16, u16, ruid, u16, euid, u16, suid)
@@ -173,12 +173,12 @@ COMPAT_SYSCALL_DEFINE3(s390_getresgid16,
 
 COMPAT_SYSCALL_DEFINE1(s390_setfsuid16, u16, uid)
 {
-	return sys_setfsuid((uid_t)uid);
+	return sys_setfsuid(low2highuid(uid));
 }
 
 COMPAT_SYSCALL_DEFINE1(s390_setfsgid16, u16, gid)
 {
-	return sys_setfsgid((gid_t)gid);
+	return sys_setfsgid(low2highgid(gid));
 }
 
 static int groups16_to_user(u16 __user *grouplist, struct group_info *group_info)
