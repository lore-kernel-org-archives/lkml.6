Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67873C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CEB21925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222957;
	bh=a8MbaBKu0rX6XxW0KQbdoakQm2FdhPnepPgSBDG6EQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ulP+sXfWy9LYreMG6v/7BSmqjjEQtH1FjCdA4lS/+P4EWJ8bv/OgjJYSUEFIEbPwo
	 fDbzceZTlO8OwldPq3A7wQFILk9GDrj4a/mm5Me9uIGA429mrixOTE6cUklFAqZLE7
	 xNRp1FJdUctpURXc6P5UAS0+KQXQcrO/ZyW9OpHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbfBOJ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:29:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44939 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfBOJ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:29:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id g1so15412729otj.11;
        Fri, 15 Feb 2019 01:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8tA+v4DHuLgHd2qBpIvd5GSFyL9ogPdxe9sV1h9WYQ=;
        b=Smua/vCVD6bOZKXvbfGoJYiH0tpDFxYOh5hc0+6MkAYHmifpjJBNcQSqwaOP6au5wb
         34BU2h4GFPebJN8itIsOuzO8pqIPXlAw13F7KKjjNP5NOUETgi1Bs6JMO7LmgqaD/dar
         jIjyVYG2YEW/EX9tmFbkVaEqG1FG51Kj36xzE5eEc/nWcklX48oeE4kJFkCPIJRvt69G
         cEGeXQ6XAC+McsS41Jw5gik4kMv4h/IXthBz8vbfSHe8Gvy+knaXaoNxrL34YbGl+iz/
         Dc6IzzDZQpE2rrH8dLV+uRtR+v/Zq35uzgJ0OCls86shMJBP7nQ4R2GEBOcuOHdJLOip
         egog==
X-Gm-Message-State: AHQUAubZeLVzr+rkrB5Ty3LHpmL5fURAvuvXvziIsZOxW4Q4SdarUxD9
        fL90svQ4pBmP+vNcB5En0TFWuzmcEEbNbfoEfVA=
X-Google-Smtp-Source: AHgI3IZtm2RHD/1/zl9+h3xLGdESvY0cmuc19ynHVRlCX/2IMjOKQjItNjDC0c+bFRKhbxIAoFEyRkEHFlofwgdxr9o=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr5235838oih.178.1550222948853;
 Fri, 15 Feb 2019 01:29:08 -0800 (PST)
MIME-Version: 1.0
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAJZ5v0j03Dj7XSbTNcu7Ew2SekdpTw2hrWT_L+5ZcdRUep7ppw@mail.gmail.com>
 <86a1eddc-01aa-f32a-9bef-c18c7649149b@huawei.com> <2813657.1l3PCoQO4Z@aspire.rjw.lan>
 <8baf1617-6037-2645-bc8a-a6dcf8f7f53b@huawei.com>
In-Reply-To: <8baf1617-6037-2645-bc8a-a6dcf8f7f53b@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Feb 2019 10:28:56 +0100
Message-ID: <CAJZ5v0g0mVP_mzpTbHzGYavdbL8UbaXbYsqgEftOMnBEE22Xvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, gcherianv@gmail.com,
        Prashanth Prakash <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 2:25 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
>
>
> On 2019/2/15 7:15, Rafael J. Wysocki wrote:
> > On Thursday, February 14, 2019 2:58:21 PM CET Xiongfeng Wang wrote:
> >>
> >> On 2019/2/14 18:58, Rafael J. Wysocki wrote:
> >>> On Thu, Feb 14, 2019 at 8:46 AM Xiongfeng Wang
> >>> <wangxiongfeng2@huawei.com> wrote:
> >>>>
> >>>> Hisilicon chips do not support delivered performance counter register
> >>>> and reference performance counter register. But the platform can
> >>>> calculate the real performance using its own method. This patch provide
> >>>> a workaround for this problem, and other platforms can also use this
> >>>> workaround framework. We reuse the desired performance register to
> >>>> store the real performance calculated by the platform. After the
> >>>> platform finished the frequency adjust, it gets the real performance and
> >>>> writes it into desired performance register. OS can use it to calculate
> >>>> the real frequency.
> >>>>
> >>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> >>>> ---
> >>>>  drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 70 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> >>>> index fd25c21c..da96fec 100644
> >>>> --- a/drivers/cpufreq/cppc_cpufreq.c
> >>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >>>> @@ -33,6 +33,16 @@
> >>>>  /* Offest in the DMI processor structure for the max frequency */
> >>>>  #define DMI_PROCESSOR_MAX_SPEED  0x14
> >>>>
> >>>> +struct cppc_workaround_info {
> >>>> +       char oem_id[ACPI_OEM_ID_SIZE +1];
> >>>> +       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> >>>> +       u32 oem_revision;
> >>>> +       unsigned int (*get_rate)(unsigned int cpu);
> >>>> +};
> >>>> +
> >>>> +/* CPPC workaround for get_rate callback */
> >>>> +unsigned int (*cppc_wa_get_rate)(unsigned int cpu);
> >>>> +
> >>>
> >>> First off, please don't split the workaround material into two parts.
> >>> IOW, the other new function added below can go here just fine IMO.
> >>>
> >>>>  /*
> >>>>   * These structs contain information parsed from per CPU
> >>>>   * ACPI _CPC structures.
> >>>> @@ -334,6 +344,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> >>>>         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> >>>>         int ret;
> >>>>
> >>>> +       if (cppc_wa_get_rate)
> >>>> +               return cppc_wa_get_rate(cpunum);
> >>>
> >>> Second, what is the value of using the function pointer above?
> >>>
> >>> All we need for now is a flag to indicate whether or not to call
> >>> hisi_cppc_cpufreq_get_rate() here and return its return value.
> >>
> >> How about adding a pointer of 'struct cppc_workaround_info' to indicate whether we have
> >> found a matches workaround ?
> >> If I use a flag, I will need another variable to indicate which item of the workaround array 'wa_info'
> >> to use.
> >
> > And why do you need to distinguish one of them from the other?
> >
>
> I was thinking about future extension. Different platform may have different implementation
> of 'get_rate' in the future.

That's right, but whoever adds this in the future may change the
driver accordingly.  They will have to make changes to it anyway.
