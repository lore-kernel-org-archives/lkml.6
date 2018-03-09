Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607054; cv=none;
        d=google.com; s=arc-20160816;
        b=fDet7WVtpDnWC6Fp0j9sm+cp70Rag4VfbmHxuQzkjJ5doMtOy4l3KT8Qq9nQTyOU5D
         2IP7/jE1WNxXQaYd5U8283y0JiAK3HZ3J04kxkrFozli4XPHyDn/2NA87JysHkNPKUFG
         uHDA+QlVqc2i36Gz1dCxXe++IffcZKon5bAFm3FPsWTf9kG9htbRDOoBTpE9/sUl4Qv8
         ixNMjwXcjFOFFUmlYrKG3jNBvNrRCtoGXFzhPW/71BMsxEzPD5wJuNTyvPLjLcqOo1Hh
         l0Fxiva80bn1ZJgETKMrCFGajNutSlZqnUj6PDKJbmhhrLRq2k9SLvM4SvQPtHQsFsYP
         eZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Ufwf7qBywoUhGsTDixw/ddKEjV907Zte7g3Yg4PGjmw=;
        b=BGXq01r6gi6HrqgHT0/KuwixNQ1+4lzhkXdj+157MaQ4BMVKDCxZTtWop+9Usb24X7
         W7Z/v1hhHuJQt9jhq+Lwt2eqC3X9KvSb1KFUxSpKKL+VfDCvA+CEQ+yBVTExRwLHLP5j
         li6SOuV1fFUXva9eZ35vv/JNDHLfYvar3YqdXzk9qHGckTbDpgcq6e4JcXtD8zP6KDFZ
         y09OWF7fwK5MmwYF40mZ1fID7dpjf43xlTzceq6qMq9MjV+ncSK4pDb9SAVv5awKl6lp
         XBouFhBn+O/wDOUuTkkhXUSmwVTRa1/XOA7ckHMr5M8JihXlXC9XzLds/Kz1M5gLOSWM
         9G1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HjvFaFKH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HjvFaFKH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvkSt0a+ekdCBRHX9Oko4MwOWN4Wlrz5ZGnUXupe0YB7J96eji8c1dax5U50USssWLfxRjjwg==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 23/25] nvmem: sunxi-sid: fix H3 SID controller support
Date: Fri,  9 Mar 2018 14:47:17 +0000
Message-Id: <20180309144719.29904-24-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472062130495903?=
X-GMAIL-MSGID: =?utf-8?q?1594472062130495903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Icenowy Zheng <icenowy@aosc.io>

It seems that doing some operation will make the value pre-read on H3
SID controller wrong again, so all operation should be performed by
register.

Change the SID reading to use register only.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 71 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 99bd54d85fcb..26bb637afe92 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -85,13 +85,14 @@ static int sunxi_sid_read(void *context, unsigned int offset,
 }
 
 static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
-				      const unsigned int word)
+				      const unsigned int offset,
+				      u32 *out)
 {
 	u32 reg_val;
 	int ret;
 
 	/* Set word, lock access, and set read command */
-	reg_val = (word & SUN8I_SID_OFFSET_MASK)
+	reg_val = (offset & SUN8I_SID_OFFSET_MASK)
 		  << SUN8I_SID_OFFSET_SHIFT;
 	reg_val |= SUN8I_SID_OP_LOCK | SUN8I_SID_READ;
 	writel(reg_val, sid->base + SUN8I_SID_PRCTL);
@@ -101,7 +102,49 @@ static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
 	if (ret)
 		return ret;
 
+	if (out)
+		*out = readl(sid->base + SUN8I_SID_RDKEY);
+
 	writel(0, sid->base + SUN8I_SID_PRCTL);
+
+	return 0;
+}
+
+/*
+ * On Allwinner H3, the value on the 0x200 offset of the SID controller seems
+ * to be not reliable at all.
+ * Read by the registers instead.
+ */
+static int sun8i_sid_read_byte_by_reg(const struct sunxi_sid *sid,
+				      const unsigned int offset,
+				      u8 *out)
+{
+	u32 word;
+	int ret;
+
+	ret = sun8i_sid_register_readout(sid, offset & ~0x03, &word);
+
+	if (ret)
+		return ret;
+
+	*out = (word >> ((offset & 0x3) * 8)) & 0xff;
+
+	return 0;
+}
+
+static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
+				 void *val, size_t bytes)
+{
+	struct sunxi_sid *sid = context;
+	u8 *buf = val;
+	int ret;
+
+	while (bytes--) {
+		ret = sun8i_sid_read_byte_by_reg(sid, offset++, buf++);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -131,26 +174,12 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	size = cfg->size;
 
-	if (cfg->need_register_readout) {
-		/*
-		 * H3's SID controller have a bug that the value at 0x200
-		 * offset is not the correct value when the hardware is reseted.
-		 * However, after doing a register-based read operation, the
-		 * value become right.
-		 * Do a full read operation here, but ignore its value
-		 * (as it's more fast to read by direct MMIO value than
-		 * with registers)
-		 */
-		for (i = 0; i < (size >> 2); i++) {
-			ret = sun8i_sid_register_readout(sid, i);
-			if (ret)
-				return ret;
-		}
-	}
-
 	econfig.size = size;
 	econfig.dev = dev;
-	econfig.reg_read = sunxi_sid_read;
+	if (cfg->need_register_readout)
+		econfig.reg_read = sun8i_sid_read_by_reg;
+	else
+		econfig.reg_read = sunxi_sid_read;
 	econfig.priv = sid;
 	nvmem = nvmem_register(&econfig);
 	if (IS_ERR(nvmem))
@@ -163,7 +192,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < size; i++)
-		randomness[i] = sunxi_sid_read_byte(sid, i);
+		econfig.reg_read(sid, i, &randomness[i], 1);
 
 	add_device_randomness(randomness, size);
 	kfree(randomness);
-- 
2.15.1
