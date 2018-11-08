Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D43CC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5227920685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViX1jaj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5227920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeKHWPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:15:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKHWPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:15:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so10751800wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KhM3UgL+WnMff4RzuxPzQBpJ2IQ6KV8e/r/JF6NPFDQ=;
        b=ViX1jaj/eZCy3YwRbAYj+8dzScdNSTokm1xLPisbAzVI/3C1onJQ4bllZZZDZB5Is8
         o0RQz3ZEFynH/cOQ4PgVfh3apt0B/MkrYRYS0jS+jMLbjudRUq/juoYgRb0xKWztEvFc
         Fu0Mtn+Goz5b9NB3FTPsVBhKTBOGHdW6Gdjhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KhM3UgL+WnMff4RzuxPzQBpJ2IQ6KV8e/r/JF6NPFDQ=;
        b=H8QokI1vt2c1mjnswE6RNr+Iic5zakkxqeZduwozTlaJxHrYeUzMjpMx6s7+6f5PJk
         TOpdDE7YJUqxYNHegU09O3BIzCUw8i3Qzv2557tb0dQXjIiX+6bO+PnAkgrs9MHOENBE
         v/q0o9SKbUstwHD64ScQ5PiX4qrhI/tkVG9WPz17E06DZxszWVZH2IMZKe/O85wDjVC/
         iipe8pK7dwumZNlVByjPklit6aE/zZ+QrT5hFYPRAZQoRv3MqcMAqau9mt6Mr1zF5UXq
         beRh8tAAuFK21Dv7pxhxugG2L9FinlcAMyQkgDZY6hRE9/sOSRouqx5YI9F3QzgdcEJ4
         l3BA==
X-Gm-Message-State: AGRZ1gJGaZM52+Dl6nBbtx6wznOIRUxALMptzf9svDXgctTI9Pa/ZF45
        NFN5HrHKajTwzHEQL7Vq9HjNd4Ybcaw=
X-Google-Smtp-Source: AJdET5cV7bp5TsxiEMN7t3FnZcLupSW5vpQFWv+sDNTx9WN9oc7dmcT+zqGlG3/r/GkQa5GbrjGtOw==
X-Received: by 2002:adf:ff4e:: with SMTP id u14-v6mr4051890wrs.232.1541680812809;
        Thu, 08 Nov 2018 04:40:12 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id v2-v6sm4176697wru.20.2018.11.08.04.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:40:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 9542F3E03FE;
        Thu,  8 Nov 2018 12:40:11 +0000 (GMT)
References: <20181107171031.22573-1-alex.bennee@linaro.org> <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com> <20181107180829.sex54bxhd5wyqvan@lakrids.cambridge.arm.com>
User-agent: mu4e 1.1.0; emacs 26.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kvm@vger.kernel.org, marc.zyngier@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        christoffer.dall@linaro.org
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
In-reply-to: <20181107180829.sex54bxhd5wyqvan@lakrids.cambridge.arm.com>
Date:   Thu, 08 Nov 2018 12:40:11 +0000
Message-ID: <87r2fv68us.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Rutland <mark.rutland@arm.com> writes:

> On Wed, Nov 07, 2018 at 06:01:20PM +0000, Mark Rutland wrote:
>> On Wed, Nov 07, 2018 at 05:10:31PM +0000, Alex Benn=C3=A9e wrote:
>> > Not all faults handled by handle_exit are instruction emulations. For
>> > example a ESR_ELx_EC_IABT will result in the page tables being updated
>> > but the instruction that triggered the fault hasn't actually executed
>> > yet. We use the simple heuristic of checking for a changed PC before
>> > seeing if kvm_arm_handle_step_debug wants to claim we stepped an
>> > instruction.
>> >
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > ---
>> >  arch/arm64/kvm/handle_exit.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit=
.c
>> > index e5e741bfffe1..b8252e72f882 100644
>> > --- a/arch/arm64/kvm/handle_exit.c
>> > +++ b/arch/arm64/kvm/handle_exit.c
>> > @@ -214,6 +214,7 @@ static exit_handle_fn kvm_get_exit_handler(struct =
kvm_vcpu *vcpu)
>> >  static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_r=
un *run)
>> >  {
>> >  	int handled;
>> > +        unsigned long old_pc =3D *vcpu_pc(vcpu);
>> >
>> >  	/*
>> >  	 * See ARM ARM B1.14.1: "Hyp traps on instructions
>> > @@ -233,7 +234,8 @@ static int handle_trap_exceptions(struct kvm_vcpu =
*vcpu, struct kvm_run *run)
>> >  	 * kvm_arm_handle_step_debug() sets the exit_reason on the kvm_run
>> >  	 * structure if we need to return to userspace.
>> >  	 */
>> > -	if (handled > 0 && kvm_arm_handle_step_debug(vcpu, run))
>> > +	if (handled > 0 && *vcpu_pc(vcpu) !=3D old_pc &&
>>
>> This doesn't work if the emulation is equivalent to a branch-to-self, so
>> I don't think that we want to do this.
>>
>> When are we failing to advance the single-step state machine
>> correctly?

When the trap is not actually an instruction emulation - e.g. setting up
the page tables on a fault. Because we are in the act of single-stepping
an instruction that didn't actually execute we erroneously return to
userspace pretending we did even though we shouldn't.

>
> I don't understand how this is intended to work currently.
>
> Surely kvm_skip_instr() should advance the state machine as necessary,
> so that we can rely on the HW to generate any necessary single-step
> exception when we next return to the guest?

It doesn't currently (at least for aarch64, the aarch32 skip code does
more messing about). But the decision isn't really about futzing with
the single-step flags but about returning to userspace so the
single-step is seen. Changing a > 0 to return to the guest to a 0 to
exit to userspace while setting the exit reason.
>
> ... and if userspace decides to emulate something, it's up to it to
> advance the state machine consistently.

Well that's a little more complex. We actually exit to handle the MMIO
stuff and then return so it can complete before exiting again for the
step (see virt/kvm/arm/arm.c):

	if (run->exit_reason =3D=3D KVM_EXIT_MMIO) {
		ret =3D kvm_handle_mmio_return(vcpu, vcpu->run);
		if (ret)
			return ret;
		if (kvm_arm_handle_step_debug(vcpu, vcpu->run))
			return 0;
	}


>
> Thanks,
> Mark.


--
Alex Benn=C3=A9e
