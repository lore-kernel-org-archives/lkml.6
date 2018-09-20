Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C611821534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G6V0dGVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C611821534
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbeIUCmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:42:11 -0400
Received: from mail-eopbgr730137.outbound.protection.outlook.com ([40.107.73.137]:29122
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727771AbeIUCmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4lKQQ7Ht47k8pVHJ2PjXUM4iGjPDVrXfs1Zwi6lCvA=;
 b=G6V0dGVnJIj0Wv7p44uJE9hlvyFKVSaQ44pnKVvndVGv6iQ+iQtLECwCjcFtWkj3txiQbprlmKCT4F4mE/q4esBUVnqO/Ly3FPMH2GwEcQreS6iz0vk7qOEapSTACeDC3YrF60ZsbfBtU3uIXBg5p6uBYuWLeFYIrUx+OF6KfVA=
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (10.173.200.7) by
 BN6PR21MB0178.namprd21.prod.outlook.com (10.173.200.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 20:56:46 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a%4]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 20:56:46 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH net-next, 1/3] hv_netvsc: Add support for LRO/RSC in the
 vSwitch
Thread-Topic: [PATCH net-next, 1/3] hv_netvsc: Add support for LRO/RSC in the
 vSwitch
Thread-Index: AQHUUSM9Owl5YpspRUuNkf5RY00FcKT5pj+Q
Date:   Thu, 20 Sep 2018 20:56:46 +0000
Message-ID: <BN6PR21MB01614DCE1099980A7B1286FFCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180920170701.9574-1-haiyangz@linuxonhyperv.com>
        <20180920170701.9574-2-haiyangz@linuxonhyperv.com>
 <20180920134725.3e149a0b@xeon-e3>
In-Reply-To: <20180920134725.3e149a0b@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-20T20:56:44.4325329Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0178;6:22Cof0eSWRWhlfTT48anVHS2GMnxmDsFoFNCegRuDDxe3VZqM/JSV2Y0uyyQxgz8FOkl1zJqUUiG6iHfwTUuUzsY+siujffoaAU8wMxXQUjH4hVof1/N5k99AxwmKzhwHgODTSfP0ip2FCo265Tkviz4NJxqKo64JYnrN1ykYHEsyC+cROrwH93K8Je4/I9nLLUOWhvEBSlJyWSL2rb7LizA0Y/yrbx3+OwO+Wl8hDblJ8+a1ymp+Z53JSaSbqFqgS6DqZjeji3Z56gYiu2scbPdso8fgRwEeKCjNeAhpjwplfM5VTSJIp5QVPHSohA8mmdYOEHQ5arxaYl0TQRoObUo0heqGzTOG723grI2aVyOtbQXuYcLRQDtLlm7gSzB9NLX2IORMORLSe/UG97CmN0s02Yr2SQaZfg/VYUyFMQwKHpe3FiwKkuKKtHNGfw5C/i9UtG67ASmZOdfyWtTIw==;5:bbZm2IYK62szOVvzio2yAgnByokT7qs7sQ74nv74T4BIlxM1ZazCRS1C6U5+KBm+zgl0jtYvx7HszhRfnr7G5IgIqgKixNQIfgUWk/LtHDK0bZVyjat+xtF+07Vc5O/m09WXg73tCx59WsqEihg26d8cK8akCgjdy2s7hpQbsY4=;7:p1XFiJp7ep+KtPl6D1N8wpWuoF4mskAlhQHgj94NNruG/XilcoGKk7NwCXW69C5vmvRB/yujUSHKJz/IZS1meeVE8gO/rJFTSmp1HZd3PhppmyMm9NJXTa7igNAUFT6FSz1Vko8D/LoVmSSPNp+APLwU7G3F0+QW34flgcNgxOB61Np3wbbWhFyZVbES5oB3lfnX/0DIjJo81gt2H4R6/bAbGdVgk12HN3tgdJX51hp7vYi3XOscp+xPqQueGzCB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5e2ec6ee-7442-4709-5ea2-08d61f3b93cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0178;
x-ms-traffictypediagnostic: BN6PR21MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN6PR21MB0178B88D26961050BC7EF5D9CA130@BN6PR21MB0178.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:BN6PR21MB0178;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0178;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(376002)(346002)(13464003)(199004)(189003)(186003)(97736004)(26005)(229853002)(66066001)(25786009)(102836004)(8676002)(256004)(6346003)(81166006)(4326008)(2900100001)(54906003)(6436002)(81156014)(14454004)(11346002)(446003)(10090500001)(476003)(71190400001)(71200400001)(106356001)(105586002)(7696005)(6506007)(53546011)(33656002)(486006)(8936002)(5250100002)(68736007)(7736002)(6246003)(305945005)(5660300001)(10290500003)(76176011)(6916009)(99286004)(6116002)(3846002)(8990500004)(22452003)(53936002)(74316002)(2906002)(55016002)(316002)(86362001)(478600001)(86612001)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0178;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: e5ELSiqIOPN9kSsh4Vi0xNneiqfEpRp8O9+ct1735jg5RWSWGafzwhOrIZqSfQ6BLoZdkxOIme9YTFKcnNhjvUklCRbpRkHyHI/ArZB5txLlJbn2mlLuGi5/GF3F3b1BZACyhXjAArgU5gwhvvQKrPgDxpGux1Y55s91ixbqJDQxOJb1nucnxnTkwkjvA69bzeJKib3tWujJs5iXFpNHwM2XypGP0Gy7MW1qRkA64Ou5UO61mv3DmI27XE6yRZtyIJdlRIUstapndR6Zlfth7hUrwvQz7wi9B5pSwd98qP5cm3k4jnFoTEDj8ujK60SoD4oIuwG1Fqi2ZXsRGbvrXWzRLU+vRcgkRuKDr2WPGig=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2ec6ee-7442-4709-5ea2-08d61f3b93cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 20:56:46.1595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, September 20, 2018 4:48 PM
> To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> netdev@vger.kernel.org; olaf@aepfle.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; vkuznets <vkuznets@redhat.com>
> Subject: Re: [PATCH net-next, 1/3] hv_netvsc: Add support for LRO/RSC in =
the
> vSwitch
>=20
> On Thu, 20 Sep 2018 17:06:59 +0000
> Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
>=20
> > +static inline void rsc_add_data
> > +	(struct netvsc_channel *nvchan,
> > +	 const struct ndis_pkt_8021q_info *vlan,
> > +	 const struct ndis_tcp_ip_checksum_info *csum_info,
> > +	 void *data, u32 len)
> > +{
>=20
> Could this be changed to look more like a function and skip the inline.
> The compiler will end up inlining it anyway.
>=20
> static void rsc_add_data(struct netvsc_channel *nvchan,

How about this?
static inline
void rsc_add_data(struct netvsc_channel *nvchan,



