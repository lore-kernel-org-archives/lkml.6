Return-Path: <kernel-hardening-return-12941-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48nv288ujWUPQjutkXrhNaA2P/Eiz1pIxM/H5wI9O47JUdQhujtX4ViDZ8Ha/KxWN32YsHl
ARC-Seal: i=1; a=rsa-sha256; t=1523308095; cv=none;
        d=google.com; s=arc-20160816;
        b=NO4u6SrDUP0CE5ebF36wwUMUiylhkR2qaiVuTbHuYVcac1GL2Ff08CcsG0TIPDa7ze
         /ZfcAtJBQbj3qMrvVc+wfgz+a8sbBcba6kZ7xs7jTrJvc5N3K0N6DSxzVL7Z0r3JuRDh
         hlXy2N+9lel4UWI1WKJEuTj9tQytrPxEaU+8rAs/9V/nqMoJMOadi9fDveMbyhhsj4dW
         UghfJVVXWFF/06eRqPRFyZFMYKXtDrnTdkjtqNYHp4FhNRgiakiXEuSwdYGj0QiWKhrK
         6wGpxCZfv/mKQvnvnRp7PV1T2B65Y0R5V943NYQP0r/DBHsVOETrZQI0mHnOUqBPFB0E
         5SJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=slZtPyz+LsNcXsDn+uhw0xVjtelCqKDeFDkVIZDhiBQ=;
        b=GnzJcDDepi8pFw1iPJO1WeSbOL4xadnzdlD/y1GuCjaB69ByYilZUI5RTx7wORnNFI
         sHm3XLRTlYigshq03wHHuZf0gp2okBOja9AKS3ccjNAGaLt2Z8jlVbsFomNs4ggnaj/S
         0eqOBAntu73BqasS8bTdpDlRfpOKC9m5usZcGbBYyRh1+mrbPa0bHNiBDxv9ggCfFV4q
         /lzFy+PhPzDWKf2F/y3uqlhH3m12XzjnEsP5fa/O9NHluRvipEPIOMd57psjFzX7ZKI4
         OKEyYDV6ntCTP+lT1MGWjV1JSqi6nd07Li5HUzedg4PzFpXRksVB/K53b+SpY+mpvDC9
         rVMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12941-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12941-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12941-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12941-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Karsten Keil <isdn@linux-pingi.de>,
	"David S. Miller" <davem@davemloft.net>
Cc: Laura Abbott <labbott@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH] mISDN: Remove VLAs
Date: Mon,  9 Apr 2018 14:07:47 -0700
Message-Id: <20180409210747.3990-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304309296205487?=
X-GMAIL-MSGID: =?utf-8?q?1597304309296205487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. Remove the VLAs from the mISDN code by switching to using
kstrdup in one place and just using the upper bound in another.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/isdn/mISDN/dsp_hwec.c   | 8 +++++---
 drivers/isdn/mISDN/l1oip_core.c | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/mISDN/dsp_hwec.c b/drivers/isdn/mISDN/dsp_hwec.c
index a6e87076acc2..5336bbdbfdc5 100644
--- a/drivers/isdn/mISDN/dsp_hwec.c
+++ b/drivers/isdn/mISDN/dsp_hwec.c
@@ -68,12 +68,12 @@ void dsp_hwec_enable(struct dsp *dsp, const char *arg)
 		goto _do;
 
 	{
-		char _dup[len + 1];
 		char *dup, *tok, *name, *val;
 		int tmp;
 
-		strcpy(_dup, arg);
-		dup = _dup;
+		dup = kstrdup(arg, GFP_ATOMIC);
+		if (!dup)
+			return;
 
 		while ((tok = strsep(&dup, ","))) {
 			if (!strlen(tok))
@@ -89,6 +89,8 @@ void dsp_hwec_enable(struct dsp *dsp, const char *arg)
 					deftaps = tmp;
 			}
 		}
+
+		kfree(dup);
 	}
 
 _do:
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index 21d50e4cc5e1..df594245deca 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -279,7 +279,7 @@ l1oip_socket_send(struct l1oip *hc, u8 localcodec, u8 channel, u32 chanmask,
 		  u16 timebase, u8 *buf, int len)
 {
 	u8 *p;
-	u8 frame[len + 32];
+	u8 frame[L1OIP_MAX_PERFRAME + 32];
 	struct socket *socket = NULL;
 
 	if (debug & DEBUG_L1OIP_MSG)
-- 
2.14.3
