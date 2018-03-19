Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs9WPzddS/4QSsEhO/FerDY4WP1vjnPPZSc0aLcBp+5UOLTg8kMQEmGN2Cn3XE+segpfiwF
ARC-Seal: i=1; a=rsa-sha256; t=1521483712; cv=none;
        d=google.com; s=arc-20160816;
        b=kRuEoNIU2CU5QNwmVeiFXzV82PD2xlHlRBdJZYYNvuG1VpZwDHFn1lG26e/kWwMYTm
         h5H2vgLvX2zznAtKzwI5AM7J9F1HKyKbVNJ2HXTOAmo9PrVx67Ol3zV1Sz36DVHIIDPO
         ELkcoREiBh+KYVhBsghrxrgcgBAQZwEmjGK24pBMtPE1O3Ljh1Ys4oeu3P9I4smcdM6F
         ZF+ZIxnAn+kU4e38oXS9j0HxNuxlOoElqqfyDdBin5tontn3ivgGD1qbrn1Rz4pbwAJ3
         RJO6Nms1TntEhKCZSAscS19T2mGOPVVoKI7Q/K7599OhR0wLGxiXnnQF+tmyVzmqBe05
         vCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KdzplP90BZMDQWxze2OC+nVu5Z7niamSbe2TfxfYS9A=;
        b=FlYTom2gcKJEhkxmKmZG6x751RfflN9U3TpfkQS96BXUe2wC4ZJpm5DlY3cPh1SlHb
         EitrCo2FXLp8Aq41Bt1XcEFSP7PTQP2dRci6Jb5R3CC0o6ol00PLL0mZmNm9NC6oZi/b
         QyGdnWrl2VEMp+4tLHEKwEpE1QUVrSkfWEhxm6R6UD9Z+P9U3XQogxWH6AAWBrRo3BHx
         0PPvP1JtTKZYS+iboqLocO2nf8ryzm+lJz05LZHPQ1DMVNFZXd78NK6fM+vA+8Bfd7/G
         Aa+Q7U1k/N9QrfrAktU6XAeAUfUlf53E7OC/2/rwzW2i99nRN9Hyz/l6xEyr24PtjcqL
         XJ5Q==
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
Subject: [PATCH 4.9 089/241] vxlan: vxlan dev should inherit lowerdevs gso_max_size
Date: Mon, 19 Mar 2018 19:05:54 +0100
Message-Id: <20180319180754.891352785@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390885442025178?=
X-GMAIL-MSGID: =?utf-8?q?1595391305269253780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2912,6 +2912,11 @@ static int vxlan_dev_configure(struct ne
 		return -EINVAL;
 	}
 
+	if (lowerdev) {
+		dev->gso_max_size = lowerdev->gso_max_size;
+		dev->gso_max_segs = lowerdev->gso_max_segs;
+	}
+
 	if (conf->mtu) {
 		err = __vxlan_change_mtu(dev, lowerdev, dst, conf->mtu, false);
 		if (err)
