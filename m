Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD32C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634F6218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfAXU7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:59:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbfAXU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:59:34 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OKtCj1067148
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 15:59:33 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q7hm12kh1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 15:59:33 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 24 Jan 2019 20:59:32 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Jan 2019 20:59:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0OKxS6G19136596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 20:59:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2AABB2068;
        Thu, 24 Jan 2019 20:59:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57741B205F;
        Thu, 24 Jan 2019 20:59:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.137.249])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 24 Jan 2019 20:59:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4E38916C64CE; Thu, 24 Jan 2019 12:59:27 -0800 (PST)
Date:   Thu, 24 Jan 2019 12:59:27 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] rcu: rcu_qs -- Use raise_softirq_irqoff to not
 save irqs twice
Reply-To: paulmck@linux.ibm.com
References: <20190124180740.GD2332@uranus.lan>
 <20190124181437.GE2332@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124181437.GE2332@uranus.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012420-0064-0000-0000-0000039C8DA1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010470; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01151245; UDB=6.00600017; IPR=6.00931585;
 MB=3.00025277; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-24 20:59:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012420-0065-0000-0000-00003C296C12
Message-Id: <20190124205927.GV4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=824 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 09:14:37PM +0300, Cyrill Gorcunov wrote:
> The rcu_qs is disabling IRQs by self so no need to do the same in raise_softirq
> but instead we can save some cycles using raise_softirq_irqoff directly.
> 
> CC: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>

Good eyes, good combo optimization of both space and time, thank you!!!

Queued, most likely for v5.2.

							Thanx, Paul

> ---
> The prev patch body has been screwed, sorry.
> 
>  kernel/rcu/tiny.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-next.git/kernel/rcu/tiny.c
> ===================================================================
> --- linux-next.git.orig/kernel/rcu/tiny.c
> +++ linux-next.git/kernel/rcu/tiny.c
> @@ -65,7 +65,7 @@ void rcu_qs(void)
>  	local_irq_save(flags);
>  	if (rcu_ctrlblk.donetail != rcu_ctrlblk.curtail) {
>  		rcu_ctrlblk.donetail = rcu_ctrlblk.curtail;
> -		raise_softirq(RCU_SOFTIRQ);
> +		raise_softirq_irqoff(RCU_SOFTIRQ);
>  	}
>  	local_irq_restore(flags);
>  }
> 

