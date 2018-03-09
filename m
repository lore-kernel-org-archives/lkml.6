Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520629815; cv=none;
        d=google.com; s=arc-20160816;
        b=P/lmd1pYaY0pEvtn3DUDmBiuOrfZT1ujNprKg2FgmdUQnqi3bQ+/HCNsFSkDSpBwLN
         I2InJ3NCSI/8loZupyYbqtM79kFLtp8ztouqGPLr2Q9VgjFmYgsAkY8MVtNi2+IYcVmD
         LdK8ftGxBaL8tm+NLsZ8Z2j/B6HoEMmH2Wxxhty6QuF01MBPrTNniK03dEESPw8+1nKO
         upmlrAZY3y0ReieGV3yIS/SWEEEIIf6sXpNnwgEtpNHijo1D1Lx5uy7UhDC24Pc9ZZWX
         yuDfTnQxtrSY44y6C+R3hcY/XisfOCZDw4Un/7dBzMZaiOGX0pScyTBQm+LzGxcNDm3y
         sRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=zGMvs2WShFG0fwUa4ySK2pAqKovLnSJWteSMzhTtPP8=;
        b=NdYCp1fShsc4YiWWc+nt6jm35rd3wkmK4dME3pyqV3r3GhKzLt63kE4Tk6chWUYK1f
         NlHeWZjYBRbtQ/Aen4zw7K5p5MQo6tlrDG6j2tiL2S9cTiwX2+UAcxBvxsFWyMcJiuH1
         TRLu4GseJAk8OzZgkBJ/r19hPVq5KRU1dw7zUiFL1VoAMh9ZOnW5F9uWS9FMYTOFN/mh
         aJiBRUelCjy/15uj+4TDgu8RqvKYrBDBhjn6Vr47cRukc9VOKZQJMC+YzJwuHNgkK8U0
         LP1pVuQZY/bnVGDUoTbmCc9KD8kOw+ZTy3IkWmJj4N9bGakNbFFyQw75dqR3GruYGSVN
         B/0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fLkAFCxX;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fLkAFCxX;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsZ2lKnQc3I03DI1aSNUVvc+X/GNtLBXOMx2aTxKg3tSCzLvBSY5+JSdNIHic4JW8o4hUwFzg==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net,
	robh+dt@kernel.org,
	mturquette@baylibre.com,
	khilman@baylibre.com,
	vincent.guittot@linaro.org,
	skannan@codeaurora.org,
	bjorn.andersson@linaro.org,
	amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com,
	davidai@quicinc.com,
	mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	georgi.djakov@linaro.org
Subject: [PATCH v4 6/7] dt-bindings: Introduce interconnect consumers bindings
Date: Fri,  9 Mar 2018 23:09:57 +0200
Message-Id: <20180309210958.16672-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495929599493024?=
X-GMAIL-MSGID: =?utf-8?q?1594495929599493024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation for the interconnect consumer bindings, that will allow
to link a device node (consumer) to its interconnect controller hardware.

Tha aim is to enable drivers to request a framework API to configure an
interconnect path by providing their struct device pointer and a name.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 70612bb201e4..7935abf10c4b 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -45,3 +45,26 @@ Examples:
 			status = "okay";
 		};
 
+= interconnect consumers =
+
+The interconnect consumers are device nodes which consume the interconnect
+path(s) provided by the interconnect provider. There can be multiple
+interconnect providers on a SoC and the consumer may consume multiple paths
+from different providers depending on usecase and the components it has to
+interact with.
+
+Required-properties:
+interconnects: Pairs of phandles and interconnect provider specifier to denote
+		the source and the destination port of the interconnect path.
+interconnect-names: List of interconnect path name strings sorted in the same
+		order as the interconnects property. Consumers drivers will use
+		interconnect-names to match interconnect paths with interconnect
+		specifiers.
+
+Example:
+
+	sdhci@7864000 {
+		...
+		interconnects = <&pnoc 78 &bimc 512>
+		interconnect-names = "memory";
+	};
