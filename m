Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C7A26107
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C7A26107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965144AbeFYUpL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:45:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934686AbeFYUpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:45:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PKZZoG033507
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:45:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju7jm0a0y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:45:08 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 16:45:08 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 16:45:04 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PKj3VA59900068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 20:45:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12A22B206B;
        Mon, 25 Jun 2018 16:44:58 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2086B205F;
        Mon, 25 Jun 2018 16:44:57 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 16:44:57 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 10F2316CA093; Mon, 25 Jun 2018 13:47:08 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:47:08 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Reply-To: paulmck@linux.vnet.ibm.com
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home>
 <20180622200548.GA114655@joelaf.mtv.corp.google.com>
 <20180625082824.GB21377@X58A-UD3R>
 <20180625163951.GA52646@joelaf.mtv.corp.google.com>
 <20180625162557.7140664c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625162557.7140664c@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062520-0040-0000-0000-000004450465
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009254; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052261; UDB=6.00539424; IPR=6.00830186;
 MB=3.00021853; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 20:45:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062520-0041-0000-0000-0000084B19FA
Message-Id: <20180625204708.GS3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=749 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:25:57PM -0400, Steven Rostedt wrote:
> On Mon, 25 Jun 2018 09:39:51 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > For whatever its worth, I made some notes of what I understood from reading
> > the code and old posts because I was sure I would otherwise forget
> > everything:
> > http://www.joelfernandes.org/linuxinternals/2018/06/15/rcu-dynticks.html
> 
> Nice write up. I may point some people to this ;-)
> 
> Anyway "complications due to nested NMIs (yes NMIs can nest!)"
> 
> What arch allows for NMIs to nest. Because we don't let that happen on
> x86, and there's code that I know of that is called by NMIs that is not
> re-entrant, and can crash if we allow for NMIs to nest. For example
> "in_nmi()" will not show that we are in_nmi() if we allow for nesting
> of NMIs. It has a single bit that gets incremented when we enter NMI
> code, and cleared when we leave it.

Last I checked with Andy Lutomirski, there are a number of things that,
though not NMIs, act like NMIs and that can interrupt each others'
handlers.  This is on x86.

							Thanx, Paul

