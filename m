Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226y6gIq+b1TYXNbXElZhbgPQBTD9SaeIvcduKMA7IwskiNELJh3w+6Jhzg33FuAfO87gGAD
ARC-Seal: i=1; a=rsa-sha256; t=1519217755; cv=none;
        d=google.com; s=arc-20160816;
        b=J2KZ7KVI+U7piK5W6tqOlR9GiKm7baOJ9atkOfaCWCMtyqTmc/76w/q8H4Jb7ozMaH
         ALkCwjI/Sz3VrpU5s8jj7QY5gziqfdmhZ0f9pKtLb9iprJ2wW98QA+7ZtVK2rLYWVQTk
         3yORwlTbZPeappT1wC3UUlW3Ck99LX4ThnYipPZZ8oehEOh6P92R2mw84XND0EeE1WYG
         HXw4iPRF56Bdqcy45lO+68Xp5FoezaY17IDvbXxfLi/XneIpvuqpvpngsMbNRXq7miWG
         qsIvPDV/SGGrsduN6fEBB7s0SBIbf1svyoJinpBYWuOUExRv/gWiX35sapCKI2OF9zkR
         Tk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xsqZ/KbMe8WfbzIHphiM3G07OeWYaW08T9nf12ntvnU=;
        b=a4K1X1QBVdWI7vjEGYLEkgmoLiFOc/c3fQfr6p3Q7iBMJJj4uBHjB3Ei+QohUQ040G
         obj2btzj79dDKyTX0wlM2FytDqTn9lWUdjnViBWsOLkKEyQX6z/Vf+Ruaz6ZRKJTAhWv
         7UeXAfLwPtebxR4FrYA//d8X68uq8r2IfrC+wtZ18tw/XwlTeAivV5pE8JZfhNz9MST5
         kw7M8MRZaLKWnnDZmFphkLOY2O1GSJqvhadgORaqkdXqYblM6EJFsj+42OWgHV8LEMAw
         fMTyEWiWVT5VkUdThM415nQTZ05GTlriPLevWoJ5t+yCxQatI2tu21VM3E6r7yyGDLXN
         q+lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eugene Syromiatnikov <esyr@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 42/77] s390: fix handling of -1 in set{,fs}[gu]id16 syscalls
Date: Wed, 21 Feb 2018 13:48:51 +0100
Message-Id: <20180221124433.964726137@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014683983574350?=
X-GMAIL-MSGID: =?utf-8?q?1593015277442871817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
