Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E40FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65E320837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IdOtSeLj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VXlsedTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65E320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeH3WzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:55:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53598 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727583AbeH3WzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:55:05 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UIo6kU027132;
        Thu, 30 Aug 2018 11:51:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SyfHMFMxJukyaJyVrNTfQ1FkS1mY/yQ9cRcq8RM8iOI=;
 b=IdOtSeLjr9vUafIFTz7/UqTa38mFaIiQ9WqWR6PyF4bBS/AC1t9Uw0nSdbidJfa5DRi/
 RHrU0oLBt69kSbc2NHcd+GzhD26INExU7SmM+6jO4EW1Jimp6zijmWqkggpWAHYBJBgK
 wXNHl4Wq8VZkLcjBzJamEtWYIuEm3No2MSs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m6nts02m2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 30 Aug 2018 11:51:13 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 30 Aug 2018 11:51:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyfHMFMxJukyaJyVrNTfQ1FkS1mY/yQ9cRcq8RM8iOI=;
 b=VXlsedTfoK31JrJ9gSzxgPgqzUPsGV0HfzKGq82VtbhHI75rX9sYIPHAQl3xp0HheRcONsBmPKeHaTVpIAF0MpG+id49eka7vfwuSuWyijv+diIxdx2647EEn0YdYgeD5L/ntj70lk5JtGAHo5yRiPUdZj52x4a1jOUnzV5H9UE=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1737.namprd15.prod.outlook.com (10.174.109.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Thu, 30 Aug 2018 18:51:07 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::e4f2:1bec:ed9d:68a9]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::e4f2:1bec:ed9d:68a9%4]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 18:51:07 +0000
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
Thread-Index: AQHUNLn8qZjSey4G2E+jv0Hfl0L1PaTYf94AgAA7f4A=
Date:   Thu, 30 Aug 2018 18:51:07 +0000
Message-ID: <2199C5F6-31A9-46F1-8656-F63087F2C67C@fb.com>
References: <20180815170313.455943-1-songliubraving@fb.com>
 <20180815170313.455943-2-songliubraving@fb.com>
 <20180830151810.GB23723@krava>
In-Reply-To: <20180830151810.GB23723@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::5:281d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1737;20:HXSVSIidPkeZ/hWEl8fSTKAGomxyA3XFSBIS5ojGkbzEvSpkT6n+fNB74odZg7s9tfvAHMl/8yloAQRXDrynjt67rwbnsWMOqUh7UNUf0roIKYrkTNU4BDvY5wgG3oGBX0rEn/1F7q3F4TYjWE0XJqnEF82/RLzQhnZCkfm3XPg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a3f2defc-9ed5-4573-a7bf-08d60ea98bec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1737;
x-ms-traffictypediagnostic: DM5PR15MB1737:
x-microsoft-antispam-prvs: <DM5PR15MB1737220A82851BF733869E81B3080@DM5PR15MB1737.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DM5PR15MB1737;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1737;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(46003)(102836004)(6486002)(305945005)(25786009)(36756003)(6116002)(8676002)(7736002)(6246003)(86362001)(6436002)(14454004)(54906003)(2616005)(256004)(476003)(316002)(57306001)(11346002)(486006)(229853002)(446003)(6506007)(53546011)(4326008)(186003)(478600001)(53936002)(6512007)(106356001)(6916009)(33656002)(2900100001)(99286004)(76176011)(5660300001)(82746002)(68736007)(83716003)(5250100002)(2906002)(97736004)(81166006)(81156014)(8936002)(50226002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1737;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gm3qa7i53qctbHxDDsnxpnFx9OKyjnRJHoqXlMxeZhK5omIrlDcNjxyGUL052m+9EModloL2W+5c8N0yXH79sY7pI3JJsqoMfzSgkVO9RVg4hHCOZA+92IEU3Nxin30CZHzOLRoZ/loCc83ucDHhl9Xd9H5LRNl4Yl8UG2l9iAJ6rk/z1VlbyHDr0mlgsSWHQ5IWtKizONcJ0YwqNXkCz3PoQxQsmdxjfwPqLDsbuAmeGl0G2scQO7EN88cCyj/AoleGRdVLx49nMgB3rK7kMpEcyeTAOaZCAU5fnC4H55uswB/3lxHuBr0WaZAVKxqUCY+MmUcMtyohJAotnmsuIECo5C3M6fKSvh1WfJWLXSs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B44DF9A24B1B954CBC3F6BC0D2D9D082@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f2defc-9ed5-4573-a7bf-08d60ea98bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 18:51:07.8307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1737
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 30, 2018, at 8:18 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Aug 15, 2018 at 10:03:13AM -0700, Song Liu wrote:
>=20
> SNIP
>=20
>> @@ -6100,7 +6333,7 @@ static void perf_output_read_group(struct perf_out=
put_handle *handle,
>>=20
>> 		if ((sub !=3D event) &&
>> 		    (sub->state =3D=3D PERF_EVENT_STATE_ACTIVE))
>> -			sub->pmu->read(sub);
>> +			event_pmu_read(sub);
>>=20
>> 		values[n++] =3D perf_event_count(sub);
>> 		if (read_format & PERF_FORMAT_ID)
>> @@ -9109,7 +9342,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(s=
truct hrtimer *hrtimer)
>> 	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
>> 		return HRTIMER_NORESTART;
>>=20
>> -	event->pmu->read(event);
>> +	event_pmu_read(event);
>>=20
>> 	perf_sample_data_init(&data, 0, event->hw.last_period);
>> 	regs =3D get_irq_regs();
>> @@ -10504,6 +10737,14 @@ SYSCALL_DEFINE5(perf_event_open,
>> 		goto err_cred;
>> 	}
>>=20
>> +	if (perf_event_can_share(event)) {
>> +		event->tmp_master =3D perf_event_alloc(&event->attr, cpu,
>> +						     task, NULL, NULL,
>> +						     NULL, NULL, -1);
>=20
> can't get around this.. I understand the need, but AFAICS you allocate
> the whole 'struct perf_event', just because there's count field in it
> otherwise the 'struct hw_perf_event' should be enough to carry all that's
> needed to read hw event
>=20
> would it be better to move the count to 'struct hw_perf_event' and use
> that instead? assuming I'm not missing anything..
>=20
> jirka

I am trying to make the master event function the same as a real event,=20
while keep dup events as followers. This avoids "switching master" in=20
earlier versions (and Tejun's RFC).=20

I also read your version that does it at hardware level, and found it=20
simplifies some parts of the change. I picked current approach mostly=20
because this approach keeps all logic about PMU sharing in one place,=20
and the rest of the perf subsystem can stay as-is. If this approach=20
doesn't work out, I will probably try the hardware level approach.

Thanks,
Song


