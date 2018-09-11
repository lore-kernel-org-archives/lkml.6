Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CACBC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186792086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Kp7odDSw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DdAEbEgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186792086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeIKSim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:38:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57154 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726622AbeIKSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:38:41 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8BDbrnY013667;
        Tue, 11 Sep 2018 06:38:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NoyiQyKNoDsaBnr0GQ9ETKQXj0iJKPHWlbLZ+asYUeE=;
 b=Kp7odDSwq5VQUc9Biac8M0aChGbg0igC4tRPAu2GVLxi6QPWkaVu7aWGG4wOVRMENWxF
 JieZuez76YnadihHj1JG2flVTnM5Hb5kO9vH/7oWnX7vooUL6/PPJrKxdxAKt3giVFcl
 2aH3RN2fk0wWz2mUU5VU/gKO4OPsUJf0r5E= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2medxeg4rr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Sep 2018 06:38:59 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 11 Sep 2018 09:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoyiQyKNoDsaBnr0GQ9ETKQXj0iJKPHWlbLZ+asYUeE=;
 b=DdAEbEgYWYKKQsRBF26adJ3601xB1m2xDSg/Mfb3e9JOZzjMbySkqMHpVeEhn7/Lc7M0PKJIbi5nYLLaJyMJy0TFrDJ8hwevWPibaS1nBiKJOpAtZoKbNh43eusx8btnjBwz7zBPS8GaAys8zonT9ILD0hXsPrK2SV+y0vPykzI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1885.namprd15.prod.outlook.com (10.174.98.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 13:38:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705%7]) with mapi id 15.20.1122.019; Tue, 11 Sep 2018
 13:38:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>, Kernel Team <Kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v2 1/1] perf: Sharing PMU counters across compatible
 events
Thread-Topic: [PATCH v2 1/1] perf: Sharing PMU counters across compatible
 events
Thread-Index: AQHUNLn8qZjSey4G2E+jv0Hfl0L1PaTYf94AgAA7f4CAEJgQgIAB7KgA
Date:   Tue, 11 Sep 2018 13:38:49 +0000
Message-ID: <F3425547-3F28-44F3-8328-1CAB0FD12A96@fb.com>
References: <20180815170313.455943-1-songliubraving@fb.com>
 <20180815170313.455943-2-songliubraving@fb.com>
 <20180830151810.GB23723@krava> <2199C5F6-31A9-46F1-8656-F63087F2C67C@fb.com>
 <20180910081531.GC31644@krava>
In-Reply-To: <20180910081531.GC31644@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:180::1:e80a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1885;20:mk8L/cf/60uQ80lDXfzSI0iNh5h0svTP8cWv/LBBSkbcC9txdb4oVOwV93GZy9sQRgnN7r+9njeX5n4pd64mrD3DGWHTCDPQF5GfnphdfvvnS33SWGqdTqbIU3XLfP9TrRHfjCoBITmqrH5WXMiBUw8oZM5ml7nSqT2aPpGVz5w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9c4ddea7-0175-4596-ce65-08d617ebe7cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1885;
x-ms-traffictypediagnostic: MWHPR15MB1885:
x-microsoft-antispam-prvs: <MWHPR15MB1885E745333C49EAD71A29E5B3040@MWHPR15MB1885.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:MWHPR15MB1885;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1885;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(54906003)(2906002)(478600001)(97736004)(316002)(186003)(76176011)(83716003)(93886005)(57306001)(82746002)(99286004)(256004)(106356001)(4326008)(36756003)(105586002)(25786009)(68736007)(14454004)(6506007)(5660300001)(53546011)(33656002)(2900100001)(6916009)(102836004)(6246003)(81156014)(81166006)(6512007)(53936002)(8936002)(8676002)(11346002)(476003)(2616005)(6436002)(7736002)(305945005)(229853002)(5250100002)(446003)(486006)(46003)(6116002)(50226002)(6486002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1885;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VX/bJkMgxRatJiVLMSayuGtvVqWIOSW0gd6BByw/lsP4CB2hxEFj5RGm3EqqnwQ+4QmteAeOns7RR77SH7SCTQJvacR313vv69NfL5KO9gTw/qvKQp7lsXSPuUpbjb7SfNrNji+nzuDBfiYbmxoi5SKpmwri+9wh1XPPaMXGMpy3REbGbuvHzGyTB+WMty8maqIGiiJdFY6B/qVSd/7IaNlwk4C9YQQ5sCpNAWZACiwgxXB04JB/GD/gueNdHYZBCypB6Q3EI8u6rMqorOkxihWxojETpzD35+NxRZNb9X5BOmAoSEXRBHnnlUxVXfvm0zsl/+dxCnrCKTDYZZJeY/zE45LuqfMF01m/yXRMkHI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2058A8806ED38144A2C143E8E6A9BE1A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4ddea7-0175-4596-ce65-08d617ebe7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 13:38:49.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1885
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 10, 2018, at 1:15 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Aug 30, 2018 at 06:51:07PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Aug 30, 2018, at 8:18 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Wed, Aug 15, 2018 at 10:03:13AM -0700, Song Liu wrote:
>>>=20
>>> SNIP
>>>=20
>>>> @@ -6100,7 +6333,7 @@ static void perf_output_read_group(struct perf_o=
utput_handle *handle,
>>>>=20
>>>> 		if ((sub !=3D event) &&
>>>> 		    (sub->state =3D=3D PERF_EVENT_STATE_ACTIVE))
>>>> -			sub->pmu->read(sub);
>>>> +			event_pmu_read(sub);
>>>>=20
>>>> 		values[n++] =3D perf_event_count(sub);
>>>> 		if (read_format & PERF_FORMAT_ID)
>>>> @@ -9109,7 +9342,7 @@ static enum hrtimer_restart perf_swevent_hrtimer=
(struct hrtimer *hrtimer)
>>>> 	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
>>>> 		return HRTIMER_NORESTART;
>>>>=20
>>>> -	event->pmu->read(event);
>>>> +	event_pmu_read(event);
>>>>=20
>>>> 	perf_sample_data_init(&data, 0, event->hw.last_period);
>>>> 	regs =3D get_irq_regs();
>>>> @@ -10504,6 +10737,14 @@ SYSCALL_DEFINE5(perf_event_open,
>>>> 		goto err_cred;
>>>> 	}
>>>>=20
>>>> +	if (perf_event_can_share(event)) {
>>>> +		event->tmp_master =3D perf_event_alloc(&event->attr, cpu,
>>>> +						     task, NULL, NULL,
>>>> +						     NULL, NULL, -1);
>>>=20
>>> can't get around this.. I understand the need, but AFAICS you allocate
>>> the whole 'struct perf_event', just because there's count field in it
>>> otherwise the 'struct hw_perf_event' should be enough to carry all that=
's
>>> needed to read hw event
>>>=20
>>> would it be better to move the count to 'struct hw_perf_event' and use
>>> that instead? assuming I'm not missing anything..
>>>=20
>>> jirka
>>=20
>> I am trying to make the master event function the same as a real event,=
=20
>> while keep dup events as followers. This avoids "switching master" in=20
>> earlier versions (and Tejun's RFC).=20
>=20
> yep, I understand.. still, it seems too much to allocate
> the whole 'struct perf_even't just to get separated 'count'
> variable

In theory, we only need separated counters. However, in practice, there
are other variables we need to handle for a switch_master operation.=20
For example, we need make sure event->state is always set properly. So=20
this optimization is not easy to implement. How about we optimize it=20
after this patch gets in?=20

Thanks,
Song



