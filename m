Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Pm3v4nU8TlBHVTtbFu/yYVjPIT2LXVYH5JY1qUQ4wG3lHbZPbqsrKC7/dX25+JS22mvs9
ARC-Seal: i=1; a=rsa-sha256; t=1523399168; cv=none;
        d=google.com; s=arc-20160816;
        b=XuTjoLX8BHlgK+1Sy1hRtLCpTsWA2uFaAbmQxhQQ9+fiprYprphzJqD50kw1uQhyrD
         KFAjglUKZENYO2IMd/wba7NqyhYKndKSJOfT00KXPwYg2VvLny42VzPJOkePWi8AqQVe
         Y0eC6cZde9v2mRFsklv43P0vMwgF3ohGhy73HaJ8Ndc1hPE8crVMs4P4s4FT0YUCu9w6
         i+LsN0X5SAS6Q/cWRX5xms+W6YYL9/0tDzGMBvOfe9w3L/IWgzdI6rD9dddNY3uT756C
         n+Gn/BTK4bDeQkglW8Qq0mh0W34jeq3yf/3Jxc1MC1rIvHz2I4F1cJbhdp5QtP+jTP9P
         CjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AgXgSZP9UiAZgJbaqBybBWl3VNu8YVX/gxhK7uPLF5s=;
        b=E6dqhNutVNrxXt40KOXEdyLGBUJ/1xCvY/23vOSudC/GPAuYk8mmVcXX7l+uNVLiW1
         KwxRwRzedxcIBuEPw1Frtqjb7urC3wr3/fkEKMWS/hk0n2oNadDsHE6N0ShS14OyFkib
         U0GNJoZGuDTFtM/Uf/SBoZoiIahqQUCY/vhDur4CSb7gkmE8BqRPmm8bCHeGwoq1x48T
         ZfQBeKJgut8QfjUUU1NdWuiuHbhJfPNZYBDI557GvlYeuzPwU9wjMTbTQwG6pBfMvf/t
         h2ESQERW7YrvqCTLAd9B2IjOouxPwLB5GRzORb1UrOz9ZUf/b4YBD1CM3bZwU27mgcq1
         5Jug==
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
Subject: [PATCH 4.15 004/168] clk: meson: mpll: use 64-bit maths in params_from_rate
Date: Wed, 11 Apr 2018 00:22:26 +0200
Message-Id: <20180410212800.398693109@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399806964398934?=
X-GMAIL-MSGID: =?utf-8?q?1597399806964398934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
