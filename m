Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935FF20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+l5Frrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935FF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeLDGCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:02:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40083 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeLDGCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:02:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so14087577oth.7;
        Mon, 03 Dec 2018 22:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qENavGeNdHRdZWiHMMywSIpwAWCHoygMUGrnlY6JJqQ=;
        b=T+l5Frrjeu4mMsyfTSSNKmNwHAUkYr42CVL1+6caCRPDlTA2Xpp72pE0DvzHrei4Zh
         fsLvujAQNBVTmIW9QeKQxyb8tvEcQQDEwKmpePQRgwlQb5d5RJQQ/ibBIGCF7MvbdLR9
         Xhg6gtRK0w281S7rdXIS2hvVnV0TYjRPknw7Gzco3KbqBfdjnBOTfjlEPweg1cerbX5E
         onv3/K/9ZgR+7HNHIjPs5HFjqNlbRYcytl3JeyJY/VWPdoHdQK+gPV+xqynM1y2jjwp4
         GmTrgeDZi8N0d0sJFGRn71A0QBginBC1Ivnv/QQDFmXG11snNRklAzZqMuxIdEOVGovu
         QR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qENavGeNdHRdZWiHMMywSIpwAWCHoygMUGrnlY6JJqQ=;
        b=hEqm6xpw4INz+DNFoe2msseFdn9AxWp/1AFqhOkihnUGrpUAk33ZzZQe5rdWRvwuGg
         0IyuGmmHYDOS8Dna5Fan/plXX092c6ztAeP1PjtFsUJPdUVYCLzNRTPbLlEBImeI95jx
         3KhomZmNLeaj7FoljNEWrgonfyAfAE1ChiLkNAyt4ffVZEbS32Po1HeKqY9Xepab6CZu
         hbwv95Ozsne8kGFaJ1bqpdwTdvN+krdkdXRbhRYZeGIO9wYbBIiRICZfY9i6yU4c83RB
         ibJydjh9bSxq1sIsA1ncakQEnjKGB1jtDp20TzkKvVjQZuRYOHmPNyiauUBHU4PQJZ/Z
         /3ng==
X-Gm-Message-State: AA+aEWby9BFLevSDiFpL4Vm+X+SKPmW2nRKqQbS+XG6TVFdKjPXSy39x
        T6aB6QhIYjApQL8pwZtId+2tTip2XIq28rKmWDs=
X-Google-Smtp-Source: AFSGD/U4ziTgMukjj2XYbngscdJjnJXJvrsmdaxAS9qGt/DpuSe+EjsUER4jQ8k29Dr4KxswXj9GjIIugmrpX3A4bSA=
X-Received: by 2002:a9d:8e4:: with SMTP id 91mr11553670otf.169.1543903360992;
 Mon, 03 Dec 2018 22:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20181122030354.13570-1-ganapatrao.kulkarni@cavium.com>
 <20181122030354.13570-3-ganapatrao.kulkarni@cavium.com> <20181203121128.GC24824@arm.com>
In-Reply-To: <20181203121128.GC24824@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 4 Dec 2018 11:32:29 +0530
Message-ID: <CAKTKpr7uSdrMrzVG5rHzmYSF6hKuP+R=ag9DqrbzSNNWQ_OyKA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE
 PMU driver
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, suzuki.poulose@arm.com,
        Randy Dunlap <rdunlap@infradead.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:41 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Nov 22, 2018 at 03:04:35AM +0000, Kulkarni, Ganapatrao wrote:
> > This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
> > Controller(DMC) and Level 3 Cache(L3C). Each PMU supports up to 4
> > counters. All counters lack overflow interrupt and are
> > sampled periodically.
> >
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> >  drivers/perf/Kconfig         |   9 +
> >  drivers/perf/Makefile        |   1 +
> >  drivers/perf/thunderx2_pmu.c | 869 +++++++++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h   |   1 +
> >  4 files changed, 880 insertions(+)
> >  create mode 100644 drivers/perf/thunderx2_pmu.c
> >
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 08ebaf7cca8b..af9bc178495d 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -87,6 +87,15 @@ config QCOM_L3_PMU
> >          Adds the L3 cache PMU into the perf events subsystem for
> >          monitoring L3 cache events.
> >
> > +config THUNDERX2_PMU
> > +     tristate "Cavium ThunderX2 SoC PMU UNCORE"
> > +     depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
> > +     default m
> > +     help
> > +        Provides support for ThunderX2 UNCORE events.
> > +        The SoC has PMU support in its L3 cache controller (L3C) and
> > +        in the DDR4 Memory Controller (DMC).
> > +
> >  config XGENE_PMU
> >          depends on ARCH_XGENE
> >          bool "APM X-Gene SoC PMU"
> > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > index b3902bd37d53..909f27fd9db3 100644
> > --- a/drivers/perf/Makefile
> > +++ b/drivers/perf/Makefile
> > @@ -7,5 +7,6 @@ obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
> >  obj-$(CONFIG_HISI_PMU) += hisilicon/
> >  obj-$(CONFIG_QCOM_L2_PMU)    += qcom_l2_pmu.o
> >  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
> > +obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
> >  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
> >  obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
> > diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> > new file mode 100644
> > index 000000000000..e6509ba868ab
> > --- /dev/null
> > +++ b/drivers/perf/thunderx2_pmu.c
> > @@ -0,0 +1,869 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * CAVIUM THUNDERX2 SoC PMU UNCORE
> > + * Copyright (C) 2018 Cavium Inc.
> > + * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/cpuhotplug.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* Each ThunderX2(TX2) Socket has a L3C and DMC UNCORE PMU device.
> > + * Each UNCORE PMU device consists of 4 independent programmable counters.
> > + * Counters are 32 bit and do not support overflow interrupt,
> > + * they need to be sampled before overflow(i.e, at every 2 seconds).
> > + */
> > +
> > +#define TX2_PMU_MAX_COUNTERS         4
> > +#define TX2_PMU_DMC_CHANNELS         8
> > +#define TX2_PMU_L3_TILES             16
> > +
> > +#define TX2_PMU_HRTIMER_INTERVAL     (2 * NSEC_PER_SEC)
> > +#define GET_EVENTID(ev)                      ((ev->hw.config) & 0x1ff)
>
> I think this should be 0x1f.

yes it should be, i will update it.
>
> > +#define GET_COUNTERID(ev)            ((ev->hw.idx) & 0x3)
> > + /* 1 byte per counter(4 counters).
> > +  * Event id is encoded in bits [5:1] of a byte,
> > +  */
> > +#define DMC_EVENT_CFG(idx, val)              ((val) << (((idx) * 8) + 1))
> > +
> > +#define L3C_COUNTER_CTL                      0xA8
> > +#define L3C_COUNTER_DATA             0xAC
> > +#define DMC_COUNTER_CTL                      0x234
> > +#define DMC_COUNTER_DATA             0x240
> > +
> > +/* L3C event IDs */
> > +#define L3_EVENT_READ_REQ            0xD
> > +#define L3_EVENT_WRITEBACK_REQ               0xE
> > +#define L3_EVENT_INV_N_WRITE_REQ     0xF
> > +#define L3_EVENT_INV_REQ             0x10
> > +#define L3_EVENT_EVICT_REQ           0x13
> > +#define L3_EVENT_INV_N_WRITE_HIT     0x14
> > +#define L3_EVENT_INV_HIT             0x15
> > +#define L3_EVENT_READ_HIT            0x17
> > +#define L3_EVENT_MAX                 0x18
> > +
> > +/* DMC event IDs */
> > +#define DMC_EVENT_COUNT_CYCLES               0x1
> > +#define DMC_EVENT_WRITE_TXNS         0xB
> > +#define DMC_EVENT_DATA_TRANSFERS     0xD
> > +#define DMC_EVENT_READ_TXNS          0xF
> > +#define DMC_EVENT_MAX                        0x10
> > +
> > +enum tx2_uncore_type {
> > +     PMU_TYPE_L3C,
> > +     PMU_TYPE_DMC,
> > +     PMU_TYPE_INVALID,
> > +};
> > +
> > +/*
> > + * pmu on each socket has 2 uncore devices(dmc and l3c),
> > + * each device has 4 counters.
> > + */
> > +struct tx2_uncore_pmu {
> > +     struct hlist_node hpnode;
> > +     struct list_head  entry;
> > +     struct pmu pmu;
> > +     char *name;
> > +     int node;
> > +     int cpu;
> > +     u32    max_counters;
> > +     u32    prorate_factor;
> > +     u32    max_events;
> > +     u64 hrtimer_interval;
> > +     void __iomem *base;
> > +     DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
> > +     struct perf_event *events[TX2_PMU_MAX_COUNTERS];
> > +     struct device *dev;
> > +     struct hrtimer hrtimer;
> > +     const struct attribute_group **attr_groups;
> > +     enum tx2_uncore_type type;
> > +     void    (*init_cntr_base)(struct perf_event *event,
> > +                     struct tx2_uncore_pmu *tx2_pmu);
> > +     void    (*stop_event)(struct perf_event *event);
> > +     void    (*start_event)(struct perf_event *event, int flags);
> > +};
> > +
> > +static LIST_HEAD(tx2_pmus);
> > +
> > +static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
> > +{
> > +     return container_of(pmu, struct tx2_uncore_pmu, pmu);
> > +}
> > +
> > +/*
> > + * sysfs format attributes
> > + */
> > +static ssize_t tx2_pmu_format_show(struct device *dev,
> > +                                  struct device_attribute *attr, char *buf)
> > +{
> > +     struct dev_ext_attribute *eattr;
> > +
> > +     eattr = container_of(attr, struct dev_ext_attribute, attr);
> > +     return sprintf(buf, "%s\n", (char *) eattr->var);
> > +}
> > +
> > +#define FORMAT_ATTR(_name, _config) \
> > +     (&((struct dev_ext_attribute[]) { \
> > +        { \
> > +        .attr = __ATTR(_name, 0444, tx2_pmu_format_show, NULL), \
> > +        .var = (void *) _config, \
> > +        } \
> > +     })[0].attr.attr)
> > +
> > +static struct attribute *l3c_pmu_format_attrs[] = {
> > +     FORMAT_ATTR(event,      "config:0-4"),
> > +     NULL,
> > +};
> > +
> > +static struct attribute *dmc_pmu_format_attrs[] = {
> > +     FORMAT_ATTR(event,      "config:0-4"),
> > +     NULL,
> > +};
>
> We have PMU_FORMAT_ATTR, PMU_EVENT_ATTR etc in the core code to help here.
> Please try to use them.

ok, i will try to use it.
>
> > +static const struct attribute_group l3c_pmu_format_attr_group = {
> > +     .name = "format",
> > +     .attrs = l3c_pmu_format_attrs,
> > +};
> > +
> > +static const struct attribute_group dmc_pmu_format_attr_group = {
> > +     .name = "format",
> > +     .attrs = dmc_pmu_format_attrs,
> > +};
> > +
> > +/*
> > + * sysfs event attributes
> > + */
> > +static ssize_t tx2_pmu_event_show(struct device *dev,
> > +                                 struct device_attribute *attr, char *buf)
> > +{
> > +     struct dev_ext_attribute *eattr;
> > +
> > +     eattr = container_of(attr, struct dev_ext_attribute, attr);
> > +     return sprintf(buf, "config=0x%lx\n", (unsigned long) eattr->var);
> > +}
>
> Shouldn't this be "event=" instead of "config="?

yep, thanks
>
> Will

Thanks,
Ganapat
