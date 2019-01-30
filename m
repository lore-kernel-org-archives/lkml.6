Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6111FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B6D20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfA3AZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:25:15 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:56894 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727148AbfA3AZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:25:14 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0U0OH9i025702;
        Wed, 30 Jan 2019 00:24:22 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qb17mr195-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jan 2019 00:24:22 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 957DEEE;
        Wed, 30 Jan 2019 00:24:07 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id AD1F637;
        Wed, 30 Jan 2019 00:24:04 +0000 (UTC)
Date:   Tue, 29 Jan 2019 17:24:04 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v2 08/10] rtc: bd70528: Initial support for ROHM
 bd70528 RTC
Message-ID: <20190130002404.GA19729@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <20190125110536.GA29321@localhost.localdomain>
 <35bbc5b9-5f8c-ec80-3eaa-bb2c0e2812c9@roeck-us.net>
 <20190128202656.GA17466@anatevka>
 <20190129070103.GA2551@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129070103.GA2551@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=986 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 09:01:03AM +0200, Matti Vaittinen wrote:
> On Mon, Jan 28, 2019 at 01:26:56PM -0700, Jerry Hoemann wrote:
> > On Sat, Jan 26, 2019 at 08:30:24AM -0800, Guenter Roeck wrote:
> > > On 1/25/19 3:05 AM, Matti Vaittinen wrote:
> > > > +static int bd70528_set_wake(struct bd70528 *bd70528,
> > > > +			    int enable, int *old_state)
> > > > +{
> > > > +	int ret;
> > > > +	unsigned int ctrl_reg;
> > > > +
> > > > +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WAKE_EN, &ctrl_reg);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (old_state) {
> > > > +		if (ctrl_reg & BD70528_MASK_WAKE_EN)
> > > > +			*old_state |= BD70528_WAKE_STATE_BIT;
> > > > +		else
> > > > +			*old_state &= ~BD70528_WAKE_STATE_BIT;
> > > > +
> > > > +		if ((!enable) == (!(*old_state & BD70528_WAKE_STATE_BIT)))
> > > > +			return 0;
> > > 
> > > I think
> > > 		if (enable == !!(*old_state & BD70528_WAKE_STATE_BIT))
> > > would be much better readable. Even if not, there are way too many ()
> > > in the above conditional.
> > > 
> > 
> > The substitution is not equivalent to original.  I think you mean:
> > 
> >  		if (!!enable == !!(*old_state & BD70528_WAKE_STATE_BIT))
> 
> Thanks Jerry! Good catch! I originally wanted that all non-zero values
> of 'enable' would be 'true'. So maybe I just use the original approach
> but get rid of extra parenthesis which were pointed out by Guenter.
> 
> 		if (!enable == !(*old_state & BD70528_WAKE_STATE_BIT))
> should do it just fine, right?
> 

The use of "!!" to turn an int into one of two Boolean values (0 | 1)
is used extensively in Linux and as such might make the intent of
the code a bit clearer which I take as checking to see the states
match.

But, I will defer to you and Guenter on the question.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
