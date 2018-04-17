Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+YUFc6gEFz/B9eM34l5w3XGlst10MHDrM/NCcnSEqllAcur+e/7Egy+IWLRP9Zo38g9AVZ
ARC-Seal: i=1; a=rsa-sha256; t=1523981079; cv=none;
        d=google.com; s=arc-20160816;
        b=yvPGJlTZTW5kX9EC9EiYyWoATt1ayuO1tnahAvYFGsGLop+NARzZOWzfspIRfU78xJ
         LDtlxpwSBmWabecLUzbuuGeRBOOJQvEEtSuZ3Yt/u/6s7cxSF67UdljA60NjheyYZ+92
         YyWXSMQIIIpaqr/z3UUthFYW008/kytAu4k/r7Rue2j6XP1m+BSgIaJx71WNzoSIZQTl
         4W7q0Gh40sbIV8RY54FpdXc/fE0qzcYM3vWIqtYf1mMpIDX1UPwEUdrj4+K9+9K51yWp
         VkKLdcpI0Hi16P6yMTaLr0XUBbAoIQQcG4Y+zoI0lEK+fROLVXxoVtfMD+6ANsHxcaKq
         ooqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0v163CqwVBUrHmJe//CfCqwRTymrOoBxcHphQd5dB5o=;
        b=OkGUY9wm8G6JPdd36HBmoTiF0hokj4rNoe+DrfRxGAFeb+4JIvEQA/2Cke2DbVHlck
         sEB3Ju2s0sFR7fnCo3h4B4OTPlhPnRguoKCHdELv6922oKZ9G+q1wOv+FydEumtXYmmk
         YFJNz6MrfNbgmDLyJeDrEqSqWpq1NBtfcwAOyb+lhzLncN8+rK5lbQgKtMlF4VsrXYVU
         h8N/sOaF7H4gJKel1ON71Gm7QXctmUocxnLMajGetbbLi+jiM87u4Voxns/pjr7caLwu
         LAfHi3PCfmy+vo5nZq1m2wlQb6/x5ec9HPkYK7SlDPa3mGIj3jR+noYi9vgV6nmgOkyd
         6O/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.15 38/53] apparmor: fix logging of the existence test for signals
Date: Tue, 17 Apr 2018 17:59:03 +0200
Message-Id: <20180417155724.975046596@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009829328873460?=
X-GMAIL-MSGID: =?utf-8?q?1598009983519267807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 98cf5bbff413eadf1b9cb195a7b80cc61c72a50e upstream.

The existence test is not being properly logged as the signal mapping
maps it to the last entry in the named signal table. This is done
to help catch bugs by making the 0 mapped signal value invalid so
that we can catch the signal value not being filled in.

When fixing the off-by-one comparision logic the reporting of the
existence test was broken, because the logic behind the mapped named
table was hidden. Fix this by adding a define for the name lookup
and using it.

Cc: Stable <stable@vger.kernel.org>
Fixes: f7dc4c9a855a1 ("apparmor: fix off-by-one comparison on MAXMAPPED_SIG")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/include/sig_names.h |    4 +++-
 security/apparmor/ipc.c               |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/security/apparmor/include/sig_names.h
+++ b/security/apparmor/include/sig_names.h
@@ -2,6 +2,8 @@
 
 #define SIGUNKNOWN 0
 #define MAXMAPPED_SIG 35
+#define MAXMAPPED_SIGNAME (MAXMAPPED_SIG + 1)
+
 /* provide a mapping of arch signal to internal signal # for mediation
  * those that are always an alias SIGCLD for SIGCLHD and SIGPOLL for SIGIO
  * map to the same entry those that may/or may not get a separate entry
@@ -56,7 +58,7 @@ static const int sig_map[MAXMAPPED_SIG]
 };
 
 /* this table is ordered post sig_map[sig] mapping */
-static const char *const sig_names[MAXMAPPED_SIG + 1] = {
+static const char *const sig_names[MAXMAPPED_SIGNAME] = {
 	"unknown",
 	"hup",
 	"int",
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -174,7 +174,7 @@ static void audit_signal_cb(struct audit
 			audit_signal_mask(ab, aad(sa)->denied);
 		}
 	}
-	if (aad(sa)->signal < MAXMAPPED_SIG)
+	if (aad(sa)->signal < MAXMAPPED_SIGNAME)
 		audit_log_format(ab, " signal=%s", sig_names[aad(sa)->signal]);
 	else
 		audit_log_format(ab, " signal=rtmin+%d",
