Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeCGO4L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:56:11 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46506 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754463AbeCGO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:56:07 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Wed, 7 Mar 2018 14:55:59 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 1/2] mfd: arizona: Update reset pin to use GPIOD
Message-ID: <20180307145559.y4tyyzd2pbqrk4yb@localhost.localdomain>
References: <20180220163540.6704-1-ckeepax@opensource.cirrus.com>
 <CAOMZO5BNYkuz6pH2qZmj+4kBPQB=j-JniiqVbqzdH8nTOXVZQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BNYkuz6pH2qZmj+4kBPQB=j-JniiqVbqzdH8nTOXVZQQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=969 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803070173
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 11:24:10AM -0300, Fabio Estevam wrote:
> >  static inline void arizona_enable_reset(struct arizona *arizona)
> >  {
> >         if (arizona->pdata.reset)
> > -               gpio_set_value_cansleep(arizona->pdata.reset, 0);
> > +               gpiod_set_value_cansleep(arizona->pdata.reset, 0);
> 
> This should be:
> 
> gpiod_set_value_cansleep(arizona->pdata.reset, 1);
> 
> as here you want to put the reset GPIO into its active state.
> 
> Assuming that in the dts this GPIO is defined as GPIO_ACTIVE_LOW, then
> the command should put it to logic level 0 as done originally.
> 
> >  static void arizona_disable_reset(struct arizona *arizona)
> > @@ -295,7 +295,7 @@ static void arizona_disable_reset(struct arizona *arizona)
> >                         break;
> >                 }
> >
> > -               gpio_set_value_cansleep(arizona->pdata.reset, 1);
> > +               gpiod_set_value_cansleep(arizona->pdata.reset, 1);
> 
> This should be:
> 
> gpiod_set_value_cansleep(arizona->pdata.reset, 0);
> 
> as here you want to put the reset GPIO into its inactive state.

Hmm... this raises a rather good point that I hadn't considered.
This driver is used in a lot of shipping devices and the old
style GPIO calls didn't take the activeness of the GPIO into
account just blindly setting the value you asked for. However the
new style calls do take this into account.

The trouble is I guess we don't know whether most users bothered
to set GPIO_ACTIVE_LOW or not. So it is very hard to say here if
we are about to breaking a lot of existing device trees here.

I guess probably the safest approach is to use
gpiod_set_raw_value_cansleep here?

Thanks,
Charles
