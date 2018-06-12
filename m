Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 855D6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2998E208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="b0wP3BQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2998E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeFLDtm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:49:42 -0400
Received: from mail-dm3nam03on0046.outbound.protection.outlook.com ([104.47.41.46]:18080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933182AbeFLDtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpzw/2jCTEvvTCvKMgv9Pa0yW19f9bW47AIcGvgfWzs=;
 b=b0wP3BQla7y+6IiMGEdIRPNhLp31ETyhzhH5Dh+NgnNaQ6jGBWsLce1fw5oj7Ve6mw5T3EkDc4PHcaOmb+y7cd3ffSqfTVqGRtxFwZGJpL5141bHPhhFNKPmMIv1UNk74iHvENMRipfSyqtgmUMI+c6nbTJj6uB5wXXMJPtT1Dw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4325.namprd05.prod.outlook.com (52.135.202.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.12; Tue, 12 Jun 2018 03:49:38 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%2]) with mapi id 15.20.0863.016; Tue, 12 Jun 2018
 03:49:38 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 6/9] x86: prevent inline distortion by paravirt ops
Thread-Topic: [PATCH v3 6/9] x86: prevent inline distortion by paravirt ops
Thread-Index: AQHUAQLqACZiCEpusUWZ3JiviOyuwKRarjWAgAFQh4A=
Date:   Tue, 12 Jun 2018 03:49:37 +0000
Message-ID: <E2A3A869-A6E7-475D-B05D-AE29431491FA@vmware.com>
References: <20180610141911.52948-1-namit@vmware.com>
 <20180610141911.52948-7-namit@vmware.com>
 <20180611074507.GP12258@hirez.programming.kicks-ass.net>
In-Reply-To: <20180611074507.GP12258@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4325;7:9bWlCyvQ+kNCe3B/k8hg2+FaWBrAkpVpi0MidruIcHY952gKer4v/HkPo8z4P43ba/Tv1bTPnq0zjeCCJUaHY36zopLpcj0Ofs0DutEe62W1EQWl1snLYTlRol77fuzSqIfhLWdAjUO/ZrIXIL7enpl+khjAb8v+WyYB6/cHFZ2rfx4Rh8eQNjU4kBsnjJmkNGo6Q+7uF4TbQJZNQtHc5Vh9AXA5fh1AnvLr+UasTb0xQ4HKDO+uz+eRfAVD8eDA;20:0SK86XGljXLVu8TjhjQp/VJHKSNZBzNIKYWwqc8EbyARLKhgYd9SNeb3vmygLOcW83/XfrCHJacWO9r4BKyliK7P4DWskR1etxVUaxibZxXPp0/XLQLMNMPDcj1CODG+YXMl/3wXErzKfbCoXiMDWuLdDGdsEjwlCdMAQ4vOnxg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4325;
x-ms-traffictypediagnostic: BYAPR05MB4325:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB4325C9739BEC0470EF244D2AD07F0@BYAPR05MB4325.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4325;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4325;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(366004)(396003)(189003)(199004)(6512007)(76176011)(102836004)(4326008)(305945005)(36756003)(99286004)(5660300001)(478600001)(3280700002)(3660700001)(6506007)(6916009)(6246003)(446003)(3846002)(26005)(2906002)(14454004)(11346002)(2616005)(86362001)(186003)(476003)(486006)(105586002)(106356001)(6116002)(81166006)(54906003)(97736004)(82746002)(68736007)(81156014)(8676002)(83716003)(6436002)(53936002)(66066001)(33656002)(7736002)(25786009)(229853002)(6486002)(316002)(8936002)(2900100001)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4325;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gof99B1zvJeIxwadZ6oj1X/Nm0Ryzl02otqHdaTy3Jiq4lS1qo9KO4UUVLMa6ayaOuMs21mdF+dJ1/DSuYkWKIIFxMQItgMd0znvKfjsC4ZiQQ0psecfwby2L3PffCY8EZrFHUwEuYHcnNdRoUH8ELbe4DAKyqUrgkJFfBWk5ftOHOQoJdWR9r/+yAdUYCK7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E965DBDB900FA40B0FE71DB2D532381@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9a505098-f2dd-4126-20c2-08d5d017853b
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a505098-f2dd-4126-20c2-08d5d017853b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 03:49:37.1331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 12:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Jun 10, 2018 at 07:19:08AM -0700, Nadav Amit wrote:
>> +/*
>> + * This generates an indirect call based on the operation type number.
>> + * The type number, computed in PARAVIRT_PATCH, is derived from the
>> + * offset into the paravirt_patch_template structure, and can therefore=
 be
>> + * freely converted back into a structure offset.
>> + */
>> +.macro PARAVIRT_ALT type:req clobber:req pv_opptr:req
>=20
> Unlike the marcro maze you replaced, this has the CALL hardcoded in. So
> maybe name this PARAVIRT_CALL instead of PARAVIRT_ALT ?

Sure. I will also merge the C macros of _paravirt_alt with paravirt_alt
and remove the former.


