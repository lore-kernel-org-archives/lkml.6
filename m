Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrI714LdzJimnV4hzRjFxg1lhc2v1UP5HvGT5YlPGDunA28a4N0rjuRjMtLJCUIh1Jq+WVf
ARC-Seal: i=1; a=rsa-sha256; t=1525116457; cv=none;
        d=google.com; s=arc-20160816;
        b=nq3VX2bcTNLKCqil9nyigWLUHhrm1K3v3tCJGK7Bq451gwFTOshXXg/IWID8yfQHEj
         hccT7g5FTZ5wHmZzdm8UnLLK0nQ/1CxN3WjpNvv13LOCNRiBlU4ajANhnW83QAn3xu5t
         bdBnIyVGx57EtoY1oEocp6Z8jaNAsVLQtN8MuvL++GbyHpFHo1NukdUTFTOZ5elaJJVP
         1Do7EV/FrbPQze1yZzD/Dsce6ETtf5tmfggMXogdbjRAHQ/kLGCQZMDd3GWF21Maibeg
         y6k5CCxY5DUfwiHXNX1/rg1Q5uu3mJ4bKXDW+8ph//kNUqMv+kmYKuYjMh45Nsl02ZOv
         x/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=51MbXB0UzuM/KmcB2653YpZa2aJcZ8V64YUJQ/dCV3w=;
        b=mDlRK5d1Er3MvCWyCEqnX1bbtKnmhkRuIWjHhqA89MozLWDaBznBNVQJc7thuHZWfS
         JlzQqwT1TGcr3EYf6T4o88wsog8ohNUIvD1UxCxSH+DsVslJOfPTORzkG8Wwte1yfPox
         8dku8VOwm9vILbrG4DwUPO+uyw1p7YRWLLLt+/GIyhAZYfaoJmT5QU3EE9SaLACUYu9M
         SNVPmuGnwnLtZDm3v5sujscsCmwv2fRv+RUxY4SEMaUjNgnG5IcH4RbDjT8qr4zjXNn+
         oOssGPHvv0ecAHwBJg/CutHQwedtj3V8OPEv8GaC2EpuInsdGgjm3KKS97mSACee2nTi
         ClEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFD1235EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>,
	Alan Tull <atull@kernel.org>,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 4.14 76/91] fpga-manager: altera-ps-spi: preserve nCONFIG state
Date: Mon, 30 Apr 2018 12:24:58 -0700
Message-Id: <20180430184008.243601470@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200514004063912?=
X-GMAIL-MSGID: =?utf-8?q?1599200514004063912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anatolij Gustschin <agust@denx.de>

commit 881c93c0fb73328845898344208fa0bf0d62cac6 upstream.

If the driver module is loaded when FPGA is configured, the FPGA
is reset because nconfig is pulled low (low-active gpio inited
with GPIOD_OUT_HIGH activates the signal which means setting its
value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/fpga/altera-ps-spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -249,7 +249,7 @@ static int altera_ps_probe(struct spi_de
 
 	conf->data = of_id->data;
 	conf->spi = spi;
-	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
+	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
 		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
 			PTR_ERR(conf->config));
