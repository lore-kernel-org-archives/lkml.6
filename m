Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226CggzDC9+LU7tByEKoEaUY/bD+TSeI+hWJgCbTZ35qi9SsjGKBPIjRnNmLRBNrFUlRLTqM
ARC-Seal: i=1; a=rsa-sha256; t=1518709124; cv=none;
        d=google.com; s=arc-20160816;
        b=sHchQj3DvLhwvW4tAl8ZQlYAFvcqqs5MqYKztLcedk02v/0+emRroLWduu1oxNs4X+
         vu71fLCUI8+e8tbBsRuIwM8HK20xgDfs9D0vPhETP3Hiuj4X6uj7zmNvO69BtgjE7xc5
         wc9ZH4vFlFaSJlCzVkxGSHUujH7e6B7ZUwA+fdKDzk6f1UJG++wDQN7kn6nWeNd6/oG+
         ZGAwc4LRUZ4dQbrwdgJvlKDvgux4/7niZJkVkXyvZ5MnxwRA4kz+rvpEGG9eWDaMpZFK
         j75WqB2MsML9pZRLQGF8V5PJoBfr3iaNbo41IvjnpLwnRrGfqmmnH0pNZebkEU+iu2Ek
         cFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9UYiwiJENYqwviVdNhXatg4UdkHuGQ/8hg+DGINCF3w=;
        b=EuUEZ0uYn7m0AJAu76lgLbG84vadC4F7pTjanKDuzZbf19GpVhVnTb0VI//yVZRIc2
         9sA2PZsuUdfXUzBWNg9Xyz9u4fXyitk9fcqHToSYDBqUkX1g4SDPSyP5JI+zWsya+Xlg
         Wwlk9g7BjmYcK6jaSDbVj5owSGsLYObOFlk2RMAwIbduJOxxaMaunnojA92o/wDTn6Iw
         RsU9iIZ2ngDu29A2lcbNFhgKTF6rPVfgXbtNRJoPTMGodIqz8JqP4KZH6T9vzGDt3FyX
         0SwI8++jsVzDqhXjvxjv2NBc0rroxS8FA8ded66DkCDRq9Qm6lC169o/ChSJFD16blx4
         Tftw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 165/195] alpha: osf_sys.c: fix put_tv32 regression
Date: Thu, 15 Feb 2018 16:17:36 +0100
Message-Id: <20180215151714.224277923@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481938695969135?=
X-GMAIL-MSGID: =?utf-8?q?1592481938695969135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 47669fb6b5951d0e09fc99719653e0ac92b50b99 upstream.

There was a typo in the new version of put_tv32() that caused an unguarded
access of a user space pointer, and failed to return the correct result in
gettimeofday(), wait4(), usleep_thread() and old_adjtimex().

This fixes it to give the correct behavior again.

Fixes: 1cc6c4635e9f ("osf_sys.c: switch handling of timeval32/itimerval32 to copy_{to,from}_user()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/osf_sys.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -964,8 +964,8 @@ static inline long
 put_tv32(struct timeval32 __user *o, struct timeval *i)
 {
 	return copy_to_user(o, &(struct timeval32){
-				.tv_sec = o->tv_sec,
-				.tv_usec = o->tv_usec},
+				.tv_sec = i->tv_sec,
+				.tv_usec = i->tv_usec},
 			    sizeof(struct timeval32));
 }
 
