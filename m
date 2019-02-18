Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54924C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221BD218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfBRCSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:18:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbfBRCSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:18:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 82A225B7FAD63462C67C;
        Mon, 18 Feb 2019 10:17:56 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 18 Feb
 2019 10:17:48 +0800
Subject: Re: [PATCH v2] staging: erofs: keep corrupted fs from crashing kernel
 in erofs_namei()
To:     Chao Yu <yuchao0@huawei.com>
CC:     Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        "Fang Wei" <fangwei1@huawei.com>, <stable@vger.kernel.org>
References: <20190201121631.15179-1-gaoxiang25@huawei.com>
 <a9381c0d-9857-4d03-710d-80006d426bbc@huawei.com>
 <c742194d-4207-e7b9-b679-c1f207961f17@huawei.com>
 <31ba7d15-058e-1996-3482-65fbd1e83e26@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <56f03bdf-1817-6b3e-44d5-922637ac39f4@huawei.com>
Date:   Mon, 18 Feb 2019 10:17:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <31ba7d15-058e-1996-3482-65fbd1e83e26@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2019/2/18 9:39, Chao Yu wrote:
> If the image is corrupted, qn->name[i] may be anything, as you commented
> above DBG_BUGON(), we really don't need to go through any later codes, it
> can avoid potentially encoutnering wrong condition.
> 
> * otherwise, it will return 1 to just skip the invalid name
> 

Just I commented in the following source code, qn is actually the user requested
name allocated in __d_alloc, which can be guaranteed with the trailing '\0' and
it is a valid string.

Thanks,
Gao Xiang

>>>> +
>>>> +	/* qd could not have trailing '\0' */
>>>> +	/* However it is absolutely safe if < qd->end */
>>>> +	while (qd->name + i < qd->end && qd->name[i] != '\0') {
>>>> +		if (qn->name[i] != qd->name[i]) {
>>>> +			*matched = i;
>>>> +			return qn->name[i] > qd->name[i] ? 1 : -1;
>>>>  		}
>>>> -		return (qn->len > qd->len);
>>>> +		++i;
>>>>  	}
>>>> -
>>>> -	if (qn->name[i] != qd->name[i]) {
>>>> -		*matched = i;
>>>> -		return qn->name[i] > qd->name[i] ? 1 : -1;
>>>> -	}
>>>> -
>>>> -	++i;
>>>> -	goto loop;
>>>> +	*matched = i;
>>>> +	/* See comments in __d_alloc on the terminating NUL character */
>>>> +	return qn->name[i] == '\0' ? 0 : 1;
>>>>  }
