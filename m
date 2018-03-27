Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49TVWmRChIdhDCi3WBPnl+ONG5vMprfIdiz84TskuFEc+X2q6kJm132Dqwmu6c4YOv2wq1p
ARC-Seal: i=1; a=rsa-sha256; t=1522168750; cv=none;
        d=google.com; s=arc-20160816;
        b=qXIKvdJ4ylVnKINzCVtP43j1t1zfBKTW126r++e9My8V/puQcyNxE5wHPlhGX363KX
         Y3hGqQZ9EZHeDq/ERtNdP/IPLZ2z1ywpeAf+wWmeE5wnBvCSbBxYe//j50oOl4G0SPS4
         v2PWdm2Nkm4GOmmuh9I6inek4dLiULcZcokmp9soKT4fjFMBWnaJNIuwF9mkCqOM6v4i
         KkEcbbRnFM5TNREoWPLJ9Ha8uYAxhLIYBAQztYtqVFnPr3hSdfYJGYFSBocvMnMs14YI
         3at064to2PR5fEhfphBumizUkQ6lidNdvQaPv8/ONYu4TVTK5qA6yjDH0nsRsq0RXsUQ
         Qhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z/q0YNzgHStp5ARpEPaoYwWgCe/biX3WzzsFb+3cbio=;
        b=Qv2AaJqhzASXrtg6hWEztfJ6fqEvcl0vYQfxqtCeK9Rtq2IeCjLQfeB+7RUgZGjCPH
         Fw4Qd7Z0QW0uhQ5T/RMclQMQySxaNym3viDPW34F6iXImkAgGwAIE3ZEVnVQT2uywDxT
         FjqB2oK4LMf07tAnFsLFUXQvyxUoe9i2xcN2ENbZeEnVwtVwgJgY8SjXdR1PuEsYHNG5
         BnYAQf5svEu/IhzLQKR85aanQVBHukKXBFz2fphzddgShV9yS3SgqjF9RuSWKgrwmbPy
         3Vpw0kFI2hWR3NLjdAtCBVdDFMVzb9mS6f8ebAzQmoWgl/2Jb7lilWpocThP9EgK1pzh
         20cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vineet Gupta <Vineet.Gupta1@synopsys.com>,
	Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 019/105] mmc: dw_mmc: Fix the DTO/CTO timeout overflow calculation for 32-bit systems
Date: Tue, 27 Mar 2018 18:26:59 +0200
Message-Id: <20180327162758.647363258@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109311824128047?=
X-GMAIL-MSGID: =?utf-8?q?1596109619355153149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>

commit c7151602255a36ba07c84fe2baeef846fdb988b8 upstream.

The commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
and commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
made changes, which cause multiply overflow for 32-bit systems. The broken
timeout calculations leads to unexpected ETIMEDOUT errors and causes
stacktrace splat (such as below) during normal data exchange with SD-card.

| Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
| -  Info: Finished target initialization.
| mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd
| response 0x900, card status 0x0

DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
code gets compiled on all 32-bit platforms as opposed to usage of
DIV_ROUND_UP when we may only compile stuff on a very few arches.

Lets cast this multiply to u64 type to prevent the overflow.

Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: <stable@vger.kernel.org> # 4.14
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -413,7 +413,9 @@ static inline void dw_mci_set_cto(struct
 	cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (cto_div == 0)
 		cto_div = 1;
-	cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
+
+	cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div,
+				  host->bus_hz);
 
 	/* add a bit spare time */
 	cto_ms += 10;
@@ -1948,8 +1950,9 @@ static void dw_mci_set_drto(struct dw_mc
 	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (drto_div == 0)
 		drto_div = 1;
-	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
-			       host->bus_hz);
+
+	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
+				   host->bus_hz);
 
 	/* add a bit spare time */
 	drto_ms += 10;
