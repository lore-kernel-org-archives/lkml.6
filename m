Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E360920857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NKH/gVBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E360920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbeG3Uuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:50:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35186 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbeG3Uuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:50:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UJ8OE7036652;
        Mon, 30 Jul 2018 19:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=msYGP1bQz8ve1rQ7e2JPf66v+VN1eCiWsGrYLTw58ts=;
 b=NKH/gVBrcGzy5x+ggsIhTKhMRpAywYgQ9Lxy2TKu/S3Y6EhM4sHdJ0855Y126HtzbmeP
 +973PrlpvKe0sCjBjF0KTROn6ZThDWyh8qdIwIr5zG+77F2WFuyinCI2tc8Bd2cnZF/5
 CdZ8Bbgn63tUbB5kF9Jsu09FigJMDjBVHUT6R3mpklyqhVNatlouWaVj+qChHZBnzQm9
 m9E6CciTu7iNtrsyrHROvunn0sFw9CtiQr9XFRPNQh7lPqR9PRB6oAIB7dY3H7NzjaFj
 TM/mlfPqJLBRZTS4SyX9TvfFD8i/Z2yNPpKXNy0cxwi1QGfQcRGAn4Zqsnxs6zqAxF4z 4w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kgfwsx19g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 19:13:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6UJDnhp016174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 19:13:50 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6UJDnhU023241;
        Mon, 30 Jul 2018 19:13:49 GMT
Received: from Konrads-MBP.t-mobile.com (/209.6.39.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 12:13:48 -0700
Date:   Mon, 30 Jul 2018 15:13:46 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        x86@kernel.org
Subject: Re: [PATCH v2] x86/bugs: protect against userspace-userspace
 spectreRSB
Message-ID: <20180730191344.GD77063@Konrads-MBP.t-mobile.com>
References: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1807261308190.997@cbobk.fhfr.pm>
 <8329a551-ccc1-248a-2e3d-194f7c832b7e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8329a551-ccc1-248a-2e3d-194f7c832b7e@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:56:55AM -0700, Tim Chen wrote:
> On 07/26/2018 04:14 AM, Jiri Kosina wrote:
> > From: Jiri Kosina <jkosina@suse.cz>
> > 
> > The article "Spectre Returns! Speculation Attacks using the Return Stack 
> > Buffer" [1] describes two new (sub-)variants of spectrev2-like attack, 
> > making use solely of the RSB contents even on CPUs that don't fallback to 
> > BTB on RSB underflow (Skylake+).
> > 
> > Mitigate userspace-userspace attacks by always unconditionally filling RSB on
> > context switch when generic spectrev2 mitigation has been enabled.
> > 
> > [1] https://arxiv.org/pdf/1807.07940.pdf
> > 
> > Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>

May I suggest:

CC: stable@vger.kernel.org ?

> > ---
> > 
> > v1 -> v2: 
> > 
> > 	- Fixed typos/capatalization in SpectreRSB name
> > 	- Josh's Reviewed-by
> > 
> >  arch/x86/kernel/cpu/bugs.c | 38 +++++++-------------------------------
> >  1 file changed, 7 insertions(+), 31 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 5c0ea39311fe..bc8c43b22460 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -313,23 +313,6 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
> >  	return cmd;
> >  }
> >  
> > -/* Check for Skylake-like CPUs (for RSB handling) */
> > -static bool __init is_skylake_era(void)
> > -{
> > -	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> > -	    boot_cpu_data.x86 == 6) {
> > -		switch (boot_cpu_data.x86_model) {
> > -		case INTEL_FAM6_SKYLAKE_MOBILE:
> > -		case INTEL_FAM6_SKYLAKE_DESKTOP:
> > -		case INTEL_FAM6_SKYLAKE_X:
> > -		case INTEL_FAM6_KABYLAKE_MOBILE:
> > -		case INTEL_FAM6_KABYLAKE_DESKTOP:
> > -			return true;
> > -		}
> > -	}
> > -	return false;
> > -}
> > -
> >  static void __init spectre_v2_select_mitigation(void)
> >  {
> >  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> > @@ -390,22 +373,15 @@ static void __init spectre_v2_select_mitigation(void)
> >  	pr_info("%s\n", spectre_v2_strings[mode]);
> >  
> >  	/*
> > -	 * If neither SMEP nor PTI are available, there is a risk of
> > -	 * hitting userspace addresses in the RSB after a context switch
> > -	 * from a shallow call stack to a deeper one. To prevent this fill
> > -	 * the entire RSB, even when using IBRS.
> > +	 * If spectre v2 protection has been enabled, unconditionally fill
> > +	 * RSB during a context switch; this protects against two independent
> > +	 * issues:
> >  	 *
> > -	 * Skylake era CPUs have a separate issue with *underflow* of the
> > -	 * RSB, when they will predict 'ret' targets from the generic BTB.
> > -	 * The proper mitigation for this is IBRS. If IBRS is not supported
> > -	 * or deactivated in favour of retpolines the RSB fill on context
> > -	 * switch is required.
> > +	 *	- RSB underflow (and switch to BTB) on Skylake+
> > +	 *	- SpectreRSB variant of spectre v2 on X86_BUG_SPECTRE_V2 CPUs
> >  	 */
> > -	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
> > -	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
> > -		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
> > -		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
> > -	}
> > +	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
> > +	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
> >  
> >  	/* Initialize Indirect Branch Prediction Barrier if supported */
> >  	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> > 
> 
> Thanks for the patch.  Looks good.  
> 
> Acked-by: Tim Chen <tim.c.chen@linux.intel.com>
> 
> Tim
