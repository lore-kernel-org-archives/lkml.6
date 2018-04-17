Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49PKBOsMThRFdsFT+pFRBCKe/klr6cpad/8isxvsW0O6faKI/CO7566Oj9HVfQJA6peDIDY
ARC-Seal: i=1; a=rsa-sha256; t=1523981141; cv=none;
        d=google.com; s=arc-20160816;
        b=cHHg1Rtta6vOR2sO6Y7QhhmpAjBOhDoEE6ZKDIoliNC/RvpZkkpUbgU6Yvx8V4bBQh
         wgxbyigGHXmo0LyF+YJ0SFLl3nvo27EqRvXoWmx4KLxTbTv6opTgWfElWBNRMHRN7f7d
         7q8xZQv9+PmJpbTPHt60mLISmtE1wJX1wNSWcmx1PLCdPMAOZSIOSPyVq4Y+K/NnH23G
         +kgHZTD09cASkO2rHn0+xgYjaYSHHXIF9G4UB07Rto2v8fnAFnnxWkK6fQ0YvT3nwR/O
         4NLCXHuc7UNfv7Sfcy1ItmZqyQOYqJLRiT6126odAgA6HcfRomtzRK3shJ4gRHal2nE9
         vMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e0K9vNoVX3Yts1EUPlL7X3Orx8jDV+fcXdeG8R92zDQ=;
        b=MQZm13yyJpf/mN/mZJDtrnB07etAfu2tf5gHFubHcoGC9dOWa3DcUZ/vnJRImGIxWg
         e9nwLeGVJZcwqY77gUs+3m7oILH9aLZJGNT94qQL2VB4RhZK3ArHhTyYFpbCvWMUz7wX
         lA4P1y/c+1xWn8sEaTz7cfTW5odkSaQR/667iUnrdqD7G6JThAF+UwshKiASRoDjmKZB
         TuJIDBzKvlj5XGEevKDAO4X/WfIuuVN2SKrwVSRz2+Box5eNVtEO9OdnyI7vFT6crZzb
         5jQ0XtMjKYCfywnVBPAwRKkmtZKgoDEzZIOxxxCwZhj2X6jitHe/DtayN/8Ja24fzNH5
         nVRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.15 40/53] apparmor: fix resource audit messages when auditing peer
Date: Tue, 17 Apr 2018 17:59:05 +0200
Message-Id: <20180417155725.064377968@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009833879299855?=
X-GMAIL-MSGID: =?utf-8?q?1598010049677829862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit b5beb07ad32ab533027aa988d96a44965ec116f7 upstream.

Resource auditing is using the peer field which is not available
when the rlim data struct is used, because it is a different element
of the same union. Accessing peer during resource auditing could
cause garbage log entries or even oops the kernel.

Move the rlim data block into the same struct as the peer field
so they can be used together.

CC: <stable@vger.kernel.org>
Fixes: 86b92cb782b3 ("apparmor: move resource checks to using labels")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/include/audit.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -126,6 +126,10 @@ struct apparmor_audit_data {
 					const char *target;
 					kuid_t ouid;
 				} fs;
+				struct {
+					int rlim;
+					unsigned long max;
+				} rlim;
 				int signal;
 			};
 		};
@@ -135,10 +139,6 @@ struct apparmor_audit_data {
 			long pos;
 		} iface;
 		struct {
-			int rlim;
-			unsigned long max;
-		} rlim;
-		struct {
 			const char *src_name;
 			const char *type;
 			const char *trans;
