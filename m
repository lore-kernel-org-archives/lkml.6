Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15841206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15841206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeG0EiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:38:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbeG0EiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:38:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6R3FaD7146818
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 23:18:20 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kfrgpp5pp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 23:18:20 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 23:18:18 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 23:18:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6R3IFZ67012788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 03:18:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B43EB2068;
        Thu, 26 Jul 2018 23:17:55 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B7A0B2066;
        Thu, 26 Jul 2018 23:17:55 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.139.164])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 23:17:55 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8DF7316CA220; Thu, 26 Jul 2018 20:18:15 -0700 (PDT)
Date:   Thu, 26 Jul 2018 20:18:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table
 throughout insertion.
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180720144152.GW12945@linux.vnet.ibm.com>
 <87muulqq8q.fsf@notabene.neil.brown.name>
 <20180722215446.GH12945@linux.vnet.ibm.com>
 <87h8kqrhi0.fsf@notabene.neil.brown.name>
 <20180723205625.GZ12945@linux.vnet.ibm.com>
 <87r2jtpqm4.fsf@notabene.neil.brown.name>
 <20180724225825.GE12945@linux.vnet.ibm.com>
 <87in53oqzz.fsf@notabene.neil.brown.name>
 <20180725152250.GN12945@linux.vnet.ibm.com>
 <87r2jpmqu2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2jpmqu2.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072703-0060-0000-0000-00000292DC85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009435; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066677; UDB=6.00548046; IPR=6.00844540;
 MB=3.00022344; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 03:18:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072703-0061-0000-0000-000045F1BCFD
Message-Id: <20180727031815.GW24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:04:37AM +1000, NeilBrown wrote:
> On Wed, Jul 25 2018, Paul E. McKenney wrote:
> >> 
> >> Looks good ... except ... naming is hard.
> >> 
> >>  is_after_call_rcu_init()  asserts where in the lifecycle we are,
> >>  is_after_call_rcu() tests where in the lifecycle we are.
> >> 
> >>  The names are similar but the purpose is quite different.
> >>  Maybe s/is_after_call_rcu_init/call_rcu_init/ ??
> >
> > How about rcu_head_init() and rcu_head_after_call_rcu()?

Very well, I will pull this change in on my next rebase.

							Thanx, Paul

