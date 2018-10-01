Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37225C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35B72089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QTjLTo6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35B72089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeJAUGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:06:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56604 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeJAUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:06:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181001132854euoutp02a575f97bc3c7f4eb6d7c9bc85e4a9e0a~ZfyK5gbcv0090000900euoutp02e
        for <linux-kernel@vger.kernel.org>; Mon,  1 Oct 2018 13:28:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181001132854euoutp02a575f97bc3c7f4eb6d7c9bc85e4a9e0a~ZfyK5gbcv0090000900euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538400534;
        bh=ODahgksovIQwUFWPQL12Xy40qwdqdBymoL2rExualHs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QTjLTo6ATBsOIn/cabun+e6y0JPgY6bptM4UcNeMzeBcuil95hTY1PdSEoGK5NLRh
         zQ3Iz4G0Rq/93mNatIpXELBj81tKSD9iXJ18+QrcXGgptGv/itaRcTkDk5kh2mIlXM
         7yChJKM6/RvrCqQhYPiOk0VqpVMG/pHGVqpuiTY4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181001132853eucas1p19b7415a093bacc00349ab9824f4db72d~ZfyKBk3LX0842808428eucas1p17;
        Mon,  1 Oct 2018 13:28:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 89.7D.04806.51122BB5; Mon,  1
        Oct 2018 14:28:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181001132852eucas1p25ab2ddf39296e2c78b188234d168f814~ZfyJK4W4N0481804818eucas1p2j;
        Mon,  1 Oct 2018 13:28:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181001132852eusmtrp22563d955eaf35a53ced2678767725d99~ZfyI5WiyY1786317863eusmtrp2R;
        Mon,  1 Oct 2018 13:28:52 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-14-5bb22115df64
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 14.F9.04284.41122BB5; Mon,  1
        Oct 2018 14:28:52 +0100 (BST)
Received: from [106.120.51.30] (unknown [106.120.51.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181001132852eusmtip243a2841decfa95dc0d1603d56dfa96c9~ZfyISgtFB1199411994eusmtip2H;
        Mon,  1 Oct 2018 13:28:51 +0000 (GMT)
Subject: Re: [PATCH v2 5/7] arm64: make arm uprobes code reusable by arm64
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
Date:   Mon, 1 Oct 2018 15:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9abe9091-f305-a446-c93f-6418d35a7dee@arm.com>
Content-Language: pl
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xNYRzHPeecezrdddvT7bZ+qybueMFUyHiGEF4cvMAwJhsHZ9V0k3sq
        Mlt/tdxVw3ZRlFhLu241J6XuJa2Vm78JNb1AKaR117gYoXQ6Nb377Pv7fp/f77s9HK3/qAni
        4hOTRXOikGBktUz9g18dYQFz5ZjFj+tDieVtA0vy5CINuXWpRkNGKvIRaXv6lyJZXVtJ5tcS
        msj93Rry0nGFJS3We4hUtb7xIi+ayyYcFXUMqbt/GhFXQTNFPn9pZ9Zh3l5qR/zL7k6ar61c
        yMu2Myxf+nA7X1uezo80dbF84W0b4j3y7G3ee7WrD4sJ8amiOWLNAW1cXkMfnTQccmLgeg+T
        gayBFuTNAV4GX9qeUBak5fS4EkHNoNtLGejxNwQOC1EHHgTPqs56TSfGftydStxA4B4uodWE
        G0HHxy0K++PNkD/QORHgOAM+BoUFCxQ/jWUKrEOtjOJh8Qq405YzyQyeB/bBEkrhALwHWnuv
        IYV12A8eFg1MerzxKhi3uiaZxgZ4/T4HqRwK2XWXaWUB4AIOXvXZGDWcCu+rR1j16o1Q685m
        VPaHIdftqTYhMN54lVL5ODjbe7zUh3IQWDObpwar4I/tHKu0ofECqHFEqHI0ZNVcoBQZsC+8
        dvup9/jC+fqLtCrrIC9Xr7rD4N5oxtQFwdCVeYE6i4zFM1oWz2hWPKNZ8f+9ZYixoUAxRTLF
        ilJkong8XBJMUkpibPihoyYZTfy+x2Ou7w2o6c/BFoQ5ZPTRzQqVY/QaIVVKM7Ug4GijQdeo
        SLrDQtpJ0Xx0vzklQZRaUDDHGAN1FaW3YvQ4VkgWj4hikmienlKcd1AG8lsfKfjuKHqk2bTB
        8tP290N0iMbRLvR3Fx7w+PZu3ts3p75dxCXLn2v7xp1jd+whV5JOSc6V2WYir31XLQm7G9Mc
        /kvLVt58Yl02GDvfnoSGd/qEZ4VFeXy2BpdLN6jKTwwZpdnPKb8HNNXpiwyG/PQ5B3Odu7pQ
        lb08N2qfkZHihCULabMk/ANpbKKkeQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xe7oiipuiDVZ0aVh03dvBZtGxaSar
        xcYZ61kt3i/rYbQ4evYvk0XTVX+Lxk9zmS02Pb7GanF51xw2i0NT9zJarD1yl93i0oEFQBXL
        trJYbN3fymhxvPcAk8XLjydYHAQ81sxbw+hx+dpFZo/NK7Q8Nq3qZPOYdzLQY/OSeo/3+66y
        efRtWcXo8XmTXABnlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpO
        Zllqkb5dgl5Gx46HzAVvZCqeLLrJ0sA4VbyLkZNDQsBE4t+3PUxdjFwcQgJLGSXeHN7DApGQ
        ljj5dhMbhC0s8edaFxtE0WtGia+bnzOCJIQFvCR6nlxkB7FFBAolnm9ZwQhSxCywiUniyvJ1
        7BAds5gk5u+8ADaWTcBcYvvRFjCbV8BNYvKMH2ArWARUJNa8mMsEYosKREisXv6CFaJGUOLk
        zCdg9ZwC1hL/px4Hs5kFzCTmbX7IDGGLSNx41MIIYctLNG+dzTyBUWgWkvZZSFpmIWmZhaRl
        ASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCY33bs5+YdjJc2Bh9iFOBgVOLhZZDfFC3E
        mlhWXJl7iFGCg1lJhHcnSIg3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgekoryTe0NTQ3MLS
        0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QD48Rsvn7+4wHBAub7d94JXttRzv6P
        d+XMHTxPV/7hvfbs0+Qpyp62cqIzTjKuYOn9wLvTXchXYLPehYpn3sLLGHmWmjPuaZ9y6F2U
        UlnI3s7N69ec1r55xSq/4/XUrh/unR9LtnyNvlux6tLOe8WS8+2O7Wpo/feW5dg8i0kC/ktu
        /HB+WsL+u0WJpTgj0VCLuag4EQAMaccDDwMAAA==
Message-Id: <20181001132852eucas1p25ab2ddf39296e2c78b188234d168f814~ZfyJK4W4N0481804818eucas1p2j@eucas1p2.samsung.com>
X-CMS-MailID: 20181001132852eucas1p25ab2ddf39296e2c78b188234d168f814
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180926121216eucas1p2b896ce19f49214d497721db9d6e59bfb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121216eucas1p2b896ce19f49214d497721db9d6e59bfb
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121216eucas1p2b896ce19f49214d497721db9d6e59bfb@eucas1p2.samsung.com>
        <1537963925-25313-6-git-send-email-m.slodczyk2@partner.samsung.com>
        <9abe9091-f305-a446-c93f-6418d35a7dee@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the review.

> I think that it would be good to move the renaming changes out of this 
> patch.
> 

So, as I understand, you suggest separating renaming from moving and 
putting it in separate patches, right?

>>   })
>> +#define ARM_COMPAT_LR_OFFSET    0
> 
> Not sure this should be defined here. What's the meaning of compat for 
> arch/arm ?
> 

Sure, I agree that the name is not very fortunate. I'll change it to 
something like ARM_UPROBES_BRANCH_LR_OFFSET.

>> @@ -39,7 +39,7 @@ struct arch_uprobe {
>>       void (*posthandler)(struct arch_uprobe *auprobe,
>>                   struct arch_uprobe_task *autask,
>>                   struct pt_regs *regs);
>> -    struct arch_probes_insn asi;
>> +    struct arch_probes_insn api;
> 
> It would be easier to follow thing by making this change in its own 
> patch. (Probably before you move arm32 code to lib/probes)
> 

Yup.


>> +enum probes_insn {
>> +    INSN_REJECTED,
>> +    INSN_GOOD_NO_SLOT,
>> +    INSN_GOOD,
>> +};
> 
> Why have two definitions of this enum rather than a common one in 
> lib/probes?
> 

Will fix in v3.

>> -typedef void (probes_handler_t) (u32 opcode,
>> -               struct arch_probe_insn *api,
>> +typedef void (probes_insn_handler_t) (u32 opcode,
>> +               struct arch_probes_insn *api,
> 
> In the previous patch you were already aligning this handler the ARM32's 
> equivalent. Why not fix the name (for the handler and struct 
> arch_probes_insn) in the previous patch?
> 

OK.

>> +
>> +#define link_register(regs)            ((regs)->compat_lr)
>> +
>> +static inline void link_register_set(struct pt_regs *regs,
>> +                       unsigned long val)
>> +{
>> +    link_register(regs) = val;
>> +}
> 
> pstate.h isn't really related to compat mode and whichever compat 
> definition it contains the relations are made explicit through their names.
> 
> I don't think a macro "link_register" defined in arch/arm64 and visible 
> to any file including ptrace.h (which is a lot) should return 
> "compat_lr" instead of the actual link register.
> 
> I'd say have the link_register macro check whether "regs" refers to a 
> compat mode context or not and provide the adequate link register.
> 
> Otherwise maybe you can get away with naming the macro 
> "arm_link_register" and the macro "arm_link_register_set". But I would 
> prefer the previous approach.
> 

OK.

>> +#ifdef CONFIG_ARM64
>> +#include <../../../arm/include/asm/opcodes.h>
> 
> Hmmm not sure this is something that is accepted.
> 

OK, I'll fix it.

>> +/*
>> + * based on arm kprobes implementation
>> + */
>> +static void __kprobes simulate_ldm1stm1(probes_opcode_t insn,
>> +        struct arch_probes_insn *asi,
> 
> The whole asi/api mix become a bit confusing IMO.
> Should we have api when the argument is of type "arch_probes_insn" and 
> asi when the type is "arch_specific_insn"?
> Should we have more coherent definitions of those structures between arm 
> and arm64 if we are going to share functions between them?
> 

OK, I'll try to figure something out that's less confusing.

> 
> #ifdef CONFIG_ARM64
> 
>> +enum probes_insn
>> +uprobe_decode_ldmstm_aarch64(probes_opcode_t insn,
>> +         struct arch_probes_insn *asi,
>> +         const struct decode_header *d)
> 
> Should be static.
> 

OK.

Thanks again for the review. I'll rework the whole patchset to include 
your remarks.


Thank you,
Maciej
