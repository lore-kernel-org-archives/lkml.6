Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225dyhI87sAxeCcMBJ2VkVq9+k5Pke+Oe+0j7hC+FEe9JQ+JpikhAfYpKRurwX/bBpEKUqEY
ARC-Seal: i=1; a=rsa-sha256; t=1519217922; cv=none;
        d=google.com; s=arc-20160816;
        b=OSAMwggjTk1y0vr0sGN/eoly74PJEsyRYpSaWypY47Hsaz7F9RufV0plbBCFll51e6
         hPo3Zwgyyr6QPqWsk5qroHA+Vjh7Ehd5KN8mdr0WPjoq7uQ/ORZWw+wWAksu20D/SGKE
         rD6jQqWAnO5xLL/ZPD3UQwj562qKDip1VrRM4QyOpf1V52INm4HEBfeuiyc/rinR4bKH
         jvxSJrmIBgh0c9HnmL8y0O25gHzyHuYDp1EXDUEaBsdfAPUOVji7UUif3RVeP3SFeM3i
         CjNsd94Qu3PEHknobGpeIgajo227TyVVvCicWRbXITRCNtiyeoNMklis9cpEVn/Zfssv
         Iekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KbVLJWM0lAxA1TP595FTro2I0QE3q5I1GANigiKcupE=;
        b=WObzOadvQQ/ia4pzfYCInTva3BTXIRsQUn2lHE2gBcJ6eyKypiMjkLUTFZVaX4ZjEa
         DpjCv+/d4HCkqVs0mjf5Dpf8ISBaQdwjeONcNJ9Upqln+tWLukNoS0iPBS4l3pSPcluA
         pbwoRxFgAfkvjVMMkMFk93zIxUTnjoBO90NYT4FQgJ86oeNpS/iEi2vMYPGnXjx2LmLy
         iitVsT+DOgaTKGttSQLBedjWErpoNCFHX43H90kYq26jtV9oPL8nr1RR+0wpgrl3EKjt
         6ko4bmI2kbcZPNtsCjg/vU3LeOu7p8Ce5MSm/NikAB8+KBcre2TldQoE+MeFppV23nZe
         U8Rw==
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
Subject: [PATCH 4.14 025/167] s390: fix handling of -1 in set{,fs}[gu]id16 syscalls
Date: Wed, 21 Feb 2018 13:47:16 +0100
Message-Id: <20180221124525.983812041@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014683983574350?=
X-GMAIL-MSGID: =?utf-8?q?1593015452233341958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
