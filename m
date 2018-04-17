Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/R4wpeSaEsSvsiug9Iwofth+fkrNJHZwTunQPtuZqk93ZnT0n4TG+AvJ/ML3V57u9bmPTj
ARC-Seal: i=1; a=rsa-sha256; t=1523938143; cv=none;
        d=google.com; s=arc-20160816;
        b=dmUOkxd9GK+Dyp3DHHK+6Inppsgl0vGru8iqaTooWyzTQmfr9dNPiACwoMptyvL39t
         e3Evb8IVsZZc7m9iOHvpFTOdGyXeY1okmkkvzmXZ5qJ1uponlSCBB5/qwnTMRhi7Y21V
         nRwknC1wmWXr3zVzShuK+7O/2w40yAu+JtlaSz0jVcNwk+QpsCefXEeu+323smVx7mrJ
         OhQ14VjxogdgUZ0iNk6UOdyyLhwcMphqU0ZMbhc5SGWnZcBTe+EdNbyVjmDV2al9NCEh
         rtYX7vK1QZ3AM8oiDXlCYj51khZQ0W+lzQglapWiisGoHYH//TlvIxzTYyyxkmhjuLNR
         YZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=SzlreaRSHA0aX10IZFhQiYj2mFF6rlRAlvA1FtABoyM=;
        b=QR9ouwlq50fCbpP+KmU1yxZKrgPF3WsGgRB+CzeHIgJC5Kmd6FR/EO3u3Fd1DXSCkL
         3r1SOlvym27DXDkaUC/2XjTzJ6UdLa4NbK66k6xSD8jIhm9Pag7egI4xneaPHDfM6/lz
         Zzd+jZbKmsF+ZaMXhs620UCs9FfRloqKAzVW1qsSncOF6lpmshGowoyOCF6dz2QNjV1A
         /123nqrKfbd9VYb5dKuGXva7bwQQ9DNLPN3EAwfCmcHHz6eDxUeREU+OiA1XG4cKWnnO
         Qb+lpkoN95Yd3KaIavX90NJtjaqArpaOFqFafkfkiC1F/7YHR2uRAzqbOv7RiirhDyw+
         XWRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PWKPpMyp;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZPM4Yw+Y;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PWKPpMyp;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZPM4Yw+Y;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E50EA602B8
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
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] parisc: define stronger ordering for the default writeX()
Date: Tue, 17 Apr 2018 00:08:50 -0400
Message-Id: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597964962868672985?=
X-GMAIL-MSGID: =?utf-8?q?1597964962868672985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

parisc architecture seems to be mapping writeX() and writeX_relaxed() APIs
to __raw_writeX() API.

__raw_writeX() API doesn't provide any kind of ordering guarantees.
commit 755bd04aaf4b ("io: define stronger ordering for the default writeX()
implementation") changed asm-generic implementation to use a more
conservative approach towards the writeX() API.

Place a barrier() before the register write so that compiler doesn't
optimize across the regiter operation.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/parisc/include/asm/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index afe493b..2ec6405 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -196,18 +196,22 @@ static inline unsigned long long readq(const volatile void __iomem *addr)
 
 static inline void writeb(unsigned char b, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writeb(b, addr);
 }
 static inline void writew(unsigned short w, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writew((__u16 __force) cpu_to_le16(w), addr);
 }
 static inline void writel(unsigned int l, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writel((__u32 __force) cpu_to_le32(l), addr);
 }
 static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writeq((__u64 __force) cpu_to_le64(q), addr);
 }
 
-- 
2.7.4
