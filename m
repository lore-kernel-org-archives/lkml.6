Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819F4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33338269CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ikMPNtkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33338269CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934672AbeFZL2S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:28:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34480 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934276AbeFZL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:28:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QBO080040475;
        Tue, 26 Jun 2018 11:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=dy9THHLyv2DDW000Xhe0GuH1RZXO63QpIAr1lF7KC9M=;
 b=ikMPNtkKO5JKS6tVnP+3VbG+sgCa56N39cX0j30olkyG9qnbgJpB0xpJkJcmvWqPEHk4
 3qpcZXqOLAbD7vbrt+vaxg3j/URKm0htsnoESeVRdF7SXuyPkRyecG1NsicMKWGFe3pw
 eSO+/3EhO6AlBcFQ4OabsEMiDyD9aprrw4J7+TuFsUmqIBe+hJs2OgYM8B97t3JC1zyq
 dS2TBIHii2un/efJjbO/TXQ/i6y2Ca5LCF0hPS5ZmJHy6l8fYKiUMQ5IxDkpZYRlq2+E
 6g9lbOv2eBhXnvX9+FvhiVQIqtNWjwKU0e77pb/ESHkoy77xn9+t62fYPhQxkAt1mNO+ UA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jum57r30f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 11:27:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5QBRCQV027198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 11:27:12 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5QBRAHS024359;
        Tue, 26 Jun 2018 11:27:10 GMT
Received: from xakep.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 04:27:08 -0700
Date:   Tue, 26 Jun 2018 07:27:05 -0400
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Message-ID: <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com>
 <20180625085543.GT2494@hirez.programming.kicks-ass.net>
 <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain>
 <20180626090003.GA2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626090003.GA2458@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180622
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=676
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> How's something like this? That moves sched_clock_init() to right before
> we enable IRQs for the first time (which is after we've started the
> whole timekeeping business).
> 
> The thing is, sched_clock_init_late() reall is far too late, we need to
> switch to unstable before we bring up SMP.

OK, sure.

> -	sched_clock_postinit();
> +	sched_clock_init();

Yes, we can move sched_clock_init(). But placing it after time_init() would
work on all arches with unstable clock except for x86.

See comment above time_init x86:
arch/x86/kernel/time.c

 99/*
100 * Initialize TSC and delay the periodic timer init to
101 * late x86_late_time_init() so ioremap works.
102 */
103void __init time_init(void)
104{
105	late_time_init = x86_late_time_init;
106}

Only After this:
> >     late_time_init()
> >         x86_late_time_init()
> >             x86_init.timers.timer_init()
> > 	        hpet_time_init() Only after this call we finally start
> > 		getting clock interrupts, and can get precise output from
> > 		sched_clock_local().

We start getting timer interrupts. Is it acceptable to move
sched_clock_init() after late_time_init()?

Thank you,
Pavel
