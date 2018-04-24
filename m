Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756266AbeDXGPH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:15:07 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48145 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756013AbeDXGPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:15:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180424061501epoutp0285dee8aaeabb98a824fdbe8ca27d9612~oSpqWJvLK1978719787epoutp02B
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/3] PM / devfreq: Actually support providing
 freq_table
Reply-To: myungjoo.ham@samsung.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180424052916.GD2052@tuxbook-pro>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <529236451.01524550500717.JavaMail.epsvc@epcpmgr01>
Date: Tue, 24 Apr 2018 15:09:14 +0900
X-CMS-MailID: 20180424060914epcms1p5de3ed78a6b2300bf143e214ad8e2d2c0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
X-MTR: 20180424060914epcms1p5de3ed78a6b2300bf143e214ad8e2d2c0
X-Hop-Count: 3
X-CMS-RootMailID: 20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b
X-RootMTR: 20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b
References: <20180424052916.GD2052@tuxbook-pro>
        <20180424002016.9205-1-bjorn.andersson@linaro.org>
        <20180424002016.9205-2-bjorn.andersson@linaro.org>
        <5ADE9AE6.9090601@samsung.com>
        <CGME20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon 23 Apr 19:48 PDT 2018, Chanwoo Choi wrote:
>
>> Hi,
>> 
>> On 2018??? 04??? 24??? 09:20, Bjorn Andersson wrote:
>> > The code in devfreq_add_device() handles the case where a freq_table is
>> > passed by the client, but then requests min and max frequences from
>> > the, in this case absent, opp tables.
>> > 
>> > Read the min and max frequencies from the frequency table, which has
>> > been built from the opp table if one exists, instead of querying the
>> > opp table.
>> > 
>> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> > ---
>> > 
>> > An alternative approach is to clarify in the devfreq code that it's not
>> > possible to pass a freq_table and then in patch 3 create an opp table for the
>> > device in runtime; although the error handling of this becomes non-trivial.
>> > 
>> > Transitioning the UFSHCD to use opp tables directly is hindered by the fact
>> > that the Qualcomm UFS hardware has two different clocks that needs to be
>> > running at different rates, so we would need a way to describe the two rates in
>> > the opp table. (And would force us to change the DT binding)
>> > 
>> >  drivers/devfreq/devfreq.c | 22 ++++------------------
>> >  1 file changed, 4 insertions(+), 18 deletions(-)
>> > 
>> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> > index fe2af6aa88fc..086ced50a13d 100644
>> > --- a/drivers/devfreq/devfreq.c
>> > +++ b/drivers/devfreq/devfreq.c
>> > @@ -74,30 +74,16 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>> >  
>> >  static unsigned long find_available_min_freq(struct devfreq *devfreq)
>> >  {
>> > -	struct dev_pm_opp *opp;
>> > -	unsigned long min_freq = 0;
>> > -
>> > -	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
>> > -	if (IS_ERR(opp))
>> > -		min_freq = 0;
>> > -	else
>> > -		dev_pm_opp_put(opp);
>> > +	struct devfreq_dev_profile *profile = devfreq->profile;
>> >  
>> > -	return min_freq;
>> > +	return profile->freq_table[0];
>> 
>> It is wrong. The thermal framework support the devfreq-cooling device
>> which uses the dev_pm_opp_enable/disable().
>> 
>
>Okay, that makes sense. So rather than registering a custom freq_table I
>should register the min and max frequency using dev_pm_opp_add().
>
>> In order to find the correct available min frequency,
>> the devfreq have to use the OPP function instead of using the first entry
>> of the freq_table array.
>> 
>
>Based on this there seems to be room for cleaning out the freq_table
>from devfreq, to reduce the confusion. I will review this further.

Could you please check if the bug suffering you gets resolved by
replacing 0 with ULONG_MAX in the function find_available_max_freq?

-                max_freq = 0;
+                max_freq = ULONG_MAX;

Even if you are not using OPP, these functions should provide somewhat
"compatible" values.

Cheers,
MyungJoo


>
>Thanks,
>Bjorn
>
