Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsh9rzZTZdNBVbKeqH4kM+BgizwwAK71rapPKE47QEi/62mexdAJoz388dWMtNemy/2uzli
ARC-Seal: i=1; a=rsa-sha256; t=1521214446; cv=none;
        d=google.com; s=arc-20160816;
        b=y3MoIIH9TSWN3IwIE0O4YgMKNhFC1Jz0ut+Fb8vebme3Bq0LBsvZ2Q6a157ZZ00zKe
         huuHwlTJAEML+KshVJWbzZ3IJLThiFbiS4jRpDgk39bIuSulkEDZlDCoZRRUXyHMjri5
         yTbw/3rFFbDvgPve7NqIsq4rTPvjeC32uxlX+OKC2XmPBiPxyV8MqKU0UcEmyvkgah+2
         gQEcR7L7QRA7z5EKgE033ZGXgvV91gc5nUBvpfY492JL8zfPnrzj67UIXhf6xTXCSih3
         rAiRWuPBIvke1Ltjl1cjL2XZ95TMTaQYi6PZw93TnzPiwmPNbm14okiItiRaUOCr4x7h
         9A2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PFv6opqgNStawK57ZydPR32cAAotgoz2S+jUcyaJ9kE=;
        b=xMsgtO7g1FusyhU9uQZGFPYndm6o3pMx2caixSmgWB8UTRtQc8VdGSy2/a56GRrqAC
         LCDarz+Ni5VdzoTihamn5fx8twD00A3j4q3f1O9D94I/kupz2bHzlrNQ9rY5CiuG746x
         PQy48VhmvT3haXMZhCbcDxkIRlnRweIXaPTQCZB2oG3EZtcya7N54FvoIjseyFicOlod
         rXPOXZojjEaSZGX0Aq1rGNbjfvQfbW9CsyEtM0pM5AIqM5WJeD33DYfFCTW6tdFzGtKf
         h3rTVMTmJpJECKRPvHYjXeqmluW59ndOuNYjzL1etlP+/HlRB8hCt8TakxADBNv3dvsX
         UFew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 010/109] xhci: fix endpoint context tracer output
Date: Fri, 16 Mar 2018 16:22:39 +0100
Message-Id: <20180316152330.422245941@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108958602732635?=
X-GMAIL-MSGID: =?utf-8?q?1595108958602732635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -728,11 +728,12 @@ struct xhci_ep_ctx {
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
@@ -2540,21 +2541,22 @@ static inline const char *xhci_decode_ep
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
 
