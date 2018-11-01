Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870DAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDAF20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDAF20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeKBIHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:07:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbeKBIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:07:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA1MxH4C157733
        for <linux-kernel@vger.kernel.org>; Thu, 1 Nov 2018 19:02:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ng6vss9cf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:02:39 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Nov 2018 23:02:39 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Nov 2018 23:02:36 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA1N2ZAK29163762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 23:02:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13C8EB2067;
        Thu,  1 Nov 2018 23:02:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7313B2064;
        Thu,  1 Nov 2018 23:02:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 23:02:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 72E5016C359F; Thu,  1 Nov 2018 16:02:35 -0700 (PDT)
Date:   Thu, 1 Nov 2018 16:02:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     lcapitulino@redhat.com, julia@ni.com, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: rcu: enable rcu_normal_after_boot by default for RT
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110123-0040-0000-0000-0000048B0641
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009968; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111298; UDB=6.00575895; IPR=6.00891389;
 MB=3.00023997; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-01 23:02:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110123-0041-0000-0000-000008940724
Message-Id: <20181101230235.GA8757@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811010191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The forcing of an expedited grace period is an expensive and very
> RT-application unfriendly operation, as it forcibly preempts all running
> tasks on CPUs which are preventing the gp from expiring.
> 
> By default, as a policy decision, disable the expediting of grace
> periods (after boot) on configurations which enable PREEMPT_RT_FULL.
> 
> Suggested-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Julia Cartwright <julia@ni.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In case it matters:

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

Alternatively, any reason that I should not pull this into -rcu?

							Thanx, Paul

> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index f56c0fbdf22e..12027723abaf 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -67,7 +67,7 @@ extern int rcu_expedited; /* from sysctl */
>  module_param(rcu_expedited, int, 0);
>  extern int rcu_normal; /* from sysctl */
>  module_param(rcu_normal, int, 0);
> -static int rcu_normal_after_boot;
> +static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
>  module_param(rcu_normal_after_boot, int, 0);
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  

