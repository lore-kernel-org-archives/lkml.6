Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45976C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006ED2482D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JIg3z1Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006ED2482D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeGBRVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:21:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58902 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeGBRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:21:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62HIjmA179000;
        Mon, 2 Jul 2018 17:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=evj2uILatZHYgkzTQDgkvu0nsj44KB/qQWY04GT3xew=;
 b=JIg3z1LmlJ3Jw6uVlZ07Ag7WKiLdzyshhICm8LdvNPsnPxUpGBbXpFtU9bVjWqnHvAQH
 4c9TMtryQEBph1HeEH2kBn6p3G//PZwGy39HCSyPlbOfaxE0Tb33/Ye9vOPiMD0jJchI
 GOXXCdPmjCElRZmK9tv0BK5VrYGSRawPDicZXAyNfYrdV/EjQ7jYSSwKHf4mg0V5Hfrl
 FmIoDAm43AADIJLbil6ly0opksAG9/mtSTUk0imUdVPWxg5I1hzmQ0Fb8GeLnGx8kwI6
 fT4+Gp4tCJmlc7D7Cs7EGQ8sg2tmoKZ6WiCRjNxbUC1Jku0M1MVRiUZJbYDJZ7Zo1NU2 Zw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jx1tnwcdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Jul 2018 17:18:44 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w62HIhN7002112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jul 2018 17:18:43 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w62HIcJx008395;
        Mon, 2 Jul 2018 17:18:38 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 10:18:38 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 64D336A00C2; Mon,  2 Jul 2018 13:18:36 -0400 (EDT)
Date:   Mon, 2 Jul 2018 13:18:36 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>, jgross@suse.com
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        boris.ostrovsky@oracle.com, pbonzini@redhat.com,
        xen-devel@lists.xensource.com
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
Message-ID: <20180702171836.GD22876@char.us.oracle.com>
References: <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
 <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
 <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
 <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com>
 <alpine.DEB.2.21.1806290925340.1578@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806290925340.1578@nanos.tec.linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 09:30:10AM +0200, Thomas Gleixner wrote:
> On Thu, 28 Jun 2018, Pavel Tatashin wrote:
> > On Thu, Jun 28, 2018 at 11:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Hi Thomas,
> > 
> > In addition to above, we have xen hvm:
> > 
> > setup_arch()
> >     ...
> >     init_hypervisor_platform();
> >         x86_init.hyper.init_platform();
> >             xen_hvm_guest_init()
> >                 xen_hvm_init_time_ops();
> 
> Duh. Missed that completely.
> 
> >     ...
> >     tsc_early_delay_calibrate();
> >         tsc_khz = x86_platform.calibrate_tsc(); == xen_tsc_khz()
> >     ...
> > 
> > Which works early.
> > 
> > So, what should we do with xen, which seems to be the only platform
> > that would provide different tsc frequency early and late, because of
> > different calibration method?
> 
> Fix it? I have no idea why XEN has two variants of the scheme and I neither
> have a clue why the KVM clock stuff is late.

Added Juergen (Xen).
> 
> Thanks,
> 
> 	tglx
> 
