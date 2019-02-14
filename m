Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A845C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B44218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rbF5KGAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfBNXsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:48:00 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:10136 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbfBNXsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:48:00 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190214234756epoutp0220ce086e624a0642324e2d760a77b97c~DX9ej9uuf2457024570epoutp02Q
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 23:47:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190214234756epoutp0220ce086e624a0642324e2d760a77b97c~DX9ej9uuf2457024570epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550188076;
        bh=GyB404MqkBIcCHGNllW8K9wRHYA7qVpPBWvDcSMVufc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rbF5KGAnqL86JCQtV9VxlKd+lfvttRC9HVQtStR/7Ak0TfNNdY/xAYG4BUkAz+YOR
         monkemLqdArFoADEtumVeYlbcN0ipFJcN+oUt7Vaq9enmzt/3Cm+qSe6XxNcorn9fO
         MOqFr4cLs9H7o/m0n//8sx7qfCt84xoDSHpnGvQ0=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214234753epcas1p138073325d98c2f7cc4dc14105df13763~DX9b4l1bY0190101901epcas1p1K;
        Thu, 14 Feb 2019 23:47:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.53.04069.92EF56C5; Fri, 15 Feb 2019 08:47:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190214234752epcas1p4ce2b42e6edf7801235f82c5f918f24b1~DX9agArY90205102051epcas1p4f;
        Thu, 14 Feb 2019 23:47:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190214234752epsmtrp1fee47ec7433984cfb15641baa6ba3923~DX9aepF822638926389epsmtrp1b;
        Thu, 14 Feb 2019 23:47:52 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-47-5c65fe29f1df
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.0F.03971.82EF56C5; Fri, 15 Feb 2019 08:47:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190214234751epsmtip18680f1e6f3e0f41e096d325b020afbce~DX9aTGkhM2296322963epsmtip13;
        Thu, 14 Feb 2019 23:47:51 +0000 (GMT)
Subject: Re: [PATCH 1/4] PM / devfreq: Track overall load monitor state
 instead of 'stop_polling'
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fdb765d1-6248-dbb9-20c5-3add6581018e@samsung.com>
Date:   Fri, 15 Feb 2019 08:47:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214165947.GY117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmnq7mv9QYg7dTVCyeHdW2aJm1iMXi
        bNMbdotbDTIWl3fNYbP43HuE0aLzyywga8NjRovbjSvYLH7umsfiwOUxu+Eii8fOWXfZPXqb
        37F5HHy3h8mjb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyV
        FPISc1NtlVx8AnTdMnOADlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn
        5haX5qXrJefnWhkaGBiZAhUmZGfcfZJRcJ6nYtrF72wNjBO5uhg5OSQETCQ+Xz7H0sXIxSEk
        sINRYm/XWSjnE6PEpi0voZxvjBKP/nazwrRcu3CNESKxl1Fi2vdXbBDOe0aJSTfPs4BUCQsk
        S8zYfI8JxBYR8Jb4+38lWBGzwHkmiRfXnjKCJNgEtCT2v7jBBmLzCyhKXP3xGCzOK2An8WDd
        CbA4i4CqxNejS5hBbFGBCInDve+gagQlTs58AraMU8BQ4uK6j+wgNrOAuMStJ/OZIGx5ieat
        s5lBFksI9LNLbD09kxniBxeJKw23mCBsYYlXx7ewQ9hSEi/726DsaomVJ4+wQTR3MEps2X8B
        GgDGEvuXTgZq5gDaoCmxfpc+xDI+iXdfe1hBwhICvBIdbUIQ1coSlx/chVolKbG4vZMNwvaQ
        uLxhFfsERsVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAmPk6N7ECE61WuY7GDec8znE
        KMDBqMTDuyIjNUaINbGsuDL3EKMEB7OSCO/1h0Ah3pTEyqrUovz4otKc1OJDjKbA0J7ILCWa
        nA/MA3kl8YamRsbGxhYmhmamhoZK4rzrHZxjhATSE0tSs1NTC1KLYPqYODilGhhF7wYKpWV3
        RGswtJjPtu/4HFQx5cHCvy+KT7uZa17dXu8wu9EvwbloS3HMdBNfl11Xtjw+uuV928xjkT2T
        lyzdt74wVvWkdGJR2NdDVX0mSqtdDv/Y9YT/rONP+9OdEvKVr9pufrwj3nLsdRWX3cRXKy/c
        nKA/I8hiaSUDk/iyjJ+c+w24f+cpsRRnJBpqMRcVJwIApgUiFMsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnK7Gv9QYgwVrWCyeHdW2aJm1iMXi
        bNMbdotbDTIWl3fNYbP43HuE0aLzyywga8NjRovbjSvYLH7umsfiwOUxu+Eii8fOWXfZPXqb
        37F5HHy3h8mjb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4Mu4+ySg4z1Mx7eJ3tgbGiVxdjJwc
        EgImEtcuXGPsYuTiEBLYzSgxbVM3G0RCUmLaxaPMXYwcQLawxOHDxSBhIYG3jBKXrrqB2MIC
        yRIzNt9jArFFBLwl/v5fyQYyh1ngMpNE9+5fTBBDlzJJ7J23iR2kik1AS2L/ixtgC/gFFCWu
        /njMCGLzCthJPFh3AizOIqAq8fXoEmYQW1QgQuLj031MEDWCEidnPmEBsTkFDCUurvsINpNZ
        QF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xY
        YJiXWq5XnJhbXJqXrpecn7uJERxxWpo7GC8viT/EKMDBqMTDuyIjNUaINbGsuDL3EKMEB7OS
        CO/1h0Ah3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGAOX
        W2Yc6wtI9bxgKZx2wExCYGudwlEd7nBura/XH7myHX57dcUklciWqYvlZv2/Ju0ptODwqis/
        9tt8mfe8+Hf6vKN2Ybd+8bgd5d5tN48nRUnJPuZW1qp/t8+ViPHf41pXKrdy5xTGd5xquXMU
        Tux/eOSJ7KceL+HkgCaH55KzlL5N3mYvp6nEUpyRaKjFXFScCACxQZUbtAIAAA==
X-CMS-MailID: 20190214234752epcas1p4ce2b42e6edf7801235f82c5f918f24b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190214170024epcas3p1fd9703dd6d0f2ee90bb52f24b8357d1c
References: <20190214013042.254790-1-mka@chromium.org>
        <20190214013042.254790-2-mka@chromium.org>
        <CAGTfZH3E+RetMzKxzZNEgYw6=kocdfgRcKSbmP5GfZ4k1j0Cuw@mail.gmail.com>
        <CGME20190214170024epcas3p1fd9703dd6d0f2ee90bb52f24b8357d1c@epcas3p1.samsung.com>
        <20190214165947.GY117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 19. 2. 15. 오전 1:59, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Thu, Feb 14, 2019 at 11:25:52PM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> 2019년 2월 14일 (목) 오후 7:16, Matthias Kaehlcke <mka@chromium.org>님이 작성:
>>>
>>> The field ->stop_polling indicates whether load monitoring should be/is
>>> stopped, it is set in devfreq_monitor_suspend(). Change the variable to
>>> hold the general state of load monitoring (stopped, running, suspended).
>>> Besides improving readability of conditions involving the field and this
>>> prepares the terrain for moving some duplicated code from the governors
>>> into the devfreq core.
>>>
>>> Hold the devfreq lock in devfreq_monitor_start/stop() to ensure proper
>>> synchronization.
>>
>> IMHO, I'm not sure that there are any benefits changing
>> from 'stop_polling' to 'monitor_state'. I have no objections
>> if Myungjoo confirms it.
> 
> I agree that as an isolated change there isn't a clear benefit.
> However in the context of the series the change is needed to
> avoid resuming a load monitor that wasn't even started.
> 
> In case this series isn't accepted I'd still suggest to change the
> name from 'stop_polling' to 'suspended'. I read 'stop_polling' as a
> call for action, while 'suspended' is a state. IMO at least in some
> contexts conditions using a state is clearer.

I agree to change the variable name 'stop_polling' to 'suspended'
for using the correct meaningful name.

> 
> Cheers
> 
> Matthias
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
