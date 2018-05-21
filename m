Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoYK8Ql/0T0cRXYL8U9gt+7nDwsdXWky0LT5PKdygLY/i00LDiWyMMk+b9Z5AEnOFub9o7A
ARC-Seal: i=1; a=rsa-sha256; t=1526937752; cv=none;
        d=google.com; s=arc-20160816;
        b=oxVjiENtZMcSPyqIw0A3irVBF/5qCKmA+aKMckgUP4rlMGFTce8vHwIrA5Ll6QaB08
         nXVVZ1yBe0sihx8tJjoCyujQ6bzJTL8ghjE2aCby0Iwn0/X8o/sd56JPPM7XSKrkOcYu
         vXyEEbSWEEnB2Z5IikM0ICV4XagToodJV9YLvr45iS4kr9+02yiexxHDye+yEfgleXAW
         uHOK33rtPqWTVqA5I6WOqo/6T+K2DhwrnF1QggnFYREZoOVs4thpmQK8m6QQ5QmO006U
         SP2DM4s/73sdSLpjukq8iNvExaiDZzWIMj7nMPjHUxUKOFgBp29+QlBpHyy32dbo4T9A
         nEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=slO+nuy4y+QPpRsGFJW0d4L/7CmZ690A7TA4dE6zwTU=;
        b=x52WRFetB+I5AAqA9O/9vQ+E+wAicdSbJjz8M6h2uTKLLq+SWYL7/iwFWb3wCsfrea
         nD4TMjHvPZEF53rYyOd4N3pkRcSoVweMjXiRWDrWTa3Ylq+JFZy/T7BEUWPeVpfK7tHq
         djeSDXdUstFzK3Un20tAu4jXum6jjgoajsrlCt3xoA58wiqKLphgQA074b2VcWTUHtE6
         IEDLz30ib06C7u5TM05b1ooDMqIfwLHPge96Vl3hP5ctDdpmhhn4jslWigIgSWuT3pwG
         Vma9wqb7ZpjhWQGNQ6bEGOw2xvExQi36quPZZP0cnryFhUwCdUrWEEOjvTri8NearJHF
         l1kA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UP3A49mo;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UP3A49mo;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.16 013/110] spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL
Date: Mon, 21 May 2018 23:11:10 +0200
Message-Id: <20180521210505.123001824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109746955059282?=
X-GMAIL-MSGID: =?utf-8?q?1601110280501465543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kdasu.kdev@gmail.com>

commit 602805fb618b018b7a41fbb3f93c1992b078b1ae upstream.

Always confirm the BSPI_MAST_N_BOOT_CTRL bit when enabling
or disabling BSPI transfers.

Fixes: 4e3b2d236fe00 ("spi: bcm-qspi: Add BSPI spi-nor flash controller driver")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm-qspi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -490,7 +490,7 @@ static int bcm_qspi_bspi_set_mode(struct
 
 static void bcm_qspi_enable_bspi(struct bcm_qspi *qspi)
 {
-	if (!has_bspi(qspi) || (qspi->bspi_enabled))
+	if (!has_bspi(qspi))
 		return;
 
 	qspi->bspi_enabled = 1;
@@ -505,7 +505,7 @@ static void bcm_qspi_enable_bspi(struct
 
 static void bcm_qspi_disable_bspi(struct bcm_qspi *qspi)
 {
-	if (!has_bspi(qspi) || (!qspi->bspi_enabled))
+	if (!has_bspi(qspi))
 		return;
 
 	qspi->bspi_enabled = 0;
