Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1581FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8A5217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Poa2kmlC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="I25pUWVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfAWEmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 23:42:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfAWEmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 23:42:39 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0N4c3Qd018432;
        Tue, 22 Jan 2019 20:42:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JfWS1GkrQ+6OvnJdRO4O75oiUMPakLgoeVpiHZtQJ3g=;
 b=Poa2kmlCqeHM+Q28MmTCHxy6Y+nNL5ztkBCSOY033lJjauXsCeBPwjxNCL2p04aXraYf
 R3UAIbfNG2Qn2+Kr+OLD3j7M0g3EXJfrF6Di9xbKNwhlit9dHB8iUSV6z5nDIRR75YND
 yCiGhN+PNlTlG5ZYf5osem1aU160wI14xts= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q6g4n05qy-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 20:42:05 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 22 Jan 2019 20:41:45 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 22 Jan 2019 20:41:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfWS1GkrQ+6OvnJdRO4O75oiUMPakLgoeVpiHZtQJ3g=;
 b=I25pUWVMirhm1aNw2zGol69PjG38KXjTlAUg1lSeyI9y2c75AAsGm/rXOsnoJjP7DB+B0d5OXFzx4VvtalE3/vbFZu/zL7wRPr+dF6XAh6mQDJe7qOqNuCbV3dmBAQmP94/7/W5d/m21Cmb0VOa5RRS6IlhSllx+8l2aHvSJa84=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2579.namprd15.prod.outlook.com (20.179.137.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Wed, 23 Jan 2019 04:41:43 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::41b9:104d:e330:d12d]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::41b9:104d:e330:d12d%5]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 04:41:43 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 2/2] mm, oom: remove 'prefer children over parent'
 heuristic
Thread-Topic: [PATCH v2 2/2] mm, oom: remove 'prefer children over parent'
 heuristic
Thread-Index: AQHUsbpO9r6cHpUHDUGFOYyrM9xrUaW8SGSA
Date:   Wed, 23 Jan 2019 04:41:42 +0000
Message-ID: <20190123044133.GA17489@castle.DHCP.thefacebook.com>
References: <20190121185033.161015-1-shakeelb@google.com>
 <20190121185033.161015-2-shakeelb@google.com>
In-Reply-To: <20190121185033.161015-2-shakeelb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0015.namprd14.prod.outlook.com
 (2603:10b6:301:4b::25) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:73b3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN8PR15MB2579;20:LVjlxB5bMyf+SlMNCprzgKsNe1cM2MO5jTSeXS0dluoRudbcVDTw4coevEIRZNPKsRASK94r6tqNnerxnK1ovH/Sv3BlGLNoO1G6yb/v7f6FVNiEOWoqD4/Uf9HdvXUjLcv+AuhxDid8H27YpuheVe9hvsxRqlKCRXEvouHmm4A=
x-ms-office365-filtering-correlation-id: 1aee15bf-4e64-4310-648b-08d680ed12a3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN8PR15MB2579;
x-ms-traffictypediagnostic: BN8PR15MB2579:
x-microsoft-antispam-prvs: <BN8PR15MB25798E2FD29D777B0FA5F966BE990@BN8PR15MB2579.namprd15.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(106356001)(81166006)(305945005)(105586002)(81156014)(8676002)(7736002)(97736004)(8936002)(86362001)(102836004)(6506007)(386003)(186003)(229853002)(76176011)(11346002)(446003)(476003)(46003)(33896004)(52116002)(1076003)(66574012)(54906003)(256004)(68736007)(486006)(7416002)(2906002)(6512007)(9686003)(6436002)(316002)(53936002)(33656002)(4326008)(6116002)(6916009)(71200400001)(71190400001)(478600001)(25786009)(6246003)(14454004)(6486002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2579;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IOfvcTtq335eCIHBdVJ7nc4Gv790DOoJ20R2qMLAw4VBj6vu7piecIDLWkLa6SQZvHTugqlbeEDYYbAKMt8c0CNN+I9GPoyYJtcXdv0mT7B6pOG9weD2FyAf6KnKjSPjDSSN7Ug48aCfFwE0XSFjvOYViqxmouq7Xn0iEUVAm8PaGtP2cAdhNb3Ybe20Me7pCm5HmrmGVa/CsHH0H0a6J6xCYHJ9dFmjgdWi7jq4NWtwZozJMZYHqS9cXVjoOsEpH2SXQ47bFPl72ikWB2lvK2GK3NPPBAEHwwDxhs55WhgKhuY8xcavfSLHOGIBN0Vy0JjBLZrrXL61h5u9fuHStyrX9XDnhsHBeEKn+/YQzQKifLT+pKieXGp2VLHlUdPuwk3dUaO8Kgtl0FXO3rQMbHpcbJGBDQTJCGbwiJPnJAk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD12C87089972E48B9CA64CA7AEA0D5A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aee15bf-4e64-4310-648b-08d680ed12a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 04:41:40.5462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2579
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:50:32AM -0800, Shakeel Butt wrote:
> From the start of the git history of Linux, the kernel after selecting
> the worst process to be oom-killed, prefer to kill its child (if the
> child does not share mm with the parent). Later it was changed to prefer
> to kill a child who is worst. If the parent is still the worst then the
> parent will be killed.
>=20
> This heuristic assumes that the children did less work than their parent
> and by killing one of them, the work lost will be less. However this is
> very workload dependent. If there is a workload which can benefit from
> this heuristic, can use oom_score_adj to prefer children to be killed
> before the parent.
>=20
> The select_bad_process() has already selected the worst process in the
> system/memcg. There is no need to recheck the badness of its children
> and hoping to find a worse candidate. That's a lot of unneeded racy
> work. Also the heuristic is dangerous because it make fork bomb like
> workloads to recover much later because we constantly pick and kill
> processes which are not memory hogs. So, let's remove this whole
> heuristic.

This is a great cleanup, thanks!

Acked-by: Roman Gushchin <guro@fb.com>
