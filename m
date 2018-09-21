Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E364DECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BAA21567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y4hgULPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BAA21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391307AbeIVAmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:42:08 -0400
Received: from mail-cys01nam02on0122.outbound.protection.outlook.com ([104.47.37.122]:39616
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391089AbeIVAmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFDzp3N+qhAygYoplrzxV8wViZd2WXdXsz4rFqVWDzc=;
 b=Y4hgULPcgSSJ+xM0fo6PR6R2AcCqf5Se5fcy91hl33rG7P6I1Co9wti6q3Ra5MWsl2nuazY5JB2E5m4aO0ywEfG40S9GXMVb7JNoFZuONNpzJAcP3Vk+Y7Yrl2+kTG7MIMjyO02VA9gZSjFf77+wWmzR4aQzClPp278mEH8BwOA=
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (10.173.200.7) by
 BN6PR21MB0115.namprd21.prod.outlook.com (10.173.199.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Fri, 21 Sep 2018 18:51:55 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 18:51:55 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC in
 the vSwitch
Thread-Topic: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC in
 the vSwitch
Thread-Index: AQHUUdoPKfeeW+WL/UOZ5UolOzJblaT7EbCA
Date:   Fri, 21 Sep 2018 18:51:54 +0000
Message-ID: <BN6PR21MB0161160A6A07055B24473327CA120@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
        <20180921182037.10077-2-haiyangz@linuxonhyperv.com>
 <20180921113620.62a004cb@xeon-e3>
In-Reply-To: <20180921113620.62a004cb@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-21T18:51:53.1039996Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0115;6:LYudV+f0nFP78kCzsSbkzo9GPWDnCFucLxNC7VZnnRToFTPg4mcuBci4uRViHcLdFkrnakKB+1Nph5VMuTN2H/ZZd0RvgyctBu6NBhkgqF4lXbuTSimdDaUD19oBTN0oVw/TbI5FYyHhKNI6JyTSdHvKnu2qkcmVA0wJV4OKypU83RwYbDEPwkTMs4Sl8GLA9FSQOY0xE2JRJYkBO18NCYTRahC/+/5ppPtuXTfhQQNIHUgyzHn4W/8C5KZ4N28fUMJnJCM4n6wZeSuj85FLAHabR0yjkv7YBbDkFDqZ3vt9jId52n3aRS80z3T0nYFQ7FYjaOH9gH5OlQ8gy/lSpR5NVyQReFiXSFpPk2QiGloaT/sVY5LUplf8hVet2MS01npPxwZsX11qNRqRmMMM2HwztJoVjB9jPpjjCYucP0/zC8KaHm4857ju3Vrzr1hTDYlOLINOarbFK0PSPOhBrw==;5:Jvv1uVe7IQ8vpUGDBtTfdt+q2k5lnxxlV8jxY92NMee+iGoLdQSbsHRPX1TBiNTKsj1UgBsVL6jnnvEJPHlDwWKEKAvuiAFXaKsPTxeI1/sbaOETFw4+wvUSXGQCaEOLNPWzQLdqHQ3PtcQ5TAhw9vZv9+/03ApjHF7gltHhE2c=;7:YN7VCMVGPiJob/jZUrt15A1Ecg3sqhwlIEPyEAF5W243f/UJfRIVoS9GICdMr92km1u5vbZkV4jTrI402OwhSEgkvNC/NXs/1CBY9rgOjwg0urlPDDUE5SGOdZUEQ8GsiaddV+GCskm8r3j38PQWTOGanE5c5hW+jW4Aq8RzpYz+oRFodOSLIiNOZ1ALM4eX6t4pDlTZsj9PaV/fmuaXuZsaZQ4kulbMk02dGLQD/RxPVRhNgfYidDB2QKCVctvu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 20320081-a9b7-424f-9d05-08d61ff34d1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0115;
x-ms-traffictypediagnostic: BN6PR21MB0115:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN6PR21MB0115441A90D6AD7D53C98BC7CA120@BN6PR21MB0115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149049)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:BN6PR21MB0115;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0115;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(13464003)(189003)(199004)(71190400001)(71200400001)(6116002)(105586002)(3846002)(25786009)(6436002)(33656002)(106356001)(9686003)(53936002)(86362001)(14454004)(74316002)(4326008)(86612001)(81156014)(81166006)(2906002)(305945005)(10290500003)(6246003)(8676002)(55016002)(7736002)(478600001)(54906003)(8936002)(186003)(53546011)(68736007)(5660300001)(10090500001)(99286004)(2900100001)(66066001)(229853002)(102836004)(6916009)(6506007)(11346002)(256004)(97736004)(22452003)(7696005)(486006)(476003)(316002)(6346003)(446003)(8990500004)(76176011)(5250100002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0115;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: LE6GO6yBNibDyPZ9Xk6me+hIy10yH1tq10p5EiROvpWLRvahn4HT5GGzIqlqO9vR2inR9n3LJHmvssnIkwTwYNRVPKkqt1VLf+Temn74oEaAPdpuCirSyCEpm32+/hzOf5yMJJ2xVOCyLkkFFTn9F9l0wwOW/9Xxs6OLHHD7s3BAvHvqdXZjWtBGE2Mu+ZKN9qPiF100ZITWQol9Lk4jMTGg6SKQUYBRrG20TCzjo6HArqujQ3ta0cOqdIRGnVLQQq5klveSFbd2fVlFgqDzYZZxXG3f/0biHxnQCKLuu7tQwlaTUZGiripcgw0RZXo4UYW+0JtQRUqPr14lNiiSzXzrENSDjS6GnhWYsfqXAPM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20320081-a9b7-424f-9d05-08d61ff34d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 18:51:54.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, September 21, 2018 2:37 PM
> To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> netdev@vger.kernel.org; olaf@aepfle.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; vkuznets <vkuznets@redhat.com>
> Subject: Re: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC=
 in
> the vSwitch
>=20
> On Fri, 21 Sep 2018 18:20:35 +0000
> Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
>=20
> Overall, this looks good. Some minor suggestions.
>=20
> > +struct nvsc_rsc {
> > +	const struct ndis_pkt_8021q_info *vlan;
> > +	const struct ndis_tcp_ip_checksum_info *csum_info;
> > +	u8 is_last; /* last RNDIS msg in a vmtransfer_page */
> > +	u32 cnt; /* #fragments in an RSC packet */
> > +	u32 pktlen; /* Full packet length */
> > +	void *data[NVSP_RSC_MAX];
> > +	u32 len[NVSP_RSC_MAX];
> > +};
> > +
>=20
> This new state structure is state on a per-channel basis.
> Do you really need this to be persistent across packets?
>=20
> Could this be on stack or do you need it to handle split packets arriving=
 in
> different polls? Or is the stack space a problem?
>=20
> Also, maybe data and length could be in one structure since they are rela=
ted.

The stack space is a problem. NVSP_RSC_MAX is 562, which is defined by host=
.
It will be too large for limited stack space.=20

struct nvsc_rsc includes the data, len, cnt, chksum, vlan for one RSC packe=
t. They
are all related to construction of one SKB and its meta data. So I put them=
 in
one structure.

Thanks,
- Haiyang

