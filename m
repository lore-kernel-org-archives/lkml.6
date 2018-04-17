Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49QWq01y7U98uEHY+DMyKM4SWg1hPs8DbMXTXbqu37knml+s2QEMLYV03PxzLd79cZgy3fK
ARC-Seal: i=1; a=rsa-sha256; t=1523980936; cv=none;
        d=google.com; s=arc-20160816;
        b=npDpy392TGiharuHynHzFEdDpWvYMoPtmUd7W9YE9aV8Kumv6N7TYS7kzl2HQBTa6H
         1JAL894bnYmSAKRnZBsLkzFapPqODrH/3EK0OWAhl7IgaI+6XmFEGKvmyU/uh9ig/QHt
         +ToexNgVsfIsLS9PduJ8wwFFu8Uh4HDnVaKms9uDNSFhyLpx95W464qmDSxwCPmQvh9E
         fsdoDnJxKcE/HN2PiWeIYJEN46pEatlyXciyiiI3Bw4JAQa9hWVvGnRUI2F9ZDa1qgbT
         vv9h03NxSjPQTQ9KFDYcxw8MeKF89eJeALnodsbnYAhTZZix97V3XCsXHyEzmn3kaKCA
         CiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q77oqTzpPCtLWuzPi/qPbibkCXy4KOTvHtyEMIxUmr8=;
        b=mgmZIUqVLGoFn1+goLqdxmRTVsRJle8Ct1pIkwX76D3kA1vLmepJN9RWtq3/Q85WoA
         DMmU6b/1ipRYEYgO5Z0pnPGmHWs169qQRo6IRUIEdydxlWCgA62Gbg2IUjmVwtwirmjt
         5SZBaFmF2R2+TwdHtx27kSZ9W0avb6D2Idkg2HQ1oGSI3JRAPyBwPGQ3NFc4rNPJcc5D
         LvG8F22tFg32H3o8LqS55LJR0WUgpLOjgx1Znulx4PEkuA8bhjUUAPNOGGE5k3hOvhwc
         v5f67MvZ4PvMDBVekK3/xU+0K6OfDoqzgC5RCK859yuatv5mKlSTWEq2qC8y/SrGA5T3
         QblQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.16 56/68] apparmor: fix resource audit messages when auditing peer
Date: Tue, 17 Apr 2018 17:58:09 +0200
Message-Id: <20180417155751.619661191@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009833879299855?=
X-GMAIL-MSGID: =?utf-8?q?1598009833879299855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
