Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+GxOqO9yDXvphH3gbrdwsErpv9zUd0teK59d5YABb7zgeG+wMGK6Y433YBzSApnP5noVTN
ARC-Seal: i=1; a=rsa-sha256; t=1524405456; cv=none;
        d=google.com; s=arc-20160816;
        b=u26mwf5EGWxKBypTYpSsGrhHToszHjCVVRdQ5PXyyygQVa+BaF3FY9sMFv1Cir9CYv
         a3eNDDpSIP8a98VaWHdmtpPPvEfjyDdyUEZQIb3aQ8u1MFDqlBwo31Hv/Yr0qjKTEy5M
         7QFyGOG4LmBr3vEHSTH1vrcQeZtgd33NoXfjimRjetm3xG954zSC6WYUy44T7EQd8zFF
         rNWCkMr11xCVW13nRJTChvwRqjtiy+wZpM54lFe/wEiKZYDDEs+PWQnOHJNXPLiknLCT
         f5vKHDvr8vwKlSWk0WDFP0DMmeE9f+B4EOwRy22vUVv3PoQk1ZGO6ZdutiOmZ/qEODKS
         5G1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=31SyK8DStvKR3/refgMSlnF+EiAj30YG2mex8/ZiAzo=;
        b=wOL3kjJvfa3//w64DCqSegu8J4vnZjDlhwUc9KIrD0MZmpsTuApM+CQWAr/hp2hjXi
         xY+G9RzoaWfVFZPJMXomF0h3ipns/cH4NrUGZvgn8WXqxEA7Pkn2WvATi2oML8ZUYjBx
         039w0kuMHFQiEr6Gb8edmCOBzCmnS8OSJjRiC7Jb3P/xdZlt89nszIBKomIFEQZOZ5nf
         s19CtA0ILZNjZhS4NGiAiT5Q1zGZon8Trhvi6ISjosh9MHG7hVEIs672c6yuCFrBPJgZ
         KbkSCR4dca59WW2uIn1mCzeimBMBswPLTLY+ekihfPgn/xEnd7Nk000UAL2b0CNMuB63
         ttdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.16 072/196] soc: mediatek: fix the mistaken pointer accessed when subdomains are added
Date: Sun, 22 Apr 2018 15:51:32 +0200
Message-Id: <20180422135107.975343300@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454976334056522?=
X-GMAIL-MSGID: =?utf-8?q?1598454976334056522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit 73ce2ce129783813e1ebc37d2c757fe5e0fab1ef upstream.

Fix the pointer to struct scp_subdomian not being moved forward
when each sub-domain is expected to be iteratively added through
pm_genpd_add_subdomain call.

Cc: stable@vger.kernel.org
Fixes: 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
Reported-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/mediatek/mtk-scpsys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -992,7 +992,7 @@ static int scpsys_probe(struct platform_
 
 	pd_data = &scp->pd_data;
 
-	for (i = 0, sd = soc->subdomains ; i < soc->num_subdomains ; i++) {
+	for (i = 0, sd = soc->subdomains; i < soc->num_subdomains; i++, sd++) {
 		ret = pm_genpd_add_subdomain(pd_data->domains[sd->origin],
 					     pd_data->domains[sd->subdomain]);
 		if (ret && IS_ENABLED(CONFIG_PM))
