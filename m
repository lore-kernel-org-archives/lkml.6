Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C00C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEC520855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dro0GWz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfAUHis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:38:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:10546 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfAUHir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:38:47 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190121014202epoutp021ed19bd9116d7b956af0be6f9e71e513~7uY_DECaB2119921199epoutp024
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:42:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190121014202epoutp021ed19bd9116d7b956af0be6f9e71e513~7uY_DECaB2119921199epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548034923;
        bh=fbtpDjs7tFi0tVH3fN2ayJ+HRVYRGC2jIbzOXZpY9BI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Dro0GWz9jwP9SeUQlh2PgOJKbjztL/VuKm+kLP89cOR9r6aBAhi67zglWXaXsPj1d
         qZQNxt2fRz7y+LZJs+DDXQ8sdJ4HGa3KVpJj3nPiJ9p8WxNCS18ajzIDfXyafLMm4f
         7YPLWT6ZLoypAAEBVcT9kwkEcyQIQhXyiDTuYe0A=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190121014201epcas1p4d0e07dca300f77a87a646a8741b5432a~7uY8f174N2878228782epcas1p4N;
        Mon, 21 Jan 2019 01:42:01 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.AB.04173.963254C5; Mon, 21 Jan 2019 10:42:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190121014200epcas1p1aef2348cc44f7cb742a3c3105868ade5~7uY8DNVaX2758927589epcas1p19;
        Mon, 21 Jan 2019 01:42:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190121014200epsmtrp2c1896ee9994a814e3a1a4507db0312c7~7uY8CSmZ30873508735epsmtrp2Z;
        Mon, 21 Jan 2019 01:42:00 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-af-5c452369b41a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.10.03971.863254C5; Mon, 21 Jan 2019 10:42:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190121014200epsmtip17d4e325cb9fb7554230a9884eb73c359~7uY73rnm80894708947epsmtip1-;
        Mon, 21 Jan 2019 01:42:00 +0000 (GMT)
Subject: Re: [PATCH 3/3] PM / devfreq: fix mem leak in devfreq_add_device()
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0ae2e104-4ff0-888a-c6ce-12b40a76e14d@samsung.com>
Date:   Mon, 21 Jan 2019 10:42:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190119160454.23151-3-tiny.windzz@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmrm6msmuMwfcJghZnm96wW1zeNYfN
        4nPvEUaL240r2Czm/p7A5sDqsXPWXXaPvi2rGD0+b5ILYI7KtslITUxJLVJIzUvOT8nMS7dV
        8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqmkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
        yC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM44sGApS0Ere8XJ9ReYGxivsnYx
        cnJICJhIzJl0jq2LkYtDSGAHo8Txjq1sIAkhgU+MEo+WaUIkvjFK3Dp8iAmm49ujV0wQRXsZ
        JT7N8YUoes8ocWPBCmaQhLCAt8TNzZ2MILaIQLnEjD1nwNYxCyhI/Lq3CcxmE9CS2P/iBtg2
        fgFFias/HoPV8wrYSTzduxYsziKgKrFsdhNYXFQgQqLj/mo2iBpBiZMzn7CA2JwC1hLNF95C
        zReXuPVkPhOELS/RvHU2M8hxEgKX2SSW7tzIDvGBi8S+XZuhvhGWeHV8C1RcSuLzu71sEHa1
        xMqTR9ggmjsYJbbsvwANMGOJ/UsnAzVzAG3QlFi/Sx9iGZ/Eu689rCBhCQFeiY42IYhqZYnL
        D+5CrZKUWNzeCTXeQ+LsmxuMExgVZyF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQuMkCN7
        EyM4NWqZ7WBcdM7nEKMAB6MSD++Pey4xQqyJZcWVuYcYJTiYlUR4M447xwjxpiRWVqUW5ccX
        leakFh9iNAWG9kRmKdHkfGDaziuJNzQ1MjY2tjAxNDM1NFQS513vANQkkJ5YkpqdmlqQWgTT
        x8TBKdXA2H/0a1GPh7n1/aOFT+t4pgYsnZTy8WHk1Hv133cHvLZQ+SR/zulW8L8Qx0jf3e9e
        /DQX8Kt25Gqbeu7wC07VF8352rMeJzrJr5kSe807N/dBY6b+XQV2myU35m/PSjP6Z9ikxG5n
        46ganzmLW6VnedKyg7KfV1mYrVfyu/lZoMFxQstizpwcJZbijERDLeai4kQA45+HzaMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnG6GsmuMwaxn2hZnm96wW1zeNYfN
        4nPvEUaL240r2Czm/p7A5sDqsXPWXXaPvi2rGD0+b5ILYI7isklJzcksSy3St0vgyjiwYClL
        QSt7xcn1F5gbGK+ydjFyckgImEh8e/SKqYuRi0NIYDejxLetF5kgEpIS0y4eZe5i5ACyhSUO
        Hy4GCQsJvGWUWLpQDMQWFvCWuLm5kxHEFhEolzj//BLYTGYBBYlf9zaxQszczyhxYMk3NpAE
        m4CWxP4XN8BsfgFFias/HoM18wrYSTzduxYsziKgKrFsdhNYXFQgQuLsy3VQNYISJ2c+YQGx
        OQWsJZovvIVapi7xZ94lZghbXOLWk/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKU
        TC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4SLc0djJeXxB9iFOBgVOLh/XHPJUaINbGs
        uDL3EKMEB7OSCG/GcecYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQW
        wWSZODilGhhTTPl19XarlsQ/3LdBdtNH5oQE9TML7u4vXSjPni+cP38Sa3f0q9o6ywNdb9Pe
        Ll12PPEx61/9ukXrhBn6hR423hIou1DVWn9g9k6ROUcsJXn27nRvZd3yMk7PbovsQuG5i33O
        d2z7nCF87nRR8YXCyq2SSQ2ndh98ft40sm7XD0ZhpusJcVuUWIozEg21mIuKEwHwjsIxjgIA
        AA==
X-CMS-MailID: 20190121014200epcas1p1aef2348cc44f7cb742a3c3105868ade5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190119183020epcas1p4c0ce7cf4c2ed02da5d6ffb7bbadfd8b8
References: <20190119160454.23151-1-tiny.windzz@gmail.com>
        <CGME20190119183020epcas1p4c0ce7cf4c2ed02da5d6ffb7bbadfd8b8@epcas1p4.samsung.com>
        <20190119160454.23151-3-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 1. 20. 오전 1:04, Yangtao Li wrote:
> 'devfreq' is malloced in devfreq_add_device() and should be freed in
> the error handling cases, otherwise it will cause memory leak.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 923889229a0b..fe6c157cb7e0 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
> -			goto err_out;
> +			goto err_dev;
>  		mutex_lock(&devfreq->lock);
>  	}
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
