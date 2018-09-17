Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B14CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16515214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyX5ccqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16515214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeIRFNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:13:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33951 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeIRFNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:13:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so56783pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wNDjIwP5itxgfriEtEmggE/dklly17J93UY94fgR/Vg=;
        b=HyX5ccqZe3nApkJeLuwFSfbflqVhLs3X7d25Rglq7AfAhs8/NCEMex9Z6jx5EuOe/v
         INWDUHRRyBRnqHstCMQkZoJ+ojbacAFsktcP7cJiEJXr8JCeFfYMYBDj+90QuPdaZATn
         5QTfXXN/7BGdkDU0omRnoDlJOz8xNbXbtYkag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNDjIwP5itxgfriEtEmggE/dklly17J93UY94fgR/Vg=;
        b=N1SPxJnDhwEr9IKIquQdrAwJoobDY9dPBpKIY0AiFsirCG5utIaN4TQv50E65GOqN7
         iPXFnW2rXPcmJ5F599Eed73MDJe5R2uxjSlfTDdUNzsK1OhVHPoDuZQM2a4uhwrQeTTY
         DlkV4pFP9QsKCVtWMdqgAlNGk4/IkN+Bih4Xkrc+Yee4L4taZxf0UZuKw5WGFisb9nkN
         76egU+6VdjEUlz1A+iuvnnkksERyYJjFO82CnpjToWP9O7JjmXogeykpFHz/OExpdz0q
         R1vCK5FN9TnyTSUNSdes3rYEP4j8qeaMxqVrL9ZVJvVRBrfoaaqpfvBlfZDtGzhxSiLs
         rajQ==
X-Gm-Message-State: APzg51CUCdn4rhtJib2EDZ/01G0uEB3p4vGl7ArUGhmWTsbKp9R7zeaq
        cuXoXu9FzFBzir1b0MT+aMhyyA==
X-Google-Smtp-Source: ANB0VdY2UI+pVaUlnjn13FB73Ur8jBhHGH3YLcQGz3gF7L7T96V/nFNLF4Yy2ht4Yr2a/zg3/MuyMg==
X-Received: by 2002:a62:c60e:: with SMTP id m14-v6mr28238935pfg.40.1537227844915;
        Mon, 17 Sep 2018 16:44:04 -0700 (PDT)
Received: from holly.lan ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id w72-v6sm38471672pfa.26.2018.09.17.16.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:44:03 -0700 (PDT)
Date:   Mon, 17 Sep 2018 16:44:00 -0700
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH v5 03/27] arm64: alternative: Apply alternatives early in
 boot process
Message-ID: <20180917234400.ctq3w2u6fi5s5coj@holly.lan>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-4-git-send-email-julien.thierry@arm.com>
 <3becf020-b230-beb8-b304-d8097377f234@arm.com>
 <78781d82-e5c4-c590-6c0c-e7d2db456bf9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78781d82-e5c4-c590-6c0c-e7d2db456bf9@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:49:09PM +0100, Julien Thierry wrote:
> > > +	__apply_alternatives(&region, false, boot_capabilities);
> > > +}
> > > +
> > >   #ifdef CONFIG_MODULES
> > >   void apply_alternatives_module(void *start, size_t length)
> > >   {
> > 
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 3bc1c8b..0d1e41e 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -52,6 +52,8 @@
> > >   DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
> > >   EXPORT_SYMBOL(cpu_hwcaps);
> > > +unsigned long boot_capabilities;
> > > +
> > >   /*
> > >    * Flag to indicate if we have computed the system wide
> > >    * capabilities based on the boot time active CPUs. This
> > > @@ -1375,6 +1377,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> > >   		if (!cpus_have_cap(caps->capability) && caps->desc)
> > >   			pr_info("%s %s\n", info, caps->desc);
> > >   		cpus_set_cap(caps->capability);
> > 
> > Hmm, the bitmap behind cpus_set_cap() is what cpus_have_cap() in
> > __apply_alternatives() looks at. If you had a call to __apply_alternatives after
> > update_cpu_capabilities(SCOPE_BOOT_CPU), but before any others, it would only
> > apply those alternatives...
> > 
> > (I don't think there is a problem re-applying the same alternative, but I
> > haven't checked).
> > 
> 
> Interesting idea. If someone can confirm that patching alternatives twice is
> safe, I think it would make things simpler.

Early versions of this patch applied the alternatives twice. I never
noticed any problems with double patching (second time round it will
write out code that is identical to what is already there so it is
merely inefficient rather than unsafe.


Daniel.
