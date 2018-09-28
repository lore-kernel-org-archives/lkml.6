Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE17CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19603216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZASrJFl7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LC1ZaxZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19603216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbeI1LQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:16:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727588AbeI1LQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:16:31 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8S4rFLb013708;
        Thu, 27 Sep 2018 21:53:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RnPwaRWNfIcarW9j5Fh8wBeCoHhCQz+gXuu8oYLi8Vw=;
 b=ZASrJFl7s/RRLMoExCobzvOESh7QuJv6u5Ba45QllI6CNwOkQ0zOLScGTdPVrLj8zvoe
 GD2ZlXdsR87YuVa7fNK5jOUkJX4QIHOy2/OQmuJ01zyfd/a9mz6zI194XcE2grksW+xT
 x2RPvym98Xsj3niPFwZ0vlgu9CeRe/WErEM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msdmfg06c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 27 Sep 2018 21:53:58 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 00:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnPwaRWNfIcarW9j5Fh8wBeCoHhCQz+gXuu8oYLi8Vw=;
 b=LC1ZaxZ8wKiLOb8y9pjJePLpXu7NLHkniMvhzZmtI/5/QRtd8U1Rb9Iyf7i6d8TDNV4Itxuy78WRGMlL+iw6q2aSvQQvuLBryLxguSScFZOi296wgIFa+VZDiyanzo/xjXtu6qqcPwDD4OFnu/kKMhYu0zt2EGzv/XS7LvbpbdU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1376.namprd15.prod.outlook.com (10.173.234.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Fri, 28 Sep 2018 04:53:52 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705%7]) with mapi id 15.20.1143.022; Fri, 28 Sep 2018
 04:53:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/1] perf: Sharing PMU counters across compatible
 events
Thread-Topic: [PATCH v3 1/1] perf: Sharing PMU counters across compatible
 events
Thread-Index: AQHUVFWHLkWT+gOEaE6ulIM978nb5KUFIEEAgAAFk4A=
Date:   Fri, 28 Sep 2018 04:53:52 +0000
Message-ID: <CBE3EBD5-EAC6-41B6-88C1-B15958591172@fb.com>
References: <20180924222517.197296-1-songliubraving@fb.com>
 <20180924222517.197296-2-songliubraving@fb.com>
 <0b57307e-b75c-5df8-1ea7-27d527577489@linux.ibm.com>
In-Reply-To: <0b57307e-b75c-5df8-1ea7-27d527577489@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:180::1:be70]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1376;20:ivHnsM6qGNDd/cBVNsHxHDW0haIoe1/hkYDngYoc7BsF1m3fYDt18T1BeD+PjpL2Iw17Qhv1R6/EDWH2MhWRz7E1qcc2oLE5cDFXoFCgFqeMF5Y4HX3I/p1v5KYtJX5liAB4BI6Yb7vItwVvOjaAxpypo4MEzdxYKJAqRt7W4aU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 45716172-9ab0-470f-ee51-08d624fe6336
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1376;
x-ms-traffictypediagnostic: MWHPR15MB1376:
x-microsoft-antispam-prvs: <MWHPR15MB137613D04E24A8CBB7A7D416B3EC0@MWHPR15MB1376.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(3231355)(11241501184)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:MWHPR15MB1376;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1376;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(446003)(5024004)(36756003)(102836004)(11346002)(83716004)(34290500001)(256004)(6246003)(2906002)(68736007)(50226002)(2900100001)(2616005)(5250100002)(6916009)(4326008)(97736004)(57306001)(53546011)(71190400001)(186003)(71200400001)(46003)(86362001)(6506007)(14454004)(966005)(478600001)(53936002)(6306002)(99286004)(33656002)(476003)(6512007)(6116002)(305945005)(7736002)(5660300001)(229853002)(486006)(316002)(76176011)(25786009)(81166006)(8936002)(8676002)(82746002)(105586002)(6486002)(54906003)(106356001)(81156014)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1376;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qYSO0BxJUD9wxqz5D28s94s3MG9ZkBF7208/bKAYuwOgH80u14G9Gn6Z8wKXqwSz+q9UY7v5pkRoQVBQExxvIcJeEf0fwMe+IcCEDj5ffSpLjMbu1PNl6IJO0TiVndgdgUimfNAF/ioRPsoD7gxQzutd4e3hln17ZFbAOETX/xUFIcqp8vYjkFR+3KfxwO86fIhPF5Npjz0JqnmjT1nUgva8USM+BMcqzKCdT3hUuuxtn9JEd4jp5KKLI6itABYdyGIa1olQfOhaEwlHpVvBeVBQe7elOPAuwiYMcBrWB4JLqCvYbvhWQX1f7GklsveGXkTUdqfePFQmRSkKk6u2l6UdOqeAD8SDhAlcpsB6nOE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30F74CF89714784EAB94EA8976ADCDE9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45716172-9ab0-470f-ee51-08d624fe6336
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 04:53:52.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1376
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

> On Sep 27, 2018, at 9:33 PM, Ravi Bangoria <ravi.bangoria@linux.ibm.com> =
wrote:
>=20
> Hi Song,
>=20
> On 09/25/2018 03:55 AM, Song Liu wrote:
>> This patch tries to enable PMU sharing. To make perf event scheduling
>> fast, we use special data structures.
>>=20
>> An array of "struct perf_event_dup" is added to the perf_event_context,
>> to remember all the duplicated events under this ctx. All the events
>> under this ctx has a "dup_id" pointing to its perf_event_dup. Compatible
>> events under the same ctx share the same perf_event_dup. The following
>> figure shows a simplified version of the data structure.
>>=20
>>      ctx ->  perf_event_dup -> master
>>                     ^
>>                     |
>>         perf_event /|
>>                     |
>>         perf_event /
>>=20
>=20
> I've not gone through the patch in detail, but I was specifically
> interested in scenarios where one perf instance is counting event
> systemwide and thus other perf instance fails to count the same
> event for a specific workload because that event can be counted
> in one hw counter only.
>=20
> Ex: https://lkml.org/lkml/2018/3/12/1011
>=20
> Seems this patch does not solve this issue. Please let me know if
> I'm missing anything.
>=20

In this case, unfortunately, these two events cannot share the same
counter, because one of them is in cpu ctx; while the other belongs=20
to the task ctx. They have to go through the rotation, that each=20
event counts 50% of the time. However, if you have 2 events in cpu=20
ctx and 2 events in task ctx on the same counter, this patch will=20
help each event to count 50% of time, instead of 25%.=20

Another potential solution is to create a cgroup for the workload,=20
and attach perf event to the cgroup. Since cgroup events are added
to the cpu ctx, they can share counters with the system wide events.=20

I made this trade-off for O(1) time context switch. If we share=20
hw counter between cpu ctx and task ctx, we have to do linear time=20
comparison to identify events that can share the counter. =20

Thanks,
Song



