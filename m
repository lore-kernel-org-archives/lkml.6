Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823ABC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484752086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lGVOY4RK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484752086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbeKFE7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:59:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35783 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbeKFE7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:59:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id v9-v6so2612366pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qj/9dIqNEHYfnb/N1l0z7V3k6z6oAg5R+Y6p2XF246c=;
        b=lGVOY4RK6BPeffXxm4VI+TxIpJMexN+jXq/GiDxZl1UGfqzX3AW145CKgDbSqnTG2r
         9gQhyIV/W6do2xJl2Vgd3++36V8MGAvXpjGyh2mNgP0hMrQ7UMez6HIMWhHsBfGoaV8P
         HSAM8TcVFiQgeauSTmDzAqjxfzcp+4v/LpsNfLCh9eYjplz7naLasNGNMVY+1PNqO+2g
         J/yAsGuAQLolBSMYUSPtn37vTmaymjo2HE94bE2dStD8xm4jvm0UBwDE72a9TFTFDTZj
         +PFmvNEKFj+Js6BbiJd6jExd1ktb/UGV4FUrmfc1B0dY+ElUluSv/UQA9KcbuoW1B3Ms
         IYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qj/9dIqNEHYfnb/N1l0z7V3k6z6oAg5R+Y6p2XF246c=;
        b=Yzahj+7GhpMF5brIWELZUpyru5xPODe9wnXWdS1AI7nLB/qIIsgIXl6hHTEQJKnQru
         X4Bt26UADTBlo8xtoAFz2YVBExpuPSOjY29iVDUAXwrAj18IwUQCDCXVim9QYfnWeZm1
         NSu6Eu3QMO+VS4ARi1+UoJDNuHOC2Y+LzOMlK/4zCHMOtXWcxePaWXsJE+mSnqB8enAk
         zQn1ThLagCRqgEs6l0Fk8WNQhYILM1lVCry/fIHjBTNSUXGZX71ddxXUIm6o9Lnvr5At
         SBZXmXeGBfnRVvn2g3WFWe6/0OUeM73q3O5hES+TMX4HgLhUAR38Eq1B46lsvDxThGDl
         m12A==
X-Gm-Message-State: AGRZ1gK5AwMH2jAIQAWdVxhQAeOheLTnPR+YwAXySKE84TUW+IJTwt5j
        4toGcnOA2MiTAxzWw7CV1HX8Dw==
X-Google-Smtp-Source: AJdET5eDsq7jVFyX+9Li09cYTtzBVDcgn4yhhDBElA6therplP3ECsnN3Y6iMCGo9x5lm3NPYRePRQ==
X-Received: by 2002:a63:4c6:: with SMTP id 189mr21472530pge.391.1541446721073;
        Mon, 05 Nov 2018 11:38:41 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x14-v6sm67470373pfe.178.2018.11.05.11.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:38:40 -0800 (PST)
Date:   Mon, 05 Nov 2018 11:38:40 -0800 (PST)
X-Google-Original-Date: Mon, 05 Nov 2018 11:36:29 PST (-0800)
Subject:     Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
In-Reply-To: <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
CC:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        anup@brainfault.org, Christoph Hellwig <hch@infradead.org>,
        Damien.LeMoal@wdc.com, tglx@linutronix.de, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alankao@andestech.com, zong@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-799bd6f4-e4af-481e-90d8-bdc0e30f2530@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Nov 2018 06:09:39 PDT (-0700), robh+dt@kernel.org wrote:
> On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
>> But it doesn't need a separate thread node for defining SMT systems.
>> Multiple cpu phandle properties can be parsed to identify the sibling
>> hardware threads. Moreover, we do not have cluster concept in RISC-V.
>> So package is a better word choice than cluster for RISC-V.
>
> There was a proposal to add package info for ARM recently. Not sure
> what happened to that, but we don't need 2 different ways.
>
> There's never going to be clusters for RISC-V? What prevents that?
> Seems shortsighted to me.
>
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>  .../devicetree/bindings/riscv/topology.txt         | 154 +++++++++++++++++++++
>>  1 file changed, 154 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/riscv/topology.txt
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/topology.txt b/Documentation/devicetree/bindings/riscv/topology.txt
>> new file mode 100644
>> index 00000000..96039ed3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/riscv/topology.txt
>> @@ -0,0 +1,154 @@
>> +===========================================
>> +RISC-V cpu topology binding description
>> +===========================================
>> +
>> +===========================================
>> +1 - Introduction
>> +===========================================
>> +
>> +In a RISC-V system, the hierarchy of CPUs can be defined through following nodes that
>> +are used to describe the layout of physical CPUs in the system:
>> +
>> +- packages
>> +- core
>> +
>> +The cpu nodes (bindings defined in [1]) represent the devices that
>> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
>> +Simultaneous multi-threading (SMT) systems can also represent their topology
>> +by defining multiple cpu phandles inside core node. The details are explained
>> +in paragraph 3.
>
> I don't see a reason to do this differently than ARM. That said, I
> don't think the thread part is in use on ARM, so it could possibly be
> changed.
>
>> +
>> +The remainder of this document provides the topology bindings for ARM, based
>
> for ARM?
>
>> +on the Devicetree Specification, available from:
>> +
>> +https://www.devicetree.org/specifications/
>> +
>> +If not stated otherwise, whenever a reference to a cpu node phandle is made its
>> +value must point to a cpu node compliant with the cpu node bindings as
>> +documented in [1].
>> +A topology description containing phandles to cpu nodes that are not compliant
>> +with bindings standardized in [1] is therefore considered invalid.
>> +
>> +This cpu topology binding description is mostly based on the topology defined
>> +in ARM [2].
>> +===========================================
>> +2 - cpu-topology node
>
> cpu-map. Why change this?
>
> What I would like to see is the ARM topology binding reworked to be
> common or some good reasons why it doesn't work for RISC-V as-is.

I think it would be great if CPU topologies were not a RISC-V specific thing.  
We don't really do anything different than anyone else, so it'd be great if we 
could all share the same spec and code.  Looking quickly at the ARM cpu-map 
bindings, I don't see any reason why we can't just use the same thing on RISC-V 
-- it's not quite how I'd do it, but I don't think the differences are worth 
having another implementation.  Mechanically I'm not sure how to do this: 
should there just be a "Documentation/devicetree/bindings/cpu-map.txt"?

If everyone is OK with that then I vote we just go ahead and genericise the ARM 
"cpu-map" stuff for CPU topology.  Sharing the implementation looks fairly 
straight-forward as well.
