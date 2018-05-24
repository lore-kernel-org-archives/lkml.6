Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoIrvi9vMYeuLR7RrVKYTbz+8NMpWqwljdhf6q21FfNB3AdxelBJklNxwKMkRqlS6OykPTA
ARC-Seal: i=1; a=rsa-sha256; t=1527156275; cv=none;
        d=google.com; s=arc-20160816;
        b=YEZr7tyoSBEIeOqgj5N29idnAT5QaSAvmPU+WvphaArmJL3i38Zy5qEPpz2uqItG8J
         UbIbbyPamWi0iIUbbYQS6FBmucvveWCQWwHHQ3GP5D9WgpJeQ+lh7Ul+5980i5iQ/Y96
         5C9vL0MAGmwBlmwREdDx2as6pWA/Ji77JoNB55GuOsjSFBGvVvfnZZ3xh03Grzhqd4xw
         hChoBZGCsETfZodI6g9vnEW8k/x6BtEKgjzhiuU33L/fC9NkywJz9gwkOSMDVYt3jc9g
         5LHO13bTzZavwicZxlpdSRspfyMwKyMdeTg3ndYI+jsaBN3DaCHLSxDC0Oh0/OrHbTo/
         CNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ied/Kf+fo5/1h+Tu3w5aN1ya8xRjdWcJKkVghSA/Il8=;
        b=lsLBukyWUOucGsCAcje0CB59q1wbxQj3yL8C1vm8SRe6U4wp+yCzDytvHIE2nsYzLl
         X1IcTPUB2kqvN9cNHrZ6TQ3o8thpLSo1B1+0xeMPfezor8qR3K4hKL6JPubHqAzBNFrw
         uXO0EqOj2I/4Agk8FloR5ideS5TOavTL2KPpPpuDMpfJKoz1W1OLMln1/1C+2R/ce+Ts
         /ePMiWlGQTGdvOeNR4eckeKiS4hzqIyNSRgt8Oz096AnSVaLhlKyAG8XFVDkJCKsLU+z
         br0O2nY5GRohwRepxHE109NZhjJInSlhtmihmgMHQFRTaj7NK6lwnxC2AuQJQpmC5k0v
         kUzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XPjUx6vp;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XPjUx6vp;
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
Subject: [PATCH 4.16 126/161] clk: samsung: s3c2410: Fix PLL rates
Date: Thu, 24 May 2018 11:39:11 +0200
Message-Id: <20180524093033.399659398@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338508992104744?=
X-GMAIL-MSGID: =?utf-8?q?1601339419162102331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit 179db533c08431f509a3823077549773d519358b ]

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
 drivers/clk/samsung/clk-s3c2410.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -168,7 +168,7 @@ static struct samsung_pll_rate_table pll
 	PLL_35XX_RATE(226000000, 105, 1, 1),
 	PLL_35XX_RATE(210000000, 132, 2, 1),
 	/* 2410 common */
-	PLL_35XX_RATE(203000000, 161, 3, 1),
+	PLL_35XX_RATE(202800000, 161, 3, 1),
 	PLL_35XX_RATE(192000000, 88, 1, 1),
 	PLL_35XX_RATE(186000000, 85, 1, 1),
 	PLL_35XX_RATE(180000000, 82, 1, 1),
@@ -178,18 +178,18 @@ static struct samsung_pll_rate_table pll
 	PLL_35XX_RATE(147000000, 90, 2, 1),
 	PLL_35XX_RATE(135000000, 82, 2, 1),
 	PLL_35XX_RATE(124000000, 116, 1, 2),
-	PLL_35XX_RATE(118000000, 150, 2, 2),
+	PLL_35XX_RATE(118500000, 150, 2, 2),
 	PLL_35XX_RATE(113000000, 105, 1, 2),
-	PLL_35XX_RATE(101000000, 127, 2, 2),
+	PLL_35XX_RATE(101250000, 127, 2, 2),
 	PLL_35XX_RATE(90000000, 112, 2, 2),
-	PLL_35XX_RATE(85000000, 105, 2, 2),
+	PLL_35XX_RATE(84750000, 105, 2, 2),
 	PLL_35XX_RATE(79000000, 71, 1, 2),
-	PLL_35XX_RATE(68000000, 82, 2, 2),
-	PLL_35XX_RATE(56000000, 142, 2, 3),
+	PLL_35XX_RATE(67500000, 82, 2, 2),
+	PLL_35XX_RATE(56250000, 142, 2, 3),
 	PLL_35XX_RATE(48000000, 120, 2, 3),
-	PLL_35XX_RATE(51000000, 161, 3, 3),
+	PLL_35XX_RATE(50700000, 161, 3, 3),
 	PLL_35XX_RATE(45000000, 82, 1, 3),
-	PLL_35XX_RATE(34000000, 82, 2, 3),
+	PLL_35XX_RATE(33750000, 82, 2, 3),
 	{ /* sentinel */ },
 };
 
