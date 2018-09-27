Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DFBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20A12170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20A12170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeI1CLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:11:04 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43756 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1CLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:11:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g5cJX-0002Ex-25; Thu, 27 Sep 2018 13:51:07 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g5cJV-0000p3-OT; Thu, 27 Sep 2018 13:51:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
References: <cover.1538058840.git.ren_guo@c-sky.com>
        <cover.1538058840.git.ren_guo@c-sky.com>
        <a51eb26bd9442a3e4d09e9785ae5ccaf2555a534.1538058840.git.ren_guo@c-sky.com>
Date:   Thu, 27 Sep 2018 21:50:43 +0200
In-Reply-To: <a51eb26bd9442a3e4d09e9785ae5ccaf2555a534.1538058840.git.ren_guo@c-sky.com>
        (Guo Ren's message of "Thu, 27 Sep 2018 22:47:45 +0800")
Message-ID: <87h8iaoh2k.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g5cJV-0000p3-OT;;;mid=<87h8iaoh2k.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19TbJoKn4uEMJ7mg2tvxEMUWeDMNfSGgd0=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH V6 08/33] csky: Process management and Signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <ren_guo@c-sky.com> writes:

> --- /dev/null
> +++ b/arch/csky/abiv2/fpu.c
> +void fpu_fpe(struct pt_regs * regs)
> +{
> +	int sig;
> +	unsigned int fesr;
> +	siginfo_t info;
> +
> +	fesr = mfcr("cr<2, 2>");
> +
> +	if(fesr & FPE_ILLE){
> +		info.si_code = ILL_ILLOPC;
> +		sig = SIGILL;
> +	}
> +	else if(fesr & FPE_IDC){
> +		info.si_code = ILL_ILLOPN;
> +		sig = SIGILL;
> +	}
> +	else if(fesr & FPE_FEC){
> +		sig = SIGFPE;
> +		if(fesr & FPE_IOC){
> +			info.si_code = FPE_FLTINV;
> +		}
> +		else if(fesr & FPE_DZC){
> +			info.si_code = FPE_FLTDIV;
> +		}
> +		else if(fesr & FPE_UFC){
> +			info.si_code = FPE_FLTUND;
> +		}
> +		else if(fesr & FPE_OFC){
> +			info.si_code = FPE_FLTOVF;
> +		}
> +		else if(fesr & FPE_IXC){
> +			info.si_code = FPE_FLTRES;
> +		}
> +		else {
> +			info.si_code = NSIGFPE;
> +		}
> +	}
> +	else {
> +		info.si_code = NSIGFPE;
> +		sig = SIGFPE;
> +	}
> +	info.si_signo = SIGFPE;
> +	info.si_errno = 0;
> +	info.si_addr = (void *)regs->pc;
> +	force_sig_info(sig, &info, current);
> +}


This use of sending a signal is buggy.  It results in undefined values
being copied to userspace.

Userspace should never be sent NSIGXXX as a si_code.  You can use
FPE_FLTUNK for this default case.

In new code please use force_sig_fault instead of force_sig_info in new
code.  That saves you the trouble of messing with struct siginfo.

Thank you very much,
Eric Biederman

