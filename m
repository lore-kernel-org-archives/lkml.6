Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226DjQili1BgCZMLgtAcXbFGQEVLKWz89ipY+7isqmBIxevwKDhGeWz6Skh/DMqKyjOeRNFP
ARC-Seal: i=1; a=rsa-sha256; t=1517591484; cv=none;
        d=google.com; s=arc-20160816;
        b=0EavmFa8pGWShHBJnVf0nu9BBCZv55LI6dUkK+odTBLPIuiKItM8VK8/WTc/wGbbG/
         jPNuD/0i+lo/CIKZHg1rLiaAmR80PB26VaC2p5TIaFEFaJQHsY0zaCfppUQ6cCXzy/2y
         7x1SORkvOcQS8Lzcc+xQs7l/hsufYnR4Svl3FFuF6Tu7S3WqlCtmcQ8ApYp/A6jpRw9J
         K9V1dgKdaFPOonl0OEwX/AOc6HEK/yG9NaSiYObLl++3qjRcBxs9SS69WB6Q5uP0eRCQ
         qf4CLUiZd0bVC8GqWgZ3zr+7FAmjOZzKsEBQiWYtScILZNUmxWkq+fEEkw0tUiXbbD/I
         Fsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WYxZfI3Ksdm/tBnbshKaCJWro3o1JgmeajAN+4kwQxg=;
        b=tt6XxNRlJcOKkCevAQZYtCJycy5O5htpxNJ7Er46OZZc++H4pWw2WnR1Yq3t1ErNO7
         DU+47hM8fOB3eEXwUZTIXbhOw9fgzqB5f1okHJjOfAWaGXGUOSwbXO2U2PYIGy5VEdPC
         5HDTtNYq5P+N7zsg+5EBsL6A0B/j+O4Qn0YYrBc9jTFYb8jwwAxnRcHEf1w7MV4A48J8
         rsbuzD99cXeTt40uhYc0A3mbh869BPE2uC4/BZaXpBT/gZgYMMmwbDwNwC4jTS7BYzPU
         bPxv4KJFUfXCZ7EsaLjw9c7R9x5elATfYXDu8AwR80EjHf2HAPAvv0B9OUZ8XMidcV77
         JjvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 095/156] bnxt_en: Fix an error handling path in bnxt_get_module_eeprom()
Date: Fri,  2 Feb 2018 17:57:56 +0100
Message-Id: <20180202140844.526691239@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309725140918750?=
X-GMAIL-MSGID: =?utf-8?q?1591310008515329296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit dea521a2b9f96e905fa2bb2f95e23ec00c2ec436 ]

Error code returned by 'bnxt_read_sfp_module_eeprom_info()' is handled a
few lines above when reading the A0 portion of the EEPROM.
The same should be done when reading the A2 portion of the EEPROM.

In order to correctly propagate an error, update 'rc' in this 2nd call as
well, otherwise 0 (success) is returned.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2133,8 +2133,8 @@ static int bnxt_get_module_eeprom(struct
 	/* Read A2 portion of the EEPROM */
 	if (length) {
 		start -= ETH_MODULE_SFF_8436_LEN;
-		bnxt_read_sfp_module_eeprom_info(bp, I2C_DEV_ADDR_A2, 1, start,
-						 length, data);
+		rc = bnxt_read_sfp_module_eeprom_info(bp, I2C_DEV_ADDR_A2, 1,
+						      start, length, data);
 	}
 	return rc;
 }
