Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02598C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77EA2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77EA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeKBXqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:46:32 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44408 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727751AbeKBXqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:46:32 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA2EYTUT021266;
        Fri, 2 Nov 2018 09:38:19 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ncne2yjn1-1;
        Fri, 02 Nov 2018 09:38:19 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 19889611E123;
        Fri,  2 Nov 2018 09:38:19 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 2 Nov 2018
 14:38:18 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wA2EcHV9006678; Fri,
 2 Nov 2018 14:38:17 GMT
Date:   Fri, 2 Nov 2018 14:38:17 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm97xx: fix uninitialized regmap pointer problem
Message-ID: <20181102143817.GP16508@imbe.wolfsonmicro.main>
References: <20181102112341.753642-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181102112341.753642-1-arnd@arndb.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=876 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811020133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:23:08PM +0100, Arnd Bergmann wrote:
> gcc notices that without either the ac97 bus or the pdata, we never
> initialize the regmap pointer, which leads to an uninitialized variable
> access:
> 
> sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
> sound/soc/codecs/wm9712.c:666:2: error: 'regmap' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Since that configuration is invalid, it's better to return an error
> here. I tried to avoid adding complexity to the conditions, and turned
> the #ifdef into a regular if(IS_ENABLED()) check for readability.
> This in turn requires moving some header file declarations out of
> an #ifdef.
> 
> The same code is used in three drivers, all of which I'm changing
> the same way.
> 
> Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  static void wm9713_soc_remove(struct snd_soc_component *component)
>  {
> -#ifdef CONFIG_SND_SOC_AC97_BUS
>  	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
>  
> -	if (!wm9713->mfd_pdata) {
> +	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {

Should this one not also have an && !wm9713->mfd_pdata?

Thanks,
Charles

>  		snd_soc_component_exit_regmap(component);
>  		snd_soc_free_ac97_component(wm9713->ac97);
>  	}
> -#endif
>  }
>  
>  static const struct snd_soc_component_driver soc_component_dev_wm9713 = {
> -- 
> 2.18.0
