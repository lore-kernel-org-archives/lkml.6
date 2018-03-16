Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvyMVJUiClqSSsky5DUO/cgYm7jSW8X8IhW5CPy4YgbR1qSxBZZBOQLD88U9R59YwSlsIsl
ARC-Seal: i=1; a=rsa-sha256; t=1521214855; cv=none;
        d=google.com; s=arc-20160816;
        b=CuYrroDp1+m1P78XG8aKAll8HA94oMHYwREgyBaevXb5mGBjOsUuFf/a3/3Aa0xHw2
         govYMFJdo2PsZYFQYpYkWjLyQuTs3j1D8i0rsWNH7VZ/Wiuao8E/+QpleheQezeFPSCu
         nerI/frVH5Hrg4l7sBgJXroaeIwZ+Ibbt8NfJ69MBEUC+WCk9/v3xQ1S55oO7oPdVWZk
         ndB7dS84+2UxSca/QpI9JJNKJ9WxDgJcRwgaXJKmSzVYVFH5bINT7F+S1LbC4pejXaZL
         i74cLOajpNQ8fP3HG93+AI1lLxlgDWYY4lCx5/DKtOxvX1jKBsRQ6c/k+hNbujETiTdj
         jS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3+K4xk4btDk7+ao9alL1Oho5b0EFx3PUYQEPrRLLdTU=;
        b=eNz49sIQLYnCZ2cnEwAUfM3PYPwEmR0NEC7XgcwTShohvAFyU+GMGlkn2/0q07N7iU
         fnloNOqdW4BX3DnTAe392QNNQwYP6yNK52oSeEKsvKguK+/FEizwI8y0R3Uy940TTPVL
         enbfxaMSuiKH/+XK7ui+MFrMlvDoUiHnl5W8cdEVZ15nTEOggXwYk/MXKU1Gsm5BGCMZ
         3Cr79wcpbHqTpvxQNqAs5oY04FUP3K0rXF6ZHK+o8PrkEpYA07+bAp+8ETbn5e20OFCk
         nMCIhcmIuzV3tz+cZUXU0MNy7HWYKLccOHla7cy7St/MnCmlqCKl7652PeEHiZ8xtw7R
         AAnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.15 008/128] xhci: fix endpoint context tracer output
Date: Fri, 16 Mar 2018 16:22:29 +0100
Message-Id: <20180316152336.631551411@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108958602732635?=
X-GMAIL-MSGID: =?utf-8?q?1595109388985766837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 97ef0faf575e03b352553f92c9430cb4c0431436 upstream.

Fix incorrent values showed for max Primary stream and
Linear stream array (LSA) values in the endpoint context
decoder.

Fixes: 19a7d0d65c4a ("usb: host: xhci: add Slot and EP Context tracers")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.h |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -718,11 +718,12 @@ struct xhci_ep_ctx {
 /* bits 10:14 are Max Primary Streams */
 /* bit 15 is Linear Stream Array */
 /* Interval - period between requests to an endpoint - 125u increments. */
-#define EP_INTERVAL(p)		(((p) & 0xff) << 16)
-#define EP_INTERVAL_TO_UFRAMES(p)		(1 << (((p) >> 16) & 0xff))
-#define CTX_TO_EP_INTERVAL(p)	(((p) >> 16) & 0xff)
-#define EP_MAXPSTREAMS_MASK	(0x1f << 10)
-#define EP_MAXPSTREAMS(p)	(((p) << 10) & EP_MAXPSTREAMS_MASK)
+#define EP_INTERVAL(p)			(((p) & 0xff) << 16)
+#define EP_INTERVAL_TO_UFRAMES(p)	(1 << (((p) >> 16) & 0xff))
+#define CTX_TO_EP_INTERVAL(p)		(((p) >> 16) & 0xff)
+#define EP_MAXPSTREAMS_MASK		(0x1f << 10)
+#define EP_MAXPSTREAMS(p)		(((p) << 10) & EP_MAXPSTREAMS_MASK)
+#define CTX_TO_EP_MAXPSTREAMS(p)	(((p) & EP_MAXPSTREAMS_MASK) >> 10)
 /* Endpoint is set up with a Linear Stream Array (vs. Secondary Stream Array) */
 #define	EP_HAS_LSA		(1 << 15)
 /* hosts with LEC=1 use bits 31:24 as ESIT high bits. */
@@ -2538,21 +2539,22 @@ static inline const char *xhci_decode_ep
 	u8 burst;
 	u8 cerr;
 	u8 mult;
-	u8 lsa;
-	u8 hid;
+
+	bool lsa;
+	bool hid;
 
 	esit = CTX_TO_MAX_ESIT_PAYLOAD_HI(info) << 16 |
 		CTX_TO_MAX_ESIT_PAYLOAD(tx_info);
 
 	ep_state = info & EP_STATE_MASK;
-	max_pstr = info & EP_MAXPSTREAMS_MASK;
+	max_pstr = CTX_TO_EP_MAXPSTREAMS(info);
 	interval = CTX_TO_EP_INTERVAL(info);
 	mult = CTX_TO_EP_MULT(info) + 1;
-	lsa = info & EP_HAS_LSA;
+	lsa = !!(info & EP_HAS_LSA);
 
 	cerr = (info2 & (3 << 1)) >> 1;
 	ep_type = CTX_TO_EP_TYPE(info2);
-	hid = info2 & (1 << 7);
+	hid = !!(info2 & (1 << 7));
 	burst = CTX_TO_MAX_BURST(info2);
 	maxp = MAX_PACKET_DECODED(info2);
 
