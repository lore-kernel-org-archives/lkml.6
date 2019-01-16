Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CB62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UCFK5HWc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XhPocGon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfAPVQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:16:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57866 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbfAPVQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:16:58 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0GLDUDj026622;
        Wed, 16 Jan 2019 13:16:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=q7+HCnPO6D/KWoisLt05HOZ3nm92pYZHTP7DqFhBAFs=;
 b=UCFK5HWcVt0i9FiySne0tEd5pcHrkdn5W8DDuU38mEjQUryC3xp27ZtOmm4rECH8s8yI
 jpeyVRrMvpCkn1F5vL9OiqO5tIsll9BHicFZ+TTR0GPwIDfWbrZhDaVgL9RIt2lY9V7l
 VceD5lOR4QwjuHwKVUyCaPF1NPoQhXxjGVU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q29h68ndy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Jan 2019 13:16:32 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 16 Jan 2019 13:16:31 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 16 Jan 2019 13:16:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7+HCnPO6D/KWoisLt05HOZ3nm92pYZHTP7DqFhBAFs=;
 b=XhPocGonP6lYZrmyq3OTVSYmAy+7+cHIGvC5WalBPa1R+1kBORdDt6lAQ1NZEdoFCdNei+Kake6FkslfCkhELwd11/eBtgjj+Bly98gdjqMIzNbz3bICm9aNv3Vpj1TJlomeGTXn1wae/XYIQn34qh9wCGXYrnzFX6leIdtxCe0=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1344.namprd15.prod.outlook.com (10.175.3.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 21:16:30 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::b109:3050:fc26:dabd]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::b109:3050:fc26:dabd%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 21:16:30 +0000
From:   Martin Lau <kafai@fb.com>
To:     Mathieu Malaterre <malat@debian.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: Make function btf_name_offset_valid static
Thread-Topic: [PATCH] bpf: Make function btf_name_offset_valid static
Thread-Index: AQHUrdHh9EehrgX/eEebLdg+YVNkzqWyZdeA
Date:   Wed, 16 Jan 2019 21:16:29 +0000
Message-ID: <20190116211627.bs3rrolbjdsxkyvp@kafai-mbp.dhcp.thefacebook.com>
References: <20190116192940.32104-1-malat@debian.org>
In-Reply-To: <20190116192940.32104-1-malat@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0068.namprd14.prod.outlook.com
 (2603:10b6:300:81::30) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:7976]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1344;20:GBoLqq3A0B+t3AQZ0tZFAE12Ai/7oX8aDe4IfqpTZtQ/vNuDpG1ZG7eFFE18xNmu3sIe5bdfJIxVGPw0C781o2X7EQpaT0UKpFdWrgnzyD6AVBv1zKJU8rY4j+AsNB8fUP3S8QixARJv05CBNCBVmLcVxvNijo+sRrWsfosyi2A=
x-ms-office365-filtering-correlation-id: 754267e8-da2b-4e85-1167-08d67bf7e186
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1344;
x-ms-traffictypediagnostic: MWHPR15MB1344:
x-microsoft-antispam-prvs: <MWHPR15MB13440B0CAB301F1FD14AAC2AD5820@MWHPR15MB1344.namprd15.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(51914003)(189003)(199004)(446003)(476003)(229853002)(186003)(52116002)(102836004)(76176011)(71200400001)(71190400001)(33896004)(386003)(6506007)(11346002)(316002)(6486002)(46003)(106356001)(4326008)(54906003)(6436002)(25786009)(105586002)(2906002)(8676002)(8936002)(81156014)(81166006)(9686003)(97736004)(6246003)(1076003)(53936002)(478600001)(6512007)(14454004)(486006)(5660300001)(256004)(14444005)(4744005)(305945005)(7736002)(86362001)(6116002)(68736007)(6916009)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1344;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OhgdUE81bCKHz88LQ6s6zKLr28ZN+Mq2C+Z1yzrcCtCM7ON/l9v0yXmL3jQ/l43WsAIoYKKKjHtbubCHQ/nXRCpQo+juy79cCDRCoz5wt3EnOCeX+FMU+U4BclL0FoYaWkxquM71EhckcM6AgYxLnHQpCUyjqj5F5EjvQS9+cHKeahLiFrqGGBM1rJzXw+giJH9XChOGkAQWhMbzazbPwtPp96oN3HgX2RGPK3W+hMTgXCqJj+6HzwPv5FB2JEZiaEQIUgclT++e5ene/Tq963Y+ixyRDtg6ZKn8XWbA+jg8ME7osf6Xetk0CaKgiyjJkLQoxSaXjPKqaVh0dLMSoxeZi6bff1lPoecCihsidHKg7MDUkMO9PFDddrGp5d5ereLtYpKsjdxBium78FLM00LiD3CRxONKxg4aSSTDArM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FD541D38FC99B42AC8675A59E731370@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 754267e8-da2b-4e85-1167-08d67bf7e186
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 21:16:28.7960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1344
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:29:40PM +0100, Mathieu Malaterre wrote:
> Initially in commit 69b693f0aefa ("bpf: btf: Introduce BPF Type Format
> (BTF)") the function 'btf_name_offset_valid' was introduced as static
> function it was later on changed to a non-static one, and then finally
> in commit c454a46b5efd ("bpf: Add bpf_line_info support") the function
> prototype was removed.
Instead of c454a46b5efd, it was removed from btf.h in
commit 23127b33ec80 ("bpf: Create a new btf_name_by_offset() for non type n=
ame use case")

>=20
> Revert back to original implementation and make the function static.
> Remove warning triggered with W=3D1:
>=20
>   kernel/bpf/btf.c:470:6: warning: no previous prototype for 'btf_name_of=
fset_valid' [-Wmissing-prototypes]
>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
Fixes: 23127b33ec80 ("bpf: Create a new btf_name_by_offset() for non type n=
ame use case")

Thanks for the fix!

Other than the above,

Acked-by: Martin KaFai Lau <kafai@fb.com>
