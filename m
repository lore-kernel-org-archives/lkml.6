Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BD3C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977D1208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977D1208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967956AbeFRIwx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:52:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44758 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965791AbeFRIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:52:51 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5I8mWWi014910;
        Mon, 18 Jun 2018 03:52:46 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2jmyy2b3s4-1;
        Mon, 18 Jun 2018 03:52:46 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 16E8C611C8A7;
        Mon, 18 Jun 2018 03:53:39 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.301.0; Mon, 18 Jun 2018
 09:52:45 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w5I8qjvA001757; Mon,
 18 Jun 2018 09:52:45 +0100
Date:   Mon, 18 Jun 2018 09:52:45 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: arizona: Don't use regmap_read_poll_timeout
Message-ID: <20180618085245.GE18740@imbe.wolfsonmicro.main>
References: <20180604115750.6126-1-ckeepax@opensource.cirrus.com>
 <20180618062754.GF31141@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180618062754.GF31141@dell>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806180109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 07:27:54AM +0100, Lee Jones wrote:
> On Mon, 04 Jun 2018, Charles Keepax wrote:
> > @@ -240,18 +241,28 @@ static int arizona_poll_reg(struct arizona *arizona,
> >  			    int timeout_ms, unsigned int reg,
> >  			    unsigned int mask, unsigned int target)
> >  {
> > +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_ms * USEC_PER_MSEC);
> >  	unsigned int val = 0;
> > -	int ret;
> > +	int ret = regmap_read(arizona->regmap, reg, &val);
> 
> I'm not a fan of this type of initialisation.
> 
> Also, what's the point of assigning 'ret' if you never check it?
> 

It could get checked if the timeout value is very small causing
the while loop to be skipped and almost certainly will cause
un-initialised warnings without it.

I can move it to its own line if you prefer? Would you want a
comment as well?

Thanks,
Charles
