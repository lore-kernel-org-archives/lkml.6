Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99019C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B2A27B2A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hiVJV//k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B2A27B2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935376AbeF2JAc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:00:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38356 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932894AbeF2JAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:00:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5T8rVHf089858;
        Fri, 29 Jun 2018 08:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=csuUhpURCuP43mF5GT7WwC/kQ9wb3Mw17ZG0z/BvsbQ=;
 b=hiVJV//k4oO4xObWerNJRugPoyHUlze+UN8eSV/wC7SoAq5PuaMZ6QHO8C4DqI3bkw8r
 TgAThnR5X+Br3uRKc5FoIITqNJ4VHl91HwFuSmHZh6mPs4E0oPjbmG+cks6QWOgqOff3
 e1fi0PG3QoYm3e5lcfwx7MlS//Sbm68bctpwA3V0qtfp/NPISAs4oNzVhdluf45HmIxq
 fxwkPPa/Al/7teSYbJk3cmzrWR1bT3Cdni6wcikr4fJ6ZETTfrtsirDggI3D+CKb8orJ
 fyci4xwaNQMo6BfSHGBlz0Rzwmzue4fz9pok+Sn+ahpufngfCMj4uJ6kdIwDrPKuH2R3 PA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jukhsnna1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 08:58:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5T8w0De019504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 08:58:00 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5T8vuWY012289;
        Fri, 29 Jun 2018 08:57:57 GMT
Received: from xakep.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 01:57:56 -0700
Date:   Fri, 29 Jun 2018 04:57:52 -0400
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
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
        boris.ostrovsky@oracle.com, pbonzini@redhat.com
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
Message-ID: <20180629085752.zkbxlwc2rzlm63lk@xakep.localdomain>
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
User-Agent: NeoMutt/20180622
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-29 09:30:10, Thomas Gleixner wrote:
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

kvm clock  I have fixed in my series.
http://lkml.kernel.org/r/20180621212518.19914-5-pasha.tatashin@oracle.com

It was late because, it depended on memblock, which is initialized later,
after e820 ranges are read.

So, after my series kvm clock will work right after
init_hypervisor_platform, the same as with most other hypervisors.

With xen, it is a little more challenging: I do not have a hardware
configured to run xen to test it.

On the other hand, most likely that tsc_early_delay_calibrate() now
fails to calibrate tsc on xen, and calibrates correctly later in
tsc_init().  I doubt, that we can use CPUID method to determine tsc
frequency on xen cpu. Anyways, that would be accidental behavior.

To make xen clock available early, we need HYPERVISOR_shared_info. So, at
least that part of xen_setup_shared_info() must be called/available from
init_hypervisor_platform():

void xen_setup_shared_info(void)
{
	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);

	HYPERVISOR_shared_info =
		(struct shared_info *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);

	xen_setup_mfn_list_list();
	...

Which, I have no idea if it is possible, or safe to do.

For now, in my series, I would like check in tsc_early_init() if we are
running xen, and set tsc_khz to 0 if so. Later in tsc_init() we will get
a proper calibration. The question is how to make this check least
intrusive.

Pavel
