Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoodiayVSdFQbBGJkC8wPa0PwY8jLQ/3gXQunxbO2Xduc645NMectsL/SXCmDl8AVIHui/I
ARC-Seal: i=1; a=rsa-sha256; t=1526937483; cv=none;
        d=google.com; s=arc-20160816;
        b=y0bjnrxY3pEgkyT7TNbgPECX0Bzf/OR00IYJKwF2QK05mPUllF/6aHrnkBbEzPPC/9
         LGI8x+EwbVJ+eCN3UQ0XOi97s5vh0n2/S1KPGGlh2nC8ruu2lBobtlO2Z8NQyYkXnhWD
         Jtsu6V5nS/Fw8bvM4J3+gK4jU3zjkSWBkku6HeQjjsdkB4VI6d5WfOHVM3M6wlu/Q45z
         575Vg7bgbU5w1+viADiK8G8TusfV+uGaTKCK/Oj3LGsagYBsy4RjtRhY+uUaoJRkeRvS
         4XhfXYRyChrQ4I88fRT8p6AZl8Vb29i3Mqo3yOp/YVCcwLP5NRzZM2Z+qxkeJl1QwsUo
         7b2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=P5cDQGSEXQS7dNx9tNVZcLQG1AJXu6fa9AMCiF2f5VI=;
        b=FAwq0g3bHIJhtAcvUeAsmZM7mith6ORq0ecExsHwLABmFzOyW+yifMd+q6Zhkq5kQ6
         1lIRRkJgFD81BuKsZVx5mW0MKzX3O4JkFM6LPksPE1xCSx63bxtRnLykoE7QNL8BPCH7
         Nhtax3aiXvFKByhMh6PZ8GPhmkXim13OlNn/RQOTjRyYxcynvsnhfnY6WwQt7Yc5n7rT
         JoJgxH02wyOS8PhhFUkHFAaHJIJlDHQtmZKuu9JHDuf+PswkNiFivTcWOMBDKgb8Ka7K
         hjTorB1LFhh6xSAoUG4AMX+jeksu9TkNRLy/xBl4kDemK9NiWdxzfyPd7LCw1aUCydJR
         UBkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=leCQWf09;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=leCQWf09;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 11/95] spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL
Date: Mon, 21 May 2018 23:11:01 +0200
Message-Id: <20180521210449.783724664@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109746955059282?=
X-GMAIL-MSGID: =?utf-8?q?1601109999382987861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
