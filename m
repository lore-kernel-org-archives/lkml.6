Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F29DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BB22229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dYVzpPml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfBLSFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22604 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbfBLSFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:39 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190212180537epoutp0270aef4850bdaeb1cce9fc0fef463719f~CsABWLz3f2787127871epoutp02-;
        Tue, 12 Feb 2019 18:05:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190212180537epoutp0270aef4850bdaeb1cce9fc0fef463719f~CsABWLz3f2787127871epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994737;
        bh=blD4+7SyDmxtJMKEV1R1vNYt2wsMfDaSTYSU/TfWmdk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=dYVzpPmlnBjO6vYSWBhPeEuFmI0bN8mwHReChieDonTLYezo4VK1BKyibl1QEvtyQ
         tX9DqTIu3ZUsCtQx86CQgroYVg46nLQDBA1xl2coXX5IXMbiPcBvHqAEIjeDm7uUHE
         n8I5JrOaz5b+gqcClrLaheegsnbZ/IFCaGJ2rQCM=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190212180536epcas2p34d5dfe439312cc1bc5924ddad3ab30cc~CsAAUNf6w2872928729epcas2p3k;
        Tue, 12 Feb 2019 18:05:36 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.2D.04093.0FA036C5; Wed, 13 Feb 2019 03:05:36 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190212180535epcas2p3aaa1c3d8fd9fcfb5a30bc6d132aba70a~Cr--zvoAS1117711177epcas2p3N;
        Tue, 12 Feb 2019 18:05:35 +0000 (GMT)
X-AuditID: b6c32a48-18bff70000000ffd-0d-5c630af057d5
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id EB.30.03689.FEA036C5; Wed, 13 Feb
        2019 03:05:35 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:35 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 16/21] ASoC: samsung: i2s: Simplify pri_dai, sec_dai
 pointers usage
Date:   Tue, 12 Feb 2019 19:03:37 +0100
Message-id: <20190212180342.32040-17-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmhe4HruQYg7O3WS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZhw6sYilYy1Wxe+pk1gbGDRxdjBwc
        EgImEhcehHYxcnEICexglOjf38gO4XxnlPh+uJ+li5ETrKh353yoxAZGiVMXz7NBOL8YJXq3
        3GMCqWITMJToPdrHCGKLCIhJ3J7TyQxSxCzQwiQxZ+5SZpCEsECExP5v98EaWARUJfavn8cI
        cgevgI1E7/lyiG3yEud717GD2JxA4WcLv4FdwSsgKPFj8j0wmxmo5uCV5ywg8yUEjrBJdM9r
        YoRodpF407AL6mxpiWerNkLFqyV2be9mhmjoYJRoubCdGSJhLXH4+EVWiKl8Eh2H/7JDAoZX
        oqNNCKLEQ6Lj0QJGiI/7GSUOr25mnsAoNQvJUbOQHLWAkWkVo1hqQXFuemqxUYGJXnFibnFp
        Xrpecn7uJkZwlGt57GA8cM7nEKMAB6MSD++Ko0kxQqyJZcWVuYcYJTiYlUR405iTY4R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzPpSeGy0kkJ5YkpqdmlqQWgSTZeLglGpgdK2YwnghnSuv+XP9
        vBw9Q0OFOjOdm5PW/qw/4nRe8HO22pSpEZUH1gs8O7ZCbOm3dhvrG/zbrZ0u5J36bCZ55W67
        weNTlfmyd+u6js2b1np43fO+W0sXvqoWstXWm8P/QlB48X+upZtcPh1bwTBdjL9Gi4Gz60ug
        4oQtc1eUGEenzLC4P2vzWSWW4oxEQy3mouJEAApUFTnuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd33XMkxBr2f5SyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZhw6sYilYy1Wxe+pk1gbGDRxdjJwc
        EgImEr0757N3MXJxCAmsY5Q49vQ/E4Tzi1Hi57q77CBVbAKGEr1H+xhBbBEBMYnbczqZQYqY
        BZqYJHbdvghWJCwQIXFj0i8mEJtFQFVi//p5QA0cHLwCNhK958shtslLnO9dB1bOCRR+tvAb
        C0iJkIC1xJVNtiBhXgFBiR+T77GA2MxA5QevPGeZwMg3C0lqFpLUAkamVYySqQXFuem5xUYF
        Rnmp5XrFibnFpXnpesn5uZsYgSG87bBW/w7Gx0viDzEKcDAq8fCuOJoUI8SaWFZcmXuIUYKD
        WUmEN405OUaINyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QD
        4zIhnfjUz6prXxwxdbgQ8KGdd23FxEd/y17vFyqQnbBPN7QxxasxLe1jjMmz25YpV30/R9d0
        3l2jeEa4ZuHMrx/vBxec3d/wdmq/Wmv0ReM/pSUOe1Z7Me1kcv19UEipUq7Q6sJCh3s7X716
        07465KSonSj/eVsRLa37e+IdIpcJnP0SfntighJLcUaioRZzUXEiAKhXLIVdAgAA
X-CMS-MailID: 20190212180535epcas2p3aaa1c3d8fd9fcfb5a30bc6d132aba70a
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180535epcas2p3aaa1c3d8fd9fcfb5a30bc6d132aba70a
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180535epcas2p3aaa1c3d8fd9fcfb5a30bc6d132aba70a@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe call is on the primary DAI we can use 'other' in place of
i2s->sec_dai, if the probe call is on the secondary DAI we can use 'i2s'
in place of other->sec_dai.

While at it fix one whitespace issue.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index f438558c4d21..097c641fc1b9 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1057,18 +1057,17 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	pm_runtime_get_sync(dai->dev);
 
 	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
-		snd_soc_dai_init_dma_data(dai, &other->sec_dai->dma_playback,
-					   NULL);
+		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, NULL);
 	} else {
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback,
-					   &i2s->dma_capture);
+					  &i2s->dma_capture);
 
 		if (priv->quirks & QUIRK_NEED_RSTCLR)
 			writel(CON_RSTCLR, priv->addr + I2SCON);
 
 		if (priv->quirks & QUIRK_SUPPORTS_IDMA)
 			idma_reg_addr_init(priv->addr,
-					i2s->sec_dai->idma_playback.addr);
+					   other->idma_playback.addr);
 	}
 
 	/* Reset any constraint on RFS and BFS */
-- 
2.20.1

