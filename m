Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C787C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC031208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC031208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389653AbeHAQai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:30:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389450AbeHAQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:30:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71EhkkB066828
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 10:44:33 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kkdhgkq8q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:44:33 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 1 Aug 2018 10:44:32 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 10:44:29 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w71EiS7O10158580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 14:44:28 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F141AE062;
        Wed,  1 Aug 2018 10:43:34 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70331AE05F;
        Wed,  1 Aug 2018 10:43:33 -0400 (EDT)
Received: from localhost (unknown [9.80.99.86])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Aug 2018 10:43:33 -0400 (EDT)
Date:   Wed, 1 Aug 2018 11:44:25 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Joe Perches <joe@perches.com>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v3 5/9] powerpc/traps: Print signal name for unhandled
 signals
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-6-muriloo@linux.ibm.com>
 <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
 <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
 <20180801074903.GG16221@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180801074903.GG16221@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18080114-0052-0000-0000-000003167B18
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009467; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068847; UDB=6.00549526; IPR=6.00847160;
 MB=3.00022441; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-01 14:44:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080114-0053-0000-0000-00005D90F2C8
Message-Id: <20180801144425.GB6022@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Segher.

On Wed, Aug 01, 2018 at 02:49:03AM -0500, Segher Boessenkool wrote:
> On Wed, Aug 01, 2018 at 12:03:50AM -0700, Joe Perches wrote:
> > On Wed, 2018-08-01 at 08:37 +0200, Christophe LEROY wrote:
> > > Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> > > I would suggest to instead use a function like this:
> > >
> > > static const char *signame(int signr)
> > > {
> > > 	if (signr == SIGBUS)
> > > 		return "bus error";
> > > 	if (signr == SIGFPE)
> > > 		return "floating point exception";
> > > 	if (signr == SIGILL)
> > > 		return "illegal instruction";
> > > 	if (signr == SIGILL)
> > > 		return "segfault";
> > > 	if (signr == SIGTRAP)
> > > 		return "unhandled trap";
> > > 	return "unknown signal";
> > > }
> >
> > trivia:
> >
> > Unless the if tests are ordered most to least likely,
> > perhaps it would be better to use a switch/case and
> > let the compiler decide.
>
> That would also show there are two entries for SIGILL (here and in the
> original patch), one of them very wrong.

Good catch.  I'll take care of that in my next respin.

> Check the table with psignal or something?

Nice suggestion.  Thanks!

Cheers
Murilo

