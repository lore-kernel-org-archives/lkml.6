Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpKC1QWJdGGAzfTFqUw35y3TBqzBfGTMVwKYtTw3GLzws/Al7AkL+OUt+0tYHf2p8ZklCel
ARC-Seal: i=1; a=rsa-sha256; t=1524838289; cv=none;
        d=google.com; s=arc-20160816;
        b=udp/fACzMyAXrlF+91GcOUKJyQGRcbOGjlMZz6MDjwlyoQF/IP4rFYEaFbmwWf/JJa
         HPIBS0CLtxtU4qCUNZ0JSi55lMMs682ys12QeKBGn29/QzBi3RWoZjvVeNTUCNeUWJjc
         2fH3sQbxIxjFxcOUoweWAeDd1/XluPIeKCNmQ9QmZw3uWLo8r1qAfUpGX2ssm48XCmYt
         N/qrd76S8cR+wrAUJS9d/Bvikb77dF18zYfGazytSD/lsBzebJU/wKA3wUkpXeKvrziU
         cgfiWtZb6lmihEtvA1DtA/jm82v2UPt63AR5qNq2qoCUbumIJaPs2q/7/Dle6aFStIkh
         lgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0VxwJxk4iw5VNkqjfxoecqQ0obSbgWt5sXUEpv39Z5M=;
        b=lC67DEld76LLu0QWI5g1CyD2SgG7dQiUrYCG20nCM91cINWV8+TbF14IOEGr44rn/i
         3STSJ2CiuZQ8thIkRnQ64jitG58iz/AUhMI+f+V9r2zWNUN6DpDW5g+I1pF8DGhRKYfl
         f1NolRIASgNHjq9ubjkTY16LvpXgyKyaYvJao0ujD6qz8stskIhLrLi5kKUorSbnpCCj
         svSu47lnU+PHZYUiAHszgSI5Bw/K5vNdAW2bSrUiN4RNQPbar/dU+V+ohrszcqbpVi7g
         DZjz4UH7RTLZn8I20B+gClip0shBhlHUUzJiO+Cnva5Wans1D4lVMR+pXR22O0NzO/mu
         uQKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ADD21895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 50/81] net: ethernet: ti: cpsw: fix tx vlan priority mapping
Date: Fri, 27 Apr 2018 15:58:52 +0200
Message-Id: <20180427135746.128377272@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908434647327307?=
X-GMAIL-MSGID: =?utf-8?q?1598908834191520891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -125,7 +125,7 @@ do {								\
 
 #define RX_PRIORITY_MAPPING	0x76543210
 #define TX_PRIORITY_MAPPING	0x33221100
-#define CPDMA_TX_PRIORITY_MAP	0x01234567
+#define CPDMA_TX_PRIORITY_MAP	0x76543210
 
 #define CPSW_VLAN_AWARE		BIT(1)
 #define CPSW_ALE_VLAN_AWARE	1
