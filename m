Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD11C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F84217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nDdnLJiv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BWHc9XcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfAYSzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:55:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52896 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfAYSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:55:04 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PIrDd5009921;
        Fri, 25 Jan 2019 10:54:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eZPrtPAPAPKbK5W7QL8EmrN2fq2UyU3ONq4ikY3vy54=;
 b=nDdnLJivOz5/cx5QEnvx9zwZtxctnaeZYsXg2KimL4FedB+DV1Q1fUqj6tToNKOmlvfW
 J4LPYHfqhBeHvPoiuvzuU312/0pOKxoMPKkU3d38VqO4IRpFRGvQZ9Ttwgu9WD1kZ4zs
 ODx6A2yNfxVa+lFbsCXepGx7M+qrQefMcpA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q86x008ux-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Jan 2019 10:54:50 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 25 Jan 2019 10:54:26 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 25 Jan 2019 10:54:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZPrtPAPAPKbK5W7QL8EmrN2fq2UyU3ONq4ikY3vy54=;
 b=BWHc9XcSx0KuExeeOUUDUo5NAgOq1QTOktNyq9WO8fIg9WE0lq4T03r3FdD5soPavJ0eYePEO/6g2rqQJkggTk272/MOQjiU8Rhco9drHkSFjdV7cxp3nMY/ZSdKuRV/SiXFNuWVv7S5wPwh4wkaqilKifW1goXFrQQZaVamF04=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1712.namprd15.prod.outlook.com (10.174.254.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Fri, 25 Jan 2019 18:54:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::ec0e:4a05:81f8:7df9%4]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 18:54:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     lkml <linux-kernel@vger.kernel.org>
CC:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Subject: perf/x86/intel/uncore
Thread-Topic: perf/x86/intel/uncore
Thread-Index: AQHUtN9kdquBrmJs/06ZsIdLUZtzEQ==
Date:   Fri, 25 Jan 2019 18:54:24 +0000
Message-ID: <E44A3BE5-E45A-4D88-818C-02E6E6342060@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:200::6:7f1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1712;20:hZ9JIRFFbzSajEDM8OoigBxJCFtR7RaujDYaLsDaEtxXWDlhHxthkS2nHmXmFmXdFjM4DZDH3UPcu+aWFfd3vc1cSmQIGw/iR0vWq04irF+58UYVagV8BQo9yABYXM2l2oF8OlLaCu13xkIXEIyEqP42PR4fjtprTmpd0FjLLHs=
x-ms-office365-filtering-correlation-id: 9a8532f3-3e33-41b1-ad23-08d682f686bc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1712;
x-ms-traffictypediagnostic: MWHPR15MB1712:
x-microsoft-antispam-prvs: <MWHPR15MB1712F2D4EF10DC4DFCDEF3DAB39B0@MWHPR15MB1712.namprd15.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(346002)(396003)(51874003)(199004)(189003)(4326008)(50226002)(316002)(36756003)(305945005)(6436002)(25786009)(6512007)(256004)(7736002)(8936002)(6486002)(53936002)(6116002)(82746002)(83716004)(86362001)(71200400001)(71190400001)(81166006)(81156014)(14454004)(105586002)(478600001)(68736007)(2616005)(6916009)(57306001)(8676002)(486006)(33656002)(186003)(6506007)(97736004)(2906002)(46003)(476003)(106356001)(99286004)(102836004)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1712;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IAFqpFmJFv//UvX2zmz1Q7f9EgkyCGFfBng9xLmw9uJe79fLisj3cvwU0i0SjEF/uqsCZaLzwMWTI0sVv8MGK9twa6b2/Wb2hPmf6l4pBkq56GY3xEvaj9Lx9sX4pT/bjJYoVI3Tfy238Ctf1MjLvviuOSo98qySIlZwG/mwRt4C5n9oFQOzYbfrCShBXNYiyYBNMyGF8dI9uEgDmfkFoZPLTlVvgEN2kspOBIMVaxt10MmoraPh6wL6QhZkTjP5fXEXOxcD94bWvE5O/z2dkywmhZ4FTOkJ/2qOn5dkeMU7PskvkrFjytOkhck3HNS1ojiDL8TE7/y8PgAcZZCXCd2/pxTzeSjdlRpPXD4qoaJL/srZtttrB6Efi3JvTZfj4qs5yS96/G5Ae7fra+A/e9xahDFEFMBAPdjx/8L07qE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <641E629144E81C4EACE7C032695DFBAA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8532f3-3e33-41b1-ad23-08d682f686bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 18:54:25.2350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1712
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are debugging an issue that skx_pci_uncores cannot be registered on
8-socket system with Xeon Platinum 8176 CPUs. After poking around for a
while, I found it is caused by snbep_pci2phy_map_init() couldn't find
a unbox_dev:

  ubox_dev =3D pci_get_device(PCI_VENDOR_ID_INTEL, devid, ubox_dev);
  unbox_dev =3D=3D NULL
  ...

The same kernel (Linus' master) works fine on some single socket SKX
systems.

I am not sure what to check next. And I am not sure whether this is
specific to this system (HPE Superdome Flex).

One thing I noticed is that the PCI configuration space shows
subsystem vendor ID of 0x1590 instead of 0x8086:

0000:00:08.0 System peripheral: Intel Corporation Sky Lake-E Ubox Registers=
 (rev 04)
00: 86 80 14 20 00 00 10 00 04 00 80 08 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 90 15 14 20   << subsystem vendor

30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

But I don't think that is the problem as the code search with PCI_ANY_ID.


Any suggestions on what might be broken? And what to try next?

Thanks in advance!
Song=
