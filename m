Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E332C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB4E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MLl2WFft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfBTLGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:06:25 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:19971 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTLGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:06:25 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190220110622epoutp038fdc4067cb226619f16fd00c7c9d0d24~FDcP4pIJl3102431024epoutp03F;
        Wed, 20 Feb 2019 11:06:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190220110622epoutp038fdc4067cb226619f16fd00c7c9d0d24~FDcP4pIJl3102431024epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550660782;
        bh=7xxjYN7BZ1rBwkZ2CY8yx070GqqxQakElrJeHeGId7Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MLl2WFftBJyaRfwD4jEMj7H/QJbbs2bmJeMb8nIDoDn7GsWR2RAd8r5SEWMiYnSVS
         fA3Jp7KtTZxAWEzsLTiCdWMFamSmKLSslveSEC/e190hoGwDuwjwxtrh2YHKnHd5E2
         +hVUpThRpp4OzO5qr0AtMYqrudv4O2FOYBcKq738=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190220110621epcas2p48f759a8108135fe8690d4878743faaa5~FDcPoa79Y2139321393epcas2p4T;
        Wed, 20 Feb 2019 11:06:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.D2.04093.DA43D6C5; Wed, 20 Feb 2019 20:06:21 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190220110620epcas2p27841bf821d10beab780362bdd59d9020~FDcOmnAA62077520775epcas2p2i;
        Wed, 20 Feb 2019 11:06:20 +0000 (GMT)
X-AuditID: b6c32a48-173ff70000000ffd-69-5c6d34ad726a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id D9.5B.03689.CA43D6C5; Wed, 20 Feb
        2019 20:06:20 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PN800HCZ1I9ZH60@mmp2.samsung.com>; Wed, 20 Feb 2019
        20:06:20 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     tiwai@suse.de, sbkim73@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: odroid: Fix of_node refcount unbalance
Date:   Wed, 20 Feb 2019 12:06:07 +0100
Message-id: <20190220110607.13293-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCmme5ak9wYg4+3NS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyeLl5jdMDtweGz43
        sXnsnHWX3WPTqk42j74tqxg9Np+u9vi8SS6ALYrLJiU1J7MstUjfLoErY9m0RUwF7wQq5v+Y
        z9TAeJ23i5GTQ0LARGLf9vesXYxcHEICOxglJh9eyAbhfGeUaHvXxAZTtf7pV6jEBkaJnmf9
        jBDOL0aJCXf+sYJUsQkYSvQe7WMEsUUEtCXm3OwA62AW+MMo0X58PdgoYQE3iQ+NrWA2i4Cq
        xJfZL5lAbF4Ba4l7pzaxQKyTl1i94QAzSLOEwBQ2icYPfxkhEi4Sr1bdYYewpSWerdoIFa+W
        2LW9G6qhg1Gi5cJ2ZoiEtcTh4xfBzmMW4JPoOPwXqJkDKM4r0dEmBGF6SOzYJAhSISQQK3Fu
        cjPbBEbxBYwMqxjFUguKc9NTi40KTPSKE3OLS/PS9ZLzczcxguNPy2MH44FzPocYBTgYlXh4
        NRhyYoRYE8uKK3MPMUpwMCuJ8D5iz40R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvtQem60kEB6
        YklqdmpqQWoRTJaJg1OqgTGVz0vaqtL3v/H8ltYTM0w1J2ybPD11/7/Y992MXGZJG4rli4In
        917/uvxfQAKf25qT72aKGqcZCa6YYZz9Umdh8vX0M+/O3g6Y8Vgw++i0tmSOnb+l2x2CDe8/
        fnf6o823xYHlTfJtzD84GEROnryulvDHRnJqY0/ZpvObFy/p3SQSrvR15VUlluKMREMt5qLi
        RADAXhx5uwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e+xoO4ak9wYgws/VCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyeLl5jdMDtweGz43
        sXnsnHWX3WPTqk42j74tqxg9Np+u9vi8SS6ALYrLJiU1J7MstUjfLoErY9m0RUwF7wQq5v+Y
        z9TAeJ23i5GTQ0LARGL9069sXYxcHEIC6xglul5/h3J+MUp8b/vGCFLFJmAo0Xu0D8wWEdCW
        mHOzA6yIWeAPo8TCS01sIAlhATeJD42tYDaLgKrEl9kvmUBsXgFriXunNrFArJOXWL3hAPME
        Rq4FjAyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECA2nbYa3+HYyPl8QfYhTgYFTi
        4dVgyIkRYk0sK67MPcQowcGsJML7iD03Rog3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB
        9MSS1OzU1ILUIpgsEwenVAOjaJb0lTkuhcuEz4Tqn0r5Edv+Kd+vLVQz7vjFk5mf9x1S/cV3
        s/ti0B/1e2dzGXV02q8ESG6SrzFWmKgfnrjdrfku972lMc2PY/J4kmxOWV858fPL5jshcxrm
        75n/Snjm94v7/ZhTfdmcJztP3DDlbUH8LYOMo3kXZ/FltFu8+zflvOrh6opLSizFGYmGWsxF
        xYkAZ/fpHCACAAA=
X-CMS-MailID: 20190220110620epcas2p27841bf821d10beab780362bdd59d9020
CMS-TYPE: 102P
X-CMS-RootMailID: 20190220110620epcas2p27841bf821d10beab780362bdd59d9020
References: <CGME20190220110620epcas2p27841bf821d10beab780362bdd59d9020@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In odroid_audio_probe() some OF nodes are left without reference count
decrease after use. Fix it by ensuring required of_node_calls() are done
before exiting probe.

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/odroid.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index bd2c5163dc7f..c3b0f6c612cb 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -257,27 +257,31 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		ret = of_parse_phandle_with_args(cpu, "sound-dai",
 						 "#sound-dai-cells", i, &args);
 		if (ret < 0)
-			return ret;
+			break;
 
 		if (!args.np) {
 			dev_err(dev, "sound-dai property parse error: %d\n", ret);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		ret = snd_soc_get_dai_name(&args, &link->cpu_dai_name);
 		of_node_put(args.np);
 
 		if (ret < 0)
-			return ret;
+			break;
 	}
+	if (ret == 0)
+		cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
 
-	cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
 	of_node_put(cpu);
 	of_node_put(codec);
+	if (ret < 0)
+		return ret;
 
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
 	if (ret < 0)
-		goto err_put_codec_n;
+		goto err_put_cpu_dai;
 
 	/* Set capture capability only for boards with the MAX98090 CODEC */
 	if (codec_link->num_codecs > 1) {
@@ -288,7 +292,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	priv->sclk_i2s = of_clk_get_by_name(cpu_dai, "i2s_opclk1");
 	if (IS_ERR(priv->sclk_i2s)) {
 		ret = PTR_ERR(priv->sclk_i2s);
-		goto err_put_codec_n;
+		goto err_put_cpu_dai;
 	}
 
 	priv->clk_i2s_bus = of_clk_get_by_name(cpu_dai, "iis");
@@ -310,7 +314,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	clk_put(priv->clk_i2s_bus);
 err_put_sclk:
 	clk_put(priv->sclk_i2s);
-err_put_codec_n:
+err_put_cpu_dai:
+	of_node_put(cpu_dai);
 	snd_soc_of_put_dai_link_codecs(codec_link);
 	return ret;
 }
-- 
2.17.1

