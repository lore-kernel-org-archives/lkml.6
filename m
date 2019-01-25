Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B12C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3C02184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kThBNdZi";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DQaAmRWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfAYWYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:24:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33528 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfAYWYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:24:25 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PMNQSv029569;
        Fri, 25 Jan 2019 14:24:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WAOo868ZQT3gECn6EVWcKQuqfv7kQHi/DUbpQQqmcMg=;
 b=kThBNdZiUSjdO5vQMUJkigqJCblbpXofCYUcUumMx5ia2Im4TLleCxZcKH6z3fQ9fXfR
 hcR6lkoE+Rq8cNPlMdmpO3cPnIHvUZ+H/pfHQNOcTQ80DQJt0XorCcG+2u560glXnoz9
 Qz0zJT+lV/bMbfNr1W5zUjKNdofz8r/5Plo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q89bw0bg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Jan 2019 14:24:21 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 14:24:20 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 25 Jan 2019 14:24:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAOo868ZQT3gECn6EVWcKQuqfv7kQHi/DUbpQQqmcMg=;
 b=DQaAmRWSgXsX8EH6x8XizZlZ9+EpHw27g/c+xejDdfn1olbU8E2P1UOCUbqknD6BSzbTU7VFSrFMlXQEZ1U87o+sI6uIuKotBNWopCRY7oTDBgRvaUyyJC0fQq3rqglKQTZ+ADz03RBqWW5H7jhjJcQ9o3x8H+93k0enb5NVWbs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1952.namprd15.prod.outlook.com (10.175.8.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Fri, 25 Jan 2019 22:24:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 22:24:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: perf/x86/intel/uncore
Thread-Topic: perf/x86/intel/uncore
Thread-Index: AQHUtN9mTaQDMPjjHkuN91Z74fJpgaXAabGAgAACLQCAABYJAIAADcYA
Date:   Fri, 25 Jan 2019 22:24:18 +0000
Message-ID: <700FE2CF-4DA0-4B62-B0B0-A740014CD7B6@fb.com>
References: <E44A3BE5-E45A-4D88-818C-02E6E6342060@fb.com>
 <2f74c906-6d13-ff18-f967-100e82343f2f@linux.intel.com>
 <5350E02A-6457-41A8-8F33-AF67BFDAEE3E@fb.com>
 <50e2eb5b-bb83-6219-d2d7-4ec832b9f5d5@linux.intel.com>
In-Reply-To: <50e2eb5b-bb83-6219-d2d7-4ec832b9f5d5@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::5:4a6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1952;20:E7o7JV6/GekLiyrkC2xhYUMhKhn51tl2NFNAmPiJU5NJP1cCnbkJ8/IhtMjMWa3nJqkpSLsrilRAwGgG3ZdmNt84Yv/5YULftC5soeYlwd8Obp7MxYZnYGB8+ooUuz2DOFqD1czXdetF7rPHemuggqvXUPsYuNdPC3dgj/rI6HQ=
x-ms-office365-filtering-correlation-id: cf2f1cd2-81ec-46a3-d012-08d68313d922
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1952;
x-ms-traffictypediagnostic: MWHPR15MB1952:
x-microsoft-antispam-prvs: <MWHPR15MB19525B2E3278A9E0442B72C1B39B0@MWHPR15MB1952.namprd15.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(86362001)(53936002)(6116002)(25786009)(36756003)(46003)(316002)(6486002)(305945005)(81166006)(50226002)(8936002)(81156014)(8676002)(57306001)(93886005)(71200400001)(71190400001)(83716004)(99286004)(6512007)(2616005)(478600001)(476003)(11346002)(14454004)(68736007)(229853002)(4326008)(6246003)(256004)(33656002)(105586002)(102836004)(106356001)(446003)(7736002)(82746002)(6436002)(53546011)(97736004)(486006)(2906002)(6506007)(186003)(76176011)(6916009)(21314003)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1952;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pt2TahHwuUyZNJQvhaH01SEbSOfFhGHZGPX8N9YWrVYUcsnmljQQ7eh5hTPKXVKu/XBVVKTEFyzBkeWnSbTCxBXJw2DQReJoajz7sZ0V8tAsNL4G2Li4Xd+6/ooo0ejpWClDVqp74mtUOPIyJgE9MnglTBeY61shxv84hZmyrYJYa6ftnU27NGrVkdGQ61taYWjJjIpQ61z1xgFglu/auUtctEtJaKlo9AxcvEXBbx8qampdkaGBBCwKG5n2T7hDZhF4jWWY00xqdfWEyLUhZPukxPD3jxIbMy8ECZuXmuXX84z4bJbqhlgtY2saoRQxc4kYuqOvop1Ue/G1lHGrQF+wJM3sLStHU33PNAleiIewa3jMMzHhbF96ItZ8/W+ShMxyASGLf+96SYV507RgTtUqmzVRBi9oi75yjJetN1M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD25FA228083CA4C94394BABD32F85CE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2f1cd2-81ec-46a3-d012-08d68313d922
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 22:24:18.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1952
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 25, 2019, at 1:35 PM, Liang, Kan <kan.liang@linux.intel.com> wrote=
:
>=20
>=20
>=20
> On 1/25/2019 3:16 PM, Song Liu wrote:
>> Thanks Kan!
>>> On Jan 25, 2019, at 12:08 PM, Liang, Kan <kan.liang@linux.intel.com> wr=
ote:
>>>=20
>>>=20
>>>=20
>>> On 1/25/2019 1:54 PM, Song Liu wrote:
>>>> Hi,
>>>> We are debugging an issue that skx_pci_uncores cannot be registered on
>>>> 8-socket system with Xeon Platinum 8176 CPUs. After poking around for =
a
>>>> while, I found it is caused by snbep_pci2phy_map_init() couldn't find
>>>> a unbox_dev:
>>>>   ubox_dev =3D pci_get_device(PCI_VENDOR_ID_INTEL, devid, ubox_dev);
>>>>   unbox_dev =3D=3D NULL
>>>>   ...
>>>> The same kernel (Linus' master) works fine on some single socket SKX
>>>> systems.
>>>> I am not sure what to check next. And I am not sure whether this is
>>>> specific to this system (HPE Superdome Flex).
>>>=20
>>> Could you please share the offset 0xC0 and 0xD4 of the PCI configuratio=
n space for each device which PCI ID is 0x2014?
>>>=20
>>> snbep_pci2phy_map_init() tries to build a mapping from BUS# to Socket I=
D.
>>> CPUNODEID (0xc0) discloses the Node ID of current BUS.
>>> GIDNIDMAP (0xd4) discloses the mapping between Socket ID and Node ID.
>>>=20
>>> Here is an example from a 4 socket SKX.
>>> BUS    CPUNODEID(bit2:0)    GIDNIDMAP
>>> 0x0    0x0            0x688
>>> 0x40    0x1            0x688
>>> 0x80    0x2            0x688
>>> 0xC0    0x3            0x688
>>>=20
>> Here is the data I get:
>> # lspci -xxx | grep "86 80 14 20" -A 15 -B 1 | grep -e "86 80 14 20" -e =
c0: -e d0: -e Intel
>> 0000:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> c0: 00 a0 00 00 2f 00 00 80 01 00 02 00 2f 2f 2f 20
>> d0: 02 00 00 00 88 d6 b6 00 01 00 00 00 00 00 00 00
>> 0001:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> c0: 01 80 00 00 1f 00 00 80 01 00 02 00 1f 1f 1f 10
>> d0: 02 00 00 00 88 46 92 00 01 00 00 00 00 00 00 00
>> 0002:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> c0: 02 e0 00 00 8f 00 00 80 01 00 02 00 8f 8f 8f 80
>> d0: 02 00 00 00 88 f6 ff 00 01 00 00 00 00 00 00 00
>> 0003:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> c0: 03 c0 00 00 4f 00 00 80 01 00 02 00 4f 4f 4f 40
>> d0: 02 00 00 00 88 66 db 00 01 00 00 00 00 00 00 00
>> 0004:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> c0: a0 b4 00 00 2f 00 00 80 01 00 02 00 2f 2f 2f 20
>=20
> The local node ID should be bit2:0. We didn't mask it in our codes.
> Does the patch as below work?
>=20
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index c07bee3..15a8e3c 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1222,6 +1222,8 @@ static struct pci_driver snbep_uncore_pci_driver =
=3D {
> 	.id_table	=3D snbep_uncore_pci_ids,
> };
>=20
> +#define NODE_ID_MASK	0x7
> +
> /*
>  * build pci bus to socket mapping
>  */
> @@ -1243,7 +1245,7 @@ static int snbep_pci2phy_map_init(int devid, int no=
deid_loc, int idmap_loc, bool
> 		err =3D pci_read_config_dword(ubox_dev, nodeid_loc, &config);
> 		if (err)
> 			break;
> -		nodeid =3D config;
> +		nodeid =3D config & NODE_ID_MASK;
> 		/* get the Node ID mapping */
> 		err =3D pci_read_config_dword(ubox_dev, idmap_loc, &config);
> 		if (err)
>=20
>=20
> Thanks,
> Kan

Yes, this patch works! Now I can see uncore_imc_0 etc. Thanks Kan!

I also noticed that uncore_pci_probe() returns at=20

        if (atomic_inc_return(&pmu->activeboxes) > 1)
                return 0;

for bus 1-7. So we only probed bus 0 (socket 0). Is this expected behavior?

Thanks again!
Song

>> d0: 02 00 00 00 6d 8b 68 00 01 00 00 00 00 00 00 00
>> 0005:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> c0: 81 90 00 00 1f 00 00 80 01 00 02 00 1f 1f 1f 10
>> d0: 02 00 00 00 24 89 68 00 01 00 00 00 00 00 00 00
>> 0006:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> c0: e2 fc 00 00 8f 00 00 80 01 00 02 00 8f 8f 8f 80
>> d0: 02 00 00 00 ff 8f 68 00 01 00 00 00 00 00 00 00
>> 0007:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regist=
ers (rev 04)
>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>> c0: c3 d8 00 00 4f 00 00 80 01 00 02 00 4f 4f 4f 40
>> d0: 02 00 00 00 b6 8d 68 00 01 00 00 00 00 00 00 00
>> Song
>>>=20
>>>> One thing I noticed is that the PCI configuration space shows
>>>> subsystem vendor ID of 0x1590 instead of 0x8086:
>>>> 0000:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Regi=
sters (rev 04)
>>>> 00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
>>>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 90 15 14 20   << subsystem ven=
dor
>>>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
>>>> But I don't think that is the problem as the code search with PCI_ANY_=
ID.
>>>>=20
>>>=20
>>> It looks for the device with PCI ID 0x2014.
>>>=20
>>>=20
>>> Thanks,
>>> Kan

