Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF7BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D518920880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D518920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbeGWV70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:59:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388068AbeGWV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:59:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NKsLBJ096538
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 16:56:25 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdjfkujb3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 16:56:25 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Jul 2018 16:56:24 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 16:56:22 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NKuLhC7078368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 20:56:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C2F8B2064;
        Mon, 23 Jul 2018 16:56:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E4ABB205F;
        Mon, 23 Jul 2018 16:56:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jul 2018 16:56:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8455616CA2D3; Mon, 23 Jul 2018 13:56:25 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:56:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table
 throughout insertion.
Reply-To: paulmck@linux.vnet.ibm.com
References: <153086169828.24852.10332573315056854948.stgit@noble>
 <153086175009.24852.7782466383056542839.stgit@noble>
 <20180720075409.kfckhodsnvktift7@gondor.apana.org.au>
 <20180720144152.GW12945@linux.vnet.ibm.com>
 <87muulqq8q.fsf@notabene.neil.brown.name>
 <20180722215446.GH12945@linux.vnet.ibm.com>
 <87h8kqrhi0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8kqrhi0.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072320-0064-0000-0000-0000032E7901
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009419; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01065123; UDB=6.00547110; IPR=6.00842980;
 MB=3.00022285; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-23 20:56:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072320-0065-0000-0000-00003A0B1785
Message-Id: <20180723205625.GZ12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=619 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 09:13:43AM +1000, NeilBrown wrote:
> On Sun, Jul 22 2018, Paul E. McKenney wrote:
> >
> > One issue is that the ->func pointer can legitimately be NULL while on
> > RCU's callback lists.  This happens when someone invokes kfree_rcu()
> > with the rcu_head structure at the beginning of the enclosing structure.
> > I could add an offset to avoid this, or perhaps the kmalloc() folks
> > could be persuaded Rao Shoaib's patch moving kfree_rcu() handling to
> > the slab allocators, so that RCU only ever sees function pointers in
> > the ->func field.
> >
> > Either way, this should be hidden behind an API to allow adjustments
> > to be made if needed.  Maybe something like is_after_call_rcu()?
> > This would (for example) allow debug-object checks to be used to catch
> > check-after-free bugs.
> >
> > Would something of that sort work for you?
> 
> Yes, if you could provide an is_after_call_rcu() API, that would
> perfectly suit my use-case.

After beating my head against the object-debug code a bit, I have to ask
if it would be OK for you if the is_after_call_rcu() API also takes the
function that was passed to RCU.

							Thanx, Paul

