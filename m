Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEB0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C7B20866
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C7B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeKBIaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:30:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728014AbeKBIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:30:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1NNkto145297
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 19:25:21 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ng8vrn2cx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:25:21 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Nov 2018 23:25:20 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 23:25:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1NPInq63766534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 23:25:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A247B2066;
        Thu,  1 Nov 2018 23:25:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BE2AB205F;
        Thu,  1 Nov 2018 23:25:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 23:25:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9288016C34AA; Thu,  1 Nov 2018 16:25:18 -0700 (PDT)
Date:   Thu, 1 Nov 2018 16:25:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: rcu: make RCU_BOOST default on RT
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110123-0068-0000-0000-000003580E9C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009968; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111306; UDB=6.00575900; IPR=6.00891397;
 MB=3.00023997; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-01 23:25:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110123-0069-0000-0000-00004648651B
Message-Id: <20181101232518.GA12385@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=841 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Since it is no longer invoked from the softirq people run into OOM more
> often if the priority of the RCU thread is too low. Making boosting
> default on RT should help in those case and it can be switched off if
> someone knows better.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 644264be90f0..0be2c96fb640 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -36,7 +36,7 @@ config TINY_RCU
>  
>  config RCU_EXPERT
>  	bool "Make expert-level adjustments to RCU configuration"
> -	default n
> +	default y if PREEMPT_RT_FULL

Would it work to leave this as is, and ...

>  	help
>  	  This option needs to be enabled if you wish to make
>  	  expert-level adjustments to RCU configuration.  By default,
> @@ -191,7 +191,7 @@ config RCU_FAST_NO_HZ
>  config RCU_BOOST
>  	bool "Enable RCU priority boosting"
>  	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT

... make the above line instead be:

  	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT_FULL

Or am I missing something?

I agree that the risk might currently seem small, but if Linus ever
starts building PREEMPT_RT_FULL kernels, I really really do not want
RCU_EXPERT to be set.  ;-)

								Thanx, Paul

> -	default n
> +	default y if PREEMPT_RT_FULL
>  	help
>  	  This option boosts the priority of preempted RCU readers that
>  	  block the current preemptible RCU grace period for too long.

