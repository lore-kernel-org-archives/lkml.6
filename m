Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A086520821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="MGvVSsNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfBFSFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:05:54 -0500
Received: from mail-eopbgr700072.outbound.protection.outlook.com ([40.107.70.72]:20410
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbfBFSFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skq5LH0IKhWW3GcTIgZ8fHXVayfNlZc0eFyAdFeAXLs=;
 b=MGvVSsNnYYJnnkA5Y/9o2PElXlz4k8uPbJBKXqgXOauQcjSQqojAPCbsTK4vYPUeZ7HNNUWaOTIuFJIwrucKyMewf90OAexZRAb/Cp9O/xdlWkHo1FTBlcxV5eHBgesCuZuRn9uzYCT8k0oAJR1g4wdxoHO8ix7x/zfqnC9FUn8=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB5249.namprd05.prod.outlook.com (20.177.242.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.16; Wed, 6 Feb 2019 18:05:49 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::52e:b645:417c:a4cf]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::52e:b645:417c:a4cf%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 18:05:49 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Freche <jfreche@vmware.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 0/6] vmw_balloon: 64-bit limit support, compaction,
 shrinker
Thread-Topic: [PATCH 0/6] vmw_balloon: 64-bit limit support, compaction,
 shrinker
Thread-Index: AQHUvkStvw9NM/JPVUmV7bK1hNU336XTEKMA
Date:   Wed, 6 Feb 2019 18:05:49 +0000
Message-ID: <CE790CFD-40E2-4651-A544-17C1311C5F8C@vmware.com>
References: <20190206051336.2425-1-namit@vmware.com>
 <20190206124926-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190206124926-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB5249;20:uUPh2nYgrRDKXZnXj7Fnrm/tc4JAyKQYSez2sGJZujwmbc2fFzAUHX5vypSBYQvbmlN3xMJeeSp/8v2PT5y3UVH+jg+xPj8TCCmfYOp5IErchM2K0fwJ4ivWevcI2MlPgQAbEaLEu2iCYfjitnypp0PH9P4g9byQk3wwtQbFbFM=
x-ms-office365-filtering-correlation-id: c9c38247-89c8-45e9-fade-08d68c5db9ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB5249;
x-ms-traffictypediagnostic: BL0PR05MB5249:
x-microsoft-antispam-prvs: <BL0PR05MB5249C951B33E803EDA5B2B73D06F0@BL0PR05MB5249.namprd05.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(6436002)(97736004)(36756003)(106356001)(6486002)(66066001)(14454004)(256004)(316002)(4326008)(105586002)(486006)(446003)(14444005)(54906003)(6506007)(53546011)(102836004)(68736007)(26005)(186003)(6246003)(99286004)(86362001)(3846002)(71200400001)(82746002)(476003)(11346002)(8676002)(81166006)(2616005)(6116002)(6512007)(83716004)(7736002)(33656002)(6916009)(305945005)(76176011)(53936002)(229853002)(25786009)(4744005)(71190400001)(478600001)(81156014)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5249;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SMRtLJGx1XAyhn34wTQMcbPrk8yWJbpymVDZwPkbJZDP1b5KlVq6bpGN5aE+MuGvaAkd3Ukrlrw9yxCpuQcP/rXBNK98N32dupoMyGo19oS8r70/ubi9gLD5lpdp3uS20lItOopnH2L/lu1miUPSA3Jq56iYnE6aUgPAttFLAt0S3ps1VbEOk0VhZjFSxYv0Y7XQzAfo1uHaxjW1lwrCag9yjyCFqPMaw9IOXyW6Kf82Q+tKYJxaLoKIbjn5gguGFeJiHxTLXHk5s61yO3/K57ELG1605H2lB/oCbICDy1MMrPxtfn2KVkvoG5LMeyoeHaDA4okGgM7IkFP+zsKz70TZt9jFTwtViauRfScFjtN1PRFgPeTXzB6mkPEXooT8sKLbPrw9DaWgRc5a5mjCRdJxvlbeDmF/geshk9naFt4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CE6823711E6D844A289499B414298C1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c38247-89c8-45e9-fade-08d68c5db9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 18:05:49.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 6, 2019, at 9:52 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Feb 05, 2019 at 09:13:30PM -0800, Nadav Amit wrote:
>> Various enhancements for VMware balloon, some of which are remainder
>> from a previous patch-set.
>>=20
>> Patch 1: Aumps the version number, following recent changes
>> Patch 2: Adds support for 64-bit memory limit
>> Patches 3-4: Support for compaction
>> Patch 5: Support for memory shrinker - disabled by default
>> Patch 6: Split refused pages to improve performance
>>=20
>> Since the 3rd patch requires Michael Tsirkin ack, which has not arrived
>> in the last couple of times the patch was sent, please consider applying
>> patches 1-2 for 5.1.
>>=20
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: linux-mm@kvack.org
>> Cc: virtualization@lists.linux-foundation.org
>=20
>=20
> I don't seem to have got anything except patch 0 either directly
> or through virtualization@lists.linux-foundation.org
> Could you bounce the relevant patches there?

Sorry for that. I will resend.

