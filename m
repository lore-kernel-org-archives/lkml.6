Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/4zJTsF51mcZ5mFLiB3xC8j1soeJs1MbCBQbz5153P90rl4mds9MjBYBwUq2a2UUBBVLv2
ARC-Seal: i=1; a=rsa-sha256; t=1523981281; cv=none;
        d=google.com; s=arc-20160816;
        b=KtcJCxlAeuO4GOM3Hq/74ORLhoiAFTPxvYnqOK45YXGupIpDIzp68jNu92MgfctbaT
         1CwAMCJ3Br+gcaky28Sdymnx5CxXAabQfb7uVkKzW2tAkg7lt1u4yGS84E2uwl4PTM0J
         NaPbe4B/TEkkqpCNDZHGSxzjQeAMSRCJL9F8X/DTxaPDYgX5xqd5Zp43SnhXZquQMrzc
         y6GobAbO4ps7kB07Uo+fwoGXc0shBxhPOu999cA3qEIn60efbQO8g1pVuTVUSM7p85hU
         Jc6WxQQ3azbxKNGwqURMex2csNoyHHxH+gM+LFuru+d+bVQoSCgtCNYBnNg991a55lCS
         EZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6baTkydM2ocs//sdJBD7RvQWCgkTudrwS7ZvomYNb5c=;
        b=Veo5dt08GQStgnFqScE8Ta8E6bHw7L69p7nMtFg/+XGWKnN10coYnCh8Z97xClpBp2
         4en0UEbnlbdeidj01nu3SPuRyZ2eDKzWlt5wFXtrQB8wgk0ahl7c1lNL3g0m7nt1UbZ2
         n1+XYoFFAUp9F831PloosSqmvA78DDZw3B8XRuig/DVGzOLyOgu2fhMJrXFzaQJBMjkq
         1ZroW+X9ybKh+cmP7h3uUZTRfKtsrO9ql02MIIBLGtD7LJbqwUaPiF6cjzl0r9tg5GJL
         TDwhrTCkW5jzV0exglpYKfmAEWONbLxCKdlsIyB6X/l24zQmfepkeHtHFsI6Uq1zTyXK
         cnQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.14 25/49] apparmor: fix resource audit messages when auditing peer
Date: Tue, 17 Apr 2018 17:59:04 +0200
Message-Id: <20180417155716.223390678@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009833879299855?=
X-GMAIL-MSGID: =?utf-8?q?1598010196381612868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
