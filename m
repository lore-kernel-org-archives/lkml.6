Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+odYE8oDFwISGklm1GPH1GHf7wf50f0YAN1PT7johhE6n+Jcj5CzgiuNBWLC7aaSycs9UG
ARC-Seal: i=1; a=rsa-sha256; t=1523399642; cv=none;
        d=google.com; s=arc-20160816;
        b=uhHQah1wdL9qZ0LureZm86veqfVhcuVRZ9iWMHMU8M3qEWcNvl6ZqMUrIBElaY0qBs
         yo3TPWYcIA0Jq5+g9aEpqogpBrWfJWJNhzevlf6syTNJZ92dAVkjUqDuvgkfP+QbnXFj
         qu1LvHlaTipkDu0Y3svjc8Irk9JbnqA0Nxv43eVpwHdfWpqkZ3SUwOWU18FJv/Gr3CZZ
         Oaw4xmkWsHE8wJicsbqLVm7rK6I7cxHXi3N3IxhxYWsUYr6ek+bO+guBe9SWYedZQpeM
         GVYPUVQMQPcATTWZvPEa0KPaIpDqVe8wy6NVAFv6xvdDThFkpruOsFDDvdi1OT0p5+sM
         tuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lFSW/RxJOPeoHGU40Y8lT5cRBneh2NSAvSnuEQZTAYg=;
        b=jS0HGJNKt2Ngv4c4+/xsDHkXmgJzdYVjwbVbaLOY2LX043UyTGI7f7rkG2jskLkrwp
         I1+c7nP3mFnB1xn+jbjFkXoCDx2jfgHC6Wak3pRV55S18xWggt/xeo9/yiU8AKzFxpiR
         5IxFBj5XVQtVdoFPQ9CQdk/fNOFXsIifBMgO85QL/Hf6sb0cAWUcfv5MFY0uEyjgraWA
         fYg1BZai0+3MIy3OabMbD0GGFX3zXq+nXnzaIWfh+zNKTKjKB3mMlOSXvLmu0nj0HF+V
         9NyVt2uPfSNMGBrBuk8exbfoKEqlkXpTtBx1RYPqqMgwQ0BeGWmJCzG1dI0S1u7UiY7i
         4H7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 004/138] clk: meson: mpll: use 64-bit maths in params_from_rate
Date: Wed, 11 Apr 2018 00:23:14 +0200
Message-Id: <20180410212902.589492631@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399806964398934?=
X-GMAIL-MSGID: =?utf-8?q?1597400303686056531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


[ Upstream commit 86aacdca66774051cbc0958110a48074b57a060b ]

"rem * SDM_DEN" can easily overflow on the 32-bit Meson8 and Meson8b
SoCs if the "remainder" (after the division operation) is greater than
262143Hz. This is likely to happen since the input clock for the MPLLs
on Meson8 and Meson8b is "fixed_pll", which is running at a rate of
2550MHz.

One example where this was observed to be problematic was the Ethernet
clock calculation (which takes MPLL2 as input). When requesting a rate
of 125MHz there is a remainder of 2500000Hz.
The resulting MPLL2 rate before this patch was 127488329Hz.
The resulting MPLL2 rate after this patch is 124999103Hz.

Commit b609338b26f5 ("clk: meson: mpll: use 64bit math in
rate_from_params") already fixed a similar issue in rate_from_params.

Fixes: 007e6e5c5f01d3 ("clk: meson: mpll: add rw operation")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/meson/clk-mpll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -98,7 +98,7 @@ static void params_from_rate(unsigned lo
 		*sdm = SDM_DEN - 1;
 	} else {
 		*n2 = div;
-		*sdm = DIV_ROUND_UP(rem * SDM_DEN, requested_rate);
+		*sdm = DIV_ROUND_UP_ULL((u64)rem * SDM_DEN, requested_rate);
 	}
 }
 
