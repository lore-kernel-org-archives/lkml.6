Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523817202; cv=none;
        d=google.com; s=arc-20160816;
        b=YJk6COzcDQg7Q/fJWyVFDzAI+LdTq4wl7mKZXHdQpno2cQ8EYithbzvlwFO0sa1SVL
         1+k7/6oOeIbzQbJ3NgPYHFoiYd0297P0sl/e+wYMphhQEtex9VBZUh9PVxIpDPyskI5N
         mBiRGyckiKa8+nj6G6zi99U4GNNzmRj4+SWyOlf/u4v3n0kU8OXFQCyyjJUiv+BWBO/x
         7/6NWMA9iXZxThCvPfQfn+1th7aGZEXyq8PkQCApyD2Tqee6jU8iev3WWe+nBT/6EwsB
         aqUZyka0otn6rN1+5wnbLkkduI3VcWe+BiOFWDctq+nsrz6uXkmZKzfIIkOjGXKUc6CY
         1JnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=5Wvjpw9GPo4BCafG7CZaI3rXvG7RbcXL63uN5tumvzc=;
        b=DGEDctU2P3OYxczD3eDSbU/24j5e//U2P6Wuja/pVNgwArc/YtSr4ozUSqLtX6CAt8
         7Fm2Emuc4HkcQ1mLEHSWHYacVvUDyuefN7c602ORkHtB/UhqqTa+ye0X/fjr9/TGeb7u
         WWB3GlQBgg+mAQsAZ0SqNPCb2lJ9TB/PQ9flCkayl6FaOd3NNbCtIVSSmL46FbjSneRr
         PBBSbP2Bj3pbonkWgFcFESA7q0KNvARkMgREq/3Cq8mv13ObqzJjXtaJ+Y0eikGvOqpG
         pMkBNYS5Yxo4aWDi2qvnOLqx50TOCYMGMhpF4mwKPLMN6pWOGfNs/pKDE7Zn5p5EvrdS
         FldQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx4/5uqltfyLW4i+X1XMO/FrIgSVnOcMq3ylwIggNZpoJ/4buGp4IRi5moS3svixnEDq9qAcuFg==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga-manager: altera-ps-spi: preserve nCONFIG state
Date: Sun, 15 Apr 2018 11:33:08 -0700
Message-Id: <20180415183308.31402-1-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597838146681454116?=
X-GMAIL-MSGID: =?utf-8?q?1597838146681454116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anatolij Gustschin <agust@denx.de>

If the driver module is loaded when FPGA is configured, the FPGA
is reset because nconfig is pulled low (low-active gpio inited
with GPIOD_OUT_HIGH activates the signal which means setting its
value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.14+
---

Hi Greg,

as discussed. Can you please take this bugfix for 4.17?
I rebased it against next.

Thanks,

Moritz

PS: Sorry for late submission
---
 drivers/fpga/altera-ps-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 14f14efdf0d5..06d212a3d49d 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -249,7 +249,7 @@ static int altera_ps_probe(struct spi_device *spi)
 
 	conf->data = of_id->data;
 	conf->spi = spi;
-	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
+	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
 		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
 			PTR_ERR(conf->config));
-- 
2.17.0
