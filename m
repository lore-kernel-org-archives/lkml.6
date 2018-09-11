Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA51C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C762086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rC6akf8W";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="M73IF7Ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C762086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeIKSb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:31:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60740 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbeIKSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:31:56 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BDTidh022775;
        Tue, 11 Sep 2018 06:29:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0gKomrGUKPvpKrVItFUcEzZevNRMd8RNaMFBKJHypq4=;
 b=rC6akf8W8Vt56y9IcQfkjfJifoVDYwDB/BcEUsyFu/Es0/j44chQEzfNSvuGtf85JmqO
 wozxbGEBpbJI2LdIrJjXMT2pTVqKbqOaciPczP1XSFt/U5OY2aVWmNNOeVZIXsW232Ru
 MEOJmlAngupsHs+M4dYTR1ju4ehUvF/mqk8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mebca8h44-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 06:29:56 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 11 Sep 2018 09:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gKomrGUKPvpKrVItFUcEzZevNRMd8RNaMFBKJHypq4=;
 b=M73IF7TaIFjSmfAhSjn+tozWNrIvPSKw+V7TpzdgTT28G5nDGjwisUoLFhvEODZMx7y/HVrsNIRcORKmilYogreK+2h0Uhm8SbTuHoUcU16cIUMH+kIaRavbOxHBoWvczXoJqurzX3FTY5nYaArTtRX2U1UnrTgiBEKrQTE5xrw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1182.namprd15.prod.outlook.com (10.175.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Tue, 11 Sep 2018 13:29:33 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705%7]) with mapi id 15.20.1122.019; Tue, 11 Sep 2018
 13:29:33 +0000
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
Thread-Index: AQHUNLn8qZjSey4G2E+jv0Hfl0L1PaTYfq6AgAA4WgCAEJvcAIAB6pcA
Date:   Tue, 11 Sep 2018 13:29:32 +0000
Message-ID: <90BE3370-3006-426A-80DC-279F07192E70@fb.com>
References: <20180815170313.455943-1-songliubraving@fb.com>
 <20180815170313.455943-2-songliubraving@fb.com>
 <20180830151355.GA23723@krava> <34EEDB74-35C5-49C4-9947-6C0248F194B3@fb.com>
 <20180910081336.GB31644@krava>
In-Reply-To: <20180910081336.GB31644@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:180::1:e80a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1182;20:Ge8Pa5nOGr9zZ1QbmNq31f7TPBN0LQIoP9ypKwWrtAiXxjyRW9tEVhNwWVNQdMzGSp22eFNgkNrMD4uB4jpaxxODQ6swgqZdM7+S5YLR4kO7INHBRnpDXQGW6NRvVETXhpXsI9zohJSy8Gc8in1zn/7CbBSRm/wZ9I9IeR7Mzvw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aa58abaf-4146-4a4b-b27f-08d617ea9c3c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1182;
x-ms-traffictypediagnostic: MWHPR15MB1182:
x-microsoft-antispam-prvs: <MWHPR15MB118258F85AACF654EDB9DAB2B3040@MWHPR15MB1182.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:MWHPR15MB1182;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1182;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(57704003)(229853002)(81156014)(6486002)(50226002)(8936002)(57306001)(81166006)(83716003)(68736007)(2900100001)(5250100002)(99286004)(2906002)(256004)(316002)(14444005)(76176011)(54906003)(82746002)(5660300001)(25786009)(4326008)(6512007)(36756003)(11346002)(93886005)(478600001)(7736002)(2616005)(86362001)(486006)(6116002)(33656002)(6436002)(8676002)(476003)(53936002)(446003)(6916009)(97736004)(6246003)(305945005)(106356001)(6506007)(14454004)(53546011)(102836004)(186003)(105586002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1182;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2JLwmkKGbTpd2kD2D4puFL15XKpdt69DCZ1MTooqcx2bYCebqA3KtLPeQ23o6B3s1IFdEjWtfLRaVEVWFIrSe2T4N1doed11BwmceJ4Rd3oNOilpSxET0934Ov+O6PpmmaDSDYQnpPmsLDcbNeorMKO3PA8hcS7mDtpLiNzxBebyhyel+MbrqUJcqnPq04CVe5lR5Hy1qtynQj95Du85YiP2j1iBExNZdU/G21IcXsonrvbR5Nep+kZ9pU5cdmBBRbdRhxk74lnD312cvkvJMwd0uJjpZHseUc/NtmfQmNe2qQH/vKHwVvkE16+BCVd/c0YMeU2jdb98RcAwDR5/LiVd0fQEdOgeL0Pr589WDGg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92AA7DE130782C49A2A48094ECE73170@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aa58abaf-4146-4a4b-b27f-08d617ea9c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 13:29:32.8531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1182
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 10, 2018, at 1:13 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Aug 30, 2018 at 06:35:37PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Aug 30, 2018, at 8:13 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Wed, Aug 15, 2018 at 10:03:13AM -0700, Song Liu wrote:
>>>=20
>>> SNIP
>>>=20
>>>>=20
>>>> +	perf_event_remove_dup(event, ctx);
>>>> 	/*
>>>> 	 * We can have double detach due to exit/hot-unplug + close.
>>>> 	 */
>>>> @@ -1982,6 +2123,92 @@ event_filter_match(struct perf_event *event)
>>>> 	       perf_cgroup_match(event) && pmu_filter_match(event);
>>>> }
>>>>=20
>>>> +/* PMU sharing aware version of event->pmu->add() */
>>>> +static int event_pmu_add(struct perf_event *event,
>>>> +			 struct perf_event_context *ctx)
>>>> +{
>>>> +	struct perf_event_dup *dup;
>>>> +	int ret;
>>>> +
>>>> +	/* no sharing, just do event->pmu->add() */
>>>> +	if (event->dup_id =3D=3D -1)
>>>> +		return event->pmu->add(event, PERF_EF_START);
>>>> +
>>>> +	dup =3D &ctx->dup_events[event->dup_id];
>>>> +
>>>> +	if (dup->active_event_count) {
>>>> +		/* already enabled */
>>>> +		dup->active_event_count++;
>>>> +		dup->master->pmu->read(dup->master);
>>>> +		event->dup_base_count =3D dup_read_count(dup);
>>>> +		event->dup_base_child_count =3D dup_read_child_count(dup);
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	/* try add master */
>>>> +	ret =3D event->pmu->add(dup->master, PERF_EF_START);
>>>> +
>>>> +	if (!ret) {
>>>> +		dup->active_event_count =3D 1;
>>>> +		event->pmu->read(dup->master);
>>>> +		event->dup_base_count =3D dup_read_count(dup);
>>>> +		event->dup_base_child_count =3D dup_read_child_count(dup);
>>>=20
>>> should you read the base before calling pmu->add ?
>>> should be same for any dup event not just master
>>>=20
>>> jirka
>>=20
>> I am not sure I am following. The pmu is disabled when we call
>> event_pmu_add(). Why do we need to read before calling pmu->add()?=20
>> And this is the first added dup event for this master, so we don't
>> need to worry about others.=20
>>=20
>> Does this make sense?=20
>=20
> I was just thinking since the pmu is disable we could
> we don't need to read the event on 2 places.. it's almost
> identic code

How about something like:


+/* PMU sharing aware version of event->pmu->add() */
+static int event_pmu_add(struct perf_event *event,
+			 struct perf_event_context *ctx)
+{
+	struct perf_event_dup *dup;
+	int ret;
+
+	/* no sharing, just do event->pmu->add() */
+	if (event->dup_id =3D=3D -1)
+		return event->pmu->add(event, PERF_EF_START);
+
+	dup =3D &ctx->dup_events[event->dup_id];
+
+	if (dup->active_event_count =3D 0) {
+		/* try add master */
+		ret =3D event->pmu->add(dup->master, PERF_EF_START);
+		if (ret)
+			return ret;
+	}
+
+	dup->active_event_count++;
+	event->pmu->read(dup->master);
+	event->dup_base_count =3D dup_read_count(dup);
+	event->dup_base_child_count =3D dup_read_child_count(dup);
+=09
+	return 0;
+}








