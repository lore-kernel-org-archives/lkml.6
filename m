Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C07C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB007206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="K1dRdnLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfANQkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:40:19 -0500
Received: from mail-eopbgr810074.outbound.protection.outlook.com ([40.107.81.74]:5138
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726656AbfANQkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6qSD5+oQHSG8QBG3NfFkhshvFevXwGd9XXlEVc5/bk=;
 b=K1dRdnLYywSwVuklYkAxHvNbitgNhDhcBCCFQHZSeAK23HO+HsB4yy/7Eb66rvgZ/h2UvXWcfDNSKN5ESRvD5q7JKExrnyQcx/dAezISY7HM40WkxBnJVo/J99AU6U4vpbFv2pTDC9DfX2bunNvykgp6qSzhth3ephtVQpoqRu0=
Received: from MWHPR06MB2896.namprd06.prod.outlook.com (10.175.138.137) by
 MWHPR06MB2478.namprd06.prod.outlook.com (10.168.248.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Mon, 14 Jan 2019 16:40:16 +0000
Received: from MWHPR06MB2896.namprd06.prod.outlook.com
 ([fe80::d992:bb7d:56ec:8946]) by MWHPR06MB2896.namprd06.prod.outlook.com
 ([fe80::d992:bb7d:56ec:8946%8]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 16:40:16 +0000
From:   "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>
To:     Steven Sistare <steven.sistare@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux_lkml_grp@oracle.com" <linux_lkml_grp@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
Thread-Topic: [RFC PATCH] mm: align anon mmap for THP
Thread-Index: AQHUqeoAUFTCAIIvn0CcxSCAmIzKA6WqnMwAgAAaIICABDLiAIAAEBAL
Date:   Mon, 14 Jan 2019 16:40:16 +0000
Message-ID: <MWHPR06MB2896124A4B2B7C9F38383817EE800@MWHPR06MB2896.namprd06.prod.outlook.com>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>,<ad3a53ba-82e2-2dc7-1cd2-feef7def0bc3@oracle.com>
In-Reply-To: <ad3a53ba-82e2-2dc7-1cd2-feef7def0bc3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com; 
x-originating-ip: [207.232.55.62]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR06MB2478;6:f41Cbm7lezw9OnspoiA3BdWGu2hhRiQZ9M99k5O7FVd24+bZ00vxKuoi8RmENZXsBFfw4OWT06D+snP5Sni42NbdwRI3AJyvY5GX0jaMiefCPiw69WXl6UdPJ3z0hPZ1KLUaI0cpG/G+Fphyj+NWUaodJuvrAvdfAbfsBDah9vDuM/nC3PIGGGrdIec2aWQ7BG3WhsytDFEd/FHe6aFfpqJwKRCvvKGbs/vmQ6AClvwwPZ8uDYkUHjOSDy8gQAa0d4QHtiUnfEGfhVQCMHZoHWdGoC5b2rSrBsPsySU+RJkW/NB+kFD3koVENPzI37dIWLLcec+SKxQG1bSQBXzV7DaqP07oOB3mE91UDKiGfwLMrMUXNZmbDq6pGmsLGDiIhjgR58slBCbq/feXawaRbbHN63xYbwE+juSkkE5U+zt80gEEsT9neeWJV5Moyp2XRY/P19ba1rirRZKlCrKkcg==;5:rPKUT5H7Ir6hEcUeoxuszMafJi4OZ4S7B0kOarQ7MZdeQCqAunjEmjc2ZNK+hXCYW3KDKmMkhlOXNMAgMEwcDvqtNvWrnA/ejryiL6NhbF2lNFgaBZuoXkM16hZE1vNWv1QADunqQ4uA1eja1f3U7xEyhQUnTScczEFXCfd/dNoi336ZrEk7N3i2FGf9c1zcczvQDuhfKNJLdHrJI332wA==;7:ZQWTfj5h5bktU5c8PX7Nw6rGyGa3kFBIwcLeu5IX1/GeGFEDxT+TSmEBs72ECBzA397JkQ+uY3ly2w31+Wa+Iv5RLmEQqNW76UZnvyXO3ep6MHnlm6vs22Z1UKbhlz6W2vgsueJjdgbfEGS+7IZfGA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3b5078bd-3825-4a67-5c6b-08d67a3ef6bc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7193020);SRVR:MWHPR06MB2478;
x-ms-traffictypediagnostic: MWHPR06MB2478:
x-microsoft-antispam-prvs: <MWHPR06MB247802D9FEA1752F9E6A658AEE800@MWHPR06MB2478.namprd06.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(316002)(486006)(110136005)(54906003)(93886005)(72206003)(33656002)(14454004)(478600001)(53936002)(86362001)(2501003)(74316002)(68736007)(76176011)(7696005)(6246003)(9686003)(7416002)(4326008)(25786009)(5660300001)(81166006)(8676002)(81156014)(8936002)(14444005)(71190400001)(256004)(186003)(26005)(105586002)(106356001)(3846002)(7736002)(446003)(11346002)(305945005)(102836004)(476003)(6506007)(6116002)(97736004)(55016002)(99286004)(229853002)(6436002)(71200400001)(66066001)(2906002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR06MB2478;H:MWHPR06MB2896.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: coJqLksDD4w42r5Zof6gt4se1NCmQ04268Co0odm53YV3CTnH+Tj8BpMMmcT/mqE/aCrEnttOHAb90n/yRkkMSewsgdpjF/y+Rzu/Hiuel8DGhHEIWbJ6IqNApxlEe0ALbFQ9DhT5iid2c/7LNE1UayLyLnV7nbW8UFs43m7n3LFah9wTwjXuqFPdq8ee/EYM4DZbfUHJQH83EIkJmuEqutplGrcbHKJZO6fBPBGVG3NcfGwYZ+7cGKMC87PNBnH92qyiNadUGG/vWQ3ej9mnKnzh+iLzWeEICQ14cjQa4WFquEXjJjcxj7pMHmdh+x/k+7XOjOQSY/Cktn4G37Z+XXxpQTttNkfEh36tRDTPiqhZlXc6PaDMQIRd0HNRx3xLbM7+jldzOwcCIzcQY4phb9aDJy7iPvdcI1uClXeQLE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5078bd-3825-4a67-5c6b-08d67a3ef6bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 16:40:16.3573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB2478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sistare <steven.sistare@oracle.com> wrote:
>=20
> A better heuristic would be to return an aligned address if the length
> is a multiple of the huge page size.  The gap (if any) between the end of
> the previous VMA and the start of this VMA would be filled by subsequent
> smaller mmap requests.  The new behavior would need to become part of the
> mmap interface definition so apps can rely on it and omit their hoop-jump=
ing
> code.
>=20

Yes that was my original request

> Personally I would like to see a new MAP_ALIGN flag and treat the addr
> argument as the alignment (like Solaris),=20

Yes I would like that. So app can know when to do the old thing ...

> but I am told that adding flags
> is problematic because old kernels accept undefined flag bits from userla=
nd
> without complaint, so their behavior would change.
>=20

There is already a mechanism in place since 4.14 I think or even before on
how to add new MMAP_XXX flags. This is done by combining MMAP_SHARED & MMAP=
_PRIVATE
flags together with the new set of flags. If there are present new flags th=
is is allowed and means
requesting some new flag. Else and in old Kernels the combination above is =
not allowed in POSIX
and would fail in old Kernels.

Cheers
Boaz

> - Steve
