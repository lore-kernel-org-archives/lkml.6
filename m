Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+pHMeHqzj9ucw6CAoqKRWPUbiYe7TVllVJiyPXMCWhCZqjkxVnPv7QqLN5jl0SjrKUdQBS
ARC-Seal: i=1; a=rsa-sha256; t=1523021406; cv=none;
        d=google.com; s=arc-20160816;
        b=H16b+evcX8sEP784LCSTRIZrwugS6vV4WNFgDmZiFRGtdFRXfAfiLGYRf0La3v6XVv
         LU1FMbbjHFlLe9XCRRco0YPcXqLlTdjU0vO2R03Pp0TMPtRlcqWglXNJ8NO5kgCux2pX
         BFWlOaCjwdijP4Hhd0gCLXQf8LBrOVaNPDLSgZnfD8MhwtqCKDK4qqzCotrQhZZpYRlN
         8bgZSf8UPXBbfQKKcQdu3WCO90HQOorzxh9RV75BdbfqQFA9aAHiLVn2U7jGS6q9C2vn
         BhRw8fp1D3w43/4iZOV/eje0SdlMR1b7ynyCerIfBju6ttfzrJU9/EwHbvhsUKvpXUXN
         Sw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XA9MBJCJItEvOUGfXkFhKZx7mvE6RFsFpbk8Z3YtV9c=;
        b=MY+2NkmrrHo52AMLqWyZowgSpmRnucxfdd/atqICcU0V+cpziME+AFvaqQelLZxUxA
         uYmq3MDZlVI6SG7GKqwxXdz2W5X1lUwPduSgaBHjth8IC6h/O4nWXHZw0ExbeoXy1W4i
         rFDuGOfJD74rNRVncsD78+Y4bvxJeKfJBMBgsdcIySOXzjF2mT66i8Hq1o3LJmGsoZ38
         UZBzWN6E3eYrQWMPVsL0OxsNsa4lQQV4xZec0/WoPPj2Eybcrk7mHV8/U9EkSTIRm/fE
         +te1seC2DJWgdT5xXP+LYn8q4BF6Ul4iRTrMhxkZzHJrjFyLkRDH2VLoX57qbIegezjY
         mOvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Moore <paul@paul-moore.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 25/72] tty: provide tty_name() even without CONFIG_TTY
Date: Fri,  6 Apr 2018 15:23:26 +0200
Message-Id: <20180406084307.255486826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003694584907676?=
X-GMAIL-MSGID: =?utf-8?q?1597003694584907676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 188e3c5cd2b672620291e64a21f1598fe91e40b6 upstream.

The audit subsystem just started printing the name of the tty,
but that causes a build failure when CONFIG_TTY is disabled:

kernel/built-in.o: In function `audit_log_task_info':
memremap.c:(.text+0x5e34c): undefined reference to `tty_name'
kernel/built-in.o: In function `audit_set_loginuid':
memremap.c:(.text+0x63b34): undefined reference to `tty_name'

This adds tty_name() to the list of functions that are provided
as trivial stubs in that configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: db0a6fb5d97a ("audit: add tty field to LOGIN event")
Signed-off-by: Paul Moore <paul@paul-moore.com>
[natechancellor: tty_paranoia_check still exists]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/tty.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -372,6 +372,7 @@ extern void proc_clear_tty(struct task_s
 extern struct tty_struct *get_current_tty(void);
 /* tty_io.c */
 extern int __init tty_init(void);
+extern const char *tty_name(const struct tty_struct *tty);
 #else
 static inline void console_init(void)
 { }
@@ -392,6 +393,8 @@ static inline struct tty_struct *get_cur
 /* tty_io.c */
 static inline int __init tty_init(void)
 { return 0; }
+static inline const char *tty_name(const struct tty_struct *tty)
+{ return "(none)"; }
 #endif
 
 extern void tty_write_flush(struct tty_struct *);
@@ -420,7 +423,6 @@ static inline struct tty_struct *tty_kre
 
 extern int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
 			      const char *routine);
-extern const char *tty_name(const struct tty_struct *tty);
 extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
 extern int __tty_check_change(struct tty_struct *tty, int sig);
 extern int tty_check_change(struct tty_struct *tty);
