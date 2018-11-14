Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9022145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LGNoBf/v";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gNrh9iwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9022145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeKODn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:43:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50194 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725759AbeKODn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:43:27 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAEHd9IZ021517;
        Wed, 14 Nov 2018 09:39:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qxE2EWSO2LFKcNvT1y0Ar90xn7vcfr4GEv5rPegnhEM=;
 b=LGNoBf/vCR6XIbTch+bY1nECZaqmKVQFZqe0HlwGmjlp2qpNdjxfMQnTpLiOqAZGoHHn
 vmV0mAniFSUq1Fv6YKldFPhCXPKc7nFGqmtHrl8DHs+UnRVEhw4It3gat6KE6SHmsEN6
 OwCuw1EDP2CRpPRrT86IP+85X7gRpagg4Aw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nrpq60b4y-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Nov 2018 09:39:16 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 14 Nov 2018 09:39:14 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 14 Nov 2018 09:39:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxE2EWSO2LFKcNvT1y0Ar90xn7vcfr4GEv5rPegnhEM=;
 b=gNrh9iwmGJvFkTniZkPEogOZJHmXBTTpt73Y77DDC0uQ7XmpSgwQLqEhTdTrQ2EDBw3gyIVIe4pdrgWLKk7RCKTjgqx1MSo3w1XXg3Xz4YT1k4wehcUd0dMz6gKsfOyAoIWqBqt4K62Z+X1W/BTBLXrTdqY/CnIwXhW026G+kxw=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0389.namprd15.prod.outlook.com (10.163.109.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 14 Nov 2018 17:39:11 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 17:39:11 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Thread-Index: AQHUetwXxFde3wHnZUKDpNhUsGNNTqVN2ueA///hhYCAAcPYAP//fIkAgACOi4CAAADSgA==
Date:   Wed, 14 Nov 2018 17:39:11 +0000
Message-ID: <20181114173905.GA25468@castle.DHCP.thefacebook.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com> <20181113154825.GC30990@redhat.com>
 <20181113215919.GC15590@tower.DHCP.thefacebook.com>
 <20181114165631.GE13885@redhat.com>
 <20181114170558.GA24889@castle.DHCP.thefacebook.com>
 <20181114173610.GF13885@redhat.com>
In-Reply-To: <20181114173610.GF13885@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:300:d4::24) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:6f7f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0389;20:0jVf2lktGIghXl1JyNHK44gsif2ghXjDcXj1/DPDwYU3fljR4b7Ub3lNYRBE9U2rZK+gaN1bO2RbZCZEtTKBs4+zggTqi9Fe3otuC6O9IW+k+A7K9lHqQQoAFzDOJpuYcruqUtkewt9GNmwpkLlJTiujw2Uzi5GQsYWieijafaU=
x-ms-office365-filtering-correlation-id: 56ec8af7-8648-443b-4471-08d64a581650
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0389;
x-ms-traffictypediagnostic: BY2PR15MB0389:
x-microsoft-antispam-prvs: <BY2PR15MB0389FE27B2D66E35CCDB3AFDBEC30@BY2PR15MB0389.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(35073007944872);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(93006095)(93001095)(3002001)(3231413)(11241501184)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0389;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0389;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(54534003)(305945005)(54906003)(14454004)(4326008)(53936002)(33896004)(8676002)(478600001)(102836004)(106356001)(105586002)(25786009)(7736002)(316002)(6506007)(386003)(6246003)(33656002)(39060400002)(86362001)(486006)(11346002)(476003)(2900100001)(6486002)(46003)(97736004)(71190400001)(71200400001)(256004)(5024004)(2906002)(68736007)(93886005)(6116002)(9686003)(52116002)(6512007)(8936002)(81166006)(229853002)(81156014)(446003)(76176011)(5660300001)(1076002)(6436002)(99286004)(6916009)(186003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0389;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e/aGxsZsz94uVxzlu5zlElh+1heXZkWChUKnLzyhq47frnD7PCTMr82h3bqZOzYNJv8HwbN/IF2+LmTZ2AH0erZR9w10253D6Xy6aaOQUCl1QYjQiP+rzrfkyAAbHZM2ruZqpGEV44PdRfUZGOR7bW0peEWcX7kE0yUNPcH4i778AmwZNhBmItGlGAKZ897th6jnxcl6TqdFmSM/PYTIXEptnpBsKSajD1Ny+Z0/lCI0N61mIbqNbtbZB7BEYq0y26krD0Lh5ycuFFQaqbkaRTfcoDd2b2+hNFz5DFQRhhOlaPu/I6ncCV/HGJnjsTUutlXnsujkVOQbWe4OVVftSfVO+cQinhZecabzhZ3V8XE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A19B4D783DCCE841BA38DDFD6C65A7A3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ec8af7-8648-443b-4471-08d64a581650
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 17:39:11.5774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0389
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 06:36:11PM +0100, Oleg Nesterov wrote:
> On 11/14, Roman Gushchin wrote:
> >
> > > No, this is very wrong. Just suppose the caller is killed right befor=
e
> > > clear_thread_flag(TIF_SIGPENDING).
> >
> > So, I had TASK_KILLABLE before, but had some issues with ptrace/gdb.
> > I'll revisit this option.
>=20
> Yes, ptrace_signal_wake_up() won't wake a TASK_KILLABLE tracee up...
>=20
> BTW. Could you explain in the changelog how should a frozen task interact
> with ptrace? 0/6 says "ptrace works" but that is all. It is not clear to =
me
> what do we actually want wrt ptrace...

Sure, will add.
Basically, I want some minimal functionality to work properly.
E.g. attach to a frozen task, get some info, detach.
