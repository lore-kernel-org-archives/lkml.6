Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvUcsYM1N9BWYR89s8zwoJhkOPWSz+oNkSfVXpwl4E0qHMZG4QcjXoF2xLnAKbNlmxgzXvg
ARC-Seal: i=1; a=rsa-sha256; t=1519981001; cv=none;
        d=google.com; s=arc-20160816;
        b=dzAuW2PHSdSths4IkiQDMU3PzrF8lxgZJIbFjUtA8QhHM85Yigt5fzBbeGpgeIl0tg
         TszCLQd/ILqjyJ3bgZP9M+1LwUTL/MO4NacKkGTWIUKO+Jf6IWMyaP8etomgdMiH9MOE
         KoOCf14bVj8Km2yBI+DDrmoY5wIKXfPbNVT4kGZSifaHoNijWW7YQf3tmqsY02hEhvRq
         XSq92lkiyhsYv0hTL5BT5mKJhUEbInQC7SSnNBUqMwjXFPgLB/EcICl2LF8b1BesZLcM
         zeaI6STPhuon8QaFYCqZBCed+tEI4fpDYE+8pNGhccL15J6ibtBtsnu5d+Orrx50VlSe
         Ebqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GOxuGhclq+svZnogadGmCYIB8PdqBzi2YeYm/lwWFA8=;
        b=vKXJ4NyIDedLN36Z3nY678brfJubGbITtNqKjPgAxMX/j+8yE0RUTplXmT3Y0mTI/Q
         pA5SEPeY1rt69fAWnGIp5Ur2VFUuV0vmPUuHFZFAyyuFHJhkJ2AhsLyRmN9okeKlvUIz
         G/+Ws9HermDn4TrCKeZWsUbPIiJdeqkj7TubyTQG5M66HfRrYhKAEzKwig4Yy+N1haUZ
         BBFme0Uy/VCjH093JKzwJ88FD2yoaKEH4iaXV54N7b3BscUdks9rdhuDdhpbMhVG/nLw
         UZ1pAsU8BBm7sf0GnDm6ZAYjY/hfvzw5NSgdhmHqyQIe2RwzAukqbPuMpiS+PIBMo/GE
         donw==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 21/56] net: stmmac: Fix TX timestamp calculation
Date: Fri,  2 Mar 2018 09:51:07 +0100
Message-Id: <20180302084450.674988291@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815599183712138?=
X-GMAIL-MSGID: =?utf-8?q?1593815599183712138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fredrik Hallenberg <megahallon@gmail.com>


[ Upstream commit 200922c93f008e03ddc804c6dacdf26ca1ba86d7 ]

When using GMAC4 the value written in PTP_SSIR should be shifted however
the shifted value is also used in subsequent calculations which results
in a bad timestamp value.

Signed-off-by: Fredrik Hallenberg <megahallon@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -38,6 +38,7 @@ static u32 stmmac_config_sub_second_incr
 {
 	u32 value = readl(ioaddr + PTP_TCR);
 	unsigned long data;
+	u32 reg_value;
 
 	/* For GMAC3.x, 4.x versions, convert the ptp_clock to nano second
 	 *	formula = (1/ptp_clock) * 1000000000
@@ -54,10 +55,11 @@ static u32 stmmac_config_sub_second_incr
 
 	data &= PTP_SSIR_SSINC_MASK;
 
+	reg_value = data;
 	if (gmac4)
-		data = data << GMAC4_PTP_SSIR_SSINC_SHIFT;
+		reg_value <<= GMAC4_PTP_SSIR_SSINC_SHIFT;
 
-	writel(data, ioaddr + PTP_SSIR);
+	writel(reg_value, ioaddr + PTP_SSIR);
 
 	return data;
 }
