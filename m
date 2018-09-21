Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ECCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4399921532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EpxnZvTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4399921532
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbeIUUsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:48:00 -0400
Received: from mail-eopbgr720113.outbound.protection.outlook.com ([40.107.72.113]:21340
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeIUUr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34B0xCvW6W9J3mfaamo9SBYqaJMbSIc8pkv8x+pi+vY=;
 b=EpxnZvTcKO64KceJNQCkND4vkeELZw/M55knXdi5Lpz7SN4qLmhTM2/OtUGbEQszpmbPh/upHFcXEhgvSdVV+pyE14eq3LGXgvZmS18i0ChYyeTEaCs/gpuIstznvY+reHxPcrXNgKZpeSJntO9UAvXQcjHqEFyuyqRx7z86Fog=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Fri, 21 Sep 2018 14:58:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 14:58:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Mikulas Patocka <mpatocka@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.18 032/136] arm64: fix infinite stacktrace
Thread-Topic: [PATCH AUTOSEL 4.18 032/136] arm64: fix infinite stacktrace
Thread-Index: AQHUTjKZkwzoLz5wYky3itWJrfizs6T139oAgAABeoCABPlwAA==
Date:   Fri, 21 Sep 2018 14:58:42 +0000
Message-ID: <20180921145840.GT3821@sasha-vm>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
 <20180917030006.245495-32-alexander.levin@microsoft.com>
 <alpine.LRH.2.02.1809180654220.17180@file01.intranet.prod.int.rdu2.redhat.com>
 <20180918110051.GB16498@arm.com>
In-Reply-To: <20180918110051.GB16498@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:lAm87PqvY9fPAq9P/RjZaUnmwInwYjuKggTBOamMC0A8d0av8Qt63Z6HD+yOyeX8x3hscI/i0x83d9kRh8yq2JgxCGEpmlRNho/Z7bLIMop7tnx304ItHuWFKD0rl2087e8XNa/SgZrsr19iXpTrCkBYXJ0jauPrOyFDVYCKWjbWv1jUTVGPQZoXeOXJ0a3ghrKuFbj72tKirkecUBxnjbFiu0KxEVzfyvfSZQivAhECmCF7K0ziTnAr70ETAvBXE1bE3KdGfaDRdagpcBvKB4AJwTU/xcaL6Sr/DgJdj/w4D73k/r5retyUiktK+aF+0mQSvE9DQZzZ4IhXhSkrrgxQyZ6Olp7shatfXtHXdALkWHPumPz5lzNwldfVC9IXO77RXuA1g5/2Rozy9oBZRdKCe167bvhQ7J4my5kGv3iT4aHr82o1wgzR6iP5gWKgVnkjKEq51OOc3yllMEXnEw==;5:Mrri8oV5zeYWRW8z4Lh3B7WeU6OHezXctBJjTXQzM9hFDlfqokxdx9TL8r/FTQgit5qDUzzOs01tQD+X0c14Lq+zu0e3ghGQbhvK6waln8DmRGEtGYRi6FLHQMFoHtzy1d4rIDH9fJQf2/eBvmeSXIlCF7EGkLn9H4WrUo5AL4o=;7:ueLGvOS2LGgdewORlyu2XqVly8g6ObsKEZ/DURK2FIzIj4/k+9hUfykYY7f9Nw2mRhsePjFox0oar6I5dv1toQJowuUIfZ57MRh2SQUzx0jvCeu77sX2kf5d2hrbleSXdrj/fcB6iNQENNCfHDar4gzOqBXm+QkGtKVOltr4OvKN+3NK7ajFNpFdffr75yPYnPxutiTCLsPuPW6TpYWsfrSI3q9HQJ/4nS8kiM94M5l53GoppUh2jsXpkTrpS4ut
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 16fd44bf-24ec-4cec-c3b7-08d61fd2b917
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01685543003C35CDDBA0B549FB120@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(51914003)(229853002)(8676002)(2906002)(305945005)(6486002)(10090500001)(6436002)(71200400001)(68736007)(478600001)(2900100001)(71190400001)(54906003)(4326008)(6506007)(8936002)(93886005)(86612001)(76176011)(66066001)(81156014)(81166006)(6916009)(86362001)(33896004)(186003)(105586002)(102836004)(486006)(22452003)(53936002)(446003)(26005)(476003)(33656002)(10290500003)(316002)(7736002)(97736004)(6512007)(14454004)(217873002)(256004)(14444005)(6246003)(9686003)(25786009)(72206003)(99286004)(1076002)(33716001)(6116002)(5250100002)(11346002)(5660300001)(3846002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6jCnjfA+EBz4FrskDQcii/JCe48oFP0lWlfkiRGWbDcVuSqeAz3Tg8t5tayAUFIOkWwOaWvyooEXNlrOS9aurv5uJyTY0ww0wtbl/BjakCtlPN91xgb/Bu7NzScO6Co65CZ6VOfYGzwxloxof7XbqFA/ycqM/onZJ/DLsku6R3/VGFkBhr/sB9Inyzl1GuM+uiVSTomVVaIL8diPlG9kABaBqjYh2sfh/MFQyAM7T+joJXDdfsR0eH5jyMXAZlGL7M0pVRxWRvpgxnHC+NWsXZdc4cziocs1kFwqX+CQ/7D0B9MhnYmn02zFo+a1HGvf0MeLCsi2gUzT9oLwpy1/IlNLWP6gtyGEId+dyM9SNQs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C99377D48D4A224DB9A832C49BB9D45F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fd44bf-24ec-4cec-c3b7-08d61fd2b917
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 14:58:42.6876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:00:51PM +0100, Will Deacon wrote:
>On Tue, Sep 18, 2018 at 06:55:34AM -0400, Mikulas Patocka wrote:
>> This patch is not correct, because the stacktrace is supposed to work
>> around discontiguous interrupt stacks.
>>
>> You should replace 'frame->fp <=3D fp' with 'frame->fp =3D=3D fp'.
>
>No, just drop the patch. It was already reverted upstream in
>e87a4a92fba3. Can the AUTOSEL robot check for upstream reverts?

It does! Once when it grabs the patch and once right before Greg sees a
pull request. There's a (rather large - ~2 week) time gap in between
when fixes/reverts sneak in.

Thanks for the review, I'll drop the patch.

--
Thanks,
Sasha=
