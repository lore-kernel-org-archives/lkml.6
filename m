Return-Path: <christophe.jaillet@wanadoo.fr>
X-Google-Smtp-Source: AIpwx4+O9czvI6jqz6Qo9t94XMssJvH2T2eFP1Uwhq3fzwqNlaH3pxgTC5kdnp4tKre5PVQI//tK
ARC-Seal: i=1; a=rsa-sha256; t=1522677811; cv=none;
        d=google.com; s=arc-20160816;
        b=qJje7u4/W3unmvgrra9a4yt/nhpeaSUZabDCLUqZWsWX6Wm2y8aOpErpi6geD20o71
         xAVgaiToleOgAh/oSEQhH7mvYy83QNYwSCiHRsOxbXjYIWdlggWUX76nK3h/fXj6b17z
         zTmZf1Jb8eFYNkwn/zhajIB3p8ZvOl/rbD4+hTkhGGTQS4R4DR0wP4RGVBnodxnRg57C
         OEisiT2Bkki3unUwkVbWp22u5PpFWtXbO1xODhOFhr7g6J355E38X3znODAqeCsYpvPs
         G1cQhMIgCCLr/LepXEx1oCLg65tCs8feKwarrCioXnUSpkNe+bSYLX0k85ODNgPnaCDi
         UDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=xKQB6tR+NFOLeasiqEcPdY2SMnT6T9oU98m7G4kkHaY=;
        b=hBfg7QkHfZ4Ch5JamUd2nCfZjfOMiY6XIn9vEdpEtarQO9Itva6XgKZI39j9dvtwO8
         JJNZqX1IVqsQ+TMVMeQ2PT5un4MC4aKseMifjg6gWsl0zBtDa1zcupSbJ91u6lfZqqIu
         oWgqIdl+OEmnK4h3aL76o4kcPq05GNoEPj4xwJvkqM+WF2t+g/GKJTWk1k4yssKARoAe
         7HSHXRXTOpmDWnfNKsAaDiRJV0o77fpidvJ6F2oCgAk5LRvZbX0EHlVaMLlV/QPtxXgq
         2oE93upD/vcKdw+SXvNOv+DgtaocHxA27iPq8fmQQ3a7/Q0JL9hhfpTeNZmdtXgrEyGi
         EiHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.123 is neither permitted nor denied by best guess record for domain of christophe.jaillet@wanadoo.fr) smtp.mailfrom=christophe.jaillet@wanadoo.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.123 is neither permitted nor denied by best guess record for domain of christophe.jaillet@wanadoo.fr) smtp.mailfrom=christophe.jaillet@wanadoo.fr
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Apr 2018 16:03:30 +0200
X-ME-IP: 86.244.119.222
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: dmitry.torokhov@gmail.com,
	benjamin.tissoires@redhat.com,
	gregkh@linuxfoundation.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Input: synaptics-rmi4 - Fix an unchecked out of memory error path
Date: Mon,  2 Apr 2018 16:03:27 +0200
Message-Id: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596643408771291983?=
X-GMAIL-MSGID: =?utf-8?q?1596643408771291983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When extending the rmi_spi buffers, we must check that no out of memory
error occurs, otherwise we may access data above the currently allocated
memory.

Propagate the error code returned by 'rmi_spi_manage_pools()' instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/rmi4/rmi_spi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 76edbf2c1bce..082defc329a8 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -147,8 +147,11 @@ static int rmi_spi_xfer(struct rmi_spi_xport *rmi_spi,
 	if (len > RMI_SPI_XFER_SIZE_LIMIT)
 		return -EINVAL;
 
-	if (rmi_spi->xfer_buf_size < len)
-		rmi_spi_manage_pools(rmi_spi, len);
+	if (rmi_spi->xfer_buf_size < len) {
+		ret = rmi_spi_manage_pools(rmi_spi, len);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (addr == 0)
 		/*
-- 
2.14.1
