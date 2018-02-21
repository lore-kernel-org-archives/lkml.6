Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225tKtCbNv890gi08nhw6HKMwc1zdD5uD2PT64CWo8PnD/ZpKw8765wnVIwLUPzWFeq5g79u
ARC-Seal: i=1; a=rsa-sha256; t=1519218497; cv=none;
        d=google.com; s=arc-20160816;
        b=pNL49+Uy13euGhuYFHvbxzUcnnJLKRETMdaflX8iESdL5/5qV0S3wR8F/KZhTZ8C9h
         KAbM1BfFTwGTYXAEsCXjK+YkJjAgpvApDMDw5kkS4Ie9LeAykjaBIf0wVGbgbn1ZXW24
         0flXZhnaPZ1yS85RWjXlAfiyh4Z9gKIYOybMtW/9O3Wn+aO3xTLcn1cM/PwS0puYOerP
         9VmrndJagpOR670vuHprxwT7Of4b59OXUnUeEDwBFWVmeh4gXi8tVJhcnqEBnXNiHIiK
         VEHFB21g/3+o4/idtm1Qf61CtIGyfXsVmSMDpvMnFrpHRFU/T6aG7Lqsd1sT1/OPDrLX
         hROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XCWJnXnAfZSyXdwhsdIpbKnJ7M41/bIkq5X4+cIu9nQ=;
        b=FHiWiucY9mmfmg0gNLmKOaZP6CaCa/m23fbYJmkCpvypOzSCSErvvaRI6Pu8cSQkp0
         6OnEj+irT2yCebsFfRt29RRCEY5VgaXG+/eDe9YE5WIXQHO1jW+c+Bs6dOiTUaQubSiD
         HkyKyrcIM/Bolj8rIcieEIdo7skfTTHROUESoJGsxCzUl1uEJwoMXEwgujDYlJ7AIx0Q
         +yi1lVqjaH3Ons58h4BlOklKar2b5uU1x/bwsBAi2YmFB/LAh8IUMTSpLaZq7qDOA6ib
         S8cmEIdTBe1UGwINEMRYuw1/FOGlmiQlVD7MN5l3hWywznUvMWOmX0+Y3JX1tVRoGMcL
         4Vzw==
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
Subject: [PATCH 4.15 026/163] s390: fix handling of -1 in set{,fs}[gu]id16 syscalls
Date: Wed, 21 Feb 2018 13:47:35 +0100
Message-Id: <20180221124531.659085883@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014683983574350?=
X-GMAIL-MSGID: =?utf-8?q?1593016055799239298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
