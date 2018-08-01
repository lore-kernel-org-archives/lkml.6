Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D5AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C558F20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C558F20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbeHAQ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:28:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389571AbeHAQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:28:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71EdAWM003084
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 10:42:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kkdr3bedj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:42:46 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 1 Aug 2018 08:42:45 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 08:42:39 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w71Egc3T18743680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 07:42:39 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8E21BE05A;
        Wed,  1 Aug 2018 08:42:38 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C625BE051;
        Wed,  1 Aug 2018 08:42:38 -0600 (MDT)
Received: from localhost (unknown [9.80.99.86])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Aug 2018 08:42:37 -0600 (MDT)
Date:   Wed, 1 Aug 2018 11:42:35 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Joe Perches <joe@perches.com>
Cc:     Christophe LEROY <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org,
        "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/9] powerpc/traps: Print signal name for unhandled
 signals
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-6-muriloo@linux.ibm.com>
 <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
 <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afa25468e62ae3259878d8a95e9ac96f6be9f88a.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18080114-8235-0000-0000-00000DDC8704
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009467; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068846; UDB=6.00549526; IPR=6.00847160;
 MB=3.00022441; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-01 14:42:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080114-8236-0000-0000-000042193B9D
Message-Id: <20180801144235.GA6022@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 12:03:50AM -0700, Joe Perches wrote:
> On Wed, 2018-08-01 at 08:37 +0200, Christophe LEROY wrote:
> > Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> > > This adds a human-readable name in the unhandled signal message.
> > > Before this patch, a page fault looked like:
> > >    pandafault[6303]: unhandled signal 11 at 100007d0 nip 1000061c lr 7fff93c55100 code 2 in pandafault[10000000+10000]
> > > After this patch, a page fault looks like:
> > >    pandafault[6352]: segfault (11) at 13a2a09f8 nip 13a2a086c lr 7fffb63e5100 code 2 in pandafault[13a2a0000+10000]
> ]]
> > > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> []
> > > @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
> > >   #define TM_DEBUG(x...) do { } while(0)
> > >   #endif
> > >
> > > +static const char *signames[SIGRTMIN + 1] = {
> > > +	"UNKNOWN",
> > > +	"SIGHUP",			// 1
> > > +	"SIGINT",			// 2
> []
> > I don't think is is worth having that full table when we only use a few
> > of them. (As discussed in v1 https://patchwork.ozlabs.org/patch/948802/)
> >
> > I would suggest to instead use a function like this:
> >
> > static const char *signame(int signr)
> > {
> > 	if (signr == SIGBUS)
> > 		return "bus error";
> > 	if (signr == SIGFPE)
> > 		return "floating point exception";
> > 	if (signr == SIGILL)
> > 		return "illegal instruction";
> > 	if (signr == SIGILL)
> > 		return "segfault";
> > 	if (signr == SIGTRAP)
> > 		return "unhandled trap";
> > 	return "unknown signal";
> > }
>
> trivia:
>
> Unless the if tests are ordered most to least likely,
> perhaps it would be better to use a switch/case and
> let the compiler decide.
>
> 	switch (signr) {
> 	case SIGBUS:	return "bus error";
> 	case SIGFPE:	return "floating point exception";
> 	case SIGILL:	return "illegal instruction";
> 	case SIGSEGV:	return "segfault";
> 	case SIGTRAP:	return "unhandled trap";
> 	}
> 	return "unknown signal";
> }
>

Hi, Joe, Christophe.

That's a nice enhancement.  I'll do that in my next respin.

Cheers
Murilo

