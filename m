Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42389C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F462275D4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JOwONjgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F462275D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966994AbeF1PGF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:06:05 -0400
Received: from mail-eopbgr710127.outbound.protection.outlook.com ([40.107.71.127]:17808
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966979AbeF1PGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX7kArEEnf9iMTB57T0G6o5nkJQBKK5zKIfrPn413mk=;
 b=JOwONjgyNZ4XzoIVAGIVGibVvTv4dQrLGSgRnXkRuIv+o2whfl+DJPUjcWMSY5kE2U4sSFfcnLzFp5qVL/BdEHsk7hObXpypZako9vwtNRUACQy74WMARM19qxptIj0tKnXfWVPzZqXcUTCyr9B6pn12e6yX/M9Em+kDOVGGSJw=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0922.namprd21.prod.outlook.com (52.132.152.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Thu, 28 Jun 2018 15:06:01 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b%2]) with mapi id 15.20.0930.005; Thu, 28 Jun 2018
 15:06:01 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
CC:     Radim Krcmar <rkrcmar@redhat.com>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] KVM: x86: hyperv: implement PV IPI send hypercalls
Thread-Topic: [PATCH 3/3] KVM: x86: hyperv: implement PV IPI send hypercalls
Thread-Index: AQHUCjky7sVBlzEva0m3QQTkSO6XC6RspcaAgAkX2ICAABCe/YAAAEHA
Date:   Thu, 28 Jun 2018 15:06:01 +0000
Message-ID: <MW2PR2101MB111321A223A1A94D10ACA66EA04F0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180622145616.5851-1-vkuznets@redhat.com>
        <20180622145616.5851-4-vkuznets@redhat.com>     <20180622191333.GC2377@flask>
        <CANRm+Cyj_Bw1nx=K9KDv7MDDdB--DxNAyRwFwCff_twXk1tPPg@mail.gmail.com>
 <87vaa3dkao.fsf@vitty.brq.redhat.com>
In-Reply-To: <87vaa3dkao.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:48b1:f1f0:892f:c11e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0922;7:ha8i4OD7CGl2uDR/A1AYOicCeCEpO3e8XZa4Ovdn6uXnKHsZrrmru+WxDUwS264GmRsMD+Gql+AMOyIn57VUObaS9hGIsDkAY7LiTPH0Z59vLUCnq0dwQYGyxCke8hqY0X/JNqqS1jKjHZN4KhxEx6xjQWzwrKM2GdK3iXGMVPy7kApmWS8S+t9yJVsph78p23bNO8wM0hLy/epqSk/9gj4OTbXAvh4Oc5xYEmP9EgiPHJ6+H9Irv7wPpPo5203M
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ce2a0665-3d85-42d4-f9aa-08d5dd08a977
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:MW2PR2101MB0922;
x-ms-traffictypediagnostic: MW2PR2101MB0922:
x-microsoft-antispam-prvs: <MW2PR2101MB09220359748A708FA2E3FD46A04F0@MW2PR2101MB0922.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0922;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0922;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(136003)(396003)(366004)(376002)(13464003)(189003)(199004)(4326008)(5660300001)(39060400002)(76176011)(105586002)(106356001)(33656002)(97736004)(25786009)(102836004)(6346003)(53546011)(6116002)(229853002)(6506007)(7696005)(68736007)(10290500003)(316002)(46003)(7736002)(305945005)(14454004)(5250100002)(10090500001)(86362001)(478600001)(486006)(256004)(8990500004)(2900100001)(93886005)(9686003)(74316002)(99286004)(110136005)(55016002)(6436002)(54906003)(22452003)(6246003)(86612001)(186003)(81166006)(446003)(8676002)(8936002)(81156014)(11346002)(53936002)(2906002)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0922;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-message-info: hYTyS/w/z5FCRH5Y4AvjGjUf5EKFCg5g6F9n2xqEQgat7sGsm6gKF0YhepqKSVm70fBfjnmSub3X132jWm+P5Df82+fjGTZsWgGDHOZfcnGUq8d2T37J+kOdmsUbT+TQj7NOOf4JkSM+zVXjXG/eNXhzGpq546vltn/dIG2CU4T3ycYDP/lk9jp9w61TBokOZKx+G5b5BZR87D9w8DqiuoLkueAJmnlpimH8NkJOkPfD3vW/1oXgJDkZ7V/cVEN0wwvYR/o0LG7PktpLGtwh+4v0Jt2yjTD3vLCphJS1kh/ng8GJXQWm/wbPYupdGt/eENweCIaDOZsp0kfXo6Dm0Kmc8gim78MIJT927Ui34D8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2a0665-3d85-42d4-f9aa-08d5dd08a977
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 15:06:01.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0922
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Thursday, June 28, 2018 8:05 AM
> To: Wanpeng Li <kernellwp@gmail.com>
> Cc: Radim Krcmar <rkrcmar@redhat.com>; kvm <kvm@vger.kernel.org>;
> Paolo Bonzini <pbonzini@redhat.com>; Roman Kagan
> <rkagan@virtuozzo.com>; KY Srinivasan <kys@microsoft.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; LKML <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH 3/3] KVM: x86: hyperv: implement PV IPI send
> hypercalls
>=20
> Wanpeng Li <kernellwp@gmail.com> writes:
>=20
> > Hi Paolo and Radim,
> >
> > I have already completed the patches for linux guest/kvm/qemu w/ vCPUs
> > <=3D 64, however, extra complication as the ex in hyperv should be
> > introduced for vCPUs > 64, so do you think vCPU <=3D64 is enough for
> > linux guest or should me introduce two hypercall as what hyperv does
> > w/ ex logic?
> >
>=20
> Neither Paolo nor Radim but as we already have
> #define KVM_MAX_VCPUS 288
> on at least x86, supporting <=3D 64 vCPUs seems to be too limiting for an=
y
> new functionality.

Agreed.

K. Y
>=20
> --
>   Vitaly
