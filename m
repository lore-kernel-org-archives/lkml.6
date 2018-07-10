Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D9DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DE7208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D9RZecRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE7208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbeGJTij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:38:39 -0400
Received: from mail-eopbgr700107.outbound.protection.outlook.com ([40.107.70.107]:57709
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732769AbeGJTij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcr04q/DJ0qoC7qhUYFX0D/ngpf+pHDZ1wB3l11vJ7k=;
 b=D9RZecRGO4UBrBJKWEWXDV1aMbI46d9YkQ+mowsg55Vb46nI/noykSejiUzGu582hwFs6s3kPbygiuZEbWP/K/3iiHacZ0jAu8GM1PM4AQ0qfeD22zhaE+jKTIWvNkh4UAOhwmOUD8cIiZhx7AuGCNYvKbg464OV2GtTuJ25z3k=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB1021.namprd21.prod.outlook.com (52.132.116.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Tue, 10 Jul 2018 19:38:07 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0952.017; Tue, 10 Jul 2018
 19:38:06 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/hyper-v: check cpumask_to_vpset() return value in
 hyperv_flush_tlb_others_ex()
Thread-Topic: [PATCH 1/2] x86/hyper-v: check cpumask_to_vpset() return value
 in hyperv_flush_tlb_others_ex()
Thread-Index: AQHUF6vosM6nFUt8gk6AuQep2ov9fqSI2vpw
Date:   Tue, 10 Jul 2018 19:38:06 +0000
Message-ID: <SN6PR2101MB1120785831C2538C2C0D93DDDC5B0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180709174012.17429-1-vkuznets@redhat.com>
 <20180709174012.17429-2-vkuznets@redhat.com>
In-Reply-To: <20180709174012.17429-2-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-10T19:38:05.4134573Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1021;7:65aAfdp6hnIfrDRa1s6n+sZLA3KJY7mfLPi+vDYXyirvlM2TJt4xzoexYE0sqrcLEt1ScgHcXzyJioeOEmfTdjaudYAq+oNENRw7kxqtgu3yMy+OCpRJkR+h1yLg5HoCtwprLlq4vg/BGwyYIBJt3c67bNTQHvduxaqgThCFvUaVfm1sB29SyYsVU0+S+KzVY3aGi48EkSmwFZOiLjv218ezq0UTpIOjytpGFxI0Pb/qMJhE7TQpRI/nHVctBIwl
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 55d6040c-329e-44ce-62ef-08d5e69ca926
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB1021;
x-ms-traffictypediagnostic: SN6PR2101MB1021:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB10216209AACB2104A80273B0DC5B0@SN6PR2101MB1021.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1021;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1021;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(5250100002)(97736004)(6506007)(2501003)(81166006)(8676002)(81156014)(72206003)(76176011)(5660300001)(74316002)(7696005)(7736002)(106356001)(105586002)(54906003)(110136005)(33656002)(55016002)(478600001)(4326008)(14454004)(486006)(2900100001)(305945005)(10290500003)(25786009)(476003)(10090500001)(6436002)(99286004)(6246003)(11346002)(86362001)(256004)(3846002)(6116002)(2906002)(186003)(8936002)(446003)(8990500004)(22452003)(68736007)(66066001)(102836004)(575784001)(53936002)(86612001)(316002)(229853002)(9686003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1021;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 06SNM+3IJQGeTtetFwNZdqpii+FDDK4PPlHjTkoIPRIdsW6zsTXlxJWMkbA2+rt/YE0lzAZW+XgQOnS5wNQdneRVsQJRVIlmenA3XPnG4r9CYswPl4TiO5hd6xHel62erzFWeCpCgPm28psaIslSBPWzoexr1qwoUGVb77VHIaVnBWfFC7icc9KbCQcOi2iDzIfjTl6+E7DiSzVbQe3XlpkEGNNjKoY2SXQ/Pfvx9jVKA5rPtm5IcburAeLatEK/KqvRNyHEYm3AdZRiEJvlU94vFHGA3y20OfIJCOOr1Lv9qYQJBJWsAcujkhtjcOBHw9kPF1cpa6TOKnFANdgicIcWTfXlel97qfG/jAbuKN8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d6040c-329e-44ce-62ef-08d5e69ca926
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 19:38:06.8514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Monday, July 9, 2018 10:40 AM
> Commit 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI
> enlightenment") made cpumask_to_vpset() return '-1' when there is a CPU
> with unknown VP index in the supplied set. This needs to be checked befor=
e
> we pass 'nr_bank' to hypercall.
>=20
> Fixes: 1268ed0c474a ("x86/hyper-v: Fix the circular dependency in IPI enl=
ightenment")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/mmu.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
