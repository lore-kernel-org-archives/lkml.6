Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3DCC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305AA214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nI4xl+Xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305AA214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJQIVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:21:03 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52519 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbeJQIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:21:03 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181017002758epoutp049c535b1f0f21521c5e8d9493d9d50a27~ePc5KUDhc1682616826epoutp04g;
        Wed, 17 Oct 2018 00:27:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181017002758epoutp049c535b1f0f21521c5e8d9493d9d50a27~ePc5KUDhc1682616826epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539736078;
        bh=Om2kOX7WjGjxHas+FpFaZwXleQSrzXojGlRh1POgFzA=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=nI4xl+Xvg2dLWIhMXjBYwFRmPMPhz56jb+JESCWUnsbszN3TG3ScvxsDOyGdtcKVT
         jwuhWgmEmf5cx2O8VwMHTe+N9l4vh1mip8PdF2hxFRFaPwjArXMFh7hMi2xiCbO0/F
         4TpAU2RzIiTXRxIjAdJFiYGKdMED7fu++iRFXA7E=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181017002755epcas1p38d9713c6ede86c33bb53009279ad488f~ePc18Gre21153411534epcas1p3K;
        Wed, 17 Oct 2018 00:27:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.F3.04073.70286CB5; Wed, 17 Oct 2018 09:27:51 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017002751epcas1p27ab64dfa4ea01e6771ba3d215319b5cb~ePcx4VbE-1680216802epcas1p2v;
        Wed, 17 Oct 2018 00:27:51 +0000 (GMT)
X-AuditID: b6c32a37-3edff70000000fe9-91-5bc68207a659
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 22.3B.03743.60286CB5; Wed, 17 Oct
        2018 09:27:50 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGP00ITWVYDVU00@mmp2.samsung.com>; Wed, 17 Oct 2018 09:27:50 +0900 (KST)
Message-id: <5BC68205.1090406@samsung.com>
Date:   Wed, 17 Oct 2018 09:27:49 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Fix static checker warning in
 try_then_request_governor
In-reply-to: <20181016100203.18624-1-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmni5707FogzufeCzW3D7EaLH5XA+r
        xdmmN+wWl3fNYbP43HuE0eJ24wo2BzaPHXeXMHr0bVnF6PF5k1wAc1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsaard3MBaf4KxqOrWRu
        YLzG08XIySEhYCIxd/sL5i5GLg4hgR2MEs8PbmGBcL4zSvxev5qxi5EDrGpvYwVIg5DABqCi
        0zIgNq+AoMSPyfdYQEqYBeQljlzKBgkzC2hKbN29nh0kLCRwl1HigjJEtZbE7k/7WUBsFgFV
        iQ9fN4HZbEDx/S9usIHY/AKKEld/PGYEsUUFIiR2zv/GDmKLCERKTGr/yAhyGbNAB6PEiYZm
        sLXCAjESey9JgtRwCjhJHDp9Cux6CYE9bBJX/u9mhvjRRWLZugUsELawxKvjW9ghvpKWuHTU
        FqK+nVHiy4tmVghnAqPEh1ObmSAajCWeLexigniMT+Ld1x5WiGZeiY42IYgSD4kvsx+wQYJn
        KqNE0zejCYyys5BCaBYihGYhhdACRuZVjGKpBcW56anFhgXGyDG3iRGcvrTMdzBuOOdziFGA
        g1GJh3eH2LFoIdbEsuLK3EOMEhzMSiK8p6uBQrwpiZVVqUX58UWlOanFhxhNgUE8kVlKNDkf
        mFrzSuINTY2MjY0tTAzNTA0NlcR5n0jNjRYSSE8sSc1OTS1ILYLpY+LglGpg9AhaEpcSv8qs
        OP+wP8tC1d8SjeuTkwqfzVKa9jWsa9L/fbyu5XNNF9geljl31ETHyEBypW3D0SS9hA3rlUy2
        +eeWbdii7ib6bM5S8fM2UUYN0yZ1Xu9bblfYzJh+8MfmUFc97nl9cVN3H76+eLr90b1r7i7X
        DMw1Y/hdMO9hr8Gkfb3v3FfpKrEUZyQaajEXFScCADbLERl1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsVy+t9jQV22pmPRBovmmlusuX2I0WLzuR5W
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmweO+4uYfTo27KK0ePzJrkA5igum5TUnMyy1CJ9uwSu
        jDVbu5kLTvFXNBxbydzAeI2ni5GDQ0LARGJvY0UXIxeHkMA6RomXJxaydTFycvAKCEr8mHyP
        BaSGWUBe4silbJAws4C6xKR5i5hBbCGB+4wSE9YpQpRrSez+tJ8FxGYRUJX48HUTmM0GFN//
        4gbYSH4BRYmrPx4zgowUFYiQ6D5RCRIWEYiUOLZ5ATvICcwCHYwS39atZgepERaIkdh7SRLi
        tOmMEv8e3wbbyyngJHHo9CmWCYwCs5BcOgvh0llILl3AyLyKUTK1oDg3PbfYqMAwL7Vcrzgx
        t7g0L10vOT93EyMwkLcd1urbwXh/SfwhRgEORiUe3h1ix6KFWBPLiitzDzFKcDArifCergYK
        8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOi31f/Yqtlr
        9RiyH+kaOtlzGW19IpTTXvnwQr4t35OvEy8+2ij5bbZ3tfjL6ztUmu/a6E+91S6dpMum1ZvN
        X7lWmXnf1XPPN6c5se2e9o/3qm1Z2P6LG8rXzD7+XUHLX+fL/6zdyqnxXfxB+gy9V11F1xm+
        Tpi0cdd8pjYF/5sFR3Ndp2gveqPEUpyRaKjFXFScCACeN1ECYAIAAA==
X-CMS-MailID: 20181017002751epcas1p27ab64dfa4ea01e6771ba3d215319b5cb
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181016100221epcas2p3da3cd977eefd0681e7d1231640b9e96e
References: <CGME20181016100221epcas2p3da3cd977eefd0681e7d1231640b9e96e@epcas2p3.samsung.com>
        <20181016100203.18624-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 10월 16일 19:02, Enric Balletbo i Serra wrote:
> The patch 23c7b54ca1cd: "PM / devfreq: Fix devfreq_add_device() when
> drivers are built as modules." leads to the following static checker
> warning:
> 
>     drivers/devfreq/devfreq.c:1043 governor_store()
>     warn: 'governor' can also be NULL
> 
> The reason is that the try_then_request_governor() function returns both
> error pointers and NULL. It should just return error pointers, so fix
> this by returning a ERR_PTR to the error intead of returning NULL.
> 
> Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 62ead442a872..b10124c7308f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -231,7 +231,7 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>   * if is not found. This can happen when both drivers (the governor driver
>   * and the driver that call devfreq_add_device) are built as modules.
>   * devfreq_list_lock should be held by the caller. Returns the matched
> - * governor's pointer.
> + * governor's pointer or an error pointer.
>   */
>  static struct devfreq_governor *try_then_request_governor(const char *name)
>  {
> @@ -257,7 +257,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  		/* Restore previous state before return */
>  		mutex_lock(&devfreq_list_lock);
>  		if (err)
> -			return NULL;
> +			return ERR_PTR(err);
>  
>  		governor = find_devfreq_governor(name);
>  	}
>

LGTM.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
