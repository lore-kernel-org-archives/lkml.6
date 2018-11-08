Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2166AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A143A2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="H5fnqZ4u";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="C8xi4qdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A143A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeKIE0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:26:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbeKIE0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:26:49 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8IjLkX026807;
        Thu, 8 Nov 2018 10:49:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=16gXqHzJuyr6/HELn8zCXqhzzrf9vjz6WzIuzvF6MVk=;
 b=H5fnqZ4uc+GFRUE4PZcK3G7nGyp2MSNobbvxG9R2cOZZlGZMrr2A+SvmafwhKv/BEohB
 F/Q2+emSIK2xJWicQRbpATYYndR/npRrLCc2q2V4kfIVD8oTFLM6aDXBwTjdcj4RvP1r
 dJGhWY5bC7jECJSpco6nUpPqVnrze0faLw0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nmq3drtve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Nov 2018 10:49:24 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 8 Nov 2018 10:49:23 -0800
Received: from PRN-CHUB14.TheFacebook.com (2620:10d:c081:35::23) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Thu, 8 Nov 2018 10:49:23 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 8 Nov 2018 10:49:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16gXqHzJuyr6/HELn8zCXqhzzrf9vjz6WzIuzvF6MVk=;
 b=C8xi4qdtf2VeGUhVj0MsQRUuIwSkQrLviYnRmVy3w9pm5roJwO0+K3fgujqYPRtYhKCvTAIu+kuAlVlWvvllibJvxt/BctOo5MT83IcICdq0xRT0NAAJD30ASBBloFUTVVWWvbrceYSdqMj/3gfy3PDGZYDxj/MggGhEkZRj/+g=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1213.namprd15.prod.outlook.com (10.175.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.32; Thu, 8 Nov 2018 18:49:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4cd7:6768:136d:7a8b%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 18:49:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     David Ahern <dsahern@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Topic: [RFC perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Thread-Index: AQHUdhLRNu0EDS9AC0KZ+9MuHYh4daVD/w6AgACjMoCAAVksAIAAM3wAgAAF/wCAAAZ1AA==
Date:   Thu, 8 Nov 2018 18:49:19 +0000
Message-ID: <050ABAC6-6C3B-4B6B-BB68-727127E00B51@fb.com>
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-2-songliubraving@fb.com>
 <20181107084057.GG9781@hirez.programming.kicks-ass.net>
 <31067290-4B66-4AA1-8027-607397BC0264@fb.com>
 <20181108150028.GU9761@hirez.programming.kicks-ass.net>
 <C858C862-E523-4CE8-AB39-CC9B27BE2538@fb.com>
 <d5043aae-69b0-fd49-e82a-5a13834a3f32@gmail.com>
In-Reply-To: <d5043aae-69b0-fd49-e82a-5a13834a3f32@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:200::7:4fb8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1213;20:Kzv0u2XdA8ehZp4QbmqMsrZmjV8BD14x6ggg2grH7SCpaVFrli8tgIn9I9ug4LD8emg5NIQgFsP3yzKIdHAiwVtytnsVQ+l/xG2lhk9HBdHRoQ2g9rqTRfhbCGf11Wo9e9MNUGYpU5PurJwYwwo14y1VekenbYBJlj0t4XVM3+g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0cd1e35d-ea79-46a2-7b8b-08d645aae447
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1213;
x-ms-traffictypediagnostic: MWHPR15MB1213:
x-microsoft-antispam-prvs: <MWHPR15MB12135D98AF1034BB858A0E2DB3C50@MWHPR15MB1213.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1213;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1213;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(51444003)(1411001)(93886005)(36756003)(25786009)(105586002)(2906002)(106356001)(82746002)(478600001)(97736004)(86362001)(33656002)(6116002)(54906003)(57306001)(446003)(316002)(4326008)(5660300001)(14454004)(46003)(6436002)(6486002)(186003)(6512007)(256004)(50226002)(8676002)(305945005)(7736002)(81166006)(81156014)(8936002)(2616005)(6246003)(476003)(68736007)(486006)(2900100001)(11346002)(39060400002)(53936002)(102836004)(53546011)(6506007)(6916009)(83716004)(71190400001)(76176011)(99286004)(71200400001)(229853002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1213;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NA/4UqD6ChqCfcnrhp6PyhfDehRAlc70jeGzzaC4+dM8jVRy1/I2qwKJL5ObKxyu6fWhidN9W+FJJa2HlK1+RwHKs9wyuwx5WNUpOPqnBGmrXAOga00xjz9aiJfrkdMDt9sdhfG8U58AMHiYpwBM/K8vo/1XAyFgKlpghLdFZOFqHb2/UVHtCP6FBIYuYrfy2StPukrBPy0aHvuEegbm4Lnh04kMkBI85YqYSdcwXun2hFfMdSezgLmXWPyjxkSk5FIVRCdTSs3cbIb/oW0e+1B6Va/T28DWmwL9h3wlUmQI79gYIfDz3OBnidHFFKl5SdDupp7NxUsGwwEneAEQLAq/nKw/q8ToI8nQM30/erM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B97BA1961469514B940AB5FC17387528@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd1e35d-ea79-46a2-7b8b-08d645aae447
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 18:49:19.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1213
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> On Nov 8, 2018, at 10:26 AM, David Ahern <dsahern@gmail.com> wrote:
>=20
> On 11/8/18 11:04 AM, Song Liu wrote:
>> On the other hand, processing BPF load/unload events synchronously shoul=
d
>> not introduce too much overhead for meaningful use cases. If many BPF pr=
ogs
>> are being loaded/unloaded within short period of time, it is not the ste=
ady
>> state that profiling works care about.=20
>=20
> but, profiling is not the only use case, and perf-record is common with
> those other use cases.
>=20
> I think that answers why your RFC set does not fork a thread for the bpf
> events. You are focused on profiling and for already loaded programs or
> for a small number of programs loaded by a specific workload started by
> perf.

We sure can fork a thread for the BPF event. But I guess that's not Peter's
main concern here...

Could you please point me to more information about the use cases you worry=
=20
about? I am more than happy to optimize the logic for those use cases.=20

Thanks,
Song

