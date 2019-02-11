Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A488C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCFB218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfBKNVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:21:48 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24773 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbfBKNVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:21:47 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BDKqv5004947;
        Mon, 11 Feb 2019 14:21:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qhurut5qx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Feb 2019 14:21:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7751C31;
        Mon, 11 Feb 2019 13:21:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34B122D79;
        Mon, 11 Feb 2019 13:21:27 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 Feb
 2019 14:21:26 +0100
Subject: Re: [PATCH 4/4] iio: counter: stm32-lptimer: Add power management
 support
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <vilhelm.gray@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
 <20190209162133.65e6fd93@archlinux>
 <20190210213320.fs5kzezyzwd6akpx@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <7abbd3e2-4a33-975a-39ee-dcf608633b36@st.com>
Date:   Mon, 11 Feb 2019 14:21:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210213320.fs5kzezyzwd6akpx@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/19 10:33 PM, Uwe Kleine-König wrote:
> On Sat, Feb 09, 2019 at 04:21:33PM +0000, Jonathan Cameron wrote:
>> On Tue, 5 Feb 2019 13:40:29 +0100
>> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>
>>> Add suspend/resume PM sleep ops. When going to low power, disable
>>> active counter. Only active counter should be resumed: don't touch
>>> disabled counter, as it may be used by other LPTimer MFD child driver.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> I think this looks fine.  I'm not totally sure if patches 3,4 are
>> separable from 1,2 though so please let me know whether I should take
>> these now, or let all 4 go in together via some path?
> 
> I'd say these are orthogonal, so if you are happy with patches 3 and 4
> you can take them without bothering for patches 1 and 2.

Hi Uwe, Jonathan,

Thanks for reviewing. I confirm you can take patches 3 and 4. I'll send
a v2 for patches 1 and 2 separately.

Best regards,
Fabrice

> 
> Best regards
> Uwe
> 
