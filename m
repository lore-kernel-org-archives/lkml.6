Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF3C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD812168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD812168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeI1TfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:35:03 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52605 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbeI1TfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:35:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2170682|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.Cx.jpG7_1538140248;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cx.jpG7_1538140248)
          by smtp.aliyun-inc.com(10.147.40.200);
          Fri, 28 Sep 2018 21:10:48 +0800
Date:   Fri, 28 Sep 2018 21:10:47 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 08/33] csky: Process management and Signal
Message-ID: <20180928131047.GC2082@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <cover.1538058840.git.ren_guo@c-sky.com>
 <a51eb26bd9442a3e4d09e9785ae5ccaf2555a534.1538058840.git.ren_guo@c-sky.com>
 <87h8iaoh2k.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8iaoh2k.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:50:43PM +0200, Eric W. Biederman wrote:
> Guo Ren <ren_guo@c-sky.com> writes:
> 
> > --- /dev/null
> > +++ b/arch/csky/abiv2/fpu.c
> > +void fpu_fpe(struct pt_regs * regs)
> > +{
> > +	int sig;
> > +	unsigned int fesr;
> > +	siginfo_t info;
> > +
> > +	fesr = mfcr("cr<2, 2>");
> > +
> > +	if(fesr & FPE_ILLE){
> > +		info.si_code = ILL_ILLOPC;
> > +		sig = SIGILL;
> > +	}
> > +	else if(fesr & FPE_IDC){
> > +		info.si_code = ILL_ILLOPN;
> > +		sig = SIGILL;
> > +	}
> > +	else if(fesr & FPE_FEC){
> > +		sig = SIGFPE;
> > +		if(fesr & FPE_IOC){
> > +			info.si_code = FPE_FLTINV;
> > +		}
> > +		else if(fesr & FPE_DZC){
> > +			info.si_code = FPE_FLTDIV;
> > +		}
> > +		else if(fesr & FPE_UFC){
> > +			info.si_code = FPE_FLTUND;
> > +		}
> > +		else if(fesr & FPE_OFC){
> > +			info.si_code = FPE_FLTOVF;
> > +		}
> > +		else if(fesr & FPE_IXC){
> > +			info.si_code = FPE_FLTRES;
> > +		}
> > +		else {
> > +			info.si_code = NSIGFPE;
> > +		}
> > +	}
> > +	else {
> > +		info.si_code = NSIGFPE;
> > +		sig = SIGFPE;
> > +	}
> > +	info.si_signo = SIGFPE;
> > +	info.si_errno = 0;
> > +	info.si_addr = (void *)regs->pc;
> > +	force_sig_info(sig, &info, current);
> > +}
> 
> 
> This use of sending a signal is buggy.  It results in undefined values
> being copied to userspace.
> 
> Userspace should never be sent NSIGXXX as a si_code.  You can use
> FPE_FLTUNK for this default case.
Ok, thx for the tips. I'll fix it up in next patch-set.

> In new code please use force_sig_fault instead of force_sig_info in new
> code.  That saves you the trouble of messing with struct siginfo.
Ok, got it. Thx

Best Regards
 Guo Ren
