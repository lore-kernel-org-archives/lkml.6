Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpX9JLQDyPkZRTIScTUaaERqMumbjShbCHvzc+yn+QDITxSOYvaEK/HKfyy80Q5i97BXouY
ARC-Seal: i=1; a=rsa-sha256; t=1525767172; cv=none;
        d=google.com; s=arc-20160816;
        b=xXq4hd/CnavhxU+l2mdLZCWj6t5OaDIHQJG+VkynosIdTgo4360TfRss26RhxYQt7R
         esaX52UZGOLJY2+HW83uZHUsjAjPJsjEa8DK1P20/aiYs4PfKOD2zl+9y2Uqxlk0mMW4
         Xvpu7qupXSo65C6Kf1eAzkKqMbmESOiZ9bqYLMDrYrqT0vXOpJ75Hz7Kb6nEpwzkBvLk
         bHWBl1txYUgKEuGP7AS5P7/1GiWMaD3CPhwKD8VbteRP3tx2nh56YncujzIXajKHN0DT
         j5t+cHIES7oKibY9zBSEbrwGtmAfZtuSBakM/1XCJEhZGcKuvnQIsRbSpnMzzC6A5D+r
         RjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Dahth8dEo7xZrhREzjOuVvYDR3hnJElEJIx6GIWf1Mk=;
        b=X20cEjNKufAowwY9HhyKNb2oTomEi+z5KtlCkQEkyXjAg/Ote0wgDc1TlwS2AbRizd
         HfhLNn67GJcgZ3BIIl36lNTKw0sC7pFCNIJK8PYag2wUT+fpXsb8bHHNxKwMq8uAoheH
         IIcbX+oyoJ9CYpJuVBsQsTlkSzuajUsulGNyl6M8QZ1Dqws7EMT/s6FRLKxKjuYSRahG
         E56OJphbF72I2Wq5AjgdOGR+r6PMBWYX/MwMV5rsHS0CGVzUfIDuQNY4vykqBiKGEHX7
         PlZPPqGu42u/hKFTGyK/rwR/nrdbm6nBGY1kObPWNy0FegZFkpQjbvAmOmNYhuRU6O1X
         oFkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Q0dahv+2;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Q0dahv+2;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 17/52] tools: power/acpi, revert to LD = gcc
Date: Tue,  8 May 2018 10:10:15 +0200
Message-Id: <20180508073930.326668789@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882838267978298?=
X-GMAIL-MSGID: =?utf-8?q?1599882838267978298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

commit 755396163148b50fe1afb4bdd3365e47f3ff7a42 upstream.

Commit 7ed1c1901fe5 (tools: fix cross-compile var clobbering) removed
setting of LD to $(CROSS_COMPILE)gcc. This broke build of acpica
(acpidump) in power/acpi:
 ld: unrecognized option '-D_LINUX'

The tools pass CFLAGS to the linker (incl. -D_LINUX), so revert this
particular change and let LD be $(CC) again. Note that the old behaviour
was a bit different, it used $(CROSS_COMPILE)gcc which was eliminated by
the commit 7ed1c1901fe5. We use $(CC) for that reason.

Fixes: 7ed1c1901fe5 (tools: fix cross-compile var clobbering)
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: 4.16+ <stable@vger.kernel.org> # 4.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/power/acpi/Makefile.config |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -56,6 +56,7 @@ INSTALL_SCRIPT = ${INSTALL_PROGRAM}
 # to compile vs uClibc, that can be done here as well.
 CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
 CROSS_COMPILE ?= $(CROSS)
+LD = $(CC)
 HOSTCC = gcc
 
 # check if compiler option is supported
