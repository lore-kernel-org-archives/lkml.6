Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZomIMwbGBTSOYI9AzzqGmqgDqtWC/uS92t4791d0CXgtDOZ3bknFd3OtLDJRrMK0B1OTS4W
ARC-Seal: i=1; a=rsa-sha256; t=1526937243; cv=none;
        d=google.com; s=arc-20160816;
        b=U7fEp256a6h+75ZAvluqf+0boh0ACTPkqEbE6t0+pCCL1RZ5WJXqCPa9Qw/q9AjhBG
         BBhLvx1fC+41fJsRXIz9gBN9JNdWGjK2Fi0DtNUvqAAt1A/TXTwbAdRViEgqLfQqVlqb
         bCtSn2aZDcQNdvbMTyEqMZiSCL7wslBarwMITVM5nN0V2Ns3YvY4BoC+mP8DEzmQ2yfd
         YE19U8xkLIxZ6oQ2A89hxx7A+dy4VTxunVjZP2hy9CVBsSQG8shRQSJUFTZSe5U4YFLl
         lCI+RR7JhdXb8RljbPnMtSXOAnMnZ/Py716eVnU0YJBaxRKH6hUT0nA1Vrork9GcCdoJ
         lpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=blPQW5BpNNwQUp3DBdaUpCO/tS+F8Myduiv2Sm8VD4g=;
        b=fUHg/c9P/KvtZ2s/IxOMf8BBqDtwku1M3ifXe6t2aVMWj8xsKOJWVFOoELWR+o83lL
         tD7COVMw5Ejpv/wRPq5d6J1dRrg6qNjSYo+4pV5+c3az9BX6JnG82sF7L7gBIkNrAWlH
         WVx+ZrHxonaaXkocSLdrldM4U+Wub1/XNkp6mohJ/MOKZZ8xZQIYTlowiDJi8aLazI+p
         EGFBsWw6AgVnUoOjk4SeBSdsTWcyQL5AX676beCoIi+0DQVZXIgMNgq+I0qcCWwOL3Sh
         gfigS2Jn7tb2jpVsDBTQyZtLvJdejlgW5+ypZkpxSK34d4kh9UX83UMtoSzRzts77SCD
         OKsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HYtKLLLx;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HYtKLLLx;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 11/87] spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL
Date: Mon, 21 May 2018 23:10:47 +0200
Message-Id: <20180521210421.242314538@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109746955059282?=
X-GMAIL-MSGID: =?utf-8?q?1601109746955059282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -514,7 +514,7 @@ static int bcm_qspi_bspi_set_mode(struct
 
 static void bcm_qspi_enable_bspi(struct bcm_qspi *qspi)
 {
-	if (!has_bspi(qspi) || (qspi->bspi_enabled))
+	if (!has_bspi(qspi))
 		return;
 
 	qspi->bspi_enabled = 1;
@@ -529,7 +529,7 @@ static void bcm_qspi_enable_bspi(struct
 
 static void bcm_qspi_disable_bspi(struct bcm_qspi *qspi)
 {
-	if (!has_bspi(qspi) || (!qspi->bspi_enabled))
+	if (!has_bspi(qspi))
 		return;
 
 	qspi->bspi_enabled = 0;
