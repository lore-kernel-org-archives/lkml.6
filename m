Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq/XXoIi4pOuAY8w0KEYZYyVePkUjDwyPqHS6yqiDySBVQg58KL8CDHIAXd/DcWpnBqf9Qi
ARC-Seal: i=1; a=rsa-sha256; t=1524838130; cv=none;
        d=google.com; s=arc-20160816;
        b=jkGGIOt9Q2BfYPd8u+WLAsHhOS0/TLcrAqGNJLBsD3HWG7pUs/fPmV8niLiXR5BGcO
         5CTfMHD5GDyJB/vQpQ1Bbn79ZYiqP+btsGRmsHziou43n5+34/ijGyBvNnzh+drAUyQh
         sdX5yXylWNCdaxbMWDkZsJb+abq0u75CHdt6/U+wtR0Ovs4kb2j/eiH0AEwOF2h1Xe2D
         m0ciTqK6MvCWXSfRuPwffb3R1AfF8he3D3g0oj7+olCbuAxeohfial3tk9+XpiNEbdcg
         6yeoxPPN1g9862j84CjJAPx/noYlSB+uBS0sbyWYb8t0uCAAYQVurlQt7hleF5OxX5yI
         gH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=hU56YurvDgJhfMid1XOOkfPSMPPtaYrJ7vEvENW+mDU=;
        b=gTSmfTohYbf6bOZN46hnWWtO+mGl3TwePRW+iaaQalZHGwDCq3TeUPyVNXWrHXF1dD
         l0DCZg20r2aDnVhphQHFYSiZdfHff+uBlJ+CO8F4+JqLSLPlnTOiDJUYx7MNL0qi9UwP
         LX9Qqnlw7pdcyDN/AgJjzmA1fVrjbZAlNL8y3H57ENU8Zc82tN+6uu6K5O4rF7bltdi1
         37cp2J8eguvsKv7EQPDMD8+FtBHNqoeIrPnH0h61q9XkNldUNh+/sKpCHjRAF+v1zCNe
         wc46RFJ8ZJQoIarbkJZnwuXgIxA1zL3RBh06EpBjHvkTCWPdq67233njNjcYAkEyRMjF
         a30Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B38021892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 38/80] net: ethernet: ti: cpsw: fix tx vlan priority mapping
Date: Fri, 27 Apr 2018 15:58:31 +0200
Message-Id: <20180427135734.895904621@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908434647327307?=
X-GMAIL-MSGID: =?utf-8?q?1598908667171811548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>


[ Upstream commit 5e391dc5a8d801a2410d0032ad4a428d1d61800c ]

The CPDMA_TX_PRIORITY_MAP in real is vlan pcp field priority mapping
register and basically replaces vlan pcp field for tagged packets.
So, set it to be 1:1 mapping. Otherwise, it will cause unexpected
change of egress vlan tagged packets, like prio 2 -> prio 5.

Fixes: e05107e6b747 ("net: ethernet: ti: cpsw: add multi queue support")
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -124,7 +124,7 @@ do {								\
 
 #define RX_PRIORITY_MAPPING	0x76543210
 #define TX_PRIORITY_MAPPING	0x33221100
-#define CPDMA_TX_PRIORITY_MAP	0x01234567
+#define CPDMA_TX_PRIORITY_MAP	0x76543210
 
 #define CPSW_VLAN_AWARE		BIT(1)
 #define CPSW_ALE_VLAN_AWARE	1
