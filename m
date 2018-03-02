Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtp1nTZ/DeiL4yTrc8JP6aPgPdGJtD4wY8YnHzKHMlXs/Fv5E+i31EBKnbw2pj1tFkPafF0
ARC-Seal: i=1; a=rsa-sha256; t=1519981249; cv=none;
        d=google.com; s=arc-20160816;
        b=d+SqTqf41rm+fcPVan3JusVU9I0UNRTHjZJxwP0kkuYg9Xsfs7GH1WgABZ6hX8ratI
         Rs85sqHgajOw6m39TF3PfCtRHiwZYa879N1umL6wBiDSxFmGMOlh0PunWWFTJLePU2at
         g9iwGYA91Bp6t7C3u9B1NN5HJeefPHmEKXPmWYXjHthDR2J3N4mFeZcz0EDLTersBqZK
         k6A3GqJtxOpni3ZzBkD3yHzG6xWzA/cqjMtGiTPe7h3k0Kq2g5025zRfhc9ytjsnoRbj
         wTHc9n2juaX/WglHobx2VG5lNJpTFyaYQpxS2dz3S8onn1AotiL7p/ZpI8METQmpnBIw
         undw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0PWlPRvCzDbSnOExTbBR6l8DFsfjNG4XxxPQxgUwDQ4=;
        b=ZixQqVfpBntaE5zsB5mxmMSgR8Odpyr/k8z1/bmmX4Cb/SkPtG157EgPLr7J5FfsH9
         PVSFtqE9DXR9rduz2N5mu+Q86sARI//P5hOmcS3XlzRaGxtBAhhfhStwl4IOBaZN31Fw
         H+sR0NVb+aa7SvC8A+fvxkuc3gyQShBbh61iWOfPz9cNa3Fdf0pu/o45HLbQXIX+Ze/s
         BtzgKKNRBUwH/bYa9gNPgJCqGxTKHWn4V9TmC86s9nHxilC1Ktorskaq4Neh26Y5vIZ+
         O919BhyE0F7Bw3SmuSZ6L23hujB+qs5BENmsXSahbcdC+qV8wpX7MqdT+ES6D/c4hwQ/
         FWIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fredrik Hallenberg <megahallon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 036/115] net: stmmac: Fix TX timestamp calculation
Date: Fri,  2 Mar 2018 09:50:39 +0100
Message-Id: <20180302084505.334349934@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815599183712138?=
X-GMAIL-MSGID: =?utf-8?q?1593815858280306070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fredrik Hallenberg <megahallon@gmail.com>


[ Upstream commit 200922c93f008e03ddc804c6dacdf26ca1ba86d7 ]

When using GMAC4 the value written in PTP_SSIR should be shifted however
the shifted value is also used in subsequent calculations which results
in a bad timestamp value.

Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -34,6 +34,7 @@ static u32 stmmac_config_sub_second_incr
 {
 	u32 value = readl(ioaddr + PTP_TCR);
 	unsigned long data;
+	u32 reg_value;
 
 	/* For GMAC3.x, 4.x versions, convert the ptp_clock to nano second
 	 *	formula = (1/ptp_clock) * 1000000000
@@ -50,10 +51,11 @@ static u32 stmmac_config_sub_second_incr
 
 	data &= PTP_SSIR_SSINC_MASK;
 
+	reg_value = data;
 	if (gmac4)
-		data = data << GMAC4_PTP_SSIR_SSINC_SHIFT;
+		reg_value <<= GMAC4_PTP_SSIR_SSINC_SHIFT;
 
-	writel(data, ioaddr + PTP_SSIR);
+	writel(reg_value, ioaddr + PTP_SSIR);
 
 	return data;
 }
