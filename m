Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C751C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92712147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfBTQkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:40:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbfBTQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:40:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KGUrVU102486
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 11:40:38 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qsaf70fjm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 11:40:38 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Feb 2019 16:40:37 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Feb 2019 16:40:35 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1KGeYTu22413514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 16:40:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67C3DB2064;
        Wed, 20 Feb 2019 16:40:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35D02B2075;
        Wed, 20 Feb 2019 16:40:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.62])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Feb 2019 16:40:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 17AE316C3B20; Wed, 20 Feb 2019 08:40:34 -0800 (PST)
Date:   Wed, 20 Feb 2019 08:40:34 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [RFC 1/5] net: rtnetlink: Fix incorrect RCU API usage
Reply-To: paulmck@linux.ibm.com
References: <20190220040827.136184-1-joel@joelfernandes.org>
 <20190220040827.136184-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220040827.136184-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19022016-0068-0000-0000-00000396CCD5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010632; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163853; UDB=6.00607726; IPR=6.00944437;
 MB=3.00025669; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-20 16:40:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022016-0069-0000-0000-000047924703
Message-Id: <20190220164034.GM11787@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:08:23PM -0500, Joel Fernandes (Google) wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
> 
> rtnl_register_internal() and rtnl_unregister_all tries to directly
> dereference an RCU protected pointed outside RCU read side section.
> While this is Ok to do since a lock is held, let us use the correct
> API to avoid programmer bugs in the future.
> 
> This also fixes sparse warnings arising from not using RCU API.
> 
> net/core/rtnetlink.c:332:13: warning: incorrect type in assignment
> (different address spaces) net/core/rtnetlink.c:332:13:    expected
> struct rtnl_link **tab net/core/rtnetlink.c:332:13:    got struct
> rtnl_link *[noderef] <asn:4>*<noident>
> 
> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>

First, thank you for doing this!

I was going to complain that these were update-side accesses, but it
looks like rtnl_dereference() already handles both readers and updaters.

So looks good to me, but the maintainers of course have the final word.

							Thanx, Paul

> ---
>  net/core/rtnetlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 5ea1bed08ede..98be4b4818a9 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -188,7 +188,7 @@ static int rtnl_register_internal(struct module *owner,
>  	msgindex = rtm_msgindex(msgtype);
>  
>  	rtnl_lock();
> -	tab = rtnl_msg_handlers[protocol];
> +	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
>  	if (tab == NULL) {
>  		tab = kcalloc(RTM_NR_MSGTYPES, sizeof(void *), GFP_KERNEL);
>  		if (!tab)
> @@ -329,7 +329,7 @@ void rtnl_unregister_all(int protocol)
>  	BUG_ON(protocol < 0 || protocol > RTNL_FAMILY_MAX);
>  
>  	rtnl_lock();
> -	tab = rtnl_msg_handlers[protocol];
> +	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
>  	if (!tab) {
>  		rtnl_unlock();
>  		return;
> -- 
> 2.21.0.rc0.258.g878e2cd30e-goog
> 

