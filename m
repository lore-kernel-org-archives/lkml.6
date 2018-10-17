Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE41AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F2D21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AU0cYITi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F2D21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJQRFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:05:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36970 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQRFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:05:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017091101euoutp01fdc0e87a4a7e5a7a4a60afe8370d21a8~eWlk0eivK2750227502euoutp01D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:11:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017091101euoutp01fdc0e87a4a7e5a7a4a60afe8370d21a8~eWlk0eivK2750227502euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539767461;
        bh=rpFHPe5GzF8y2Gv2U16uAJceNbHh7K+Aucm0PEZhcA0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AU0cYITisYdLCj5Nnci8J1BbmUs+ux/SMtixaS/SWlUAT0OJwrGAjEu2iHvR6IXO7
         AoEPw+PK81h3BrVxJGwUHjcAhd3S4QzSVziPjsYXJnDJSlxgf16vzROvu+yinQl6Cn
         5Whe6KWXicY+dUef9pzbdAMO1PQInYCv+eDGqRgo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017091100eucas1p2ea1f752972a7978f9a1ca465c1157ab5~eWljqy-Zk0924109241eucas1p2-;
        Wed, 17 Oct 2018 09:11:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AC.04.04294.4ACF6CB5; Wed, 17
        Oct 2018 10:11:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181017091059eucas1p2919e8b5984d4b8998438251a26987068~eWli2LsTV3025130251eucas1p2r;
        Wed, 17 Oct 2018 09:10:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181017091059eusmtrp196ea38ba42048c4e5934b2ac0e115e97~eWlil_RWC0296402964eusmtrp1A;
        Wed, 17 Oct 2018 09:10:59 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-eb-5bc6fca41214
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 24.BA.04128.3ACF6CB5; Wed, 17
        Oct 2018 10:10:59 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181017091058eusmtip134ee45b4055e211c1160b22435099c64~eWliLM66H1756717567eusmtip1p;
        Wed, 17 Oct 2018 09:10:58 +0000 (GMT)
Subject: Re: [PATCH 3/3] drivers: use probe_err function in obvious cases
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Wed, 17 Oct 2018 11:10:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeZEtG7f3WmgvLrirReSwgbOQDp1qiBZ47652poMw8BUQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+Xm3u7vV5DofO1hUriQq8kXRjR4UGEwoMowQ/aOWXnTopuyq
        aX/k1Kyl+UDTcmi2tCbDGJuPfKSC81FqqKVh0lJrEUorwRVmam1eJf/7nNf3nC8cAhO1cn0J
        uTKFVilliRJcwGnu+z18sHa5LzroTecWarbYgijTAyOXKpux4VROjRGndOV6RJk/v+NSb9sq
        cepZj5VHVTnKsFN8aavWypOaDXdwaVdVPU/aUJsp/dE5jksLGw1IumDeEc6LEhyPpRPlabQq
        8OQVQfyS/kSyRZBeaFQjNZrj5SE+AeQhmFrOcnOxiKxDMPn9TB4SONmB4LZhnMsGCwj01Xq0
        MWEoXlwv6BGs5LVjbGBHsNi+vKblSYaB3ZiP5yEe4UUGQleaqwUjSzDoGPmIu1pwch+sNLxf
        Yw7pD0NjWszF3mQk9Ezr1pYJSQ94VWHjuJhPXoDZ3MW1fozcCc/tlRjLYpi0Vbu5FgDZxwOj
        Y945TDiH06B+Op09OhTyTZZ1A54w19+4bn87DJbe5bCcCdkVYxiro0HwskaPs4VjYOkf5bo0
        MefRxrZAFwJ5GhZr/Fh0hwm7B3uNO5Q038fYtBA0t0Sshh9MvW7CWBbDk5GfeDGSaDd51G7y
        pd3kS/t/7SPEMSAxncoo4mgmRElfC2BkCiZVGRcQk6QwI+dDDa72O1pQ2/LVbkQSSLJV2OLT
        Fy3iytKYDEU3AgKTeAnlNc6UMFaWcZ1WJV1WpSbSTDfaRnAkYuHTh6ZoERknS6ETaDqZVm1U
        3Qi+rxqVFvz6u2fX/NzqpegCW5W5zhRjtWQPtOs6Kh5rez8Qf4pyNaMH6gIyG4+22CYiGYPG
        MVyfPqgO0/iEnW+S6DyESzNFmfcGPGThNp96byl2MeHsl8NROavnXhwZuLF7QT5ULs7yjQi9
        +S1kaG+v30wI1/9TcO7SdJCw0vLVGjGPJBwmXha8H1Mxsn9QHs0ETAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7qL/xyLNnj2R9ji5YTDjBYbZ6xn
        tZj68AmbRfPi9WwWC6ctZ7TY9Pgaq8XlXXPYLNYeuctuMffLVGYHTo+ds+6ye2xa1cnmsX/u
        GnaPzUvqPd7vu8rm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
        sVZGpkr6djYpqTmZZalF+nYJehm/ltsWHOaq6FvfwNjA+Iq9i5GTQ0LARGLVhB+sXYxcHEIC
        SxklPj56ywqREJfYPf8tM4QtLPHnWhcbRNFrRokNy5vBuoUFPCXeru8GSrBziAjoS+wvA4ky
        C0xjljg/WxeivIFJYv40iJlsApoSfzffZAOxeQXsJNavaQGbzyKgKnHmyiwwW1QgQmL18hes
        EDWCEidnPmEBsTkFAiVetv5gg1igLvFn3iVmCFteYvvbOVC2uMStJ/OZJjAKzULSPgtJyywk
        LbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGJfbjv3csoOx613wIUYBDkYlHt4d
        YseihVgTy4orcw8xSnAwK4nwZi4GCvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MGXklcQb
        mhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpg3CAgPD1vuRjHFQe/m+fm
        ndVvrzK5wBQU8sdKpJ7pz/2r1vHlB54bBs1VrhPyrzqeOu3v6s7f3Y5msx/LMi6/asC7OZnZ
        YFXM6S6W7t7X9lM/LORm8Tcp3mnwU+7llalbGY45Lwm0ScrbsGuln/D36tRN7QWRnaf9jZdk
        ST88vMWmP84yf8daJZbijERDLeai4kQAPiXj8uECAAA=
Message-Id: <20181017091059eucas1p2919e8b5984d4b8998438251a26987068~eWli2LsTV3025130251eucas1p2r@eucas1p2.samsung.com>
X-CMS-MailID: 20181017091059eucas1p2919e8b5984d4b8998438251a26987068
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016072250eucas1p1a763670c8509d20a6e6847eadb246817
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016072250eucas1p1a763670c8509d20a6e6847eadb246817
References: <CGME20181016072250eucas1p1a763670c8509d20a6e6847eadb246817@eucas1p1.samsung.com>
        <20181016072244.1216-1-a.hajda@samsung.com>
        <20181016072244.1216-4-a.hajda@samsung.com>
        <CAHp75VeZEtG7f3WmgvLrirReSwgbOQDp1qiBZ47652poMw8BUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 15:51, Andy Shevchenko wrote:
> On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> The patch replaces obviously matching code with probe_err function.
>> There are many more places where probe_err could be used.
>> The patch shows how the new function should be used, and how it
>> improves the code.
>> --- a/drivers/gpio/gpio-pca953x.c
>> +++ b/drivers/gpio/gpio-pca953x.c
>> @@ -824,9 +824,7 @@ static int pca953x_probe(struct i2c_client *client,
>>         reg = devm_regulator_get(&client->dev, "vcc");
>>         if (IS_ERR(reg)) {
>>                 ret = PTR_ERR(reg);
>> -               if (ret != -EPROBE_DEFER)
>> -                       dev_err(&client->dev, "reg get err: %d\n", ret);
>> -               return ret;
>> +               return probe_err(&client->dev, ret, "reg get err: %d\n", ret);
> No need to assign ret above.
> As I mentioned, better to print a value for everyone.

OK.

Thanks for all reviews. I have posted v2 of patches 1 and 2 as replies
in this thread.
As patch 3 requires splitting, adjusting arguments of probe_err (remove
err and newline), and depends on patch 1 I will prepare it and post
later, probably next cycle as suggested Javier.

Regards
Andrzej


>
>>         }
> Please, split it at least one patch per subsystem.
>

