Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48y0BWLKiorptiw36kagtAGRSdUVdTvSOfLRuToBOUfFd5Slfpw32NbnWUZ76J6cAXuu2sF
ARC-Seal: i=1; a=rsa-sha256; t=1523021394; cv=none;
        d=google.com; s=arc-20160816;
        b=izWwT8RTB2lSkD9FKP6nirCFxvu7PVzXjTZYrSGdzY4FKddMgvOPsqWEgTdppft5LZ
         mxYPKtko6nJ2hwXlZG0bK313vdeo43/YQVv4g5UJwdbR6aYCWRi7iki8HfpeotTjlb92
         DMU+dN42RtXDgdYf0+qM89x8qfRlZV4TegQH7CjYFAe2X3MUeMxVNUO7X8GSh0zShqyD
         W0ZDWR5e0IBnKyz0d9lj6UKr6cgSa2y5hGKEYZp5AYN0qLi9QcqM0tWZqDJ9wlxqExnR
         kHkRG5ef8Y3+XQflR1MuP6kyudJV69LDBdOLrEmpaJ1sXGF5Nq948/R3k4SEm+A7IQRS
         EOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=We3ho7eDbKnIQM8zPez9fOLDjfm4axdre/yOvkkdgwY=;
        b=AXZnthClJF2FnYTF4+AWd/urHRFWmEqUKzTZwoXt1h6vHssVZ94Xrrwq8PGKvkuyCV
         OfcnrT0TKeObV15tridWQZJvkSbNZwXsWZiPCKjW6YSI5+5JkKFym01aoxU6sscwWMiD
         lVzBlvYOGS+KQrS6fidsvkgUIAwOGAR70HHsCJl1BXzlidDaQ7Iv1HW6JMwqlIX5Lz9U
         /dEypAhkiJlrwG+mgbIyApyHFiSTx7GHTWeX5zOHziTT/O4QGbNBAbNyi6P4dbdTXZRS
         vxqNgH3xduOpNICsBY1kb6L1sGO4SyG3V7UVl5NmLzhieDc9tevokYzgkT8hVGhqnMN+
         nANw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Charlebois <charlebm@gmail.com>,
	Behan Webster <behanw@converseincode.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 21/72] fs: compat: Remove warning from COMPATIBLE_IOCTL
Date: Fri,  6 Apr 2018 15:23:22 +0200
Message-Id: <20180406084306.917330581@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003681793972685?=
X-GMAIL-MSGID: =?utf-8?q?1597003681793972685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Charlebois <charlebm@gmail.com>

commit 9280cdd6fe5b8287a726d24cc1d558b96c8491d7 upstream.

cmd in COMPATIBLE_IOCTL is always a u32, so cast it so there isn't a
warning about an overflow in XFORM.

From: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/compat_ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -811,7 +811,7 @@ static int compat_ioctl_preallocate(stru
  */
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
 
-#define COMPATIBLE_IOCTL(cmd) XFORM(cmd),
+#define COMPATIBLE_IOCTL(cmd) XFORM((u32)cmd),
 /* ioctl should not be warned about even if it's not implemented.
    Valid reasons to use this:
    - It is implemented with ->compat_ioctl on some device, but programs
