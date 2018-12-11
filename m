Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE496C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953A52086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pYeXvj1L";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bgfLwWgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953A52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeLKRTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:19:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbeLKRTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:19:55 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBHGofW015889;
        Tue, 11 Dec 2018 09:19:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BYLxUkozcVrMoH8Y7f3yvbfurewgLhZDTJwUA4Wc2cw=;
 b=pYeXvj1LR5+84ib1Dj1cUnGYSp96Ixpc6XycVfa7epaVHSQsD5ptmqvel62cdExIVDqp
 t4VBR3wVayY1kz2p9O5K7dBN0ncf0TqX1JKQ9/Hf01Y2hRDqxHM0uf20lMY6xS4oDkZO
 m8Z0JbhnXmj84cjxoM7AG12PB5kpywXKYJU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2paengrsth-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 09:19:34 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 11 Dec 2018 09:18:35 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Tue, 11 Dec 2018 09:18:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYLxUkozcVrMoH8Y7f3yvbfurewgLhZDTJwUA4Wc2cw=;
 b=bgfLwWgo9NeBhgxK7SOmSWXKhP6B4+y/HOb+RnZLPV4edDUrf9fxIfTC7s1EEPuqJtDhEUj0aHsd0H8/mOvlTt60Rc7Hyacisloxqjk/cSxL8jrEmC8oLaHIeK1qphAsAqS3L2ozGsFy6f08qUnikHMko6BxWZ4eIPqliGYqwWg=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1326.namprd15.prod.outlook.com (10.175.3.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 11 Dec 2018 17:18:33 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::14db:7315:30f7:10d7]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::14db:7315:30f7:10d7%7]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 17:18:33 +0000
From:   Martin Lau <kafai@fb.com>
To:     Roman Gushchin <guroan@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: add btf annotations for
 cgroup_local_storage maps
Thread-Topic: [PATCH v2 bpf-next 3/3] selftests/bpf: add btf annotations for
 cgroup_local_storage maps
Thread-Index: AQHUkOIroIjX8FpQFkGLspDtogcZeaV5yU+A
Date:   Tue, 11 Dec 2018 17:18:32 +0000
Message-ID: <20181211171831.cu7mxi2jqbitzvst@kafai-mbp.dhcp.thefacebook.com>
References: <20181210234302.31327-1-guro@fb.com>
 <20181210234302.31327-4-guro@fb.com>
In-Reply-To: <20181210234302.31327-4-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:301:4c::18) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:a71b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1326;20:i8IW65RnLreQe6fPRTfCArcZEPLIIUzGIA/enhBN1/3Y5hFlAweYRJZZJtUdmMjDiVlKoumq7yRwUZdZv0BIJEx/NhpPzWWkIIdc94DV19pcFiBvj2XrSQ8xck/BNH8PQvSyK/mVFTTMINHJ2uEDIWzyW67II3+leA8yBKcHbBo=
x-ms-office365-filtering-correlation-id: 61745485-cfe7-480b-1505-08d65f8cad41
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1326;
x-ms-traffictypediagnostic: MWHPR15MB1326:
x-microsoft-antispam-prvs: <MWHPR15MB1326892C3AB98FC164A82EFDD5A60@MWHPR15MB1326.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1326;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1326;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(5660300001)(6436002)(2906002)(14454004)(1411001)(256004)(14444005)(71190400001)(46003)(102836004)(186003)(71200400001)(86362001)(6506007)(386003)(76176011)(6916009)(486006)(8936002)(446003)(81166006)(8676002)(6116002)(33896004)(52116002)(316002)(6512007)(6246003)(81156014)(1076002)(4326008)(39060400002)(53936002)(9686003)(54906003)(25786009)(305945005)(97736004)(558084003)(7736002)(68736007)(476003)(105586002)(99286004)(11346002)(6486002)(478600001)(106356001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1326;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q+m++UXtRScO+RB+7joWA+fI5ijDsgxN7Lt+P5xYy7ULWJXBn+/m2ACN2+wCdq6qIHlUj64MP7Xl8d1tjkxWTerA0gej6NYIHJbwBPhKFQ69ZJpbuOA2sE8dhfJITYbMP6ENB7uE1DdJJmAi0dFIG5d7runF92wpiLV9yl+cybUYLwpuGvG002fQAhVrs54q7Kjw3l5LO6/Bb8vHuc1mUc7RWrvUhW0RC7SI2fEEV/V1AxKi+xwFf9YD84eNa8fgxbQWRVpOvKUezNB39e3KBtkLDFHryUWinzUhrVYTJzCEfqHMZZuWOp+U3ET0ZQq2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC0D6F376E4C78458C1F896906EC852B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61745485-cfe7-480b-1505-08d65f8cad41
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 17:18:32.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1326
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 03:43:02PM -0800, Roman Gushchin wrote:
> Add btf annotations to cgroup local storage maps (per-cpu and shared)
> in the network packet counting example.
Acked-by: Martin KaFai Lau <kafai@fb.com>
