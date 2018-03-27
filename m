Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+wMNs0Sd2tTyq02f2dGsxX+EER9VwdMWPccEd7eM8SSV7evAhAViODcHenFq6G06ZAcTd0
ARC-Seal: i=1; a=rsa-sha256; t=1522168390; cv=none;
        d=google.com; s=arc-20160816;
        b=SKF6+SDcApXHGMNFtYDnw3mjOoIfaRumsHPQpiruSdlS/7oo0iQpI2XyqMu5eOk0df
         hpT19KhngzzvFI/5vjwQRDDvqwAs2mBXLJKJvu2i5GbuwqCUaHBy1jSLlmoZGHBBnY5i
         Z41Q7IHXjaJYqvSx8O0PQ6WxdZWsNP9YsWuFWtNrauieX6FxbMAksgQ0P05ooGuW9hJ/
         91XP0oPI9xW5cngjOw2yXi/Rt1hhj95kn0kntq4x4+xN2AWhO1dW1yM5u1T7OeTTbrcs
         wYU5jsOzZaXBbX44R4A+skKCzAmiH7HN+iPIiVmD35im/AhUplzWJN4LqHrid6yqb0Qs
         enQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+Rx5gR4mY+GXPJQxtA7Iuk+ev6aQqoZrnq9+cgo1kjw=;
        b=bKOPcRn8dwWOmWTmtRw+ywZiY4uzzjhfsn0CsJXUp9Mn0lz9CYXMilAqt0Ky3KaE9G
         CK7XKN+dN/0uSnmMXgvH9kexSOioyCNipWq0t4/6vw2dYNT1bGdMVlxv+NprZhpvGY3r
         Lns2DXhpZwnkDP5QTxhwlYxKX50fy2xg0KmXydvonS4lrs0GBrm6PWhgXDb1yAwJjyeP
         ChwBlt6FP54IN4EqP1TcqYEjxYF8GkAMiSGysMWJbmmoJ84GkY1gdIkn+CGMoGOBP8Pf
         AxeJUBU6cgVEpUrOweNCC/T9Nsj1//FvJEZProjmzyOkzOQ/LD+VFLDoDyCUUeTKe/3a
         PTWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.9 62/67] signal/testing: Dont look for __SI_FAULT in userspace
Date: Tue, 27 Mar 2018 18:27:54 +0200
Message-Id: <20180327162731.072188869@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109242041081736?=
X-GMAIL-MSGID: =?utf-8?q?1596109242041081736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit d12fe87e62d773e81e0cb3a123c5a480a10d7d91 upstream.

Fix the debug print statements in these tests where they reference
si_codes and in particular __SI_FAULT.  __SI_FAULT is a kernel
internal value and should never be seen by userspace.

While I am in there also fix si_code_str.  si_codes are an enumeration
there are not a bitmap so == and not & is the apropriate operation to
test for an si_code.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 5f23f6d082a9 ("x86/pkeys: Add self-tests")
Fixes: e754aedc26ef ("x86/mpx, selftests: Add MPX self test")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/mpx-mini-test.c   |    3 +--
 tools/testing/selftests/x86/protection_keys.c |   13 ++++++-------
 2 files changed, 7 insertions(+), 9 deletions(-)

--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -419,8 +419,7 @@ void handler(int signum, siginfo_t *si,
 		br_count++;
 		dprintf1("#BR 0x%jx (total seen: %d)\n", status, br_count);
 
-#define __SI_FAULT      (3 << 16)
-#define SEGV_BNDERR     (__SI_FAULT|3)  /* failed address bound checks */
+#define SEGV_BNDERR     3  /* failed address bound checks */
 
 		dprintf2("Saw a #BR! status 0x%jx at %016lx br_reason: %jx\n",
 				status, ip, br_reason);
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -224,19 +224,18 @@ void dump_mem(void *dumpme, int len_byte
 	}
 }
 
-#define __SI_FAULT      (3 << 16)
-#define SEGV_BNDERR     (__SI_FAULT|3)  /* failed address bound checks */
-#define SEGV_PKUERR     (__SI_FAULT|4)
+#define SEGV_BNDERR     3  /* failed address bound checks */
+#define SEGV_PKUERR     4
 
 static char *si_code_str(int si_code)
 {
-	if (si_code & SEGV_MAPERR)
+	if (si_code == SEGV_MAPERR)
 		return "SEGV_MAPERR";
-	if (si_code & SEGV_ACCERR)
+	if (si_code == SEGV_ACCERR)
 		return "SEGV_ACCERR";
-	if (si_code & SEGV_BNDERR)
+	if (si_code == SEGV_BNDERR)
 		return "SEGV_BNDERR";
-	if (si_code & SEGV_PKUERR)
+	if (si_code == SEGV_PKUERR)
 		return "SEGV_PKUERR";
 	return "UNKNOWN";
 }
