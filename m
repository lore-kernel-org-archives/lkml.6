Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AIpwx49GRY/P8LzVABBRCFDhMGNotdbU8zLXxBWWkRaqqs5WtErVumXPCWE8bixwNFSEWlpElSAR
ARC-Seal: i=1; a=rsa-sha256; t=1522192135; cv=none;
        d=google.com; s=arc-20160816;
        b=yOTFaIdvZ5v85XtXl+mCbt2QcBct+/VgesrV6oO3rmYwnoBbkQk3FTZHqTQ1cG8GIf
         bixadG/yHg8Au6OOEUcJV0XEJCnsZyKBz95N4VtAg7AA2/L4KDxr6ynKyXSu9Fw9JSRF
         r/A4TBDo9rgttEZC4A0oCXmOZkZFtTIP6ZvIm31RLvrRcG3+5tKryJpEeKRXCriROCZW
         xuls7ySzQAq54AsnweOonloMqmVP1YrsZrLflugmu9650SbTcPCA29HNNEpagMwQkaH1
         CeUkc7BJuGE4a51Pl3H0UaCRzDh7By/KDmf3LBQzw/gwRfS0gUebOC2dDDmJh1O45w42
         aPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:cc:to:from:arc-authentication-results;
        bh=qH8voW2c7rrhKbx9PsUVeSzjaNuuBsNoOv2KBZPBxfs=;
        b=Cbvyz2clwFhNlO3R4cHDEb1kWGm5Z+lu2iHdUig/7bKmtkpaLXOi+D93ig4I7CoCyA
         mkYmk462fe2ob8AT0qL4bs5lcZuHwTIAZlE2aM21wgZ56PLR3gTiB0dWTj4/6QZHOqLe
         ughSi+GJJsze0wnxUdfXIl+toBI9yNXkFr8AjxSCWyGNS+8CM/8lZJs9jOm9uxxr9DHI
         3nC0XSFjfGZlThEfUIfGlB52iw64F4YoU/hwasHGhOU1Il42UW13UIIbtx4Z1LMCSlM+
         vY4tkBZBzPDBtTfCdrzrib+b1atD9gBAaXrmQtxfrP6u2alwI+IzTpKcbTw/xMJGvoxh
         RHzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 27 Mar 2018 17:08:29 -0600
Message-Id: <20180327230834.5931-5-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180327230834.5931-1-logang@deltatee.com>
References: <20180327230834.5931-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v15 4/9] powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596134140285324978?=
X-GMAIL-MSGID: =?utf-8?q?1596134140285324978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These functions will be introduced into the generic iomap.c so
they can deal with PIO accesses in hi-lo/lo-hi variants. Thus,
the powerpc version of iomap.c will need to provide the same
functions even though, in this arch, they are identical to the
regular io{read|write}64 functions.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Horia Geantă <horia.geanta@nxp.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/iomap.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index aab456ed2a00..5ac84efc6ede 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -45,12 +45,32 @@ u64 ioread64(void __iomem *addr)
 {
 	return readq(addr);
 }
+u64 ioread64_lo_hi(void __iomem *addr)
+{
+	return readq(addr);
+}
+u64 ioread64_hi_lo(void __iomem *addr)
+{
+	return readq(addr);
+}
 u64 ioread64be(void __iomem *addr)
 {
 	return readq_be(addr);
 }
+u64 ioread64be_lo_hi(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+u64 ioread64be_hi_lo(void __iomem *addr)
+{
+	return readq_be(addr);
+}
 EXPORT_SYMBOL(ioread64);
+EXPORT_SYMBOL(ioread64_lo_hi);
+EXPORT_SYMBOL(ioread64_hi_lo);
 EXPORT_SYMBOL(ioread64be);
+EXPORT_SYMBOL(ioread64be_lo_hi);
+EXPORT_SYMBOL(ioread64be_hi_lo);
 #endif /* __powerpc64__ */
 
 void iowrite8(u8 val, void __iomem *addr)
@@ -83,12 +103,32 @@ void iowrite64(u64 val, void __iomem *addr)
 {
 	writeq(val, addr);
 }
+void iowrite64_lo_hi(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+void iowrite64_hi_lo(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
 void iowrite64be(u64 val, void __iomem *addr)
 {
 	writeq_be(val, addr);
 }
+void iowrite64be_lo_hi(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+void iowrite64be_hi_lo(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
 EXPORT_SYMBOL(iowrite64);
+EXPORT_SYMBOL(iowrite64_lo_hi);
+EXPORT_SYMBOL(iowrite64_hi_lo);
 EXPORT_SYMBOL(iowrite64be);
+EXPORT_SYMBOL(iowrite64be_lo_hi);
+EXPORT_SYMBOL(iowrite64be_hi_lo);
 #endif /* __powerpc64__ */
 
 /*
-- 
2.11.0
