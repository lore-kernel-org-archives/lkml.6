Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+y8S11ScJPZM0SqMN7fAGvd/SO59UTdhdKNrDT7BY3i5ItLaP6YyBtEOE5GS6znG6A1FM
ARC-Seal: i=1; a=rsa-sha256; t=1527156278; cv=none;
        d=google.com; s=arc-20160816;
        b=npnBjyRvBXLS7p6cVP3umLGz2ER+lEQb0A5NI7IJMiMyK/ChFxiq3gH4hnjIdV6O9v
         4jOVOgnnq2mYFwRMNJIyTPIHfcy5Y9b+Qu9Jrb67MDZT94SWPs4qBvcK52ar7+huuumI
         okDcsFRp10/9CnrTlSCXtTAYPcqWDeBKS6k8FIJyYvwJclB+21ZFW9rumG+7OhwQLMU/
         WE2cBU/sN8liHJUl+cZBlaEvqnTmnfD2MZLRQQ8MWdDXDjb8IjucpEgA3dRimU0xIDWA
         qLKov70qpQexfnRWrWKh9gCT3yLpWyTpeNLknbZOjw+stoF0lX7Q/6+vY9bhL4fM1D3r
         rMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bBkvbykfY3oF1LJO2WE/X2vY6a9bKh8GCrYea6x5o4s=;
        b=kFJhhpjnJbYM/ipM1ZqcuAM6bGGlsP5X2Zei1Qw6NIfI6Wde+23jI/azQA9fho2LKX
         pVmQh5MevPwYqfkXPyr8DysvbSqhwN1bIEoB1NXW7zYcL0KCuW3k1SuFbyJoOHOitX0z
         dU+jpAV/5qDuJM2MbJRSkanIUoiZtRYlCj12buVxV8G4cP1ZtzuvL0bd7OO6IOVtKHjj
         6h285U8Vj2n8/ZBSc9mpJtbpQOz3W8rUS/BHMIDsQG7931lQDI7H6xAMSpptTZi6LMgG
         JaO/DLXyv7H5H/o24ZF03FQ3dFT9K/fK6n0S1MGyy3cJeMCKfhVTstHTxnWBwzWL3/Y/
         L46g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GdOE3rE6;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GdOE3rE6;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrzej Hajda <a.hajda@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 127/161] clk: samsung: exynos7: Fix PLL rates
Date: Thu, 24 May 2018 11:39:12 +0200
Message-Id: <20180524093033.528569490@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338511708844836?=
X-GMAIL-MSGID: =?utf-8?q?1601339421961041458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit 7e4db0c2836e892766565965207eee051c8037b9 ]

Rates declared in PLL rate tables should match exactly rates calculated from
the PLL coefficients. If that is not the case, rate of the PLL's child clock
might be set not as expected. For instance, if in the PLL rates table we have
a 393216000 Hz entry and the real value as returned by the PLL's recalc_rate
callback is 393216003, after setting PLL's clk rate to 393216000 clk_get_rate
will return 393216003. If we now attempt to set rate of a PLL's child divider
clock to 393216000/2 its rate will be 131072001, rather than 196608000.
That is, the divider will be set to 3 instead of 2, because 393216003/2 is
greater than 196608000.

To fix this issue declared rates are changed to exactly match rates generated
by the PLL, as calculated from the P, M, S, K coefficients.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos7.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -140,7 +140,7 @@ static const struct samsung_div_clock to
 };
 
 static const struct samsung_pll_rate_table pll1460x_24mhz_tbl[] __initconst = {
-	PLL_36XX_RATE(491520000, 20, 1, 0, 31457),
+	PLL_36XX_RATE(491519897, 20, 1, 0, 31457),
 	{},
 };
 
