Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeFDK1Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:27:25 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60446 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750868AbeFDK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:27:24 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 4 Jun 2018 11:27:19 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>, <patches@opensource.cirrus.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: arizona: Don't use regmap_read_poll_timeout
Message-ID: <20180604102719.GA18740@imbe.wolfsonmicro.main>
References: <20180511135030.14590-1-ckeepax@opensource.cirrus.com>
 <20180604054452.GD17993@dell>
 <CAHp75Vdcg2GQ4G-YF054iCob+f4=ZmfT_XLknMZm72nOB7D_mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vdcg2GQ4G-YF054iCob+f4=ZmfT_XLknMZm72nOB7D_mw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=878 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806040128
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 12:40:37PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 4, 2018 at 8:44 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Fri, 11 May 2018, Charles Keepax wrote:
> 
> >> +     while (true) {
> >> +             ret = regmap_read(arizona->regmap, reg, &val);
> >>
> >> +             if ((val & mask) == target)
> >> +                     return 0;
> >> +
> >> +             if (ktime_compare(ktime_get(), timeout) > 0)
> >> +                     break;
> >> +
> >> +             usleep_range(ARIZONA_REG_POLL_DELAY_US / 2,
> >> +                          ARIZONA_REG_POLL_DELAY_US);
> >> +     }
> 
> >From my point of view infinite loops not good for readability and maintenance.
> Perhaps
> 
> do {
> ...
> } while (ktime_compare(...));
> 
> ?

I would rather not do it that way since then it becomes
impossible to have a single poll with no delays happening. I can
refactor to remove the while(true) but it will make the code a
bit bigger, as I will probably need to duplicate some code
outside the loop.

Thanks,
Charles
