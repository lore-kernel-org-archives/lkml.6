Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF0EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92EC2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dAtjhdVJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cKm9bUpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92EC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJEALk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:11:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727489AbeJEALj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:11:39 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w94GlSlW032553;
        Thu, 4 Oct 2018 09:55:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=o6xM4lsaqbktWmwTvIO1+BF2LfK5pTP5fJO38BP1j70=;
 b=dAtjhdVJ+Hv3rpzRLK+XsV0CTkysDrqkRX6ZEA7G2jtspIL/9+o68Gd1I3UZMXntWV0e
 7hOEoHXK8lV8epk9vAYzQL/ms1+iB6T9hvISBo5J9uovrrPQr0rCz5scjHQEXVf+7N17
 qN5109I2Dk2t0YDcRfFD/g47bZs14XDNdyk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2mwm7qgnm1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 04 Oct 2018 09:55:51 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 4 Oct 2018 12:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6xM4lsaqbktWmwTvIO1+BF2LfK5pTP5fJO38BP1j70=;
 b=cKm9bUpJD9UsFw5Fil4CGTbXLB8nRQbfbg29Ve8vixNKCyTtS2EZYwP5tilViHmvNejdrLHY3bA0cfpqr0RGhpdBwVDVI0gP8FSwjBaW0QhAjPsn9/A96dFnK3NG0+OBLABAyJWi19Wl7dA6QDiJpImQxKdAfqw+DVFxsIxs7/s=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1630.namprd15.prod.outlook.com (10.175.135.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 16:55:47 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%7]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 16:55:47 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Thread-Topic: [PATCH v2 RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Thread-Index: AQHUWhH2tpGAaY0zAUyTv+cG3phqRKULmxMAgAO2+QA=
Date:   Thu, 4 Oct 2018 16:55:47 +0000
Message-ID: <7B4458A1-20B3-4BDE-9DCF-5E87EBD2D485@fb.com>
References: <20181002053636.1896903-1-songliubraving@fb.com>
 <20181002081206.GS3439@hirez.programming.kicks-ass.net>
In-Reply-To: <20181002081206.GS3439@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::7:e269]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1630;20:vNEgHIxD/njzWxow7Y5A2GCq9NKet8iSHJ/bOjEv00DuJK2yIaPY/A9Gsrx3ff1bBa0h7t7Cb1xFDLrcPklpRO192Bk8i36cXWhGeXYyD3z6VmcEhAGB0uSrO4xYFRt2bVzqANdfSdhr/2r5G59a5D9Zwnmv+SZJ/j48wM76Pms=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7183b3e1-6aeb-425b-a84a-08d62a1a3b87
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1630;
x-ms-traffictypediagnostic: MWHPR15MB1630:
x-microsoft-antispam-prvs: <MWHPR15MB1630D3E8FC37C49B86B12FB4B3EA0@MWHPR15MB1630.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302088)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991048);SRVR:MWHPR15MB1630;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1630;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(102836004)(8936002)(71190400001)(105586002)(83716004)(106356001)(50226002)(486006)(86362001)(11346002)(305945005)(6116002)(71200400001)(2616005)(25786009)(186003)(46003)(6246003)(14454004)(4326008)(478600001)(7736002)(476003)(33656002)(2906002)(256004)(76176011)(446003)(99286004)(6512007)(6436002)(229853002)(68736007)(53936002)(5250100002)(5660300001)(81166006)(316002)(8676002)(54906003)(36756003)(53546011)(6916009)(81156014)(57306001)(6486002)(6506007)(97736004)(2900100001)(82746002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1630;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lSIDcArtyF8Dolv5F+yd+5YkJrJMthCjx66JAbTIJ5lQhOyeubQjSbOd4/dKbKR42VxGnLym8Qe0RZIoZ/97ZDJTDFxFZVUDQYS0SnNKDQYnSACg51h6aQbSzQr0TGUsIB0x8qVqr38G6BP3sonIVliBleD15Q/9wrIEgYR4teeIcZ4iLvs1FHp2XamHfSWgrS/8hSNz9KFzj6FAYcQcQ7yAG7qgt8lkRWsuZW43XVP8pCzjXVxy32S0aefi/8HU5jKX3rTTIcOYUMi7Xz3OPG7DCtPMN7HAPMxY/7BzhFNlIILaHmt/ByFcfHfzlJSaUhcYWorFlj1w4T2aWDaD31irv3KcoimQRPPfH1yFNws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5B2E4858291E64781662D8EB2D69518@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7183b3e1-6aeb-425b-a84a-08d62a1a3b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:55:47.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 2, 2018, at 1:12 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Mon, Oct 01, 2018 at 10:36:36PM -0700, Song Liu wrote:
>> Changes v1 -> v2: Fix PMU_FORMAT_ATTR as Peter suggested
>>=20
>> This patch enables uprobes with reference counter in fd-based uprobe.
>> Highest 32 bits of perf_event_attr.config is used to stored offset
>> of the reference count (semaphore).
>>=20
>> Format information in /sys/bus/event_source/devices/uprobe/format/ is
>> updated to reflect this new feature.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>=20
> Works for me,
>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks Peter!

Steven, could you please test/apply this?=20

Best,
Song
