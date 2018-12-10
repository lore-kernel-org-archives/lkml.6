Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BC8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A86A20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ndhEasR9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ahz55d77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A86A20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeLJT5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:57:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728567AbeLJT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:57:04 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJtOXO019892;
        Mon, 10 Dec 2018 11:56:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=O2MZf8PFryxrUTyGRl1a/jMCEVlZdy2f49K3aKySW/I=;
 b=ndhEasR97gm0YK9cUqdNtGeXSaqCT5Lo0WtN4j11T1lOX0x3ycmvaGkBW34xQH4OMLS6
 HgdwXFieqvadkpixW3Hd+umB+4wW8TGvEOyB2zvXWTIQy+paI8jDmiXNQ+2aAmzKrOM+
 xNUsVlHSI97DQaCCIscJRdR3Or6JvvH3RZs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9wdt8c2j-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:56:42 -0800
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:56:31 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:56:31 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:56:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2MZf8PFryxrUTyGRl1a/jMCEVlZdy2f49K3aKySW/I=;
 b=ahz55d77r6FGa9SL/IvdZvx4I393LlM33CYMWupXH2j3847zKoxAxKmntk7avrrRQQ0wsSTc1Og5SQNBNXvXF9GgzIa84wJiQBzwjWfAo4Pq6+7IwOGud/uoROVZDZhNHcgsZlvcwvDGSMnvOjm36f9snvk5gzZeZbh/jShLGWQ=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1885.namprd15.prod.outlook.com (10.174.98.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 19:56:28 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:56:28 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 00/12] x86/crypto: gcmaes AVX scatter/gather support
Thread-Topic: [PATCH 00/12] x86/crypto: gcmaes AVX scatter/gather support
Thread-Index: AQHUkMJwKbtVtUN9HEO2eLhKcPP8Dg==
Date:   Mon, 10 Dec 2018 19:56:28 +0000
Message-ID: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: CO2PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:104:4::26) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1885;20:PG5r/J1ZJOU/jHYi6etYxuhXzdP6Xy5QAhtXYfaSCkY55IR8e3KCKMHNfG8j/YKm82wy3qGVpvaccGX+eNgHf5ytLW2PC0LKfiw0pN/LeoOTGxWEBRyJcqi4/74UlIp9LHW2cc4KP8lwpC9GHbcD+EcrX9y051q34WN3IIwbK4Y=
x-ms-office365-filtering-correlation-id: b93731c7-0f40-4087-ced3-08d65ed992be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1885;
x-ms-traffictypediagnostic: MWHPR15MB1885:
x-microsoft-antispam-prvs: <MWHPR15MB1885DBEAF2B00674D7D99DE1DDA50@MWHPR15MB1885.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1885;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1885;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(54906003)(97736004)(7736002)(6486002)(486006)(110136005)(6116002)(86362001)(316002)(58126008)(305945005)(8936002)(106356001)(386003)(186003)(6506007)(46003)(105586002)(2616005)(81156014)(102836004)(5660300001)(99286004)(81166006)(476003)(8676002)(2906002)(6436002)(52116002)(36756003)(25786009)(68736007)(4326008)(53936002)(14454004)(256004)(14444005)(6512007)(71200400001)(71190400001)(478600001)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1885;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xVj7rXiEq2tXWYprKLMUYFne7yAtB7I1mPUDiYgXChtSJdl9h2/13t7JnCDx92y+3UGTizzix8UFH7fi0s8VGlipoJw1MFCX7cKHQLHuUfWL4JCp2LJBeL/dHOwcYIWJtv5z5y2VmeCcXf2pgkb0kbD1wj64SWp1f4oFLdfhSWIUzb9XJ6GOBzZSCjD2bbZtxfJXFhQuv3g/SR07dtmqK5IFIZjimpf/ZJwwVeYEKXZUklr0/tEwg98J+bc4ApTygCrMwENnqnMbn0TEYr0IU5A/Jmip08CsEeZWwEOwjyDb1gz1snccZWfeDHXt7M/d
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <914379E01B9F9E4695BA62F75999E850@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b93731c7-0f40-4087-ced3-08d65ed992be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:56:28.6719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1885
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set refactors the x86 aes/gcm AVX crypto routines to
support true scatter/gather by adding gcm_enc/dec_update methods.

It is similar to the previous SSE patchset starting at e1fd316f. =20
Unlike the SSE routines, the AVX routines did not support
keysize 192 & 256, this patchset also adds support for those
keysizes.

The final patch updates the C glue code, passing everything through
the crypt_by_sg() function instead of the previous memcpy based
routines.

Dave Watson (12):
  x86/crypto: aesni: Merge GCM_ENC_DEC
  x86/crypto: aesni: Introduce gcm_context_data
  x86/crypto: aesni: Macro-ify func save/restore
  x86/crypto: aesni: support 256 byte keys in avx asm
  x86/crypto: aesni: Add GCM_COMPLETE macro
  x86/crypto: aesni: Split AAD hash calculation to separate macro
  x86/crypto: aesni: Merge avx precompute functions
  x86/crypto: aesni: Fill in new context data structures
  x86/crypto: aesni: Move ghash_mul to GCM_COMPLETE
  x86/crypto: aesni: Introduce READ_PARTIAL_BLOCK macro
  x86/crypto: aesni: Introduce partial block macro
  x86/crypto: aesni: Add scatter/gather avx stubs, and use them in C

 arch/x86/crypto/aesni-intel_avx-x86_64.S | 2125 ++++++++++------------
 arch/x86/crypto/aesni-intel_glue.c       |  353 ++--
 2 files changed, 1117 insertions(+), 1361 deletions(-)

--=20
2.17.1

