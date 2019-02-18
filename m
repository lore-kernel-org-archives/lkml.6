Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F782173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zzykdc66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfBRLdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:33:49 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:48001 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfBRLdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:33:49 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190218113346epoutp027fc2837ee991c1296eedd387c078ec26~Echm6w9xY3203532035epoutp02k;
        Mon, 18 Feb 2019 11:33:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190218113346epoutp027fc2837ee991c1296eedd387c078ec26~Echm6w9xY3203532035epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550489626;
        bh=qY6+hgGrgfsjcJuBcan/yQ4q6XLVGneF6hLprmyqwqE=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=Zzykdc662QeN5GTMtxCddGOiCpgyb4l3Q1Em1y3mPudooYaqxA0+ZXYL4L6XPsNMS
         P1SsCHJpBKQ7zTNz+bN0uuwz8wiY/KhYVi8mz+ag26yvGa+krWAG6QT/UPqD5+A6Uc
         UCbaiEmkq+W9CBiblcsSBmroImVazkOtB8qfCjSc=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190218113345epcas1p162b8b5df54811f5bc7655159a73554bc~EchlzDVAr0600006000epcas1p1f;
        Mon, 18 Feb 2019 11:33:45 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.58.04074.9189A6C5; Mon, 18 Feb 2019 20:33:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190218113344epcas1p20c6dd1ab70f6ed9829be6abb28b346f3~EchlRSsd10363503635epcas1p2T;
        Mon, 18 Feb 2019 11:33:44 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-5c-5c6a981903ff
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id EA.C4.04015.8189A6C5; Mon, 18 Feb
        2019 20:33:44 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PN400D3GDG5V170@mmp2.samsung.com>; Mon, 18 Feb 2019 20:33:44 +0900 (KST)
Subject: Re: [PATCH 2/2] ASoC: samsung: i2s: Fix multiple "IIS multi"
 devices initialization
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <8b28c8d6-c8bb-4b31-403b-023f49108e6f@samsung.com>
Date:   Mon, 18 Feb 2019 12:33:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <CAJKOXPfF7+Qp1DLR_YJJOXH-YMQqWbxr0Hp=cKU+7mc9oKTUtA@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7bCmga7kjKwYg+MrRCyuXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNou1R+6yW1xc8YXJgd1jw+cmNo+ds+6ye2xa1cnm0bdlFaPH501y
        AaxRXDYpqTmZZalF+nYJXBmnL91nK/jHWbFi0R2WBsZL7F2MnBwSAiYSU8/dYe5i5OIQEtjB
        KHHh1z42COc7o0T73nOMXYwcYFWPb/pAxDcwSkyesIcRpFtI4D6jxNLLLCC2sECcxP/zn8Gm
        ighoSlz/+50VxGYWWMMo0fiWA8RmEzCU6D3aB9bLK2AnsXnKLRaQ+SwCqhKrrsqBhEUFIiQO
        976DKhGU+DH5Hth4ToFgibZj1xghRmpKvPgyiQXCFpc4dv8mVFxeYvOat2DPSAhcZpM4vHML
        G8SXLhI3D55mh/hFWuLSUVuIcLXEru3dUPUdjBItF7YzQySsJQ4fvwh1P5/Eu689rBC9vBId
        bUIQJR4SvS3r2CFh0sEk0de1i30Co8wsJHfPQnLrLCS3zkJy6wJGllWMYqkFxbnpqcWGBYZ6
        xYm5xaV56XrJ+bmbGMEJQst0B+OUcz6HGAU4GJV4eD+UZcYIsSaWFVfmHmKU4GBWEuENis2K
        EeJNSaysSi3Kjy8qzUktPsQozcGiJM673sE5RkggPbEkNTs1tSC1CCbLxMEp1cCo01C45tIi
        A1GPF77/Pq6+uVRLNb9ImXmuqWyg37bA6VfXuPE43/WXMAjmfZTeLrl1bkzY1GmXnt/7oPwl
        4U28Y/lE5bS1G75J8sh5XVujwyDH/7Z2x+RXKgFxv66Iu0VF3XQ96yUk7SYw7Vocp+mR5isL
        08Oc4hepaKlPXnLLVpL90Env1M9KLMUZiYZazEXFiQD/pg+iDAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jQV2JGVkxBnc26FlcuXiIyWLqwyds
        FufPb2C3+Halg8ni8q45bBZrj9xlt7i44guTA7vHhs9NbB47Z91l99i0qpPNo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDJOX7rPVvCPs2LFojssDYyX2LsYOTgkBEwkHt/06WLk4hASWMco
        8XDZUcYuRk4g5yGjxNM3UiA1wgJxEkdeMIOERQQ0Ja7//c4KUs8ssIZRYuf2bhaI5i4mibal
        HSwgVWwChhK9R/vABvEK2ElsnnKLBWQQi4CqxKqrciBhUYEIiY9P9zFBlAhK/Jh8D6yVUyBY
        Yv35FWwg5cwC6hJTpuSChJkFxCWO3b/JCGHLS2xe85Z5AqPALCTdsxA6ZiHpmIWkYwEjyypG
        ydSC4tz03GKjAsO81HK94sTc4tK8dL3k/NxNjMDw33ZYq28H4/0l8YcYBTgYlXh4P5Rlxgix
        JpYVV+YeYpTgYFYS4Q2KzYoR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzns771ikkEB6Yklqdmpq
        QWoRTJaJg1OqgXH2aT4x21iOn4eXLf6d/FHppxr7DCutxWd/TlbsdHn/nMdyXfsjZ2HNFwXi
        dWW6zNtjud73yxnHyAheeSZ1itWvLrWZfdVClskhv+zfO/73EfZt/3kwwz3yYc1XVSnFXZNC
        D/O8aJjcd+eCoV+5j+iplzMf2FVO3cX/in1V10GLL3Pk25JCDJVYijMSDbWYi4oTAfJTpvl7
        AgAA
X-CMS-MailID: 20190218113344epcas1p20c6dd1ab70f6ed9829be6abb28b346f3
CMS-TYPE: 101P
X-CMS-RootMailID: 20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204
References: <CGME20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204@epcas2p2.samsung.com>
        <20190215144809.28007-1-s.nawrocki@samsung.com>
        <20190215144809.28007-2-s.nawrocki@samsung.com>
        <CAJKOXPfF7+Qp1DLR_YJJOXH-YMQqWbxr0Hp=cKU+7mc9oKTUtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 12:00, Krzysztof Kozlowski wrote:
> On Fri, 15 Feb 2019 at 15:48, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:

>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> index e36c44e2f1bb..4a6dd86459bc 100644
>> --- a/sound/soc/samsung/i2s.c
>> +++ b/sound/soc/samsung/i2s.c
>> @@ -1339,20 +1339,34 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
>>  /* Create platform device for the secondary PCM */
>>  static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
>>  {
[...]
>> +       ret = platform_device_add(pdev_sec);
>>         if (ret < 0) {
>> -               dev_info(&pdev->dev, "device_attach() failed\n");
>> +               platform_device_put(pdev_sec);
>>                 return ret;
>>         }
>>
>> -       priv->pdev_sec = pdev;
>> +       priv->pdev_sec = pdev_sec;
>> +
>> +       ret = device_attach(&pdev_sec->dev);
>> +       if (ret < 0) {
>> +               dev_info(&pdev_sec->dev, "device_attach() failed\n");
> 
> Don't you need here platform_device_unregister()?

It's in i2s_delete_secondary_device(), but it might be better
indeed to add it here and move the priv->pdev_sec assignment
to the end making it a last step. 

-- 
Thanks,
Sylwester
