Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6156AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A94D20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A94D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeIER36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:29:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbeIER36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:29:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85CxCbm102206
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 08:59:47 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2macxkfyrr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 08:59:46 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 08:59:45 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 08:59:42 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85Cxfkc36700268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 12:59:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE9CCB2068;
        Wed,  5 Sep 2018 08:58:28 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE584B2065;
        Wed,  5 Sep 2018 08:58:28 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.199.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 08:58:28 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4A98516C29AE; Wed,  5 Sep 2018 05:59:41 -0700 (PDT)
Date:   Wed, 5 Sep 2018 05:59:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86-ml <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, joel@joelfernandes.org
Subject: Re: 4.19-rc1: ./include/linux/rcupdate.h:631 rcu_read_lock() used
 illegally while idle!
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180901173559.GC26871@zn.tnic>
 <20180901175442.GO4225@linux.vnet.ibm.com>
 <20180901184531.72ffb792@vmware.local.home>
 <20180902041639.GQ4225@linux.vnet.ibm.com>
 <20180904162611.6a120068@gandalf.local.home>
 <20180904205321.GQ4225@linux.vnet.ibm.com>
 <20180905082254.GA2237@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905082254.GA2237@zn.tnic>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18090512-0068-0000-0000-00000335142B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01083893; UDB=6.00559395; IPR=6.00863893;
 MB=3.00023125; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-05 12:59:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090512-0069-0000-0000-000045A1395D
Message-Id: <20180905125941.GE4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:22:54AM +0200, Borislav Petkov wrote:
> On Tue, Sep 04, 2018 at 01:53:21PM -0700, Paul E. McKenney wrote:
> > I must defer to Borislav on this one.  Assuming it has the desired
> > effect, I am good with it.
> 
> It did survive a bunch of reboots (the WARN would fire after boot
> finishes, normally) so I guess we can run with it and see how it works
> out in the next couple of weeks.
> 
> Thanks guys!

Woo-hoo!!!  Thank you for testing this!

							Thanx, Paul

