Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73839C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0788220841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UE60Fptv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0788220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbeHAHbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:31:03 -0400
Received: from mail-dm3nam03on0111.outbound.protection.outlook.com ([104.47.41.111]:25952
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731897AbeHAHbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEAIA+O7gQtGqmiha3KA0FjBWk8qGKjimSz8XhP87Ps=;
 b=UE60FptveKSEvJO0L6VnCnzmScYp3RqqfxQw1B29oZou4FeuPJ3PlTNwWKs5KMZcDguOUu0opvDi/c3MlO4e9zb+9JFgjZkAPbiiTOD3OHcq01cvgt98kIjMxbejCNalrh6faTsKJlF8TRG+tBl6UD4IUx6qhPcy+Se80VmSUJ0=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0789.namprd21.prod.outlook.com (10.175.121.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.2; Wed, 1 Aug 2018 05:47:08 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f%7]) with mapi id 15.20.1038.003; Wed, 1 Aug 2018
 05:47:08 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "mhkelley58@gmail.com" <mhkelley58@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH char-misc 1/1] Drivers: hv: vmbus: Make synic_initialized
 flag per-cpu
Thread-Topic: [PATCH char-misc 1/1] Drivers: hv: vmbus: Make synic_initialized
 flag per-cpu
Thread-Index: AQHUKHxDlEyTLKiml0qH4U3EvoNZ3KSpL9oigAEw2VA=
Date:   Wed, 1 Aug 2018 05:47:08 +0000
Message-ID: <CY4PR21MB0773EFCF6EA21CF8F9CE01E0DC2D0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1533004484-3937-1-git-send-email-mikelley@microsoft.com>
 <87ftzzodnv.fsf@vitty.brq.redhat.com>
In-Reply-To: <87ftzzodnv.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-01T05:47:06.6205788Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0789;6:C3FpiohrHFDZl0ep/fRnFRXaBDAl4JxSucqMAP2TvYmR6KKaVmqaJgA7Pg7pUtNMsY6whtz7+Kl6YlDrnIyD15LYHSOG4ueE5AHIoXfNABdMFS01wUmuZWIcdfXWa3uUPYEvN6/jDovAxggF8ilTp3TzqUROlknfvXZhq3/BKTlRj1bUprPrswdp17RZXUcjSaRH7Mi8yF1GOb447hGSBRe3Qm+neJ7D9pouWX1bRD3yEhHFciLHqTFahk0nekU41IjCKJH5YVYjbdkTfUYDm7RXpuqTXa8jp9t1VKZcCZJnNwJhs/PPfRIw4u2BHqmCEL24TZcujpjKWrHJ5dMWYTQmblhTb7AQqTTSW6oqdRZTjVsreVcfkh5X39ZTWF/j2SlKK+GQMJlV/yJhywCOxr/qx+PVBwQUr9kMgyDuuIJNHytd/2Cp694VYvcv55nGokUVtDo2ugZgw/anTbWY4w==;5:keSnWMYP0d2zfAvNtblV16s3PRsTzk+TAw1vELK39MC1cs4RD9a8DkkfBHrbO6QRmrwzr/nTrvm/jPR76fxbgqVVu3or0YXXlGssldFTJyGzSoh35iuLm47n4Vgjq+vvIIU0rvVKKlg0P9M3sd3P3Visr2qvCQyAUbegFKj+1WI=;7:WUx6jIcu/r6N10ey0e8ExYtOytIf/ra7UIDh22a/ZO697e5N+X8ziMvZknNRJY5L5TwgbmiQoOaoszyxQulw8CT3zGc4HKJbS6FUDuqWtylQcSiv8Mj+fjPtTNeqkjwtg1S8FWD3AIy1ydndIP9xd3k20/v4v2w5UVQp5f9hez17MUv1A/U6wwQ938IpTzz24jERUtmH3Gs5ysiSXJOsJ7nkR/TgMgevxCeM+uIoW6jdI9wv+WsKDKULwGjWxrFj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 63381333-1a0a-49c0-c326-08d5f772382f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:CY4PR21MB0789;
x-ms-traffictypediagnostic: CY4PR21MB0789:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB078949F3A0500FCA4A2250ACDC2D0@CY4PR21MB0789.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR21MB0789;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0789;
x-forefront-prvs: 0751474A44
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(51914003)(33656002)(26005)(66066001)(105586002)(10290500003)(54906003)(486006)(22452003)(68736007)(110136005)(99286004)(102836004)(76176011)(11346002)(476003)(10090500001)(7696005)(25786009)(2906002)(478600001)(4326008)(14454004)(8990500004)(229853002)(39060400002)(446003)(81166006)(6506007)(316002)(53936002)(97736004)(72206003)(86362001)(74316002)(2900100001)(81156014)(8676002)(2501003)(5250100002)(186003)(8936002)(256004)(5660300001)(6116002)(3846002)(7736002)(305945005)(55016002)(106356001)(6246003)(107886003)(6436002)(9686003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0789;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cCMgf5LXOErxIMkDxBr55xEU8ie5/NC0ZP5R4WDdw0kxju4NmJZT4GZvYdhGbN6iwo18Cc8GrMiby/X5K2KcrMPG50onIA0orQewmF19F72kEwDv7tQ3xu5W8WYO1I+m4SIGUWTlxgbDVcSL8k+i5z757lBHqnAVlYHCL14Xl81kG5t3pxVgL9P55q3LvGy5YDjqlPJ+hZrahqTDCYPuiZc1hzhUJxVUt4rqqopelnKF2KifiInb8Oj9VQ4YuAGzXKYxblu8u3G1/s6wll5N6AoPGtXIqmsekEpLKxvZWAUhXqAoeRR4JDb2iLbS4mROResGlIQ5DbyG/7D1xQz0d3m7QVJ3DZTv1TAQqDddKNA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63381333-1a0a-49c0-c326-08d5f772382f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2018 05:47:08.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0789
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, July 31, 2018 4=
:20 AM
>=20
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks for the review

>=20
> Alternatively, we can get rid of synic_initialized flag altogether:
> hv_synic_init() never fails in the first place but we can always
> implement something like:
>=20
> int hv_synic_is_initialized(void) {
> 	union hv_synic_scontrol sctrl;
>=20
> 	hv_get_synic_state(sctrl.as_uint64);
>=20
> 	return sctrl.enable;
> }
>=20
> as it doesn't seem that we need to check synic state on _other_ CPUs.
>=20
> --
>   Vitaly

I was trying to decide if there are any arguments in favor of one
approach vs. the other:  a per-cpu flag in memory or checking
the synic_control "enable" bit.   Seems like a wash to me, in which
case I have a slight preference for the per-cpu flag in memory vs.
creating another function to return sctrl.enable.  But I'm completely
open to reasons why checking sctrl.enable is better.

Michael

