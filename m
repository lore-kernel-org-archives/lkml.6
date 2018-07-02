Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A62BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FA325B8A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHFKbZYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FA325B8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeGBIpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:45:43 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46827 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbeGBIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:45:39 -0400
Received: by mail-io0-f195.google.com with SMTP id p7-v6so1665615ioh.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MLqTGVMr81t/6rlNmBVApRztnXvLHWrIRmByS7RlnA=;
        b=mHFKbZYCi6mUqm9Juts9Csmny5N8OcAiVQIIv32SIRAxzm8atWX2G1pnyqcFAR+WNQ
         5Sj1jckrkGMDWgGFKV0Wt8xTaRXEU7KWFHqdS5EpNFXGz9aASa2RMpCtfJlI7pGEGF5k
         TqR39e8Lr801zO52QFwjySU33juE4UkCAfeGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MLqTGVMr81t/6rlNmBVApRztnXvLHWrIRmByS7RlnA=;
        b=VaI8yln4aYSESCM28ajUedLz/L2U+kDaXTHVpADhluixzSe+utXGpwHRWZloOQoPNz
         PQN1FqyhKSOL3TKI+nmtWSem5l76hHO6K9v7Jz965XfagGpyFL/V9sxxYthCp5a6FwMZ
         hqKK8yCghhNOh0B7XLQ5HfYwpRBR8abGhqZMXOVcHZrDe94tZGwn/2r039KMKKY2dnx8
         +dbPLyW6Vbz7VJlkGnoGe0TmTuU0NKE/Fw2HiZ29bcaiZulTsFI4Ah7V5t8rSdBE1SKa
         YXeBZwio6xcqey35bcQ4J7XPGgPFIXdaKCQ2TKnI4w4IgSBcIEOMgW26sLgtgmDDF2tP
         74Kw==
X-Gm-Message-State: APt69E1OYDLTbhdyCr8THPKKvxkvs4pPf1HmMwu0QFgqYQfft16+gtDw
        6cxxMcBZrMspA7yiLV1cRMHNj1bdddY=
X-Google-Smtp-Source: AAOMgpdA46BO0nXgnP8M/mQJYIc/SdvBaffN1Dez00oP/oLlvKWRNs2SdED6xPnUrcQBNp0fikmyHQ==
X-Received: by 2002:a6b:b010:: with SMTP id z16-v6mr20000405ioe.206.1530521138554;
        Mon, 02 Jul 2018 01:45:38 -0700 (PDT)
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com. [209.85.223.181])
        by smtp.gmail.com with ESMTPSA id b4-v6sm1897824ioh.79.2018.07.02.01.45.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:45:35 -0700 (PDT)
Received: by mail-io0-f181.google.com with SMTP id d185-v6so14045622ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:45:35 -0700 (PDT)
X-Received: by 2002:a6b:3b87:: with SMTP id i129-v6mr12367079ioa.86.1530521135269;
 Mon, 02 Jul 2018 01:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 2 Jul 2018 17:45:24 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXH7BpOXW++TxgsdRBr5C7PsHLO8jZtysGiNwUbkNW+BQ@mail.gmail.com>
Message-ID: <CAPBb6MXH7BpOXW++TxgsdRBr5C7PsHLO8jZtysGiNwUbkNW+BQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/27] Venus updates
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

Thanks for this very well organized series and sorry for not giving
feedback earlier.

I have tested this version against the 4.14 Chrome OS kernel tree (+ a
few extra changes to comply with the codec API) and it was working
flawlessly.

Therefore,

Tested-by: Alexandre Courbot <acourbot@chromium.org>

For the whole series.

I have a few comments/questions on some patches, would be great if you
could take a look. Also wondering what is your plan regarding codec
API compliance? Do you plan to integrate it into the current series,
or work on it after merging this initial work? Both ways would be ok
as far as I am concerned.

Cheers,
Alex.


On Thu, Jun 28, 2018 at 12:27 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi,
>
> Here is v4 with following changes:
>
> - fixed kbuild test robot in 12/27.
> - fixed destination of memcpy in fill_xxx functions.
>
> v3 can be found at https://lkml.org/lkml/2018/6/13/464
>
> regards,
> Stan
>
> Stanimir Varbanov (27):
>   venus: hfi_msgs: correct pointer increment
>   venus: hfi: preparation to support venus 4xx
>   venus: hfi: update sequence event to handle more properties
>   venus: hfi_cmds: add set_properties for 4xx version
>   venus: hfi: support session continue for 4xx version
>   venus: hfi: handle buffer output2 type as well
>   venus: hfi_venus: add halt AXI support for Venus 4xx
>   venus: hfi_venus: fix suspend function for venus 3xx versions
>   venus: hfi_venus: move set of default properties to core init
>   venus: hfi_venus: add suspend functionality for Venus 4xx
>   venus: core,helpers: add two more clocks found in Venus 4xx
>   venus: hfi_parser: add common capability parser
>   venus: helpers: rename a helper function and use buffer mode from caps
>   venus: helpers: add a helper function to set dynamic buffer mode
>   venus: helpers: add helper function to set actual buffer size
>   venus: core: delete not used buffer mode flags
>   venus: helpers: add buffer type argument to a helper
>   venus: helpers: add a new helper to set raw format
>   venus: helpers,vdec,venc: add helpers to set work mode and core usage
>   venus: helpers: extend set_num_bufs helper with one more argument
>   venus: helpers: add a helper to return opb buffer sizes
>   venus: vdec: get required input buffers as well
>   venus: vdec: a new function for output configuration
>   venus: helpers: move frame size calculations on common place
>   venus: implementing multi-stream support
>   venus: core: add sdm845 DT compatible and resource data
>   venus: add HEVC codec support
>
>  .../devicetree/bindings/media/qcom,venus.txt       |   1 +
>  drivers/media/platform/qcom/venus/Makefile         |   3 +-
>  drivers/media/platform/qcom/venus/core.c           | 107 ++++
>  drivers/media/platform/qcom/venus/core.h           | 100 ++--
>  drivers/media/platform/qcom/venus/helpers.c        | 555 +++++++++++++++++++--
>  drivers/media/platform/qcom/venus/helpers.h        |  23 +-
>  drivers/media/platform/qcom/venus/hfi.c            |  12 +-
>  drivers/media/platform/qcom/venus/hfi.h            |  10 +
>  drivers/media/platform/qcom/venus/hfi_cmds.c       |  62 ++-
>  drivers/media/platform/qcom/venus/hfi_helper.h     | 112 ++++-
>  drivers/media/platform/qcom/venus/hfi_msgs.c       | 399 +++------------
>  drivers/media/platform/qcom/venus/hfi_parser.c     | 278 +++++++++++
>  drivers/media/platform/qcom/venus/hfi_parser.h     |  45 ++
>  drivers/media/platform/qcom/venus/hfi_venus.c      | 109 +++-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |  10 +
>  drivers/media/platform/qcom/venus/vdec.c           | 326 +++++++-----
>  drivers/media/platform/qcom/venus/venc.c           | 220 ++++----
>  17 files changed, 1694 insertions(+), 678 deletions(-)
>  create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.c
>  create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.h
>
> --
> 2.14.1
>
