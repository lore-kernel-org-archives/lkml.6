Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEDFC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFA2206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="V8dzo+Nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFA2206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeI2DaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:30:09 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:44760 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbeI2DaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:30:09 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SKu92S007320;
        Fri, 28 Sep 2018 16:03:55 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0049.outbound.protection.outlook.com [216.32.181.49])
        by mx0b-00010702.pphosted.com with ESMTP id 2msrc9rjrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 16:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IREB59CNjRu7IeLAasb0ywqub2T3ABxw8fJNiPYmwY=;
 b=V8dzo+Nt8VmuPWlM/o/ffd02u4hrYoL6lJmAvg0tdUZ8iYpGzNshPUEFTDTSmVyup22Y+zWQDvfrYrvUZNEKMIHueUPfeWdZi4CdURUj386NHk94iiA6reU3SOrmZg1565e+449o8FKNQ055OV1XOZVkTBDXZmTdIwmCJXKV7LU=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB0741.namprd04.prod.outlook.com (10.172.198.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Fri, 28 Sep 2018 21:03:53 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::351f:554:dbf4:f988]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::351f:554:dbf4:f988%2]) with mapi id 15.20.1185.022; Fri, 28 Sep 2018
 21:03:53 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>
Subject: [PATCH 0/2] Fix watchdogd wakeup deferral on RT
Thread-Topic: [PATCH 0/2] Fix watchdogd wakeup deferral on RT
Thread-Index: AQHUV27CUiTQnLAdKE2fr/XRviSMog==
Date:   Fri, 28 Sep 2018 21:03:52 +0000
Message-ID: <cover.1538089179.git.julia@ni.com>
References: <73in2vl5mj.fsf@pengutronix.de>
In-Reply-To: <73in2vl5mj.fsf@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To BN6PR04MB0963.namprd04.prod.outlook.com (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.116]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR04MB0741;6:ok7qHiYlc6Ha/grThZLM1adAsz1eHyx5J74dYYhllumYersnqz/p7kjlDm50xtz+qayqiWot/fyG3SE/m5T3PR1j3fHaxrGt9U/gLSxvyawxL67iT1EyzW9keTzyDVoqaniNtD21VjqSDYdcCoOnzujTHGGKX+2b0qv789k0zgUw5le4tBLEaGC0IwUJqaZgZvPf6me9QE8eS5o2Pq1olCt8jvwDLffJWqBjgbFmCVuDZmMpSwW0oi5AA9ILm8tIcyai8FVK683RM1JYg43wizgoC0aUYm2ecztm8PDkrmCd2C19cDAKjOP+43Tq6zN8D3VNxejW+EqYHHyD5+nj89EQRG2DBB7seANXWgwLVbKedp2kagshHIdlhRlJye2aZ+5eWLIbpSKbQslOsUBLJuYje3XTkaAiUvjSHehb8+zYz+FhOEMv7vjEpw/KqyM2weR0+NHjkSrHjTiOz5FdtA==;5:baCIBXd2tot/q/zhEsWcC7HNvcHHZplR1Hap5munNqqBH76yd8YqyO8kvkNz8YR27PkOZ4YXUoFJFes9H4LtFbXfbgeA7TpmjeLpjuAyqL1Y3SWkuLDEgy1VnFhWwZ9lMGazHlj1ko6jslZ1lkgyu2PTjapkh1y14Uq3B1xLoE4=;7:ryE5Pgk83xarvA9G6L/BdoG2/rylmqhwCvp7kSK4qm1ntq0BLDkRJr0EDtjmVTn7gaGmiLCmtfugc+d5kRttBOmbiN2gfMdfCZ+/aGapP2BLzeW9Qt+UAREr0qxBNaktWWh4IjcAece+UwJXF58mEddBQoptOQ4C5cbYuG8oWqF6w9fBpGlZVOmVKyOzyKVOzIJrorYcRzaEaddZP47xiezA3SzXxBU48SDeVM2Lju6B18vQ3Wu5m3TpAQrC+er2
x-ms-office365-filtering-correlation-id: cd9e9cd2-0421-4e6c-1319-08d62585e513
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0741;
x-ms-traffictypediagnostic: BN6PR04MB0741:
x-microsoft-antispam-prvs: <BN6PR04MB074131A4FE63A81057B18B53F4EC0@BN6PR04MB0741.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:BN6PR04MB0741;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0741;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(486006)(2900100001)(476003)(2616005)(478600001)(76176011)(2906002)(105586002)(6116002)(3846002)(386003)(106356001)(8936002)(5250100002)(54906003)(68736007)(102836004)(6506007)(110136005)(26005)(186003)(11346002)(6486002)(6436002)(52116002)(53936002)(6512007)(8676002)(316002)(446003)(81156014)(81166006)(97736004)(99286004)(4326008)(25786009)(256004)(36756003)(14444005)(34290500001)(14454004)(71190400001)(71200400001)(66066001)(7736002)(5660300001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0741;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WyUQg6TBCj9xhI4rvxktoYgXSz5jw7hy0hP7xDbuRTGMBkzuo+qhHtz561zsFuL+d5d6luyG47eSYxuPTDR9Cy1xkkxyS/fC4Qa93xGhUVaso82LpnUiZfVDoJFwh1XN1oDDmp4H+Upy0/xtT2hKMB46XLy9jsj6NH21Cp/JZHv6hC0vxaykP54jd5Qm/p0brV3yw7JUDTldhaqKCxXFJxq65h9HZcyuqdwROdyQ0cR7e6eBEFZF0/xHB0r5M51VYeDEC0x/r2I0bnul8UOiwya0ywjLZ0a1yCELpK2FtPL/YkdUAJHOCpKdxCxOQp4uki0YbrYsUAYKNMtoGOnn9Uhq6eAh+blXfTxbYTwqNEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9e9cd2-0421-4e6c-1319-08d62585e513
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 21:03:52.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0741
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=769 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches solve an issue reported by Steffen Trumtrar
and Tim Sander to the linux-rt-users mailing list.  Namely, the wakeup
of the watchdogd thread being starved by an RT task due to the hrtimer
deferral through ktimersoftd (on PREEMPT_RT_FULL).

The first patch adjusts the kthread_worker locking to make use of a raw
spinlock, making it suitable for work item queueing from hardirq context
on PREEMPT_RT.  This patch can be applied directly to mainline without
any functional change.

The second patch adjusts the hrtimer used by the watchdog core to be a
_HARD timer (and thus not deferred through ktimersoftd w/ PREEMPT_RT).
This patch depends on hrtimer patches carried in the RT patch, and so
should therefore land there.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Tim Sander <tim@krieglstein.org>

Julia Cartwright (2):
  kthread: convert worker lock to raw spinlock
  watchdog, rt: prevent deferral of watchdogd wakeup

 drivers/watchdog/watchdog_dev.c |  2 +-
 include/linux/kthread.h         |  2 +-
 kernel/kthread.c                | 42 ++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 23 deletions(-)

--=20
2.18.0

