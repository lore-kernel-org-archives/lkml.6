Return-Path: <kernel-hardening-return-12966-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48pa/I1x3phh1M+r1Hyi6Zcpt94SKrsIaDrfMFvokOjZuw3dRndSBRb9785ENeHhAJAv3mE
ARC-Seal: i=1; a=rsa-sha256; t=1523408649; cv=none;
        d=google.com; s=arc-20160816;
        b=I+XLd+JMFEBlr+39AVeA2Qf7iAqBPMqKt+iz7FPaoPY2e7lExy6Wxg/eI74fqY0WS0
         g/onVT2OdA5ExIvZXRTo5sjBVN4Hp8lCYEfmgYl1KJ2SPKZukUZI2FjIbWjE/+2pjhYC
         FZM498+EGGA1qnp50agA+frkeCWWSm8CDvTSaufFn92eFjzIT9hJU+KatMnEFTi1yK8J
         XOySFHSX0a/VvB+yXkYL6G4IQHyHQdqO9LCeZvxnqVkEVfnIS7BRVDg6InPhN+63x4zd
         GjLTpwUw4+Pd5naBJluwJqSzmtnrkQ2qvUEpjj5Pg8Z0WwzMuQHILs2Y0Beeqfc13Z2H
         Q/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=a8jzB+4333HGsfDCv6oyqqZ3vgyNG2rzXgC5UtxijMM=;
        b=F56CPJG2txNK21oeLD2nxmVVv4DBfopOM6tT2RnpFD5D66598oG1uRStcAg8cDF4oQ
         0POLXSBac/te/E4NYWWHCiBeUyrghej7fBkoOORcnI5NXRoZivjP8pXqboHIAXZoRYj8
         mKdbDIHlYh6l6KDRcCstE5obvxO9UuyI0qDLq1IxKD8IogmcFBbiBW/j1yZuHW8EUkih
         f7lLFkFo/dBRnq63A/X5nNl1HYoOLGLGY5CpvlLLIvSniXQzrYtYYGuwThl+IQ0HezFt
         znKBOH71hvrUtIqmgrieQvpY4AoQ1INP9miOFWrBeEM26PXJG7xBmT8+u7NobJ2fNAnR
         WoWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12966-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12966-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12966-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12966-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Russell King <linux@armlinux.org.uk>,
	David Airlie <airlied@linux.ie>
Cc: Laura Abbott <labbott@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: [PATCHv2] drm/i2c: tda998x: Remove VLA usage
Date: Tue, 10 Apr 2018 18:03:30 -0700
Message-Id: <20180411010330.17866-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409747630328610?=
X-GMAIL-MSGID: =?utf-8?q?1597409747630328610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. The vla in reg_write_range is based on the length of data
passed. The one use of a non-constant size for this range is bounded by
the size buffer passed to hdmi_infoframe_pack which is a fixed size.
Switch to this upper bound.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switch to make the buffer size more transparent and add a bounds
check.
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 9e67a7b4e3a4..c8b6029b7839 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -466,13 +466,22 @@ reg_read_range(struct tda998x_priv *priv, u16 reg, char *buf, int cnt)
 	return ret;
 }
 
+#define MAX_WRITE_RANGE_BUF 32
+
 static void
 reg_write_range(struct tda998x_priv *priv, u16 reg, u8 *p, int cnt)
 {
 	struct i2c_client *client = priv->hdmi;
-	u8 buf[cnt+1];
+	/* This is the maximum size of the buffer passed in */
+	u8 buf[MAX_WRITE_RANGE_BUF + 1];
 	int ret;
 
+	if (cnt > MAX_WRITE_RANGE_BUF) {
+		dev_err(&client->dev, "Fixed write buffer too small (%d)\n",
+				MAX_WRITE_RANGE_BUF);
+		return;
+	}
+
 	buf[0] = REG2ADDR(reg);
 	memcpy(&buf[1], p, cnt);
 
@@ -679,7 +688,7 @@ static void
 tda998x_write_if(struct tda998x_priv *priv, u8 bit, u16 addr,
 		 union hdmi_infoframe *frame)
 {
-	u8 buf[32];
+	u8 buf[MAX_WRITE_RANGE_BUF];
 	ssize_t len;
 
 	len = hdmi_infoframe_pack(frame, buf, sizeof(buf));
-- 
2.14.3
