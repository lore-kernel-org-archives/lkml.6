Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E33C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342A820837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mC4a7aQ3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="g7Ouyj40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342A820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeH3Wjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:39:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbeH3Wjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:39:40 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UIUHsU018786;
        Thu, 30 Aug 2018 11:35:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HK92Wrg4x+uzPGEwWfImps3A7LSGdrfjYBpWxXl90/U=;
 b=mC4a7aQ3s8dEPegI1efZ9VERwvlEziQS1/6XgC9dulSd5kr+uwTJPVIQ1XwHWZp5zStI
 OMoN3QThduyds7vR3qznYazxOqmJLEbHsXy9X0s1T7Iaa/q4gMeyf15IbxMI8hv4nIbX
 +WdYWNvpRt30E0KTwjKJ25rAYBmiWgzAxZ4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m6mvh87v0-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 30 Aug 2018 11:35:42 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 30 Aug 2018 14:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK92Wrg4x+uzPGEwWfImps3A7LSGdrfjYBpWxXl90/U=;
 b=g7Ouyj407J2kWj7Lx0rIJX/7rCPMtxfgXyTMXJ/qMbGr0W9dtJEDUCqOmQQWCtzpQE59eRADz8/7qbhGi5jQeG1CRkr5FH2hPhJDx1q1xdsi3FHRe9qiObYjMYlJl2+TqbQIL/WdpUEAlc/SmGAsyzb4MznVwV3Bf6/j4mKI85A=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1787.namprd15.prod.outlook.com (10.174.246.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Thu, 30 Aug 2018 18:35:37 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::e4f2:1bec:ed9d:68a9]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::e4f2:1bec:ed9d:68a9%4]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 18:35:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Kernel Team <Kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/1] perf: Sharing PMU counters across compatible
 events
Thread-Topic: [PATCH v2 1/1] perf: Sharing PMU counters across compatible
 events
Thread-Index: AQHUNLn8qZjSey4G2E+jv0Hfl0L1PaTYfq6AgAA4WgA=
Date:   Thu, 30 Aug 2018 18:35:37 +0000
Message-ID: <34EEDB74-35C5-49C4-9947-6C0248F194B3@fb.com>
References: <20180815170313.455943-1-songliubraving@fb.com>
 <20180815170313.455943-2-songliubraving@fb.com>
 <20180830151355.GA23723@krava>
In-Reply-To: <20180830151355.GA23723@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::5:281d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1787;20:e5OYDODPEVcv9fmp9zgCyLMoiYCkretp4t2SztXqkPNFxi8+PgWTz5KkJERw9Tm2NI+Oaa0We/aliR9EoTPEU5vWfSd4IQmEs0UI8IEMLurjlI701KQffXpvWo1mJx/7Hg2SJHOGMefDJlRN0VMpukJo/MiCZ5WIsUqoCC+bYcU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 873e6978-cd75-4dc5-db7d-08d60ea7614b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1787;
x-ms-traffictypediagnostic: DM5PR15MB1787:
x-microsoft-antispam-prvs: <DM5PR15MB1787166A851C1D37E4B9BDDDB3080@DM5PR15MB1787.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DM5PR15MB1787;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1787;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(57704003)(189003)(51914003)(6436002)(316002)(2616005)(7736002)(57306001)(6246003)(11346002)(476003)(36756003)(305945005)(8936002)(50226002)(446003)(54906003)(6116002)(68736007)(81156014)(478600001)(4326008)(486006)(256004)(81166006)(86362001)(25786009)(14444005)(5660300001)(14454004)(82746002)(83716003)(97736004)(102836004)(6916009)(6512007)(105586002)(33656002)(5250100002)(2900100001)(186003)(106356001)(6506007)(2906002)(6486002)(53546011)(99286004)(46003)(53936002)(76176011)(8676002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1787;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c79UPQCrfv0Y+9lVMwMyjdZU6K0I5qKtcattvoBG4YcWdNe2ZKsMDRC0KgTBlGhYU2LBCn6wnU6et1dVdmEDLBLC9stt9TLrK3uee4L+Y/yW+ykTepN0ZzqkpzFkWPZJ36jBvoJu8P+tMOibdZsazYVJRp97dhrO55cN0wNF36gOxKB6sC+OSpgh1WUVtJ03HWA7tZi52LqTF7zWcbA7juT2IKpnJ71rJdrGhZsOf8gZtR3xqW95rIpccELwpTXAyyXADu7TiiUum1Ox8dzLVe30/A5Zsgbzeblqf44n+y4dPA1AZKIZUh6CF/vqwmrX/g/J+hidBQkfotgiF7wBnEkjXIi4P9aGudErmkX3OAI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2375C46F79BB354F858F9F0320B21D5D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 873e6978-cd75-4dc5-db7d-08d60ea7614b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 18:35:37.3491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1787
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 30, 2018, at 8:13 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Aug 15, 2018 at 10:03:13AM -0700, Song Liu wrote:
>=20
> SNIP
>=20
>>=20
>> +	perf_event_remove_dup(event, ctx);
>> 	/*
>> 	 * We can have double detach due to exit/hot-unplug + close.
>> 	 */
>> @@ -1982,6 +2123,92 @@ event_filter_match(struct perf_event *event)
>> 	       perf_cgroup_match(event) && pmu_filter_match(event);
>> }
>>=20
>> +/* PMU sharing aware version of event->pmu->add() */
>> +static int event_pmu_add(struct perf_event *event,
>> +			 struct perf_event_context *ctx)
>> +{
>> +	struct perf_event_dup *dup;
>> +	int ret;
>> +
>> +	/* no sharing, just do event->pmu->add() */
>> +	if (event->dup_id =3D=3D -1)
>> +		return event->pmu->add(event, PERF_EF_START);
>> +
>> +	dup =3D &ctx->dup_events[event->dup_id];
>> +
>> +	if (dup->active_event_count) {
>> +		/* already enabled */
>> +		dup->active_event_count++;
>> +		dup->master->pmu->read(dup->master);
>> +		event->dup_base_count =3D dup_read_count(dup);
>> +		event->dup_base_child_count =3D dup_read_child_count(dup);
>> +		return 0;
>> +	}
>> +
>> +	/* try add master */
>> +	ret =3D event->pmu->add(dup->master, PERF_EF_START);
>> +
>> +	if (!ret) {
>> +		dup->active_event_count =3D 1;
>> +		event->pmu->read(dup->master);
>> +		event->dup_base_count =3D dup_read_count(dup);
>> +		event->dup_base_child_count =3D dup_read_child_count(dup);
>=20
> should you read the base before calling pmu->add ?
> should be same for any dup event not just master
>=20
> jirka

I am not sure I am following. The pmu is disabled when we call
event_pmu_add(). Why do we need to read before calling pmu->add()?=20
And this is the first added dup event for this master, so we don't
need to worry about others.=20

Does this make sense?=20

Thanks for the review!
Song

