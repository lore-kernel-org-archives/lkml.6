Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF61C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A95021569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OgP3fldW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A95021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeHMObp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:31:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53783 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeHMObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:31:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180813114947euoutp02b707aa0b075f0ec7a6cb591f536bcbae~Kb0o49qoO1909419094euoutp02E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 11:49:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180813114947euoutp02b707aa0b075f0ec7a6cb591f536bcbae~Kb0o49qoO1909419094euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534160987;
        bh=9N9j7XXUKooiFn6yPPoa5XxO9DL5bcL4dCIz6tv4UXE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OgP3fldWUhhkRC1yMNN+6JMNsATuEkZKLcpL6K8pFNrHuyut1ARs/tmHoJmK1HguJ
         Ftppdg1g3Z9olTc2XwsB4N8Vi246hZLND3IfgfikMwkmCVHTbaj7ADhD4KU+PAESUH
         tkee6QD30qmDyDsL0VjmaGUrzpretmv27lxRfWRs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180813114946eucas1p2fc88e1cd1fa73c1cc8d7991f031f3f2a~Kb0oJXvqz1604616046eucas1p24;
        Mon, 13 Aug 2018 11:49:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.0F.04441.A50717B5; Mon, 13
        Aug 2018 12:49:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180813114945eucas1p1e9d900848b4256341fe93278f4fa6f67~Kb0nDRoKq0841508415eucas1p1p;
        Mon, 13 Aug 2018 11:49:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180813114945eusmtrp23dca75897851ed52ba82772d10db6069~Kb0mzWaZI2192521925eusmtrp2N;
        Mon, 13 Aug 2018 11:49:45 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-6a-5b71705ac5d6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.7D.04128.950717B5; Mon, 13
        Aug 2018 12:49:45 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180813114944eusmtip283d3bfda3bff00b7b7bbd08f21ac4a1f~Kb0mWteAS0521705217eusmtip2y;
        Mon, 13 Aug 2018 11:49:44 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: re-run dw_hdmi_setup when
 setting mode
To:     Icenowy Zheng <icenowy@aosc.io>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Mon, 13 Aug 2018 13:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725035627.58223-1-icenowy@aosc.io>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+5+zqzY9Ts2XZbeBhFaaUHHAiAQ/nE8hGBSOrJkntba5dryk
        EolhzeUls/LSSod5Ibs5zbyQhfeopeYCFW+FRJrDai4z0trxKPntx/M+7/99HviLcGkHXyaK
        1yTSOo1SJRe48Bq7F9/tidSeV+wtafMlM/U2Pmn6OIaTVsecgLSbxjHyw8I0TmYX3BeSgy1G
        ATk5/RKR7XmKw2KqYnEZo+aGsoTUvYfp1GBeLka9+FnOo+7oS/jUxLUejHqVW8ij7Oat4eJI
        l4MxtCo+mdYFHTrlEldsmMG1g64X6ioz8QzUKTYgsQiIffDbmMljWUrUIGjoCud4HsHVNleO
        7Qhajd5r/u6BL0IDcnHq1QjMo8MCzmRDMODwZ9mTUEBfTRHOmryIxxjk2OwYO8CJUFjKf4az
        LCD8YameW+YRfmDKMSOWvYnj0DlpWmEJ4QGvS6ZW0omJ/dB0+6aQe2cbPLcZcY59YGSqDOPS
        jQhhuVzB7SbDp+w8IaeHgdE8usqeMNPTsMq+8Ld5bfcSZJZYV0IDoUfQW1Et4AYh0NEzwDcg
        kfOYPzxpCeLkULD8WsBYGQg3GLJ5cHHc4EYj252VJaC/IuXcO2DCwjUHZ+LKfofgOpKXritZ
        uq5Y6bpipf/vliPeA+RDJzHqWJoJ1tApgYxSzSRpYgNPJ6jNyPm13iz3/GhCjvfR7YgQIflG
        ib5Wq5DylclMqrodgQiXe0n6NzglSYwyNY3WJZzUJaloph1tFvHkPhK3gDMKKRGrTKTP0bSW
        1q1NMZFYloEi8yO+v20b7tBWodAAw1e/rgJ9cXzd0YJ561j0o2+X0wJtF2W97l19UcLPsxaD
        9c/O6sFNM3cbntr1ra2uhWHHtt/KCg5MTzSccE1R7bK0Mu7BqhGiNnYLap49YpfXm4rKZBZh
        akuEOK5KqU6I6hgaZ/rys236/pDkEMOBs7vlPCZOGRyA6xjlP8/bQvRWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7qRBYXRBnO+CVk0dbxltVj48C6z
        xZWv79ksPi+8x2Rx9ftLZovOiUvYLS7vmsNm8eDlfkaLQ33RDpwei3/+Y/J4f6OV3WPemmqP
        y329TB57vy1g8ZjdMZPV4373cSaPA72TWTw+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S0
        0DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5jR9Yq54DJ3xcalTcwNjEc4uxg5OSQETCSO
        XXzB3sXIxSEksJRR4uDM86wQCXGJ3fPfMkPYwhJ/rnWxQRS9ZpT48HMfI0hCWCBa4vyK6cwg
        CRGBTUwS335dYQFJMAs4Svzt3wrWLSTQwSixcaEkiM0moCnxd/NNNhCbV8BOYsufq0wgNouA
        qsTCnk1gQ0UFIiRWL3/BClEjKHFy5hOwmZwCphI7pk1hh5ivLvFn3iVmCFteYvvbOVC2uMSt
        J/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGK/bjv3c
        soOx613wIUYBDkYlHt4HawuihVgTy4orcw8xSnAwK4nwXmAACvGmJFZWpRblxxeV5qQWH2I0
        BXpuIrOUaHI+MJXklcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpg
        nGn6v3K747XEMuW00BUBKX/ijpVKXxCd8901l7U9/vre9JpHd+P196cYC5ze9F/jekjN5fDw
        AtcJLSvz2z8oqG2aaX1UnLdoefGkyYW5p82+vGEM+KeVVj5To4RrSmKl78TF62rKLeW0Eput
        GB6fuvGsesHBtefm7t76Q1rEXluu49DriQznlViKMxINtZiLihMBFAAqJe0CAAA=
Message-Id: <20180813114945eucas1p1e9d900848b4256341fe93278f4fa6f67~Kb0nDRoKq0841508415eucas1p1p@eucas1p1.samsung.com>
X-CMS-MailID: 20180813114945eucas1p1e9d900848b4256341fe93278f4fa6f67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180725035712epcas1p25df72b8af38438b7bb66a2729fdff445
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180725035712epcas1p25df72b8af38438b7bb66a2729fdff445
References: <CGME20180725035712epcas1p25df72b8af38438b7bb66a2729fdff445@epcas1p2.samsung.com>
        <20180725035627.58223-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.2018 05:56, Icenowy Zheng wrote:
> Currently dw_hdmi_setup is only run when the dw-hdmi bridge is enabled,
> with the mode set last time.
>
> When the bridge is enabled before any mode is set (this may happen when
> booting), the mode won't be set at all, some setup steps will be
> skipped or fail, and the HDMI output may not work.

I guess, it should not happen. Could you show the stack-trace.

>
> Re-run dw_hdmi_setup when setting mode, in order to prevent such
> situation.

mode_set is run with hardware disabled, thus usually it should not touch
hardware.


>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5971976284bf..e2f832182afe 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2007,6 +2007,7 @@ static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
>  
>  	/* Store the display mode for plugin/DKMS poweron events */
>  	memcpy(&hdmi->previous_mode, mode, sizeof(hdmi->previous_mode));
> +	dw_hdmi_setup(hdmi, mode);

This hdmi->previous_mode also looks strange, it is current mode and
moreover it is always available from crtc state, there is no point in
copying it to private field.

Regards
Andrzej
>  
>  	mutex_unlock(&hdmi->mutex);
>  }


