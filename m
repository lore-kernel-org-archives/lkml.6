Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5D0207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550242864;
	bh=AkVBKEMZ0ZYJo67INS81B29Rgu0o9C+VCzGlb/jazs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D6iaHxHUnzjdr5Grq9JxBdSzZcFXjAjetls/sGWDocflPU+stIXX11qvNf85F0ET7
	 GXl6HH/1EkRWqvdYfU075rBND1Zc1pXa15ItTuU16mbbP5u9URpqsZ0b3+FJ5857vL
	 SEMfPlN5hmtGaEldLiqbFzPktBtErs26Zk7mkcm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfBOPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbfBOPBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:01:02 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AD0D207E0;
        Fri, 15 Feb 2019 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550242861;
        bh=AkVBKEMZ0ZYJo67INS81B29Rgu0o9C+VCzGlb/jazs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MIqjAlxX0GHFbsj9JncL/1H7+IfZ0hRrH34WM4G7PMtnyN5vECPRdt3AsFpFz6117
         HddvhlNMLNhkexjGJ2FGwdZLbxQ0d7/eRetcAGlmpeOChx6WLQwVhNxm0fijb/mXao
         SOXwYKisokyabfcyzOmKHm1s22Lx2L9vDlupxG18=
Date:   Sat, 16 Feb 2019 00:00:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-Id: <20190216000058.a75ff4d9497065ce216e246d@kernel.org>
In-Reply-To: <20190214155522.GA1825@fuggles.cambridge.arm.com>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
        <154998628802.21869.4041705065539411318.stgit@devbox>
        <20190214155522.GA1825@fuggles.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 15:55:22 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hi Masami,
> 
> On Wed, Feb 13, 2019 at 12:44:48AM +0900, Masami Hiramatsu wrote:
> > Use arch_populate_kprobe_blacklist() instead of
> > arch_within_kprobe_blacklist() so that we can see the full
> > blacklisted symbols under the debugfs.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >   Changes in v3
> >    - Do not populate blacklist in __kprobe_text in
> >      arch_populate_kprobe_blacklist(), since it is already
> >      populated in populate_kprobe_blacklist().
> >    - Add exception entry text blacklist since those are rejected
> >      by in_exception_text().
> > ---
> >  arch/arm64/kernel/probes/kprobes.c |   45 +++++++++++++++++++++---------------
> >  1 file changed, 26 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index 194262fca5cd..37d913f33a89 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -465,26 +465,33 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
> >  	return DBG_HOOK_HANDLED;
> >  }
> >  
> > -bool arch_within_kprobe_blacklist(unsigned long addr)
> 
> I think it would be useful to add a comment here so that we remember
> why this code is the way it is:
> 
> /*
>  * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
>  * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
>  */

Agreed. This looks good to me too.

> 
> With that, you can have my ack for the series:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thank you!

> 
> Catalin -- can you pick these up with that comment added, please?
> 
> Cheers,
> 
> Will


-- 
Masami Hiramatsu <mhiramat@kernel.org>
