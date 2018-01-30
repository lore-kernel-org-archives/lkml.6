Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeA3NZs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:25:48 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39625 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeA3NZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:25:46 -0500
X-Google-Smtp-Source: AH8x224Vk32x+Ph1hAi/fcTGsuWtLJCA5DXPqJy5yyZDkcRobTmFACVQ2lNj7YVChTu7mcelCQ90TPNqZho4qfB0ino=
MIME-Version: 1.0
In-Reply-To: <e804928d-deb9-668a-7012-2843ba85285e@st.com>
References: <a2a6bf12-529c-cb20-c69f-106d34e1204a@st.com> <e804928d-deb9-668a-7012-2843ba85285e@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jan 2018 14:25:45 +0100
X-Google-Sender-Auth: e-hE4AN6y6FZKBL2Hf3U4MD0ZUE
Message-ID: <CAK8P3a36Kqh-qscU0vsKH00ReXKk8HOYzzhbt6SxAoEBvPYuig@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Compilation_error_report_for=3A_drivers=2Ffirmware=2Fq?=
        =?UTF-8?Q?com=5Fscm=2Ec=3A469=3A47=3A_error=3A_passing_argument_3_of_=E2=80=98dma=5Falloc=5F?=
        =?UTF-8?Q?coherent=E2=80=99_from_incompatible_pointer_type?=
To: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc: Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "Andy Gross <andy.gross@linaro.org> , David Brown"
        <david.brown@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:11 AM, Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
> On 01/12/2018 05:11 PM, Arnaud Pouliquen wrote:
>> Hello Andy,David,
> + Arnd
>
> I have the same issue on drm-misc-next.
> Does Arnaud's fix make sense or should we update/change the way of how
> we compile the kernel ?

We've hit a couple of bugs with qcom drivers confusing physical addresses
and DMA addresses in the past, usually the drivers were buggy in
some form, and tried to use dma_alloc_coherent() to get a buffer
that gets passed into a firmware interface taking a physical address,
which is of course completely wrong.

>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index af4c752..8dfbe61 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -448,7 +448,7 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t
>> mem_sz,
>>       struct qcom_scm_mem_map_info *mem_to_map;
>>       phys_addr_t mem_to_map_phys;
>>       phys_addr_t dest_phys;
>> -     phys_addr_t ptr_phys;
>> +     dma_addr_t ptr_phys;
>>       size_t mem_to_map_sz;
>>       size_t dest_sz;
>>       size_t src_sz;

This would be bad: you can basically never have a 'dma_addr_t ptr_phys': it can
be exactly one of 'dma address',  'physical address' or a pointer,
this claims that the
struct member is all three of them.

The proper fix here is to stop using dma_alloc_coherent.

     Arnd
