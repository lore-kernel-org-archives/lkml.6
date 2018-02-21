Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226VLUSEZoVxsJyCOBv/icpf5MuQUow7OaLk70Mo/ypQEHxwrQYMD3Tw1JN13mN8x2k3/Ydc
ARC-Seal: i=1; a=rsa-sha256; t=1519217822; cv=none;
        d=google.com; s=arc-20160816;
        b=lA0nY9HIv/qBaCPj14clEaQnDB2/JEdFXsgvppi1hNeO/PCgGJVRz/DHvgW/hLFe8Z
         4J0vNrMCKuhSjKna47lp/7gz53+c3OAch4VUdTntrWXJBHrjvkLPsHSAxZUzTAsZciQj
         OsXKvCZI3w9CnlzXp8VmlZ6OJ8TuewO4PKLLx83VellK5W5lrSJVNaHO5ouQXWUsD32h
         R5zuQoeJw0RLQ7E6eCiI4Otx6tpOmc6HnmlaF1YEx8TxxnghaCwn+ny4Xila0iAx0x/E
         0O51gnlPWsswOB8bGFIxIipuPJHK2VYx183qobyZaQNGNgPwuq0yv87lflGyLIu8779P
         O4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h2tJU5yIbVfo7xp82p9W7PYWseznl3CzuZI5DWZ5Y4k=;
        b=I0uY9NcQp7Bftk1SGIwzjdYJdQq/ivrdmMnfjN3e1IW0GeaL3GBtkPDExlnQamLJqY
         n89SDeZHcpV/x57stJBCG6GYhXG24gJ8iegUVQhHK2OWI9ZRZzLng1SaDfQ6pF1dnjR0
         4a2cxH7alGHWMCqZONCIuRhA4Phrw6oT14IW7oNR1ouSGgvE4zgEVNiQwl0QK2W7+UkN
         2GUEntNhZfwn/An4tkHK/3SET+swXdHHBAkuYhJiwcKup2UFnHg0NaVX0ztBdXaOUhZo
         28IihSVMeC3n4ixH9CBQcUw1lZjFoK7BR8bWfrd2dpbNpPJ66XtQy9aAlP9DYkobF8y2
         AGUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 4.9 67/77] x86: fix build warnign with 32-bit PAE
Date: Wed, 21 Feb 2018 13:49:16 +0100
Message-Id: <20180221124435.030654100@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014689163586116?=
X-GMAIL-MSGID: =?utf-8?q?1593015347295352632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------


I ran into a 4.9 build warning in randconfig testing, starting with the
KAISER patches:

arch/x86/kernel/ldt.c: In function 'alloc_ldt_struct':
arch/x86/include/asm/pgtable_types.h:208:24: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
 #define __PAGE_KERNEL  (__PAGE_KERNEL_EXEC | _PAGE_NX)
                        ^
arch/x86/kernel/ldt.c:81:6: note: in expansion of macro '__PAGE_KERNEL'
      __PAGE_KERNEL);
      ^~~~~~~~~~~~~

I originally ran into this last year when the patches were part of linux-next,
and tried to work around it by using the proper 'pteval_t' types consistently,
but that caused additional problems.

This takes a much simpler approach, and makes the argument type of the dummy
helper always 64-bit, which is wide enough for any page table layout and
won't hurt since this call is just an empty stub anyway.

Fixes: 8f0baadf2bea ("kaiser: merged update")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kaiser.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/kaiser.h
+++ b/include/linux/kaiser.h
@@ -32,7 +32,7 @@ static inline void kaiser_init(void)
 {
 }
 static inline int kaiser_add_mapping(unsigned long addr,
-				     unsigned long size, unsigned long flags)
+				     unsigned long size, u64 flags)
 {
 	return 0;
 }
