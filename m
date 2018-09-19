Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5711ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CD1208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="FCbRaEj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD1208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbeITARG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:17:06 -0400
Received: from mail-eopbgr690103.outbound.protection.outlook.com ([40.107.69.103]:31760
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731253AbeITARG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHCsh66YniOySGu0ZjvLeXkqlVocWtzBA1KHPa9Illw=;
 b=FCbRaEj0HGwO2Gtvn10R/0V8/6BvIuKT8EH3JGAf+vlohlnqX8RZCIxtuI+PUXjpCQekwAEkMNVLcMvDed3yclC8IqIgsViWFfnMGSfhoYROkBGBLqAXAtmpTxx8LVUVzHXemYAFSe609NwE690PzPSOpsW+oZfsCnR1paAk1Bw=
Received: from SN1PR0101MB1567.prod.exchangelabs.com (10.163.128.25) by
 SN1PR0101MB1487.prod.exchangelabs.com (10.163.128.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 18:37:48 +0000
Received: from SN1PR0101MB1567.prod.exchangelabs.com
 ([fe80::c445:3e01:80ab:a944]) by SN1PR0101MB1567.prod.exchangelabs.com
 ([fe80::c445:3e01:80ab:a944%2]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 18:37:47 +0000
From:   Hoan Tran <hoan.tran@amperecomputing.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Will Deacon <will.deacon@arm.com>,
        Loc Ho <loc.ho@amperecomputing.com>,
        Khuong Dinh <khuong.dinh@amperecomputing.com>,
        Tai Nguyen <ttnguyen@amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: xgene: Add CPU hotplug support
Thread-Topic: [PATCH] perf: xgene: Add CPU hotplug support
Thread-Index: AQHUNMY/3L/cBXIgnE6YXsz8+aMzWqTrW6gAgAzKeoA=
Date:   Wed, 19 Sep 2018 18:37:47 +0000
Message-ID: <5BBDA14E-2D6B-47B1-AEE9-7450FE54AA4C@amperecomputing.com>
References: <1534357895-19031-1-git-send-email-hoan.tran@amperecomputing.com>
 <20180911151749.3vvvgovguuyyugma@lakrids.cambridge.arm.com>
In-Reply-To: <20180911151749.3vvvgovguuyyugma@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan.tran@amperecomputing.com; 
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR0101MB1487;6:1ifpppOvt0VjNMflgJGbPH2dG9q5Z91VTIHMikGawQ6GgqYgtQ/mzzxDdpDSc3Bhh1YtNnzO9LpulA5cUZsjB9JSSfAmfYITWU1kNvPgGO/wHNry1Xd4ZkjBEUSezwzmnHRTGHeIbgQnojOxrHgv/E2txs3c7/XDCJxY6P+6U/95Qb8iLaQsrzVJRBjjIaPQ5t7vXqeOAU23c+O9Kfx7bVbGWQtYKibUyLSQBvoGsRwf44osqlUE643Z+KqiWRVe7W5ulufrg/ix9WGk0KCX2YldCvbSCW7SGDEAiATPDMU6/QcTYckcVkSEt+UauVNjf987XGLdPS1VK9oZYKuhz1j5V+l7Rgmuc3t+kW7JbkCn4refRdyK07mYprDh5HiiJeb1ixO0fcLqGczuz/Y7z7xTFL7vH+1eAxtlcmc2r14O9bWyh3r9zFrg3VpiYkaBD9Op8sG2CgRQBE90UR3iSQ==;5:+nwdYfOnGwCPoEsY6mvqmW8dJB6APwq3CHfW0D/EneIffLsVbRLfpjggo9Z+QBv7/+wDis5+COMnQ9DmJw+Zk7jIToz06DK7ZRk3locWnXNvCFxGiSX8Su4nOBSJ6NRekg87Kx90oZqRWlOSz1uC8UwMhfB1iszLniV4S1K17hs=;7:sB4Wo+EJ2PmkSPtzinHVpyXju4KObW/HAGu9YF4Gy3mhD9cpzPa0n1HV71tgiejF4KqJVkQfUKl1nc7iDIvu5mg9T6OvXBmCY/kmeUFf2wzYZvor7gDmW7LV6l3yFnJfO4JKOq8EwoV+KwdRDOtO5ZKDGseyoDwjpRI1HQoLUEgccepwMIkC6HsPLRj07yfnBYdnpU/+La2cOCZW9MqPShfBrzeDpWdqFrr8YYji0xOoz2XUy4qJshlK9o5D02ok
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39850400004)(199004)(189003)(54906003)(8936002)(305945005)(99286004)(2906002)(76176011)(66066001)(53936002)(8676002)(3846002)(6916009)(86362001)(25786009)(6116002)(102836004)(68736007)(81166006)(316002)(14454004)(81156014)(478600001)(36756003)(5660300001)(6506007)(5250100002)(4326008)(33656002)(2900100001)(446003)(6246003)(2616005)(476003)(44832011)(11346002)(53546011)(486006)(26005)(6436002)(97736004)(83716003)(7736002)(6512007)(106356001)(256004)(82746002)(105586002)(229853002)(186003)(14444005)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR0101MB1487;H:SN1PR0101MB1567.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 57073c18-251f-47cc-cba8-08d61e5eff25
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0101MB1487;
x-ms-traffictypediagnostic: SN1PR0101MB1487:
x-microsoft-antispam-prvs: <SN1PR0101MB1487C5601968E674B2F6DD8BE41C0@SN1PR0101MB1487.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:SN1PR0101MB1487;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0101MB1487;
x-forefront-prvs: 0800C0C167
received-spf: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: Sf55BsQCeXCBFK09xEMtqSfBGCGzoWyyTzqUBMR/RXq/j90RuGCrxixsl4lA3PStGOalZ2VUGyPEP5/F+d0ntKxrrJ/+QNOyVwHKHc6IglwF+18vjZAoLls14X9YiZmRcppsyC4vn3aUGk/1XG6YRi9KEglovy5zX05SciAizfFqoaObh1SzzIIM0MxpYcPGUJhVilrVFEH637zqkrPRwgUncMiEgvK2/e3ZgingSiiu3CkLqImk7T1S9kGYhiOpzKS3/kICDt3ccvjQ55znqLXQH4Z7NUe5RkWEYwgD2MKrHCyvs9R5AQGr4jG67E7nn1EbOi4BT+vnb4W5g8oxqg13kMOB/wsVJvzLSobcWqw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DA912E9A9E4064CBBFA119166CA7352@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57073c18-251f-47cc-cba8-08d61e5eff25
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 18:37:47.4538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0101MB1487
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> On Sep 11, 2018, at 8:17 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>=20
> [NOTICE: This email originated from an external sender. Please be mindful=
 of safe email handling and proprietary information protection practices.] =
___________________________________________________________________________=
_____________________________________________
>=20
> On Wed, Aug 15, 2018 at 11:31:35AM -0700, Hoan Tran wrote:
>> This patch adds CPU hotplug support where the PMU migrates the context t=
o
>> another online CPU when its CPU is offline.
>>=20
>> It fixes the below issue where the user does offline the CPU which is as=
signed
>> to this PMU.
>>=20
>> Assuming, CPU0 is assigned for this PMU. When the user does offline CPU0
>>        [root@(none) ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
>> This PMU does not work anymore and shows the below error.
>>        [root@(none) ~]# perf stat -a -e l3c0/cycle-count/,l3c0/write/ sl=
eep 1
>>        Error:
>>        The sys_perf_event_open() syscall returned with 19 (No such devic=
e) for event (l3c0/cycle-count/).
>>        /bin/dmesg may provide additional information.
>>        No CONFIG_PERF_EVENTS=3Dy kernel support configured?
>>=20
>> With this patch, when CPU0 is offline, PMU migrates to another online CP=
U and
>> works on that CPU.
>>=20
>> Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
>> ---
>> drivers/perf/xgene_pmu.c   | 71 ++++++++++++++++++++++++++++++++++++++++=
++----
>> include/linux/cpuhotplug.h |  1 +
>> 2 files changed, 66 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
>> index 0e31f13..248a3f7 100644
>> --- a/drivers/perf/xgene_pmu.c
>> +++ b/drivers/perf/xgene_pmu.c
>> @@ -21,6 +21,7 @@
>>=20
>> #include <linux/acpi.h>
>> #include <linux/clk.h>
>> +#include <linux/cpuhotplug.h>
>> #include <linux/cpumask.h>
>> #include <linux/interrupt.h>
>> #include <linux/io.h>
>> @@ -130,12 +131,14 @@ struct xgene_pmu_ops {
>>=20
>> struct xgene_pmu {
>>        struct device *dev;
>> +       struct hlist_node node;
>>        int version;
>>        void __iomem *pcppmu_csr;
>>        u32 mcb_active_mask;
>>        u32 mc_active_mask;
>>        u32 l3c_active_mask;
>>        cpumask_t cpu;
>> +       int irq;
>>        raw_spinlock_t lock;
>>        const struct xgene_pmu_ops *ops;
>>        struct list_head l3cpmus;
>> @@ -1806,6 +1809,53 @@ static const struct acpi_device_id xgene_pmu_acpi=
_match[] =3D {
>> MODULE_DEVICE_TABLE(acpi, xgene_pmu_acpi_match);
>> #endif
>>=20
>> +static int xgene_pmu_online_cpu(unsigned int cpu, struct hlist_node *no=
de)
>> +{
>> +       struct xgene_pmu *xgene_pmu =3D hlist_entry_safe(node, struct xg=
ene_pmu,
>> +                                                      node);
>> +
>> +       if (cpumask_empty(&xgene_pmu->cpu))
>> +               cpumask_set_cpu(cpu, &xgene_pmu->cpu);
>> +
>> +       /* Overflow interrupt also should use the same CPU */
>> +       WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
>> +
>> +       return 0;
>> +}
>> +
>> +static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *n=
ode)
>> +{
>> +       struct xgene_pmu *xgene_pmu =3D hlist_entry_safe(node, struct xg=
ene_pmu,
>> +                                                      node);
>> +       struct xgene_pmu_dev_ctx *ctx;
>> +       unsigned int target;
>> +
>> +       if (!cpumask_test_and_clear_cpu(cpu, &xgene_pmu->cpu))
>> +               return 0;
>> +       target =3D cpumask_any_but(cpu_online_mask, cpu);
>> +       if (target >=3D nr_cpu_ids)
>> +               return 0;
>> +
>> +       list_for_each_entry(ctx, &xgene_pmu->mcpmus, next) {
>> +               perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target=
);
>> +       }
>> +       list_for_each_entry(ctx, &xgene_pmu->mcbpmus, next) {
>> +               perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target=
);
>> +       }
>> +       list_for_each_entry(ctx, &xgene_pmu->l3cpmus, next) {
>> +               perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target=
);
>> +       }
>> +       list_for_each_entry(ctx, &xgene_pmu->iobpmus, next) {
>> +               perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target=
);
>> +       }
>> +
>> +       cpumask_set_cpu(target, &xgene_pmu->cpu);
>> +       /* Overflow interrupt also should use the same CPU */
>> +       WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
>> +
>> +       return 0;
>> +}
>> +
>> static int xgene_pmu_probe(struct platform_device *pdev)
>> {
>>        const struct xgene_pmu_data *dev_data;
>> @@ -1815,6 +1865,14 @@ static int xgene_pmu_probe(struct platform_device=
 *pdev)
>>        int irq, rc;
>>        int version;
>>=20
>> +       /* Install a hook to update the reader CPU in case it goes offli=
ne */
>> +       rc =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_XGENE_ONLINE,
>> +                                     "CPUHP_AP_PERF_XGENE_ONLINE",
>> +                                     xgene_pmu_online_cpu,
>> +                                     xgene_pmu_offline_cpu);
>> +       if (rc)
>> +               return rc;
>> +
>>        xgene_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*xgene_pmu), GFP_KE=
RNEL);
>>        if (!xgene_pmu)
>>                return -ENOMEM;
>> @@ -1865,6 +1923,7 @@ static int xgene_pmu_probe(struct platform_device =
*pdev)
>>                dev_err(&pdev->dev, "No IRQ resource\n");
>>                return -EINVAL;
>>        }
>> +
>>        rc =3D devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
>>                                IRQF_NOBALANCING | IRQF_NO_THREAD,
>>                                dev_name(&pdev->dev), xgene_pmu);
>> @@ -1873,6 +1932,8 @@ static int xgene_pmu_probe(struct platform_device =
*pdev)
>>                return rc;
>>        }
>>=20
>> +       xgene_pmu->irq =3D irq;
>> +
>>        raw_spin_lock_init(&xgene_pmu->lock);
>>=20
>>        /* Check for active MCBs and MCUs */
>> @@ -1883,13 +1944,11 @@ static int xgene_pmu_probe(struct platform_devic=
e *pdev)
>>                xgene_pmu->mc_active_mask =3D 0x1;
>>        }
>>=20
>> -       /* Pick one core to use for cpumask attributes */
>> -       cpumask_set_cpu(smp_processor_id(), &xgene_pmu->cpu);
>> -
>> -       /* Make sure that the overflow interrupt is handled by this CPU =
*/
>> -       rc =3D irq_set_affinity(irq, &xgene_pmu->cpu);
>> +       /* Add this instance to the list used by the hotplug callback */
>> +       rc =3D cpuhp_state_add_instance(CPUHP_AP_PERF_XGENE_ONLINE,
>> +                                     &xgene_pmu->node);
>>        if (rc) {
>> -               dev_err(&pdev->dev, "Failed to set interrupt affinity!\n=
");
>> +               dev_err(&pdev->dev, "Error %d registering hotplug", rc);
>>                return rc;
>>        }
>=20
> You also need to remove the cpuhp instances when unregistering the PMUs
> in xgene_pmu_dev_cleanup().

Yes, I'll fix it.

Thanks and Regards
Hoan

>=20
> Otherwise this looks fine to me, on the assumption the system PMU is
> accessible from all CPUs in the system (e.g. it's not lcoal to a socket
> or anything like that).
>=20
> Thanks,
> Mark.

