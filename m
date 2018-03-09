Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520629804; cv=none;
        d=google.com; s=arc-20160816;
        b=VvuG9QcqwUH/wDvCSEb3LtZHROZzCAtHVcQg1EsQ3zP8RzluQc1PMru30Jrxh48oKS
         9AYFFlGYlrK7BfEJ56GoUTb65FZbDK5z6ddjPKLfUjys5biYIagD/GptVOAB+89X0QGd
         XS+rqqiavlnJ+85UQLZdo72fSEisGBj/wO6QZVVBCXXACSjvhB4bTo5QOhsLFwxPGHTf
         ttTl+1CaOm8mOJQ7Ztf2210rGLm/DzhvEbFdvIb9U8gq2ikwkVip/bq1FH+OLVYVALEy
         7NaNwAwe9U3wCRBXsN4FZ1JvwW3vR3oRIp0+KWLmzCra2J168j/v+MEOaKw8SYE/QOa9
         MXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=wM/SaubxVX3slZlGlL5x0GjCoPJHmze/47/4joVNGN4=;
        b=dDf9zF+Q3PsSu67GhDlQThHa38O9Cv9Vz12GGU2xlYcT2fFkOJoIlMaKDx90BjrWvp
         j6uXC31uc1IjyC+gLciKNXh7Amyzzz1IaxPpC7EsWNcTwgJwJMLhrXv6shdWq7qL4bot
         jVh+HPST5dBrg/ycfrLGuSGU8A1QU4EjATj9c8iW8ABStjrNGYrRVuGKDix9YQhUr1jQ
         XVjGeBdAfrwVgNInft/yJE8ktmRbB9BaLkTTFIrBQpvE5PMq26M8DQfTuK883kwoqbjF
         DrZwU0CfiJt0WA4QhAa5gB+/hU9wbu0NLo0BxL1AM0kFtBxyewJlPZc4VWrUKGh2+3cm
         HDTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KiG7aLYc;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KiG7aLYc;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsi30g07dlmppAZ3sVoO01Sdm42G8it/12U1GyPNsqrw8hpSbyELITK/lakB9H2Qq3CGCiiZQ==
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
Subject: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider bindings
Date: Fri,  9 Mar 2018 23:09:53 +0200
Message-Id: <20180309210958.16672-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495918143221321?=
X-GMAIL-MSGID: =?utf-8?q?1594495918143221321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This binding is intended to represent the interconnect hardware present
in some of the modern SoCs. Currently it consists only of a binding for
the interconnect hardware devices (provider).

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt         | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..70612bb201e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -0,0 +1,47 @@
+Interconnect Provider Device Tree Bindings
+=========================================
+
+The purpose of this document is to define a common set of generic interconnect
+providers/consumers properties.
+
+
+= interconnect providers =
+
+The interconnect provider binding is intended to represent the interconnect
+controllers in the system. Each provider registers a set of interconnect
+nodes, which expose the interconnect related capabilities of the interconnect
+to consumer drivers. These capabilities can be throughput, latency, priority
+etc. The consumer drivers set constraints on interconnect path (or endpoints)
+depending on the usecase. Interconnect providers can also be interconnect
+consumers, such as in the case where two network-on-chip fabrics interface
+directly
+
+Required properties:
+- compatible : contains the interconnect provider vendor specific compatible
+	       string
+- reg : register space of the interconnect controller hardware
+
+Examples:
+
+		snoc: snoc@580000 {
+			compatible = "qcom,msm8916-snoc";
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
+			status = "okay";
+		};
+		bimc: bimc@400000 {
+			compatible = "qcom,msm8916-bimc";
+			reg = <0x400000 0x62000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
+			status = "okay";
+		};
+		pnoc: pnoc@500000 {
+			compatible = "qcom,msm8916-pnoc";
+			reg = <0x500000 0x11000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+			status = "okay";
+		};
+
