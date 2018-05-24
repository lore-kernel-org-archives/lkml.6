Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpSMWuMdxExXZWUrc3zfaZxysxEfcI513tQHPYZDI/Ec0sB7dNoAiPy2qP1lFPGWODd4QZ5
ARC-Seal: i=1; a=rsa-sha256; t=1527156258; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWnIaA8gsf9YBZo9aCoizqv2OkKIeUvFq9avLH2fUQWBKyKsbegi5yqp/EH7BQgEpz
         BGA/s1tvvAmVnBvw1LLB5BeZSybwUFPR5laDKhHBlfYCgwIc2OtxTa6GPlQ3NDY7QxEL
         hkueaBPebXQMyvrnqTKpgFlPfrQBISkTxahN1LGImFp0YJyLIMxFNNxIebPc1eydP8/c
         Gjvf7Pc5qV80E9Qx1K/fDjhWKyfTSxv6t2/sT1RxpovG2/OLDmw1H9X1wXmSHkWzGyjL
         pUPG+/7t30CUDlh+69OftAj98TK8Th3CsWkC9gMGJ4UBnH84hd3G3WDy/z1SFFh+x5IT
         e2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/4Qr7hCm55zCPCEf04s/gV8xN4mp1eIemNUixYyRUlw=;
        b=T20qbuyOLTqScDD/JMHRpiuzQwBiVWHTFo2hL8eF19gzYhwlpUYUR/4FsfH/aHBMJL
         Mhzfh5866pnhX89MyEwdsv0do23nVAgq45dWhrJ4Ryy/ypaaP7EOoELS19aEYu38qRtF
         7wvjpZBWbsSh57BVN+5KaSgHw263BEIjR9lSOgDTUKnbgd7eyUZBbEq81XNp6gexXALK
         EmDwlU7cMv1jpCe4c44qGylFV/uTBBuMcQKj8D7CnhtoGTdv7iPqaZvDNOWke50DzHnE
         WoSJw6bhhDezJF+wVae/4GMhrTESR6FuAq58QxgfAcz285RaymB0YjYWOzw4KPZpFQ7I
         CLyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jhZNEdWP;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jhZNEdWP;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 121/161] clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228
Date: Thu, 24 May 2018 11:39:06 +0200
Message-Id: <20180524093032.789110882@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338495289551147?=
X-GMAIL-MSGID: =?utf-8?q?1601339401702599393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 4b0556a441dd37e598887215bc89b49a6ef525b3 ]

commit c420c1e4db22 ("clk: rockchip: Prevent calculating mmc phase
if clock rate is zero") catches one gremlin again for clk-rk3228.c
that the parent of SDMMC phase clock should be sclk_sdmmc0, but not
sclk_sdmmc. However, the naming of the sdmmc clocks varies in the
manual with the card clock having the 0 while the hclk is named
without appended 0. So standardize one one format to prevent
confusion, as there also is only one (non-sdio) mmc controller on
the soc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/rockchip/clk-rk3228.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -387,7 +387,7 @@ static struct rockchip_clk_branch rk3228
 			RK2928_CLKSEL_CON(23), 5, 2, MFLAGS, 0, 6, DFLAGS,
 			RK2928_CLKGATE_CON(2), 15, GFLAGS),
 
-	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
+	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc", mux_mmc_src_p, 0,
 			RK2928_CLKSEL_CON(11), 8, 2, MFLAGS, 0, 8, DFLAGS,
 			RK2928_CLKGATE_CON(2), 11, GFLAGS),
 
