Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792B2C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2365520877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PNSnQdEz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gaF6LXvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2365520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeJECoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:44:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbeJECoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:44:22 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w94JnUiv006267;
        Thu, 4 Oct 2018 12:49:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=w1FAm/64X/oIZPYp+iDdFLbKzbg3dd1/1gN3e557Z18=;
 b=PNSnQdEzrhbWoIlGkVt+ARqVebC252Noezk9WEhVduLPKfcn1LBTzZ/mFoC+6UEdLI8H
 2sqC5CfOkhbuHlSVpmzszACEL2kMGPVHx+M7cV4CFwGcC40OOAuiYbqRp7RYilfMZH+4
 Zz+xqVIpowvFJ+oHzmarLXEiwISgiOyeZ6o= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mwpub0f5u-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 04 Oct 2018 12:49:31 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 4 Oct 2018 12:49:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1FAm/64X/oIZPYp+iDdFLbKzbg3dd1/1gN3e557Z18=;
 b=gaF6LXvrwy6qYtwW14HW1dUbk9kcnem9ggR4X5yRkNDznV8AtQZq4+A3xsTqWkzEBrDm4TV0TCtXUnoDlWsf1h39DlZ6bhl8R7zS1MYi+sESIY8BMk4blfsU3Do3exWep9ns8eHhwOS8gncV1NUyOYycAIB3Qf4YTr+hZB2Ckm0=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0741.namprd15.prod.outlook.com (10.164.170.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Thu, 4 Oct 2018 19:49:22 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba%4]) with mapi id 15.20.1185.024; Thu, 4 Oct 2018
 19:49:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
CC:     Tejun Heo <tj@kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Cgroup v2 thread mode oddity: "domain invalid" cgroup with
 threaded controller enabled
Thread-Topic: Cgroup v2 thread mode oddity: "domain invalid" cgroup with
 threaded controller enabled
Thread-Index: AQHUXBpG2QSB/eWyOU6Gx6MnXcTjwqUPfncA
Date:   Thu, 4 Oct 2018 19:49:22 +0000
Message-ID: <20181004194915.GA12862@castle.DHCP.thefacebook.com>
References: <a4912516-8c6b-d8d3-b714-5c03bcfc5e91@gmail.com>
In-Reply-To: <a4912516-8c6b-d8d3-b714-5c03bcfc5e91@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0083.namprd17.prod.outlook.com
 (2603:10b6:300:c2::21) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:e832]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0741;20:19Kh3Nn/8uMcvVv8HifGTsIKAYn1ZDy81Op9pOWGOiByiVlc/hM4NwY9ryKTcbv5IfZcIe9QJJdZmsnLHR6cyYQJMQmSNBlYNhjELzcLc6QbJdx8x622M2iMWTuLmRFkoLFjsj1JU6v9Be1Rr5njA2NTrsCG1J/tgov21xDwT/o=
x-ms-office365-filtering-correlation-id: affa6c09-d7cf-4075-d8ba-08d62a327adc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0741;
x-ms-traffictypediagnostic: BY2PR15MB0741:
x-microsoft-antispam-prvs: <BY2PR15MB0741CE35914CBC42C5F4FF3DBEEA0@BY2PR15MB0741.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:BY2PR15MB0741;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0741;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(39860400002)(366004)(189003)(199004)(2906002)(8936002)(33656002)(54906003)(81156014)(8676002)(5660300001)(186003)(102836004)(68736007)(105586002)(316002)(9686003)(305945005)(81166006)(6512007)(106356001)(53936002)(6246003)(6916009)(7736002)(71190400001)(97736004)(71200400001)(6436002)(5250100002)(11346002)(229853002)(25786009)(446003)(39060400002)(33896004)(6116002)(1076002)(86362001)(46003)(476003)(76176011)(52116002)(386003)(256004)(2900100001)(4326008)(486006)(6506007)(478600001)(14454004)(99286004)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0741;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7tVqFdLzZc+tDCD+QYtWfTr1OE9gEmKK4AijAP8weXmnq6e3CUxFciL/q/E+fubib+Qbk+6j6rdHebfUH1eX9q8NIV5WyxKgM/Q1xbgs6fuF5S6OtAekS7dUI9mrMTUir/2YM5B6KxZftkoJmXx6w7m2XyHVO9FqAYD6yoOVR6VP485mqp2ohCUpNUBGKtVKoUXUAvS7xcZGkNbiD14ZFBs+AChQCpzmr1s+DRSRmzAQ3a4rkoI4kPW/eUd/ewxgRdabp3kqV7cxxbgReHhzzFeYWN+tMgf5AD9/fdHP9ki+yk3E4KCuld5RP1vkkBkNljph3sPPqwg2GwjxS6U78O+GxqT40Io1vbuMq9GlYuc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81F87F41AC7086478B93F04956517F7C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: affa6c09-d7cf-4075-d8ba-08d62a327adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 19:49:22.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0741
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:40:57PM +0200, Michael Kerrisk (man-pages) wrote=
:
> Hello Tejun,
>=20
> Suppose we have the following scenario:
>=20
> x [d]    (pids)
>     y [dt]    (pids)
>         p [t]
>         q [t]
>         r [t]
>     z [d]
>=20
> Here, x/y is a "domain threaded root" with a threaded controller
> (the 'pids' controller) enabled. (In this scenario, there are no
> member processes in any of the cgroups.)
>=20
> Suppose we now convert x/z to "threaded" type:
>=20
>      # echo threaded > x/z/cgroup.type
>=20
> Now we end up in the following state:
>=20
> x [dt]    (pids)
>     y [inv]    (pids)
>         p [t]
>         q [t]
>         r [t]
>     z [t]
>=20
> This seems odd. x/y is now of "domain invalid" type with a controller
> enabled! This feels like a violation of the rules, since we can't
> in other circumstances do anything with a "domain invalid" cgroup
> except convert it to "threaded". In particular, we can't create
> child cgroups under a "domain invalid" cgroup, or add member processes
> to the cgroup, or *enable controllers in the cgroup*. In fact, when
> doing the=20
>=20
>     # echo threaded > x/z/cgroup.type
>=20
> I had expected a write(2) error because the state of x/y should
> (I thought) not be permitted.
>=20
> Your thoughts?

Just a note: there are now some cgroup core kernel selftests in
tools/testing/selftests/cgroup/test_core.c . It's fairly easy to add new
tests to cover tricky cases like this one. It always nice to have more test=
s,
and also easier to show and reproduce a problem.

Thanks!
