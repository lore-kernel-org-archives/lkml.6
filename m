Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34032C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11812084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Bgh013PQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O6ebMBQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11812084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJBGGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:06:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726027AbeJBGGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:06:53 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w91NOeLY014072;
        Mon, 1 Oct 2018 16:25:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WVUTWXMtfCVIraMrDPp7yQoEJxBAjw1f4Sc6zmDHE/Y=;
 b=Bgh013PQvOJhvbLq4MXKb14PrAkm/yJ4uvW2tsp/lb9Q7VjHbIFPNR/VRIIJE5LH9A0u
 Ji2vB4ZztUSx6q5Xkx65JcQ/DtPtjCjzGEQb4befcXopsgJ3Lp5sErVTgJP/AMpUBSop
 m7Dj0JnxLCq17gsoUUt7rOP9zH+AVNPFUFQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2mutwt8ej1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 16:25:13 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 1 Oct 2018 19:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVUTWXMtfCVIraMrDPp7yQoEJxBAjw1f4Sc6zmDHE/Y=;
 b=O6ebMBQZq/bxbsv7MC29nEfGDaxSIdN7HgTOXMkp6TpC7eKJENmQ7qMT+3BdyctF6LNga2DYIIfpmodGlYEQ3/gGHQ1ZlQjYCZhEHA7zFzWEHp1L9vyNnvD/unVqqpjcERoSWxxNt7Zv/iH6ZFq4JFYBZmf4Vydo9upx87DKsRk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1150.namprd15.prod.outlook.com (10.175.2.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Mon, 1 Oct 2018 23:25:10 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%7]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 23:25:10 +0000
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
Thread-Index: AQHUVFWHLkWT+gOEaE6ulIM978nb5KUFIEEAgAAFk4CABe18AA==
Date:   Mon, 1 Oct 2018 23:25:09 +0000
Message-ID: <6803478E-035D-4CD4-B16E-6250BB07CA0B@fb.com>
References: <20180924222517.197296-1-songliubraving@fb.com>
 <20180924222517.197296-2-songliubraving@fb.com>
 <0b57307e-b75c-5df8-1ea7-27d527577489@linux.ibm.com>
 <CBE3EBD5-EAC6-41B6-88C1-B15958591172@fb.com>
In-Reply-To: <CBE3EBD5-EAC6-41B6-88C1-B15958591172@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::5:f9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1150;20:10YDovvLcrVVo9e0s13QDsboi7kc8eJum+Db4YcRTaDfpMzeq1roda6xJ09DnnACbNVmV6IUkUtt4d4ZDGDjeBfuw75pGYI06llaWWR3g6Jhr3vyQeGBkAIcsDZN4vhnYnboB3mVRWGnh/SFqioM+R2BGhtjkF/JqWR43dRjmI8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf3097f3-138f-46fa-873a-08d627f52179
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1150;
x-ms-traffictypediagnostic: MWHPR15MB1150:
x-microsoft-antispam-prvs: <MWHPR15MB115099C37B9C19F4AF93F6E0B3EF0@MWHPR15MB1150.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:MWHPR15MB1150;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1150;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(6506007)(57306001)(229853002)(50226002)(6916009)(105586002)(106356001)(68736007)(6436002)(33656002)(2906002)(5250100002)(966005)(14454004)(4326008)(93886005)(6486002)(53936002)(54906003)(81166006)(81156014)(6306002)(76176011)(97736004)(36756003)(8676002)(305945005)(476003)(5660300001)(8936002)(99286004)(256004)(82746002)(478600001)(83716004)(316002)(71190400001)(486006)(6512007)(71200400001)(6246003)(6116002)(2900100001)(11346002)(102836004)(7736002)(46003)(86362001)(2616005)(446003)(25786009)(53546011)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1150;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kXPy3ckrSqPTWF1y+2qika0lTNHNl3nmqh6/oK/v1YvgfWxARYMw1y052vnZZurP0hY6zpnfG0LU9JeOu1X54d+9MVoX3ZEM3Uzw0e0A54tgV0oBijuiHu8EE+xlJ8fbcZZU0FgqjB6YpO9SvKLi5rz3bgBEfnC+JU7n2gPRoNpB2xTPuI+l5E6EL0mBnkZVJ3rO4T5vwH5WlxgknuLm8cSyWZU8wgx9KxARqUgGyH+02s3Wmvx7gsW7kHkM+MyB4dH5/59jTwLRfsUi1e4wYiPZGnlzKbA5fzJQtmTIJRUHZ5ipZN9X6Ee2XEBKmphrMySe1F+bYttMGtgRA1O+qT2oLJjKxCZ4EO8V5yCv/mg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFD41EF02A1B4A4A85EC9D4F8D7B09A6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3097f3-138f-46fa-873a-08d627f52179
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 23:25:10.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1150
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2018, at 9:53 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> Hi Ravi,
>=20
>> On Sep 27, 2018, at 9:33 PM, Ravi Bangoria <ravi.bangoria@linux.ibm.com>=
 wrote:
>>=20
>> Hi Song,
>>=20
>> On 09/25/2018 03:55 AM, Song Liu wrote:
>>> This patch tries to enable PMU sharing. To make perf event scheduling
>>> fast, we use special data structures.
>>>=20
>>> An array of "struct perf_event_dup" is added to the perf_event_context,
>>> to remember all the duplicated events under this ctx. All the events
>>> under this ctx has a "dup_id" pointing to its perf_event_dup. Compatibl=
e
>>> events under the same ctx share the same perf_event_dup. The following
>>> figure shows a simplified version of the data structure.
>>>=20
>>>     ctx ->  perf_event_dup -> master
>>>                    ^
>>>                    |
>>>        perf_event /|
>>>                    |
>>>        perf_event /
>>>=20
>>=20
>> I've not gone through the patch in detail, but I was specifically
>> interested in scenarios where one perf instance is counting event
>> systemwide and thus other perf instance fails to count the same
>> event for a specific workload because that event can be counted
>> in one hw counter only.
>>=20
>> Ex: https://lkml.org/lkml/2018/3/12/1011
>>=20
>> Seems this patch does not solve this issue. Please let me know if
>> I'm missing anything.
>>=20
>=20
> In this case, unfortunately, these two events cannot share the same
> counter, because one of them is in cpu ctx; while the other belongs=20
> to the task ctx. They have to go through the rotation, that each=20
> event counts 50% of the time. However, if you have 2 events in cpu=20
> ctx and 2 events in task ctx on the same counter, this patch will=20
> help each event to count 50% of time, instead of 25%.=20

I was wrong here. The CPU flexible events have higher priority than
task flexible events, so the per task event will never get scheduled.=20

On the other hand, I think it is possible to put per task event on=20
per CPU ctx, and handle the event just like per cgroup events. Once we
get this part work, system wide events will be able to share PMU with
per task events. Let me try prototype it.=20

Thanks,
Song

