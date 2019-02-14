Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E112C21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbfBNXRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:17:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46753 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfBNXRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:17:15 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 9063745e333a071e; Fri, 15 Feb 2019 00:17:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, gcherianv@gmail.com,
        Prashanth Prakash <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 2/2] cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
Date:   Fri, 15 Feb 2019 00:15:52 +0100
Message-ID: <2813657.1l3PCoQO4Z@aspire.rjw.lan>
In-Reply-To: <86a1eddc-01aa-f32a-9bef-c18c7649149b@huawei.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com> <CAJZ5v0j03Dj7XSbTNcu7Ew2SekdpTw2hrWT_L+5ZcdRUep7ppw@mail.gmail.com> <86a1eddc-01aa-f32a-9bef-c18c7649149b@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 14, 2019 2:58:21 PM CET Xiongfeng Wang wrote:
> 
> On 2019/2/14 18:58, Rafael J. Wysocki wrote:
> > On Thu, Feb 14, 2019 at 8:46 AM Xiongfeng Wang
> > <wangxiongfeng2@huawei.com> wrote:
> >>
> >> Hisilicon chips do not support delivered performance counter register
> >> and reference performance counter register. But the platform can
> >> calculate the real performance using its own method. This patch provide
> >> a workaround for this problem, and other platforms can also use this
> >> workaround framework. We reuse the desired performance register to
> >> store the real performance calculated by the platform. After the
> >> platform finished the frequency adjust, it gets the real performance and
> >> writes it into desired performance register. OS can use it to calculate
> >> the real frequency.
> >>
> >> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> >> ---
> >>  drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 70 insertions(+)
> >>
> >> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> >> index fd25c21c..da96fec 100644
> >> --- a/drivers/cpufreq/cppc_cpufreq.c
> >> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >> @@ -33,6 +33,16 @@
> >>  /* Offest in the DMI processor structure for the max frequency */
> >>  #define DMI_PROCESSOR_MAX_SPEED  0x14
> >>
> >> +struct cppc_workaround_info {
> >> +       char oem_id[ACPI_OEM_ID_SIZE +1];
> >> +       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> >> +       u32 oem_revision;
> >> +       unsigned int (*get_rate)(unsigned int cpu);
> >> +};
> >> +
> >> +/* CPPC workaround for get_rate callback */
> >> +unsigned int (*cppc_wa_get_rate)(unsigned int cpu);
> >> +
> > 
> > First off, please don't split the workaround material into two parts.
> > IOW, the other new function added below can go here just fine IMO.
> > 
> >>  /*
> >>   * These structs contain information parsed from per CPU
> >>   * ACPI _CPC structures.
> >> @@ -334,6 +344,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> >>         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> >>         int ret;
> >>
> >> +       if (cppc_wa_get_rate)
> >> +               return cppc_wa_get_rate(cpunum);
> > 
> > Second, what is the value of using the function pointer above?
> > 
> > All we need for now is a flag to indicate whether or not to call
> > hisi_cppc_cpufreq_get_rate() here and return its return value.
> 
> How about adding a pointer of 'struct cppc_workaround_info' to indicate whether we have
> found a matches workaround ?
> If I use a flag, I will need another variable to indicate which item of the workaround array 'wa_info'
> to use.

And why do you need to distinguish one of them from the other?

