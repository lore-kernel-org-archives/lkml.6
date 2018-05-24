Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoANnDq+F4gBWjBYR9BcmrEMRmwlrQ2wMrCAHKFYdpcFJ+C3GcYu9iJYqSdeucAVinjfVTG
ARC-Seal: i=1; a=rsa-sha256; t=1527156289; cv=none;
        d=google.com; s=arc-20160816;
        b=Uau2UEokUmwxNqZpLfR8v6gu0ZSZIak2fWifzyu9+nUTdflNRQaPfXiOaozUkDz4/e
         Kn+kt2BlV+VEFgphrPaUf26mO9L2kbON/QWJcfXg2MhZ+11QexszoiOQld9SS9QTf+Z8
         grpw9YJwUCoS2yCxoaAQ+kUSuK8+It/6oP5ouKb/kMOxtoGfPFkRAqr6wmjBz1nHPT6Z
         95sgVPLl1ZFey6fMLXHpUybkSXQCN59Pmgh0/3XpJMqRoIUwJd1yOVFFWBXDZBMgmfi1
         SjZ3pDftb5yGPZifulsrRzzVzEf7Bwu4+qdx7hmYLUz/43JiMvlN7QJ7v3c9Cf4SbXHk
         tW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=G2uMb5SPlffCGW/WZ6UwUUEgaQOvG8cHsdvYR5yTtn8=;
        b=IX4UzwPo6JfYsz6Ui4X3UtvopPvsoEzADKlXEuwabMZuRrIYflzcnxnBbR5gIwQhGf
         Cw5WM10zuco8GA5lWBaEYdaIY9cWtNFYE7LKVtxn3RBWBMtj6Lk1FJzhTRNB+95dygeO
         e6n9eERiB6lQ9ajseO2DC3c1D7xfjWvHYvasUdAfEnGSM8Bf2SPNnV12xy/0CjJX7/e6
         qlRFkg12FsLlahleUoyfHtJDBevOx5KRswc49uqz+yzNmKur1PEJi68DnynpDJ7Nvaon
         qjeMckLD3OLxB2XVGWqfUXxCDBgtLSs7VdN5J07leEhz82NktqM/ukTday3NH+grw50A
         CgbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vsWAEAFL;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vsWAEAFL;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrzej Hajda <a.hajda@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 131/161] clk: samsung: exynos3250: Fix PLL rates
Date: Thu, 24 May 2018 11:39:16 +0200
Message-Id: <20180524093034.045796359@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338525735775270?=
X-GMAIL-MSGID: =?utf-8?q?1601339433268235460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit a8321e7887410a2b2e80ab89d1ef7b30562658ea ]

Rates declared in PLL rate tables should match exactly rates calculated
from PLL coefficients. If that is not the case, rate of the PLL's child clock
might be set not as expected. For instance, if in the PLL rates table we have
a 393216000 Hz entry and the real value as returned by the PLL's recalc_rate
callback is 393216003, after setting PLL's clk rate to 393216000 clk_get_rate
will return 393216003. If we now attempt to set rate of a PLL's child divider
clock to 393216000/2 its rate will be 131072001, rather than 196608000.
That is, the divider will be set to 3 instead of 2, because 393216003/2 is
greater than 196608000.

To fix this issue declared rates are changed to exactly match rates generated
by the PLL, as calculated from the P, M, S, K coefficients.

In this patch an erroneous P value for 74176002 output frequency is also
corrected.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos3250.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -698,7 +698,7 @@ static const struct samsung_pll_rate_tab
 	PLL_36XX_RATE(144000000,  96, 2, 3,     0),
 	PLL_36XX_RATE( 96000000, 128, 2, 4,     0),
 	PLL_36XX_RATE( 84000000, 112, 2, 4,     0),
-	PLL_36XX_RATE( 80000004, 106, 2, 4, 43691),
+	PLL_36XX_RATE( 80000003, 106, 2, 4, 43691),
 	PLL_36XX_RATE( 73728000,  98, 2, 4, 19923),
 	PLL_36XX_RATE( 67737598, 270, 3, 5, 62285),
 	PLL_36XX_RATE( 65535999, 174, 2, 5, 49982),
@@ -734,7 +734,7 @@ static const struct samsung_pll_rate_tab
 	PLL_36XX_RATE(148352005,  98, 2, 3, 59070),
 	PLL_36XX_RATE(108000000, 144, 2, 4,     0),
 	PLL_36XX_RATE( 74250000,  99, 2, 4,     0),
-	PLL_36XX_RATE( 74176002,  98, 3, 4, 59070),
+	PLL_36XX_RATE( 74176002,  98, 2, 4, 59070),
 	PLL_36XX_RATE( 54054000, 216, 3, 5, 14156),
 	PLL_36XX_RATE( 54000000, 144, 2, 5,     0),
 	{ /* sentinel */ }
