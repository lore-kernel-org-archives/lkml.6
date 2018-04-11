Return-Path: <kernel-hardening-return-12969-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49Mhtmwn5us7SZtprbS7Mg+v8rLXPIYpM5AASt7bisuSkyz1yIp49xPrNnF5NZdkk4K4tjp
ARC-Seal: i=1; a=rsa-sha256; t=1523408698; cv=none;
        d=google.com; s=arc-20160816;
        b=h8xo3fX0hILugMbGBbpe1oBMOZwVZkDgTk2bhmEHuZrZ1s0Gi2GVawsesNcIMqGf8M
         BT+g6lkY+Ummf5eGd90ZGVq2H2bd/yCAaKY/NyM2eoIs1tlU1rvbvWpTrqtqPYeTTIRj
         /qYN73mZ4k2m5lgxJGYcWqyvr6OgypBl4PhahCcEgermMJ5MDOc7cboigZthawR8Orax
         bfk0v5IV3WUYn0AjFfcLPymlt3TvAlQYL1mQUJKF6YNeTQg9297UmFwMYh8/Yw33mHgb
         zJRRWddzpAUQnNRGDR10WpUGA0pzBqwVOElWhzR2p3rLN6xMvo9hQLN6Zzm2+wZVD3PL
         S1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=UVltaXvPEpAzzp4frEzWsci/0CLoGCfuso2MDjy8rzk=;
        b=VGSswAKcaiDopIpwr6FcXoO2Cqq0p3aYXQpg6lYNy2gTy2DBFruNXnMYYFzEpUqxwy
         UHnJd8Gu0gUtqg7vojbf4hObBDl5dRpYmY+1PtiB7K8m0J84OBhXg6Afdy85hiC18RZu
         5m3L9S///8PH18VE+NBAFYWPZpgrHgz5hUqNoEbDMyA7jmohpTo7mkIYKsSorwJcs0pK
         /WlBjDB7UFrjt8UtK0juRR2qKeHFSTfHtBqI4ZL6mrRtdNEe3fIwruy5PEpknNLbmYtS
         s4JtTSGVu8Hrxf4nmgGiomJpFVcdLqBkKWcpmZyDGbrdn4cSgQ2ngya8cvRfnv167xDt
         +ZVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12969-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12969-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12969-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12969-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCHv2] mISDN: Remove VLAs
Date: Tue, 10 Apr 2018 18:04:29 -0700
Message-Id: <20180411010429.18074-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409800222276851?=
X-GMAIL-MSGID: =?utf-8?q?1597409800222276851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. Remove the VLAs from the mISDN code by switching to using
kstrdup in one place and using an upper bound in another.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switch to a tighter upper bound so we are allocating a more
reasonable amount on the stack (300). This is based on previous checks
against this value.
---
 drivers/isdn/mISDN/dsp_hwec.c   |  8 +++++---
 drivers/isdn/mISDN/l1oip_core.c | 14 +++++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

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
index 21d50e4cc5e1..b05022f94f18 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -279,7 +279,7 @@ l1oip_socket_send(struct l1oip *hc, u8 localcodec, u8 channel, u32 chanmask,
 		  u16 timebase, u8 *buf, int len)
 {
 	u8 *p;
-	u8 frame[len + 32];
+	u8 frame[MAX_DFRAME_LEN_L1 + 32];
 	struct socket *socket = NULL;
 
 	if (debug & DEBUG_L1OIP_MSG)
@@ -902,7 +902,11 @@ handle_dmsg(struct mISDNchannel *ch, struct sk_buff *skb)
 		p = skb->data;
 		l = skb->len;
 		while (l) {
-			ll = (l < L1OIP_MAX_PERFRAME) ? l : L1OIP_MAX_PERFRAME;
+			/*
+			 * This is technically bounded by L1OIP_MAX_PERFRAME but
+			 * MAX_DFRAME_LEN_L1 < L1OIP_MAX_PERFRAME
+			 */
+			ll = (l < MAX_DFRAME_LEN_L1) ? l : MAX_DFRAME_LEN_L1;
 			l1oip_socket_send(hc, 0, dch->slot, 0,
 					  hc->chan[dch->slot].tx_counter++, p, ll);
 			p += ll;
@@ -1140,7 +1144,11 @@ handle_bmsg(struct mISDNchannel *ch, struct sk_buff *skb)
 		p = skb->data;
 		l = skb->len;
 		while (l) {
-			ll = (l < L1OIP_MAX_PERFRAME) ? l : L1OIP_MAX_PERFRAME;
+			/*
+			 * This is technically bounded by L1OIP_MAX_PERFRAME but
+			 * MAX_DFRAME_LEN_L1 < L1OIP_MAX_PERFRAME
+			 */
+			ll = (l < MAX_DFRAME_LEN_L1) ? l : MAX_DFRAME_LEN_L1;
 			l1oip_socket_send(hc, hc->codec, bch->slot, 0,
 					  hc->chan[bch->slot].tx_counter, p, ll);
 			hc->chan[bch->slot].tx_counter += ll;
-- 
2.14.3
