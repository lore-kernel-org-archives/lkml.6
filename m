Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2183C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE7E20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mJeWGg0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE7E20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeK0Gnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:43:35 -0500
Received: from mail-eopbgr770098.outbound.protection.outlook.com ([40.107.77.98]:62854
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbeK0Gne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHRTBRGgxVckjnBQSP7+9edSFJBtr6tA98GQq/IjRMk=;
 b=mJeWGg0cDhjEozMSYdfiA7hliVs6nUFtF+MvxUpgEUpK/A7H3yB/bgk7rWm9kY9xOhoar0CpvwXQzs6E7OtfjjAIvONoYACeo+V65i87XF9yH6rd5QFQ83bvgP9p++3hnRnQhceDitIcDoLeCd6US0WkrwJnWJ2VfKqHKIgxBzQ=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.2; Mon, 26 Nov 2018 19:47:41 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1404.002; Mon, 26 Nov 2018
 19:47:41 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@armm.com" <catalin.marinas@armm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Thread-Topic: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Thread-Index: AQHUghEmRPt7Kjul9E+Q8Cz+6wluT6VidjKAgAAFstA=
Date:   Mon, 26 Nov 2018 19:47:41 +0000
Message-ID: <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
 <20181126192101.GC32208@kroah.com>
In-Reply-To: <20181126192101.GC32208@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-26T19:47:39.9290359Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:ed00:bad5:da35:76f9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:maS7alnzMIqwgKKZAe/Y1Gr6Yvy6L6d7lxCsjE9hgBTBp4OrCsAicPfqcJO9SjPne7vreqV7CpWIDh95+PyCHClxTeW5d01MDxEg1GFcBYMidH0eMHGBJ1Xm5QHc5ntgjKepM++4L30Fjy5Ww/4XI16hPqAZF9jaKJHkz9C8SvF0mJK2d9JIUwmRXKmmuGufGP/rA+oBmbWXuq8iJgWQ9u7X4xvtHe5aN01GchKk0QuxxAHO4QNrjdQ/YuAZ0b9AOLvlNRy9I/EaVOjGNosf3sKQcfNWg9yvjhPheDPU0s2ggCpmyFkrMsB7XIRfNzUPfWc3tR6YJ+aAh2yt1+1Sz9aUDKVurejsMA2AAusV9yYaLLsMb6XFqEaBuKyvc2HO4eGyQIswa2Oe6GNZPd7YdPzJK8vuQXN3G/QsWwGwSZxjXsoj5gMqUuYh4pHmHVYScejmvX60lcvK9IQjUVcmUQ==;5:rrkA2ODmtgalskIQCNFaNAEPkn6ZBAsHeDWoHkPNGcFMFz3CAEfCTHRlNhSoO4l17ChefZvVscCct3JnZophDf/J0XILLezzTt0CNzcLO3Ejbw6jIF7dHmu+U0dHAogucrCw+qRmvRVOnxC055Fsc4A88f4sog54XZcSnhS5QaA=;7:aq60RL6GXPdkkGiafH+LJqOUMlXfA9YuOLx/7nmmaG7r9wg3E+/uFwqixI0kh3E9ymrQfDEuhdQYdJhAb0PNS2EGV9pQUPH+ZMLsinxV10D2KCkTN8oAmz50Kw2A85qyFkQsmaFX1iy470q9ksxqAQ==
x-ms-office365-filtering-correlation-id: 6a687e46-47f8-4e03-cfdc-08d653d80732
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB084027132D1A2129DD49F9B2D7D70@CY4PR21MB0840.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231443)(944501421)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(33656002)(86362001)(575784001)(6636002)(105586002)(6246003)(9686003)(55016002)(106356001)(11346002)(110136005)(446003)(68736007)(229853002)(8990500004)(53936002)(256004)(93886005)(10090500001)(10290500003)(305945005)(86612001)(7696005)(7416002)(76176011)(8676002)(486006)(74316002)(97736004)(99286004)(6116002)(25786009)(6506007)(81166006)(6436002)(81156014)(8936002)(102836004)(186003)(54906003)(4326008)(478600001)(71190400001)(71200400001)(1511001)(476003)(14454004)(46003)(7736002)(316002)(22452003)(5660300001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RYhE/HX/MeU6cA+6tDm/STtBYV/3aT3TVFVY+JZkh8W5hYcwN+rS2wPPaGbNjpWSQiAAc0KKnhOFWLDFDOJjEo/NJXVM4aZVKoWzb3zrNbqZMOxQYj6o4Y5XexYsELgJM99cBQOVWu4R+5tdcWXEHQNc25dG4xGUA7qsLqrzCrstJ3R+rHAsqqwpIKGGntWPDuOtIGz3kIg9TdGbFeC4L8tUqU8SGmC7ft1/czDLoRe8B2miW6Oq9q+nRD8dr/G1606sh6hAA0uDWv2xiMNIlJN5Wq2s3bQHbxvtq8vITis0u51mMT5k1u19yV9NLTgzOJ7THISRnyfPKgdlHsfnRYuCuNlhX6n/UeUOO620X8w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a687e46-47f8-4e03-cfdc-08d653d80732
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 19:47:41.7414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org>  Monday, November 26, 2018 11:21=
 AM

> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/msh=
yperv.h
> > index 0d6271cce198..8d97bd3a13a6 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -109,6 +109,10 @@ void hyperv_vector_handler(struct pt_regs *regs);
> >  void hv_setup_vmbus_irq(void (*handler)(void));
> >  void hv_remove_vmbus_irq(void);
> >
> > +/* On x86/x64, there isn't a real IRQ to be enabled/disable */
> > +static inline void hv_enable_vmbus_irq(void) {}
> > +static inline void hv_disable_vmbus_irq(void) {}
> > +
> >  void hv_setup_kexec_handler(void (*handler)(void));
> >  void hv_remove_kexec_handler(void);
> >  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > index 166c2501de17..d0bb09a4bd73 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -307,6 +307,7 @@ int hv_synic_init(unsigned int cpu)
> >  	hv_set_siefp(siefp.as_uint64);
> >
> >  	/* Setup the shared SINT. */
> > +	hv_enable_vmbus_irq();
> >  	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> >
> >  	shared_sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> > @@ -434,6 +435,7 @@ int hv_synic_cleanup(unsigned int cpu)
> >  	/* Disable the global synic bit */
> >  	sctrl.enable =3D 0;
> >  	hv_set_synic_state(sctrl.as_uint64);
> > +	hv_disable_vmbus_irq();
> >
> >  	return 0;
> >  }
> > --
> > 2.19.1
>=20
> You created "null" hooks that do nothing, for no one in this patch
> series, why?
>=20

hv_enable_vmbus_irq() and hv_disable_vmbus_irq() have non-null
implementations in the ARM64 code in patch 2 of this series.  The
implementations are in the new file arch/arm64/hyperv/mshyperv.c.
Or am I misunderstanding your point?

Michael

