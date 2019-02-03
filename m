Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A6C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BDA2177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mjjGTTyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbfBCV0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 16:26:16 -0500
Received: from mail-eopbgr690115.outbound.protection.outlook.com ([40.107.69.115]:52160
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbfBCV0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 16:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDHCF20+7rl/2OwgI0bJrsk0Mv6/MccTdW11D0Dbf8I=;
 b=mjjGTTykVAdWfCDkRB9YDIlWX3O06TanQbxopZZb0pVOsvb9GqSpDnrz/HbtLxYwJQseccR/pkWHtu09+9ypK8urA0gOxFyyJC3w0SkmJpEYwtp7CqmzN4s72NvRn2V/OH+g4UGyMRUPqhAwuI1K1nWk0L2I0NTXzNeecDlnb20=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB0808.namprd21.prod.outlook.com (10.167.110.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.5; Sun, 3 Feb 2019 21:26:12 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781%9]) with mapi id 15.20.1622.000; Sun, 3 Feb 2019
 21:26:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        vkuznets <vkuznets@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH V2 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Thread-Topic: [PATCH V2 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Thread-Index: AQHUuvlTwPZ6bltwDU2xvCAU8RYxpqXOl3rw
Date:   Sun, 3 Feb 2019 21:26:11 +0000
Message-ID: <DM5PR2101MB091820B372812576837724CED76C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549113287-5606-2-git-send-email-Tianyu.Lan@microsoft.com>
In-Reply-To: <1549113287-5606-2-git-send-email-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-03T21:26:08.0309977Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3a2e98dd-1d43-442a-b22a-b86e63bd2231;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;6:OODiYD74pEJU3ba/p39f+UZnjTNBiN+fhdNX1MwSNmt7vUmH1r3wBADXM7kwqWvoIVh+AFdPA3ZULh5pl2PmheFMVMlydZRJGCy+FaOGaFYFl+l/yrViD8OKczau1JaiYyyolK4fcIHCIyWw002+BAYvvxuc7MPCh2vBGiOdRJkL1NMlcnRTdfhgD9Z7Bz+zgMlrhzPhNIn3CclnLqiQEWNpBnPfXK63WQ5UtJVvA2lgt00rCmYrlhdCheWZ6NrEtJkQ9xSEzou1yD33QuxTIOuTrlG1pP9qhqOHaD+UQFpUfzITXaUO+xpKsNRtWzSQVwK14KlMLwnfsY8CJZ5Di7KJV8hkgPgGy/swQI12SfCn5LwCpKaYefHrhpdnEWW62Hn8IREfZhAzDK2o3SP1BKqY5/0rCBiPwmqA4AUVl42FDxKecEu0nRUDBjG1U+ta7mhJ1E/hTfPd7ANbLJlRiw==;5:BM0c7NaAaET6rUqCgbZlsn8x6J4OfDJ3fvASq0cK/qryXA19oIw/C8j9Yf0ICctrys8lAn+5nO81DynPVK5a9tYMvfZN0FtdpapBQ8cle/qj4/5Id+DoanhyzQwMwjGwdyAe0dYcQof//dTvGu73HZyGol6/zL1KXiMe6hOP1dP2rMlhwU1zuIUpB2hlyUbl+rjh7YO2zJPxjQOCF+fNIQ==;7:DqJPmjlM9fJV5AFtY28YVd8qNMCT1MTlaE1GGHspX3TnVtEMs+NswqpoP3wPvgRqF/dBGKPb8LX2ed5gB9HmeglKVPtky6nHGO0CBwPX7D/IDCQsunPPp5Om9D8tDpwhn/7240Dl5wZcCPEUoBkzSQ==
x-ms-office365-filtering-correlation-id: 0693736a-94c3-48ba-c7fc-08d68a1e3877
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0808C98440A38679B2A4A0D9D76C0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(81156014)(81166006)(9686003)(68736007)(446003)(7416002)(55016002)(5640700003)(11346002)(10090500001)(8676002)(476003)(14454004)(2501003)(8936002)(305945005)(7736002)(478600001)(74316002)(97736004)(71190400001)(105586002)(8990500004)(486006)(106356001)(2906002)(71200400001)(2351001)(3846002)(6116002)(1411001)(99286004)(66066001)(26005)(6346003)(6506007)(186003)(54906003)(76176011)(102836004)(7696005)(1361003)(6436002)(22452003)(229853002)(6916009)(86612001)(86362001)(256004)(4326008)(10290500003)(33656002)(53936002)(6246003)(316002)(25786009)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0TXWn1wmRCLqLBWmIQXCgMovgwipeGiIEQKfKSf+a0JnrtEo25cdzMRw/DLi401cDpPpW5yoyeX/6W2RfDjU7N9RN3hKaxfdgilGPm+/dnkIAAwbj+qSqQaS5smFF85OEYvNjRzls1NMpZYHzHYcP/3pKpjGGJnlEauqU5xBpS9o0h5gd2NXk1kyjtUlRUuG04u29S2eDq7xNxyg69tJHLKTIW7hg8FpqnS4FDdTVGiAcrc2Y+DZRiNrXLMrkgqfAgKYwnGaiLtqlUGA/lxh9ohHSwe49GMbNGKcnkeAV7OQq3HnVHSDJA+TZHNtjDso+T+MEH1TB/vDdwoaduDaqBC/Drmdiwv6JS3dbjxPxhqYl1fjlXOdAZMDMMezIOlD8wWkmHQnaz4fejq7S747POnhazL+x2ajNix0Qucmikw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0693736a-94c3-48ba-c7fc-08d68a1e3877
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 21:26:11.9640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com>  Sent: Saturday, Fe=
bruary 2, 2019 5:15 AM
>=20
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.
>=20
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
>        - Remove redundant extern for x2apic_phys
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index e81a2db..4bd6d90 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -328,6 +328,16 @@ static void __init ms_hyperv_init_platform(void)
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
>  # endif
> +
> +/*
> + * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> + * set x2apic destination mode to physcial mode when x2apic is available
> + * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
> + * have 8-bit APIC id.
> + */

Per comment from Dan Carpenter on v1 of this patch, the above comment
block should be indented one tab to line up with the "if" statement below.

Michael

> +	if (IS_ENABLED(CONFIG_HYPERV_IOMMU) && x2apic_supported())
> +		x2apic_phys =3D 1;
> +
>  #endif
>  }
>=20
> --
> 2.7.4

