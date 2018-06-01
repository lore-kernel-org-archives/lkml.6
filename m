Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbeFAE7m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:59:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750760AbeFAE7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:59:41 -0400
Date: Fri, 1 Jun 2018 10:24:33 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
Reply-To: ego@linux.vnet.ibm.com
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18060104-0008-0000-0000-0000030FCFBF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009106; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040623; UDB=6.00532705; IPR=6.00819753;
 MB=3.00021404; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-01 04:54:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060104-0009-0000-0000-0000396D9FF3
Message-Id: <20180601045433.GA17425@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806010054
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

Thanks for reviewing the patch!

On Fri, Jun 01, 2018 at 12:51:05AM +1000, Balbir Singh wrote:
> On Thu, May 31, 2018 at 10:15 PM, Gautham R. Shenoy

[..snip..]
> >
> > +static u64 get_snooze_timeout(struct cpuidle_device *dev,
> > +                             struct cpuidle_driver *drv,
> > +                             int index)
> > +{
> > +       int i;
> > +
> > +       if (unlikely(!snooze_timeout_en))
> > +               return default_snooze_timeout;
> > +
> > +       for (i = index + 1; i < drv->state_count; i++) {
> > +               struct cpuidle_state *s = &drv->states[i];
> > +               struct cpuidle_state_usage *su = &dev->states_usage[i];
> > +
> > +               if (s->disabled || su->disable)
> > +                       continue;
> > +
> > +               return s->target_residency * tb_ticks_per_usec;
> 
> Can we ensure this is not prone to overflow?

s->target_residency is an "unsigned int" so can take a maximum value
of UINT_MAX. tb_ticks_per_usec is an "unsigned long" with a value in
the range of 100-1000. The return value is a u64. The product of
s->target_residency and tb_ticks_per_usec should be contained in u64.

Is there a potential case of overflow that I am missing ?

> 
> Otherwise looks good
> 
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

--
Thanks and Regards
gautham.
