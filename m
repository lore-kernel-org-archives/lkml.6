Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeCGOQ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:16:26 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43626 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754279AbeCGOPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:15:19 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Wed, 7 Mar 2018 14:15:09 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Lee Jones <lee.jones@linaro.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 1/2] mfd: arizona: Update reset pin to use GPIOD
Message-ID: <20180307141509.e3dpxteodxeoy2k3@localhost.localdomain>
References: <20180220163540.6704-1-ckeepax@opensource.cirrus.com>
 <20180307132812.r5epcs26clpnh72t@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180307132812.r5epcs26clpnh72t@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803070165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 01:28:12PM +0000, Lee Jones wrote:
> On Tue, 20 Feb 2018, Charles Keepax wrote:
> > +	if (IS_ERR(pdata->reset)) {
> > +		ret = PTR_ERR(pdata->reset);
> > +		switch (ret) {
> > +		case -ENOENT:
> > +		case -ENOSYS:
> > +			break;
> > +		case -EPROBE_DEFER:
> > +			return ret;
> > +		default:
> > +			dev_err(arizona->dev, "Reset GPIO malformed: %d\n",
> > +				ret);
> > +			break;
> > +		}
> 
> I haven't seen a switch statement used in the error handling path
> before.  There is probably good reason for that.
> 

There are a fair few of them "grep -rI "switch (ret)" | wc -l" ==
205. Although to be fair that has rarely been an argument in
somethings favour.

> What is the 'default' case?  -EINVAL?
> 

I would guess most of the time yes, but I would rather not assume
that. I can redo this as if's if you prefer it that way? The if is
slightly less lines although I do think the switch is much
clearer as to intent.

if (ret == -EPROBE_DEFER) {
	return ret;
} else if (ret != -ENOENT && ret != -ENOSYS {
	dev_err(arizona->dev, ....);
}

> > -	if (arizona->pdata.reset) {
> > +	if (!arizona->pdata.reset) {
> >  		/* Start out with /RESET low to put the chip into reset */
> > -		ret = devm_gpio_request_one(arizona->dev, arizona->pdata.reset,
> > -					    GPIOF_DIR_OUT | GPIOF_INIT_LOW,
> > -					    "arizona /RESET");
> > -		if (ret != 0) {
> > -			dev_err(dev, "Failed to request /RESET: %d\n", ret);
> > -			goto err_dcvdd;
> > +		arizona->pdata.reset = devm_gpiod_get(arizona->dev, "reset",
> > +						      GPIOD_OUT_LOW);
> > +		if (IS_ERR(arizona->pdata.reset)) {
> > +			ret = PTR_ERR(arizona->pdata.reset);
> > +			if (ret == -EPROBE_DEFER)
> > +				goto err_dcvdd;
> > +			else
> > +				dev_err(arizona->dev,
> > +					"Reset GPIO missing/malformed: %d\n",
> > +					ret);
> 
> You don't need the else.

Happy to drop.

> > --- a/include/linux/mfd/arizona/pdata.h
> > +++ b/include/linux/mfd/arizona/pdata.h
> > @@ -56,6 +56,7 @@
> >  #define ARIZONA_MAX_PDM_SPK 2
> >  
> >  struct regulator_init_data;
> > +struct gpio_desc;
> >  
> >  struct arizona_micbias {
> >  	int mV;                    /** Regulated voltage */
> > @@ -77,7 +78,7 @@ struct arizona_micd_range {
> >  };
> >  
> >  struct arizona_pdata {
> > -	int reset;      /** GPIO controlling /RESET, if any */
> > +	struct gpio_desc *reset;      /** GPIO controlling /RESET, if any */
> >  
> >  	/** Regulator configuration for MICVDD */
> >  	struct arizona_micsupp_pdata micvdd;
> 
> I know it doesn't have much to do with this patch, but it's probably
> better to use a Kerneldoc header for this struct.
> 

Indeed I would agree that would be better, not sure what the
commenting style there is about. I should be able to find time to
make a patch for this soon, but seems unrelated to this series.

Thanks,
Charles
