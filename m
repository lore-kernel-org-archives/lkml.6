Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81CFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E2320857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TIWvB7T5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E2320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeGaUL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:11:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:33148 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729680AbeGaUL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:11:57 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6VITXT0030295;
        Tue, 31 Jul 2018 11:29:59 -0700
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0184.outbound.protection.outlook.com [216.32.181.184])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2kjug7r7ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 31 Jul 2018 11:29:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8ZUXdEY2s7oTJOcVjYe7Vy3mh3BRJaJhY2qD4zNsY8=;
 b=TIWvB7T5Kz3dmiP6NqgGxYnIANs0yj9VZM3fiArhtnVK1lw1wqZFQv2fWn7jLOnUa5Y8MKP7lRIm2efJnjcR/2Wqx1SD+AlzA5OEpcXehjhxqmy6Qg84Hp6C7ptZIiKf4caaR8QrDsbpNtmEXIStzjZ6e5qZRlGdfIeOzYQA8eQ=
Received: from BYAPR02MB4501.namprd02.prod.outlook.com (52.135.239.148) by
 BYAPR02MB5270.namprd02.prod.outlook.com (20.177.124.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.4; Tue, 31 Jul 2018 18:29:57 +0000
Received: from BYAPR02MB4501.namprd02.prod.outlook.com
 ([fe80::fc2a:75b2:a5d4:9da]) by BYAPR02MB4501.namprd02.prod.outlook.com
 ([fe80::fc2a:75b2:a5d4:9da%4]) with mapi id 15.20.0995.020; Tue, 31 Jul 2018
 18:29:57 +0000
From:   David Chen <david.chen@nutanix.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Backport 35a2897c2a (sched/wait: Remove the lockless swait_active()
 check in swake_up*()) to 4.9 branch
Thread-Topic: Backport 35a2897c2a (sched/wait: Remove the lockless
 swait_active() check in swake_up*()) to 4.9 branch
Thread-Index: AQHUKPty7fqAjSD5DkC+tSrYlI0jDA==
Date:   Tue, 31 Jul 2018 18:29:57 +0000
Message-ID: <BYAPR02MB450141DA090306319C646EFE942E0@BYAPR02MB4501.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.193.132.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB5270;6:yyAbLFakuTa6tBsvYp15dgdK5sTivm4meZnxiAoJKTQaL6xewltjsD7cAhKsMZ4ff3aHyg5pNuxhhe98eUHT8vc5n3SXeh7kJLaS7RAp0IGTesNJjZ9vm8RUU3U9h9NxrP0Ff2ryp+gmVDhhm9aRv+uww2ZAWfUwXFQ8+eDJo62UxC1Yn/RpOGOSsFxnpjRwCgvsiOR9Nkj65w1kKRNJZF1PZ1bqAqKU4nwOyB5GDbbrjXBOps1Bf4086tq/8MDixrwXWFPxMd8FichxZq9cweiZ5WA9d8sWSUdD8u4gUV9eqGQqXmrZKVbMM4D0Ujfc38NaeYa8XD7oomI0CpfnztelPgZ8+Jp0OfNnLnSjI1JPxKAdi/USsWaRBxL/pJeC8gYI3+XLxVp89wczHln834jNTDMmPR9UA8cVjTEWLYujp/ZYijRCFS4m5A9MZzWSThWJRJSR17NEvReOUVl7Tw==;5:mGj5hNkcxJqGZwwqnbrK6cpOVqczFgVT3CnTmDXf+jpvPKLzDEc9xUXWyA8EJbXOexkenX3Oi1pmKn7ixyTN/lYjjY/1GYXuR0FZj8baFlYPpoG9IeICMS6P52PgU5Y3vIKf884wBTdyMIeh3jFnF6Lb2zgVIkDA3s2VqMkmDXo=;7:O9U2Cw6Edsl84dF47wbS+nb34sJ4kBxkqbmtzqdzsjvFIt77dIC06ZA6/+EWLQntRTMaWTq7iSqzMwuVUxObisbvt++8j3f2RVzVBg0j1LJs2D03/sjRAw/g5SO4Q5GL/yjlhl+f/p8TU7ukZNGZrNBmcqSDJqFuKnKkAPvTzBYVJo9SbX8vRRLzlBVa9hbAiqvizLNcRUkJJfVd1xu0KbKbAUsJQd4KKOh3uwa1Yv/Y+cmyq3NEdtPb6gRTF49N
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1294c49b-58d3-45fc-2dff-08d5f7139e86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5270;
x-ms-traffictypediagnostic: BYAPR02MB5270:
x-microsoft-antispam-prvs: <BYAPR02MB527082F4D660507FFFCBFFA7942E0@BYAPR02MB5270.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB5270;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5270;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(55016002)(6116002)(4326008)(256004)(7696005)(2900100001)(6506007)(106356001)(25786009)(97736004)(74316002)(478600001)(33656002)(26005)(2906002)(14454004)(99286004)(102836004)(186003)(54906003)(9686003)(5660300001)(486006)(105586002)(66066001)(44832011)(3846002)(53936002)(305945005)(7736002)(68736007)(81156014)(8676002)(8936002)(6916009)(476003)(6436002)(81166006)(5250100002)(316002)(86362001)(66574006)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB5270;H:BYAPR02MB4501.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XtpI/B9YWJtASYeCP5raKsp58HzVn80EGMWYDVJQWggPe1omO5WSNV35yr4bdDIAzhaQ68S5S1do4xEqYQbaOBakeoWlqH1USFsT36Qdy4SyajeSYV6E1rYcJ1dmCTdRKbOJLc9W2H2OJai8QjwfLlK/A1vvLQNe/0BlGgrhJ4TWlUW/OpuMs7tLJd4RmVOVvwnkh6XGPmYPQXpyyPLwbPCjZ9Oj7g5tVzlejGV8MKyquIWfop5UQR0e9m+QEU+Hje2k/6xltD5/eCyFVvLw7YrLTaq75Ye35H2yc1VUUoGyMtrVqZY8c4YqBX6C+pLLDO++X6MZnQ45wCglO6CUgCQj/IN1JnxTY6QE508R9xg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1294c49b-58d3-45fc-2dff-08d5f7139e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 18:29:57.7275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5270
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

In 4.9 branch, we hit an issue in RCU, where the NOCB follower list not get=
ting
reclaimed and causing OOM.

In discussion with Paul, we were able to figure out the problem was because=
 of
missed wake up resulted from lack of proper memory barrier between setting
wake up condition and swake_up().

nocb_leader_wait()
{
		*tail =3D rdp->nocb_gp_head;
		smp_mb__after_atomic(); /* Store *tail before wakeup. */
		if (rdp !=3D my_rdp && tail =3D=3D &rdp->nocb_follower_head) {
			swake_up(&rdp->nocb_wq);

Note, that the smp_mb__after_atomic() is only a compiler barrier on x86.
Originally I was going to change the barrier to smp_mb(). But then I found =
out
master has this following patch that solves the same class of problem by
removing the lockless check inside swake_up().

35a2897c2a (sched/wait: Remove the lockless swait_active() check in swake_u=
p*())

So I'm wonder if we can backport this patch to 4.9 branch to solve this iss=
ue,
and maybe solve other potential missed wake up issue as well.

Thanks,
David=
