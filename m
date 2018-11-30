Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78153206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFgIH9NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78153206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeK3VrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:47:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45473 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbeK3VrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:47:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so4758687wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 02:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YuAYie91ImB2WqhzRLQtsGktOjfWDck7ib2uKUhKWk8=;
        b=gFgIH9NIsrKPu4CrMlRZghehBrZiMOZqhSxt0ewudz67pV2cQrV+ZQ4Mw8Yepi+g/o
         fVkYbA++JZDEnMW0waks60/09pkLS11rSVbemb+Mh/0B89v4yqFykAGnNkf6iI3cf5vg
         aAuLRASyxYpPfqMZ8z1G2+pOEczd6VtBG0UzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YuAYie91ImB2WqhzRLQtsGktOjfWDck7ib2uKUhKWk8=;
        b=qwlDTFociisiIWEZv3MR6gYZlxWeKrt0tJZpqn5qGOPAEPEb2xU/847lpLMgDLEZdo
         eq7lD37mkhpL5IDvCRqRYkeIRaJ6VPwR8i+oUo1r7Xw+tTRKu7BweemqJ9y4IEn+X5MJ
         M6Tr8q4RYT7Juz9So+WTxZByoVExXRjgZhYi8EWLnY0/qUVhYrP+85hAZue5LDC+luvu
         C0Tsj73UcDfYBzv0RwMohzmEo9rV5TrG0sI1IR9iN/wzu/d0T1Kt1FwPmn9eBlJOOE9H
         VUeC14sekCtv/voEhOIrgybheJEz/VuuFWx25OqXI6LVjGdVltr5cHoo0YRZ7eQBAu+F
         Dr3Q==
X-Gm-Message-State: AA+aEWaMIXCFbbxq9xN7L254aNA0xdFnb+OB07ZEyIeQoykTpwSd9FMx
        PtKIgQFMplhJCCwUhOj54HWFRA==
X-Google-Smtp-Source: AFSGD/WkUKNxAatJkQjgvBh3Ku3X41HHm4y2x6cmb45ldwyYqz1xSLV4l/+L1kYXNA1dAO0+JHOz3Q==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr4173858wrl.137.1543574294290;
        Fri, 30 Nov 2018 02:38:14 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t5sm4639724wmg.43.2018.11.30.02.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 02:38:13 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:38:11 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v6 06/24] arm64: ptrace: Provide definitions for PMR
 values
Message-ID: <20181130103811.lushdja552xevghm@holly.lan>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-7-git-send-email-julien.thierry@arm.com>
 <20181129164013.qmmwhbygjkh5lwx5@lakrids.cambridge.arm.com>
 <79145359-3594-3dac-1123-cec552c2b13e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79145359-3594-3dac-1123-cec552c2b13e@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:53:47AM +0000, Julien Thierry wrote:
> 
> 
> On 29/11/18 16:40, Mark Rutland wrote:
> > On Mon, Nov 12, 2018 at 11:56:57AM +0000, Julien Thierry wrote:
> >> Introduce fixed values for PMR that are going to be used to mask and
> >> unmask interrupts by priority. These values are chosent in such a way
> > 
> > Nit: s/chosent/chosen/
> > 
> >> that a single bit (GIC_PMR_UNMASKED_BIT) encodes the information whether
> >> interrupts are masked or not.
> > 
> > There's no GIC_PMR_UNMASKED_BIT in this patch. Should that be
> > GIC_PRIO_STATUS_BIT?
> > 
> 
> Yep, forgot to update the commit message when renaming, thanks.
> 
> >> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> >> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> >> Cc: Oleg Nesterov <oleg@redhat.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  arch/arm64/include/asm/ptrace.h | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> >> index fce22c4..ce6998c 100644
> >> --- a/arch/arm64/include/asm/ptrace.h
> >> +++ b/arch/arm64/include/asm/ptrace.h
> >> @@ -25,6 +25,12 @@
> >>  #define CurrentEL_EL1		(1 << 2)
> >>  #define CurrentEL_EL2		(2 << 2)
> >>  
> >> +/* PMR values used to mask/unmask interrupts */
> >> +#define GIC_PRIO_IRQON		0xf0
> >> +#define GIC_PRIO_STATUS_SHIFT	6
> >> +#define GIC_PRIO_STATUS_BIT	(1 << GIC_PRIO_STATUS_SHIFT)
> >> +#define GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON ^ GIC_PRIO_STATUS_BIT)
> > 
> > Could you elaborate on the GIC priority logic a bit?
> > 
> 
> Yes, I'll give details below.
> 
> > Are lower numbers higher priority?
> > 
> 
> Yes, that is the case.
> 
> > Are there restrictions on valid PMR values?
> > 
> 
> Yes, there are at most 8 priority bits but implementations are free to
> implement a number of priority bits:
> - between 5 and 8 when GIC runs two security states (bits [7:3] always
> being implemented and [2:0] being optional), but non-secure side is
> always deprived or the lowest implemented bit
> - between 4 and 8 when GIC runs only one security state (bits [7:4]
> implemented, bits [3:0] optional)
> 
> This is detailed in section 4.8 "Interrupt prioritization" of the GICv3
> architecture specification.
> 
> So Linux should always be able to see bits [7:4].
> 
> > IIUC GIC_PRIO_IRQOFF is 0xb0 (aka 0b10110000), which seems a little
> > surprising. I'd have expected that we'd use the most signficant bit.
> > 
> 
> So, re-reading the GICv3 spec, I believe this sparked from a confusion...
> 
> The idea was that the GICv3 specification would recommend to keep
> non-secure group-1 interrupts at a lower priority that group-0 (and
> secure group-1 interrupts) interrupts, and to do so the idea was to
> always keep bit[7] == 1 for non-secure group-1.
> 
> So, we would need to have priority bit[7] == 1 for both normal
> interrupts and pseudo-NMIs, and using the most significant bit to mask
> would mean masking pseudo-NMIs as well.
> 
> However, I only find mention of this in the notes of section 4.8.6
> "Software accesses of interrupt priority". The section only applies to
> GIC with two security states, and the recommendation of writing
> non-secure group-1 priorities with bit[7] == 1 is only directed at
> writes from the secure side. From the non-secure side, the GIC already
> does some magic to enforce that the value kept in the distributor has
> bit[7] == 1.
> 
> So, I believe that from the non-secure point of view, we could define
> pseudo-NMI priority as e.g. 0x40 (which the GIC will convert to 0xa0)
> and use the most significant bit of PMR to mask normal interrupts which
> would be more intuitive.
> 
> Marc, as GIC expert do you agree with this? Or is there a reason we
> should keep bit[7] == 1 for non-secure group-1 priorities?

I think selecting bit 6 dates back to when I was working on this.

I originally used bit 7 but switched due to problems on the FVP at the
time (my memory is a little hazy here but it felt like it wasn't
doing the magic shift properly when running in non-secure mode).

Once the patchset was running on real hardware I kept on with bit 6 
figuring that, given the magic shift from non-secure mode is a little
odd, it would remain furtile soil for future silicon bugs (I was
watching a lot of patches go past on the ML working round bugs in
non-Arm GIC implementations and ended up feeling rather paranoid
about things like that).


Daniel.
