Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62343C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D43A20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfAPDrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:47:45 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:59564 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728627AbfAPDrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:47:45 -0500
X-Greylist: delayed 5080 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 22:47:44 EST
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0G2BwCR029079;
        Wed, 16 Jan 2019 02:22:44 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2q1qkb9ghf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jan 2019 02:22:44 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id CA30D85;
        Wed, 16 Jan 2019 02:22:43 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 2679A3A;
        Wed, 16 Jan 2019 02:22:43 +0000 (UTC)
Date:   Tue, 15 Jan 2019 19:22:42 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 0/4] watchdog: hpwdt: Fix NMI-related behaviour when
 CONFIG_HPWDT_NMI_DECODING is enabled
Message-ID: <20190116022242.GC18342@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114023617.10656-1-mironov.ivan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:36:13AM +0500, Ivan Mironov wrote:
> Hi,
> 
> I found out that hpwdt alters NMI behaviour unexpectedly if compiled
> with enabled CONFIG_HPWDT_NMI_DECODING:
> 
>  * System starts to panic on any NMI with misleading message.

hpwdt doesn't start to panic on any NMI.  It starts to panic on:

1) NMI_SERR		associated with NMI
2) NMI_IO_CHECK		associated with IO errors
3) NMI_UNKNOWN		NMI unclaimed by all local handlers.

On Gen10 going forward we plan to restrict to just iLO
generated NMIs.

There is a long history on hp/hpe proliant systems where hpwdt
was handler of general IO errors (at least ones that would cause
NMI to be generated) and we chose to panic in these situation
as the errors were generally quite serious.

Yes, this has caused some problems in the past as Linux has
overloaded NMI and some subsystems didn't claim the NMIs that
they generated (think profiling.)  But, I haven't seen these
types of problems for several years now.

The more modern platforms have more robust error handling built
into them and to linux so going forward we'll restrict hpwdt to a more
traditional WDT role.  But we're retaining the more conservative
approach for legacy platforms.

How would you suggest that the message be enhanced?


>  * Watchdog provided by hpwdt is not working after such panic.
> 
> Here are the patches that should fix this.
> 
> This is an RFC patch series because I am not sure that patches are
> correct. Questions:
> 
>  * Are "mynmi" flags always set on all supported iLO versions when iLO
>    is the source of NMI?


Unfortunately no.

hpwdt is a dual purpose driver.  It handles the iLO watchdog timer
and the "Generate NMI to System" button.  These are closely related
hardware wise.

However, some platforms generate NMI for "Generate NMI to System" button but aren't
signaled via iLO registers.  These will show up as NMI_UNKNOWN, hence while
hpwdt still claims these.

There are also some systems that do not set the nmistat bits correctly.

So as to not break legacy platforms, the use the nmistat bits for
control will be for Gen10 going forward.



>  * Is it safe to reset "mynmi" flags to zero if code decides to not panic?

The reading of the registers is itself destructive (sets to zero) but the real
issue is that some proliant systems lack the ability to acknowledge the NMI so
only one can ever be received.  So returning is not advisable as no
further NMI will be generated via this path.  A reset through firmware
is required to restore the feature.


> 
> Ivan Mironov (4):
>   watchdog: hpwdt: Don't disable watchdog on NMI
>   watchdog: hpwdt: Don't panic on foreign NMI
>   watchdog: hpwdt: Add more information into message
>   watchdog: hpwdt: Make panic behaviour configurable
> 
>  drivers/watchdog/hpwdt.c | 45 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> -- 
> 2.20.1

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
