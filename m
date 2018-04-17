Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/4VRH+tM4+McY7Kk6vhWr8T4AYvte4qJc+WkjxigUXaD/IA2reOlgotAxCk/FOWj7ZYhmp
ARC-Seal: i=1; a=rsa-sha256; t=1523938146; cv=none;
        d=google.com; s=arc-20160816;
        b=lM4o2edVmMkiXYuawi47NpvTN99Jlsrjtypuz4PqqveQ7O4B7guRQ9rKFEDZPyQ7Ux
         7enN2V5Rr5TC7T35da5wNaVX/BODx5SgnjkR37NPmXcWS6zvHrrJV6s1GXepz25wDNi8
         EwEdNJOHG7zi+BKA645SId5/E+rNRbNGYAUK7XOsV7g2sO8ndsItpwfE4EFswwLQknkI
         VysKcUm8cSnYYqDFdK0T9EpB3C1iODW2rrKWb3OuWx8XPdXSacxjdkvhBIiN+IvJbVY3
         L/x2iku8B5crHAwFtYFXnFtiNwEbNYxwYjKqNm/fRCzgkoG3bN2FZ2fPbdV/3cjzc1kl
         bV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=vL0k39cpajalA/+qqPHIS1xHoERY9shrgrOj4+pXFdo=;
        b=YHjGZ6epZTKyNnz+JU2x8jWjmL9YHwV+ae0knUo55B1X3BsDg4x9rsF6yKtFjiGPIX
         z88AlC545YTLey3TOIzlkLeuT4uVuzVlpNtigDIP5GnyGE1/SaP7dW3EDW3EzUE6x5uX
         2FmgvPpddBt8I5VWWqSfG1i4jkvxQBiVt7ofek8r1+bJnem1WyZj2GzZTunk2g3Htn+6
         a1e2Muoi5vVN/CAzOcbKIFPfprfi0glhH8AJQ2uZ4kniC/4L0ozuIMgwwUR/ptnWw5qq
         v/8KOC8qWXYMPiGb96CNOZd7FkjUrRD201AMHBkxNpHsz6fN7ON5tnCfzz3U1+KNdrb6
         1GrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=e5i9quRl;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QMDxXVjn;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=e5i9quRl;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QMDxXVjn;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F49660F6E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-parisc@vger.kernel.org,
	arnd@arndb.de,
	timur@codeaurora.org,
	sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sinan Kaya <okaya@codeaurora.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] parisc: define stronger ordering for the default readX()
Date: Tue, 17 Apr 2018 00:08:51 -0400
Message-Id: <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597964966697704374?=
X-GMAIL-MSGID: =?utf-8?q?1597964966697704374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

parisc architecture seems to be mapping readX() and readX_relaxed() APIs
to __raw_readX() API.

__raw_readX() API doesn't provide any kind of ordering guarantees.
commit 032d59e1cde9 ("io: define stronger ordering for the default readX()
implementation") changed asm-generic implementation to use a more
conservative approach towards the readX() API.

Place a barrier() after the register read so that compiler doesn't
optimize across the regiter operation.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/parisc/include/asm/io.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 2ec6405..e04c4ef 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -179,19 +179,34 @@ static inline void __raw_writeq(unsigned long long b, volatile void __iomem *add
 
 static inline unsigned char readb(const volatile void __iomem *addr)
 {
-	return __raw_readb(addr);
+	unsigned char ret;
+
+	ret = __raw_readb(addr);
+	barrier();
+	return ret;
 }
 static inline unsigned short readw(const volatile void __iomem *addr)
 {
-	return le16_to_cpu((__le16 __force) __raw_readw(addr));
+	unsigned short ret;
+
+	ret = le16_to_cpu((__le16 __force) __raw_readw(addr));
+	barrier();
+	return ret;
 }
 static inline unsigned int readl(const volatile void __iomem *addr)
 {
-	return le32_to_cpu((__le32 __force) __raw_readl(addr));
+	unsigned int ret;
+	ret = le32_to_cpu((__le32 __force) __raw_readl(addr));
+	barrier();
+	return ret;
 }
 static inline unsigned long long readq(const volatile void __iomem *addr)
 {
-	return le64_to_cpu((__le64 __force) __raw_readq(addr));
+	unsigned long long ret;
+
+	ret = le64_to_cpu((__le64 __force) __raw_readq(addr));
+	barrier();
+	return ret;
 }
 
 static inline void writeb(unsigned char b, volatile void __iomem *addr)
-- 
2.7.4
