Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCC4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7713820848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pTraOz16";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NegAf/PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7713820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeLCRzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:55:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49608 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbeLCRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:55:54 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB3HrXQL025198;
        Mon, 3 Dec 2018 09:55:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jXgZmmGrKJOCH7aXns46ZCD3NukG2hkqMLsh3ROlQSY=;
 b=pTraOz16Qug3Wy6ITtrBMdD8cBywjhMEQZvStRzMQ3+LJ2dK8yzp9XlE2Io7QgXV49gf
 0gSOwQ7B18CFpkV9MoP5L2LxmSETu4HyYMnKVRYAVPk+c+wI8W98yXpKYWHN+Xl2PDmy
 J5Ybxe5RZFZikvo19qITE82Emi50HlWQ3vc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p56fjgprg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Dec 2018 09:55:39 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 3 Dec 2018 09:55:37 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 3 Dec 2018 09:55:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXgZmmGrKJOCH7aXns46ZCD3NukG2hkqMLsh3ROlQSY=;
 b=NegAf/PUbTfQMkN4Jz/EF5FsiLbCJdThsiMPaHgVxvT1l+Iwbwf25Fgs+7/po7O3XcCkQ2RLHqi0rgyOm1TC1ldkWvVVmirVR4xKcKhQEY5uH56or7D0JGUvSeloLgNmwstR/t/+8ULDXZAThW2qH6jPD0NKDsXIry+aM68ZA8o=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0309.namprd15.prod.outlook.com (10.163.65.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 17:55:32 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 17:55:32 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Roman Gushchin <guroan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v4 3/7] cgroup: protect cgroup->nr_(dying_)descendants by
 css_set_lock
Thread-Topic: [PATCH v4 3/7] cgroup: protect cgroup->nr_(dying_)descendants by
 css_set_lock
Thread-Index: AQHUiQcqg9FeP0KCwE+U9gDrsk6hyKVtNTUAgAAbfAA=
Date:   Mon, 3 Dec 2018 17:55:32 +0000
Message-ID: <20181203175525.GA31090@castle.DHCP.thefacebook.com>
References: <20181130234745.6756-1-guro@fb.com>
 <20181130234745.6756-4-guro@fb.com>
 <20181203161706.GL2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181203161706.GL2509588@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0135.namprd04.prod.outlook.com (2603:10b6:104::13)
 To BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:1d19]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0309;20:WK04FN5ZLjC8MZ8KqEG4v6s8nzcoDqT3hvWUzRAvEkcncX6YQEiEgcmfMlUmfzxO0zyTtUM7infxgLsfmD9X2t/XDcGeQlLXS7kIMNRfA0l7plqMy7xGlRIqKTOHnNg0HwqV9De1Qy0PB6JBcQ7pzYR9eNnBoJ1M2qGCLJXLHXU=
x-ms-office365-filtering-correlation-id: ed0a4ab3-1041-4ad7-062c-08d6594884a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0309;
x-ms-traffictypediagnostic: BY2PR15MB0309:
x-microsoft-antispam-prvs: <BY2PR15MB0309F9CFE7BFD1511E52B804BEAE0@BY2PR15MB0309.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(3231455)(999002)(11241501185)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0309;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0309;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(53936002)(68736007)(386003)(102836004)(6506007)(9686003)(46003)(33896004)(6512007)(6916009)(54906003)(186003)(14444005)(256004)(33656002)(4326008)(2906002)(8676002)(39060400002)(6246003)(1076002)(105586002)(106356001)(6436002)(478600001)(6486002)(316002)(25786009)(76176011)(476003)(7736002)(81156014)(6116002)(81166006)(8936002)(305945005)(446003)(11346002)(97736004)(52116002)(99286004)(14454004)(5660300001)(229853002)(86362001)(71190400001)(71200400001)(486006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0309;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WY5U90tKQNM4yiWODoAT6d1MPFs/cavAGTZXeJd+lZFJm8gH/UBcbRh1M+J8km5ykJuS0Gj0tq0KcLPcckNJsZ09E/13ql2AqH/LyXUQmPKGFhfLpJUiZj0Qs4C2dQY8sSM1MlmV0B2/T9+lBJLHia+zBk+m8LVGeTD5RNXMe/+iTnGpPDbYBfoi0TT5+wIgYCYtnpxmYJ1qRpxUd+bhAFmCyzaJBo0PlaG/tdT4N5o2NWfYNLjzjmDcqceCa10nLJJRCP65jpM7FBjAflSLH0BO/ovjKKuOj5z5ZAjOwAwVz0Qe00chPRPbLTjsHtl+mE64Td6CNPlnU75eR5crptzOHVs16XFeULY477tJUyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BFDF386C6DA804C8707CAE220CD369C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0a4ab3-1041-4ad7-062c-08d6594884a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 17:55:32.2445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0309
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 08:17:06AM -0800, Tejun Heo wrote:
> On Fri, Nov 30, 2018 at 03:47:41PM -0800, Roman Gushchin wrote:
> > +	 * nr_descendants and nr_dying_descendants are protected
> > +	 * by cgroup_mutex and css_set_lock.
>=20
> Can you be a bit more specific - hold both for writes, either for
> reads.

Sure. Thanks!
