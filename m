Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELt5jPCQhBZYKYgSqKqVqzK5lSy8f39l0qr5x8ErixmoQZj/41ZV10j322T8beCNx/hBfwLe
ARC-Seal: i=1; a=rsa-sha256; t=1520276931; cv=none;
        d=google.com; s=arc-20160816;
        b=sQIP4S26n7Il7komi4qvVkkap83FolGZ/e4XzKsceUKUAadWO1di7cLlQzFo+SYdZS
         bb8KZi0QAuzDEhv+yFKJnOs5zpv4C9o9LpqVxSBcmsqIanbyJARN1S4HB3w93NrVihdP
         7N4DRAeJzpVWU/IWf9ekIAO5B1SstK/WJ0aApypm1oPce9h7arEzWUtAGs2m5/QgrCV2
         m0jrPAIaK2bdIbT5bdYgMtDYstJDWJ8T1C014Gx8idDf6a/kmIhst6zxEcx1spSGQQtX
         MxThy9vuZPPG9mj+uoZAU6wtXRlydmYIXU5wzPoSxhHXL7yeqoTcvUc2wm3B/XZNI8AQ
         2pOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:cc:to:from:arc-authentication-results;
        bh=qH8voW2c7rrhKbx9PsUVeSzjaNuuBsNoOv2KBZPBxfs=;
        b=jH9RM7+/DzixUXUNeehF1e9XLoIX0eWQzTWlP7Q6VJ0NA7kArdiQE1GCMvh9PIg3TS
         zBBJ7Yuw0uKTWf1nfKWW7/yV1e9IOQsDDmkEDiw9Ovcfl02T2Nlqrer6g4YSXdJzkWtJ
         MulRM9u0zyvI8P1ToV6Fy5oHKBX37b4hK5SEoGw7SEeMKw12C9Ra1HKo2xqXqjTM/Vjs
         kbFg4djYP2wOifdHAXC9aF9HtlNRoUlkG6v4uogh8/9LicT8UNG6TBQbnI/3b4agFH2d
         G5ANlSbv47MlKIO/3nuLZbm2qx19d0laJCfA2njfiGd0m6A9+3SGkCMIiaRur/FcWj3O
         qC2Q==
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
Date: Mon,  5 Mar 2018 12:08:19 -0700
Message-Id: <20180305190824.847-3-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180305190824.847-1-logang@deltatee.com>
References: <20180305190824.847-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 2/7] powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125903311097175?=
X-GMAIL-MSGID: =?utf-8?q?1594125903311097175?=
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
