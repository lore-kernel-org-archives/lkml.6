Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AEF2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AEF2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeKHAHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:07:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40215 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHAHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:07:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so19915043qki.7;
        Wed, 07 Nov 2018 06:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtQpXLKVDU3hFhHXorBFshy4vyWhc9NzCNeAxKTvCio=;
        b=tUpGaiWO5XHNPbmhanDiiTdicKm1oEvdfWuaGGDOkLCLRN/1VJdpALlju1b9wWv1Rs
         PtxZ2dkUvTe4mOgW9T+FK1DVhCrhzoBVAHgFuM/WO3uu8JZnIzshs1xD0aowKXha1+MW
         feaJj7Xdpy2FInNAxA3206t6NsfG25PZi1erpw5GyLUH4z0T8K20ycQdej5RhU6S1btg
         MtJGp6h1x8wp6hCtzgIC87KP7vGtey2Jz++Eo7eajnyyqqG2oTeKud284TW0o2OeFrPf
         puYUWsUi3iK3MmA39vO3jAFL3QgSi+8V2Z1cEd6XPYqlUr/NBEE5TtestskQlR9L35zS
         K+Ag==
X-Gm-Message-State: AGRZ1gJvhIoo56V6UO+E8wbuMsFPxP0bV6Es6fP2jwIzUZGOCAC3B+8C
        wnNYx+PHL7n7xcAxFVjiavYcMpn/VIRzL4mrfOA=
X-Google-Smtp-Source: AJdET5czaP7pUBNFkzjBegELf2vAy/WKeIDW4els6qGv8qRITWWI9I97zJr9S3Am4teDV8FLiucB+BpFaE9xHwC7Zkg=
X-Received: by 2002:a37:324a:: with SMTP id y71mr434916qky.291.1541601426423;
 Wed, 07 Nov 2018 06:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-5-elder@linaro.org>
In-Reply-To: <20181107003250.5832-5-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 15:36:50 +0100
Message-ID: <CAK8P3a3iKshE3yCG477AeZbKbLtpDwMhn5mfLySFRLOLmUv5AQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/12] soc: qcom: ipa: immediate commands
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>
> +/**
> + * struct ipahal_context - HAL global context data
> + * @empty_fltrt_tbl:   Empty table to be used for table initialization
> + */
> +static struct ipahal_context {
> +       struct ipa_dma_mem empty_fltrt_tbl;
> +} ipahal_ctx_struct;
> +static struct ipahal_context *ipahal_ctx = &ipahal_ctx_struct;

Remove the global variables here

> +/* Immediate commands H/W structures */
> +
> +/* struct ipa_imm_cmd_hw_ip_fltrt_init - IP_V*_FILTER_INIT/IP_V*_ROUTING_INIT
> + * command payload in H/W format.
> + * Inits IPv4/v6 routing or filter block.
> + * @hash_rules_addr: Addr in system mem where hashable flt/rt rules starts
> + * @hash_rules_size: Size in bytes of the hashable tbl to cpy to local mem
> + * @hash_local_addr: Addr in shared mem where hashable flt/rt tbl should
> + *  be copied to
> + * @nhash_rules_size: Size in bytes of the non-hashable tbl to cpy to local mem
> + * @nhash_local_addr: Addr in shared mem where non-hashable flt/rt tbl should
> + *  be copied to
> + * @rsvd: reserved
> + * @nhash_rules_addr: Addr in sys mem where non-hashable flt/rt tbl starts
> + */
> +struct ipa_imm_cmd_hw_ip_fltrt_init {
> +       u64 hash_rules_addr;
> +       u64 hash_rules_size     : 12,
> +           hash_local_addr     : 16,
> +           nhash_rules_size    : 12,
> +           nhash_local_addr    : 16,
> +           rsvd                : 8;
> +       u64 nhash_rules_addr;
> +};

In hardware structures, you should not use bit fields, as the ordering
of the bits is not well-defined in C. The only portable way to do this
is to use shifts and masks unfortunately.

> +struct ipa_imm_cmd_hw_hdr_init_local {
> +       u64 hdr_table_addr;
> +       u32 size_hdr_table      : 12,
> +           hdr_addr            : 16,
> +           rsvd                : 4;
> +};

I would also add a 'u32 pad' member at the end to make the padding
explicit here, or mark the first member as '__aligned(4) __packed'
if you want to avoid the padding.

> +void *ipahal_dma_shared_mem_write_pyld(struct ipa_dma_mem *mem, u32 offset)
> +{
> +       struct ipa_imm_cmd_hw_dma_shared_mem *data;
> +
> +       ipa_assert(mem->size < 1 << 16);        /* size is 16 bits wide */
> +       ipa_assert(offset < 1 << 16);           /* local_addr is 16 bits wide */
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return NULL;
> +
> +       data->size = mem->size;
> +       data->local_addr = offset;
> +       data->direction = 0;    /* 0 = write to IPA; 1 = read from IPA */
> +       data->skip_pipeline_clear = 0;
> +       data->pipeline_clear_options = IPAHAL_HPS_CLEAR;
> +       data->system_addr = mem->phys;
> +
> +       return data;
> +}

The 'void *' return looks odd here, and also the dynamic allocation.
It looks to me like all these functions could be better done the
other way round, basically putting the
ipa_imm_cmd_hw_dma_shared_mem etc structures on the stack
of the caller. At least for this one, the dynamic allocation
doesn't help at all because the caller is the same that
frees it again after the command. I suspect the same is
true for a lot of those commands.

       Arnd
