Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELts5t7ei+3DZSlELsWKBrlMeVyLnF50mxTboUjKt2iwfjinmVpPWud8D5kvJxObRZ5Tut8O
ARC-Seal: i=1; a=rsa-sha256; t=1520824059; cv=none;
        d=google.com; s=arc-20160816;
        b=pJfKfBuf3kr/32TMXDsv+yvRWXU7anqTuc+T2MMeGS0lLSud3Aqv+b9i20ltfrf9hZ
         QKkDf9uNDyM3wAh5pakf6QOchbufE/FNIsjhzc5v2mmrZA8zZ8ny4WONFJrTd5nwC5ie
         aJtkinUemxmUQMGDk0pphWRWUmWesq5TnkDLFkcJvsuVQqnMCCjM7xfdiFMUe979ygoS
         9aoDGAo+UuOaleMlYhsIGk6o2XJBrU9htKwxNoazhZ1hGunPvRM1UodlR5CZGZkSzybt
         GZKhukhhj7cHDrlNbz1vLUxCv1naqGuOAFlNzrPuIurogA1WJmQ/mPGnXHy/PN7o46kG
         ICDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=DzVHuqOw95w3ApYc4GrwpVNqh81tAtriIWZyjfObS6E=;
        b=rz6eoezm5whnr/tJTiv+fIlDq6yVyI25Y0dHQqWIKwZt0mRBrkIsSCwq3KBXoCZ9Vy
         NXcQyxPyEUd2PU1i/zu+3Q2n18SCBYAQ4TU33J20RRNY9XVxsplWF8FgtsdF3RW8XQN8
         rGeFNE7gEhdLU/ftl5WKqZEJ9gNtSDmxnN45fcqjcfrLYmwk1tPDEYD8DSCvPDTHMCUJ
         ENkr8PFY39M2KizJjRupe2868KGKM7QRvG46a7fiDNrDm9AAQykmw6rUUYKRPR0XO6I+
         08Pplf1XqU9GA7wIO8/DahinEl+8iEsMpLWOYU1c83Jnhs6eBTLU36dWxw8imqCt/1qm
         kB5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Hugh Dickins" <hughd@google.com>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "Kees Cook" <keescook@chromium.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.428778762@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 103/104] x86: fix build warnign with 32-bit PAE
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699608797216012?=
X-GMAIL-MSGID: =?utf-8?q?1594699608797216012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/kaiser.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kaiser.h b/include/linux/kaiser.h
index 58c55b1589d0..b56c19010480 100644
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
