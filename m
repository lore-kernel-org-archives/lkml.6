Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E55C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC342084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eRph4k/P";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="in0Prwr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC342084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeJBCBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:01:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49174 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbeJBCBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:01:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91JIIBh022853;
        Mon, 1 Oct 2018 12:21:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Dbw6BIfIlh22RYSpmuWZrK6iRGrj4Mqo3F56a3SgpWQ=;
 b=eRph4k/PNnkUDmE7HR6rXZI/t1OV7qDj3wW+VyuXZWqEtS0mq5LaKCOI1/YH+xB45F5e
 NGTsMHA3HEGOT38kXgW2R7LF3T0caNC2buAujaqNNl+yNqPVFRZ+hDbgd3ux6/5Tnk3u
 lKgrOJ2xhJ7DUV/FvJiaE/G7Kv2hCEhr4ao= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2murj8g7bw-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 12:21:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 1 Oct 2018 12:21:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbw6BIfIlh22RYSpmuWZrK6iRGrj4Mqo3F56a3SgpWQ=;
 b=in0Prwr0LRezGvCuaL19v+YSrJ6PE8SVv4zHdpZAH2upZDQq5USrI4FFfgKbXC0Xysn6afuJPw8nED3s08MAYM6mmlBN/FYD3mFKGAHn349mzcHmEneinKyMPIVKb0wzZqq9aeMsLu+Vic6IbeA217LfPKQWltMkpiXcqNshihc=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0759.namprd15.prod.outlook.com (10.164.171.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 19:21:23 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba%4]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 19:21:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com" 
        <syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in pcpu_alloc
Thread-Topic: WARNING in pcpu_alloc
Thread-Index: AQHUWbP7s66ewJiSa0SppKFj5uwleKUKxHjk
Date:   Mon, 1 Oct 2018 19:21:22 +0000
Message-ID: <3C215C12-D2EB-4A3D-B2F0-7A27875B8061@fb.com>
References: <000000000000357da505772ec5ad@google.com>,<CAADnVQ+DyZ5ze4gjfgQz+OATRE_Jd1b5D1osq8+8O3BL9vHzhg@mail.gmail.com>
In-Reply-To: <CAADnVQ+DyZ5ze4gjfgQz+OATRE_Jd1b5D1osq8+8O3BL9vHzhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [107.77.211.19]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0759;20:SoN1f1ylpMo1M8IXeipSnOYU3x92TWFZvlKYVl6+s5zHfCe1OS0oHqcyy1xWGrT73Ga28snce43h+jUlnWYypD+sxS+AzwqhH5hn2oNCMx4mcPcpycakLbiXWUASLE6p2Pq6x/dZujc6hHFWrkTuEUuBEfxK8KcUj/3K3FzOWGY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 420211cd-ac1a-4dc2-75c6-08d627d31309
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0759;
x-ms-traffictypediagnostic: BY2PR15MB0759:
x-microsoft-antispam-prvs: <BY2PR15MB075900EDE20D97E10B127911BEEF0@BY2PR15MB0759.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(10436049006162)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR15MB0759;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0759;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(136003)(366004)(396003)(199004)(189003)(105586002)(305945005)(5250100002)(106356001)(7736002)(9886003)(68736007)(486006)(446003)(39060400002)(3846002)(6116002)(11346002)(97736004)(82746002)(6486002)(2616005)(6916009)(476003)(7116003)(5003630100001)(81166006)(81156014)(2906002)(8676002)(8936002)(5660300001)(256004)(14444005)(186003)(66066001)(33656002)(26005)(36756003)(6506007)(575784001)(54906003)(6246003)(4326008)(86362001)(102836004)(25786009)(76176011)(6512007)(6306002)(229853002)(53546011)(966005)(14454004)(53936002)(99286004)(83716004)(71190400001)(71200400001)(478600001)(2900100001)(316002)(6436002)(99710200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0759;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cmY+dJeiIeLbJ616d/gSOAq8wT1EchEJYL99UB6Z4+6HCWpeKC4a/7t6J+O07joAJPxAg3Mrc1bSvmFOK6vQxoysvS4bmz63d0Z90rikF2KZSNCkGEkdzycd8v6AKa53uqKV9aalmchYQUXYqbwOuXP6OzIeKKIoR8e1qVfQ2oLLtVfEbTVnqaagIRC/KYr7tSNv+wEcU98SBek8xnz7+doWp5Y+Zt6W8lphG41hD3Nok3PEPV/qrJomYNI1Twy/jeIX55Hg8AO4Wvb9wm2B0o7drxSH8m3gbnZPgBlQL8DlSKfp0PgtGkKnwk/fAW7u6ltTq5+ZYBhZPP6AYc+CnZHOp6CssNohBAHc46XRT1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 420211cd-ac1a-4dc2-75c6-08d627d31309
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 19:21:22.9067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, will do soon. Thanks!

Sent from my iPhone

> On Oct 1, 2018, at 20:24, Alexei Starovoitov <alexei.starovoitov@gmail.co=
m> wrote:
>=20
> On Mon, Oct 1, 2018 at 6:14 PM syzbot
> <syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com> wrote:
>>=20
>> Hello,
>>=20
>> syzbot found the following crash on:
>>=20
>> HEAD commit:    c5a9f9817ba5 Merge branch 'bpf-per-cpu-cgroup-local-stor=
age'
>> git tree:       bpf-next
>> console output: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_log.txt-3Fx-3D175f98e6400000&d=3DDwIBaQ&c=3D5VD0RTtN=
lTh3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3DRDq5scOAUEmnSy8tXTh8WldgNIIBk=
pJow65eBMO1X78&s=3D1gv4CbD91yt2XHXTnOVUyGN15DqWWFz3xYlo9ioGZEw&e=3D
>> kernel config:  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_.config-3Fx-3D443816db871edd66&d=3DDwIBaQ&c=3D5VD0RT=
tNlTh3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3DRDq5scOAUEmnSy8tXTh8WldgNII=
BkpJow65eBMO1X78&s=3DEdREqNHdZup-52h5rZo0Mq59K3DYw1YVizBexkGikEk&e=3D
>> dashboard link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_bug-3Fextid-3D18628320d3b14a5c459c&d=3DDwIBaQ&c=3D5VD0=
RTtNlTh3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3DRDq5scOAUEmnSy8tXTh8WldgN=
IIBkpJow65eBMO1X78&s=3DQlmeF_tfsUIhzLLRKSwcR5ruQyqZA5wqow5kw_BRA6o&e=3D
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_repro.syz-3Fx-3D129cbd1a400000&d=3DDwIBaQ&c=3D5VD0RT=
tNlTh3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3DRDq5scOAUEmnSy8tXTh8WldgNII=
BkpJow65eBMO1X78&s=3DVDTRxfcVTxFp9LiiLsUYKevDzawNsYjRuqMHAZ7an2c&e=3D
>> C reproducer:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__s=
yzkaller.appspot.com_x_repro.c-3Fx-3D16685ac9400000&d=3DDwIBaQ&c=3D5VD0RTtN=
lTh3ycd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3DRDq5scOAUEmnSy8tXTh8WldgNIIBk=
pJow65eBMO1X78&s=3DPIFdU3kSa5SEp7k0bav9JxpLGyBiPz84uRE25vyl5_0&e=3D
>>=20
>> IMPORTANT: if you fix the bug, please add the following tag to the commi=
t:
>> Reported-by: syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com
>>=20
>> ------------[ cut here ]------------
>> illegal size (0) or align (8) for percpu allocation
>=20
> Roman,
>=20
> looks like
>        if (attr->value_size > PAGE_SIZE)
>                return ERR_PTR(-E2BIG);
> is not enough, since value_size=3D=3D0 needs to be rejected as well.
> Could you prepare a patch?
