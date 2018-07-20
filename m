Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0499CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7996020661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="3Gwm+ekN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7996020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeGUANA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:13:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:59864 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727429AbeGUANA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:13:00 -0400
X-Greylist: delayed 1001 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2018 20:12:59 EDT
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KN4gLJ021382;
        Fri, 20 Jul 2018 16:05:54 -0700
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp0242.outbound.protection.outlook.com [216.32.181.242])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2kbpx207bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 20 Jul 2018 16:05:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48qL2XxfkXFLrPIdYQz4W1Yo+OEWja+89eurPNnNdpY=;
 b=3Gwm+ekNIf5qg0vyCQ+1/fWoymLnC/HVJqZ37IbQg+BmfvHJO0deByPlV4CWVb+sAenAbZZjdgRybfe0jjFMxbXrVQEGmCoE991tVz4kv+iP6RmCb+ifXQvJ5rR+e1ceu27Fhl9h8a+yyb1muwGdXS1D13LYsE7nJJJM4rq3bLw=
Received: from BYAPR02MB4501.namprd02.prod.outlook.com (52.135.239.148) by
 BYAPR02MB4600.namprd02.prod.outlook.com (52.135.239.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Fri, 20 Jul 2018 23:05:52 +0000
Received: from BYAPR02MB4501.namprd02.prod.outlook.com
 ([fe80::fc2a:75b2:a5d4:9da]) by BYAPR02MB4501.namprd02.prod.outlook.com
 ([fe80::fc2a:75b2:a5d4:9da%3]) with mapi id 15.20.0973.018; Fri, 20 Jul 2018
 23:05:52 +0000
From:   David Chen <david.chen@nutanix.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC:     David Chen <david.chen@nutanix.com>
Subject: RCU nocb list not reclaiming causing OOM
Thread-Topic: RCU nocb list not reclaiming causing OOM
Thread-Index: AQHUIH18yrHc1RUlUkiqYiJ1aV59oA==
Date:   Fri, 20 Jul 2018 23:05:52 +0000
Message-ID: <BYAPR02MB4501B990E353A2616594821294510@BYAPR02MB4501.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.193.132.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4600;7:5kb6BS7tsVpL+cUVnRQToK1AKm9cKftOxzmR//m8v4/20INQJ6X2v91M+mkjmRxh3KfmaG/U4lffgDVsyBMGwusfqoCaty2n2nskHzp01HtqeBrvqmlJ2jaGTO4i8owUzo7SM1dDJhUbrLwfXGEi3KhhjCrKwIkOSXrVqdg6xia3VMGrNWUlHIf1TPendyXxfCQyaxDvkMF7ldpyAlIXgra/YUTp/JseIcChAIXSLujIRRKR/1qGSzJAUZkE6z5w
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(396003)(366004)(346002)(189003)(199004)(54094003)(3846002)(81156014)(14444005)(2906002)(33656002)(6116002)(2900100001)(68736007)(99286004)(256004)(8676002)(8936002)(81166006)(575784001)(316002)(97736004)(66066001)(110136005)(86362001)(7736002)(6436002)(102836004)(478600001)(106356001)(5660300001)(2501003)(26005)(5250100002)(55016002)(476003)(305945005)(4326008)(74316002)(14454004)(25786009)(7696005)(6506007)(44832011)(105586002)(486006)(53936002)(9686003)(107886003)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4600;H:BYAPR02MB4501.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 29d46182-b05d-4b54-126a-08d5ee955729
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4600;
x-ms-traffictypediagnostic: BYAPR02MB4600:
x-microsoft-antispam-prvs: <BYAPR02MB46008D88417BD2E8E9C7E7D594510@BYAPR02MB4600.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4600;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4600;
x-forefront-prvs: 073966E86B
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j/ta1gHzcaRE60uX/uxMMQ04SseS8IHCOJ8wMNhd15l/3pldSlbzF6zY/hAHzfgYw9uOjL9lm94zrdpA+Qyo4IHLfowSLss8UtfZkduNYkS9JEXNYEFg8GWadLwGecmUpRqf4basitX5uHlbJ9Vpku951dARhMvXUu7T3Q2Vh6kFDtPsO7nPLXmGGjjJFqPWKNmAjprk41RPUSwEoV2m5+pKdUZ+wg1QU+37B712jgXTcCV6jI94G2SZA/yj1fRejkTO9M01l7ZMaMRUJQgyUZv40TMtIdntmGVWlmT+7pcBsudB+Zz2n7ReVEHBKudHCHDMg2DRE015qxX3fetjSTxnrBA7wvWoyv3wSriy4/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d46182-b05d-4b54-126a-08d5ee955729
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 23:05:52.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4600
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

We hit an RCU issue on 4.9.37 kernel. One of the nocb_follower list grows t=
oo
large, and not getting reclaimed, causing the system to OOM.

Printing the culprit rcu_sched_data:

  nocb_q_count =3D {
    counter =3D 32369635
  },
  nocb_follower_head =3D 0xffff88ae901c0a00,
  nocb_follower_tail =3D 0xffff88af1538b8d8,
  nocb_kthread =3D 0xffff88b06d290000,

As you can see here, the nocb_follower_head is not empty, so in theory, the
nocb_kthread shouldn't go to sleep. However, if dump the stack of the kthre=
ad:

crash> bt 0xffff88b06d290000
PID: 21     TASK: ffff88b06d290000  CPU: 3   COMMAND: "rcuos/1"
 #0 [ffffafc9020b7dc0] __schedule at ffffffff8d8789dc
 #1 [ffffafc9020b7e38] schedule at ffffffff8d878e76
 #2 [ffffafc9020b7e50] rcu_nocb_kthread at ffffffff8d112337
 #3 [ffffafc9020b7ec8] kthread at ffffffff8d0c6ce7
 #4 [ffffafc9020b7f50] ret_from_fork at ffffffff8d87d755

And if we dis the address at ffffffff8d112337:

/usr/src/debug/kernel-4.9.37/linux-4.9.37-29.nutanix.07142017.el7.centos.x8=
6_64/kernel/rcu/tree_plugin.h: 2106
0xffffffff8d11232d <rcu_nocb_kthread+381>:      test   %rax,%rax
0xffffffff8d112330 <rcu_nocb_kthread+384>:      jne    0xffffffff8d112355 <=
rcu_nocb_kthread+421>
0xffffffff8d112332 <rcu_nocb_kthread+386>:      callq  0xffffffff8d878e40 <=
schedule>
0xffffffff8d112337 <rcu_nocb_kthread+391>:      lea    -0x40(%rbp),%rsi

So the kthread is blocked at swait_event_interruptible in the nocb_follower=
_wait.
This contradict with the fact that nocb_follower_head was not empty. So I
wonder if this is caused by the lack of memory barrier in the place shown b=
elow.
If the head is set to NULL after doing xchg, it will overwrite the head set
by leader. This caused the kthread to sleep the next iteration, and the lea=
der
won't wake him up as the tail doesn't point to head.

Please tell me what do you think.

Thanks,
David

diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/rcu=
/tree_plugin.h
--- linux-4.9.37.orig/kernel/rcu/tree_plugin.h	2017-07-12 06:42:41.00000000=
0 -0700
+++ linux-4.9.37/kernel/rcu/tree_plugin.h	2018-07-20 15:25:57.311206343 -07=
00
@@ -2149,6 +2149,7 @@
 		BUG_ON(!list);
 		trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, "WokeNonEmpty");
 		WRITE_ONCE(rdp->nocb_follower_head, NULL);
+		smp_mb();
 		tail =3D xchg(&rdp->nocb_follower_tail, &rdp->nocb_follower_head);
=20
 		/* Each pass through the following loop invokes a callback. */
