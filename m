Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtsp8EUbjVf9AjTvdLkuXk7ppfGTyHJguhuJOSvZDOEljlahHYt2+xd7KaXne7DaHVdIHbh
ARC-Seal: i=1; a=rsa-sha256; t=1520824071; cv=none;
        d=google.com; s=arc-20160816;
        b=S1xija9WlKuv7ObqLxVR4gFO7VLVS9ept6sp+Y24qDQKNcYsXr5tLafTOU7cTx92N5
         52L68mZLax9qkUj8EYHE0JoYL7KHmbxa7v6rdMFTaM2mdavHGpG1HiGBTd63aTOUyPEF
         okrX5I2C3HCH+/YWrsaOqrCz3zVJM+8MvOK+7Qnn8uouS8SmH9v3TzP6kPYWqhS66F4e
         LkCzhsXMOlQKMX6VdJTC7h9k34+Oo5m3E0zI8zIWwLorVtf24UdLIWB+y+ZACpCUJQVC
         ebS7vgrjdgoG7/HXLwxhh15QPVTfriOsqHn7ZKUaLJVKKJZouwvdaD/GtH1ZsgfxzynH
         tg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=EjylDuFpoPFCVgZwaI2qt8Vo3ib05A0KySLOME7/qmU=;
        b=Xl2AVtzVTHXKKrra3lwFS1wF3TLLUNgym5NmDpjbk5Lc3666h/DbYqcQs6D2gF0Ft9
         f7EVYzw4uMeU08nHN/1Cw6Uek4vut+D8PhEtuO9iO0LDD3pP1pYa027GycEB/VRLSw/7
         oI9gX2+1Jw5U53kzOnZEt8OlZm83TfsR6rs5MODb5f2S61mtBq7pMUs4cRs/DKF1tfji
         JpL7hSFVCfAX1ay0Op9JQtLe64F8cMYvXkImd23m0r3IZGKPIc1VybKMLEJooDuBkEJ/
         gUXKvCyvc0KdZ9viZL0QlmC7p+bSWbcTkQxV3j5MZnSJUWw1XFNgG3uvNQDpU4Syymif
         12Nw==
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
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.668764666@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 76/76] x86: fix build warnign with 32-bit PAE
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699608797216012?=
X-GMAIL-MSGID: =?utf-8?q?1594699621722976523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
