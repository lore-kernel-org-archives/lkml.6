Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs7eIo8W7DLmeWxX9bPzRvf14sYSBxzenbe4sudQlKNPO+8q3qny3zSVvBAmoIg7LW6S0d8
ARC-Seal: i=1; a=rsa-sha256; t=1521483312; cv=none;
        d=google.com; s=arc-20160816;
        b=iNafyl9qwJENPuvu5EX+2XO3J56CF4OWSLoEcWnRAzHUr7NcoKCJ6fnj9M4bif9BZ1
         Q+Kc3Gv/MyspJlbX9w3vCNshdl6EZtUdB+mIvt+CE/jhJ1PFgZSMIqPBNEllvncPlggD
         3VpDyWM+VRJXTkGB8N8KmitwR9ia69Ua9guYyLe9jMTq5HpukMg4I0aex/AoC6OEZSPx
         3UG5gRuOdaRrQfMTnNOSvRj3FcbBtiqxqwoFYzH6noAg5pvxdQsc0+VMcpENmPqrSrBD
         qKgpMDaOpDtLzk9OyhiNsaMl+B6Em0Y6RUzXgx9tCFWaPOznnhshK5kN5RvwxEcCTvpE
         YpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8Ypt9shM3tmZ6rKwuVK8cjxNMcnDhXDaRnHb/Y3bvM8=;
        b=VszosnQU3FSAov4IV7D+JXM0uCTaJqiIwZPCwIRbORcNSU+tIPoU2F7keEPyXmhZw+
         hnQ9ZknQ59+1NVlR6XDkeLkkVt2LjBddwizIR+wJi0q3F+1CisoZW1VaLXIwfNgwuhbD
         /BFk2ymgyQRMPAN/Oysh8Udd3DQPzqPtFas6Y1tyEus+36VnzKpBEUmmW8Vx5m+XQnNC
         kGbCiUcsCUaxnIz4LP3IKqF7+ePkQDnOonb+87Aq9+4pS0xGz7S0M3Xt1Dm8hTJAIudR
         vPgOmQNlSIyQ9oy6mU4tKxsENtaqoL6UmamkYREZ1g4Jrajj5cKPV0XVjB1XCgVVhXJ8
         MFEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felix Manlunas <felix.manlunas@cavium.com>,
	Satanand Burla <satananda.burla@cavium.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 044/134] vxlan: vxlan dev should inherit lowerdevs gso_max_size
Date: Mon, 19 Mar 2018 19:05:27 +0100
Message-Id: <20180319171855.752190937@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390885442025178?=
X-GMAIL-MSGID: =?utf-8?q?1595390885442025178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Manlunas <felix.manlunas@cavium.com>


[ Upstream commit d6acfeb17d030bb3907e77c048b0e7783ad8e5a9 ]

vxlan dev currently ignores lowerdev's gso_max_size, which adversely
affects TSO performance of liquidio if it's the lowerdev.  Egress TCP
packets' skb->len often exceed liquidio's advertised gso_max_size.  This
may happen on other NIC drivers.

Fix it by assigning lowerdev's gso_max_size to that of vxlan dev.  Might as
well do likewise for gso_max_segs.

Single flow TSO throughput of liquidio as lowerdev (using iperf3):

    Before the patch:    139 Mbps
    After the patch :   8.68 Gbps
    Percent increase:  6,144 %

Signed-off-by: Felix Manlunas <felix.manlunas@cavium.com>
Signed-off-by: Satanand Burla <satananda.burla@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2834,6 +2834,11 @@ static int vxlan_dev_configure(struct ne
 		needed_headroom = lowerdev->hard_header_len;
 	}
 
+	if (lowerdev) {
+		dev->gso_max_size = lowerdev->gso_max_size;
+		dev->gso_max_segs = lowerdev->gso_max_segs;
+	}
+
 	if (conf->mtu) {
 		err = __vxlan_change_mtu(dev, lowerdev, dst, conf->mtu, false);
 		if (err)
