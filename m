Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B3EC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE09D2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HVD9B9Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE09D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeKBLvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 07:51:17 -0400
Received: from mail-pu1apc01on0138.outbound.protection.outlook.com ([104.47.126.138]:35825
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbeKBLvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 07:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAjfNQdwv6tVxgV3TMzbNrh5CJnehUzbyxN/Q0su/f0=;
 b=HVD9B9Z9HyiM+DJqv4gpQPJrLB4e6zpAKB6IXf3FQugji2CKkDTE/RYhuEdv25BVDA71N8mL+LEVmUQM6v1qgMmJbdkxbnxWUs+PeLg0mWsK77TsQ7WDJuFrBoxmTu04NKAylb0KNTgrJ5H4hJPdVaGD7pYfjlcHkIrLjvQSCcQ=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0121.APCP153.PROD.OUTLOOK.COM (10.170.188.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.1; Fri, 2 Nov 2018 02:45:43 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217%3]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 02:45:43 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Roman Gushchin <guro@fb.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: RE: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Topic: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVcwABuNOAAAOCDwA=
Date:   Fri, 2 Nov 2018 02:45:42 +0000
Message-ID: <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
In-Reply-To: <20181102005816.GA10297@tower.DHCP.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-02T02:45:40.4138380Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a27f:df20:8102:641d:eddd:25f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0121;6:Xn7NY2Zv90TLj+I1Sl7vhPCYZX1arWgoibFNitrMl3p6PegCybl7oqnUT1kz8+Yu2Cqw2hrTPdnphuJeTDYrERr44QeTI3kP0rHOg30sOS3P384ZjtTpJyyNuuCl4o9NxTNCDlwf6FbFiSgcImF8K0/T0HTHOBpZ5HJ0FVyXHfj5IKyHmdSXSVeldUK1H/pOauMVN4+VLZdIo8V1MZq9icOT8ZG9RN4Ma2O4+vdDnUO9jdfBCoqpwMKbV5PfkMYWAAnykKF8onbvHysPyKI3prMxrB9duPfyaEt/3nbL2OR8T+mf1scfYwyonHfP9Y23dSWG18XAtuLLrSlLMCTwdOZbNItCLZrbZyhGzaTQPuqyN1ENVDWyWLrZo0oIffd+KsQ3pM7LuXIvoMDETHb1Tx7QPeZDJf9UJh8rS4/Ze9CVbdDhLcqjk+xhsozLkrOJ4+JH92VMFi+ZXFPU5ukp/A==;5:iwP/PIulxhfQ+si4wBYagemPeIfAGS0879fAz/raJd8HXIQFTgGFenhA5VToF0aSvgwMzffDZ14EXGvZXO6PQuFYhi9HUoSyDdSViBbnNshumnDmCARa5+cSxSw6a04aCzb6EzvRQKh0Nqns8oHrvZnMpb2jMXsdLKVnQgwIUW8=;7:Vh4jlc+kn2YqrLHvfUewDs40HXcJxOY8x+MWhc5qL/WbrU814miOTkfrrQREd37eQDGgN2Qq2b1zZnunRnY8SIjNL/ke8ErpggdvhcGmt9Yk/ALTGudwzubWR/nI742bt7kMGe8iWDO4CZAujc1wmQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c669e7ee-19e0-4a83-5516-08d6406d48a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0121;
x-ms-traffictypediagnostic: PU1P153MB0121:
x-microsoft-antispam-prvs: <PU1P153MB012166E868DD38A35DFF5813BFCF0@PU1P153MB0121.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0121;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0121;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(51914003)(6436002)(5660300001)(8676002)(14454004)(46003)(486006)(10090500001)(99286004)(33656002)(53936002)(55016002)(186003)(9686003)(6916009)(8936002)(446003)(76176011)(7696005)(2900100001)(478600001)(8990500004)(10290500003)(11346002)(97736004)(81156014)(102836004)(476003)(81166006)(229853002)(6506007)(86362001)(25786009)(22452003)(71190400001)(71200400001)(39060400002)(6246003)(86612001)(74316002)(7416002)(2906002)(7736002)(305945005)(316002)(106356001)(4326008)(5024004)(256004)(54906003)(6116002)(68736007)(14444005)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0121;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /+gaK9CYZrlW/SRcOM+WEAbnB9bwySqsNEOF9WNy3f5U3Yohq5jEcnLiWLiifrbsOqIyVDPywYuWUZz93WrxPKwQSgOUDhaJjZItUlvHnmYQ3JFWyqWKQuIa1jrJTyhj8C7RxI4iH7CJZyfxMysSYiTal8sQxyovWKLVJkJS3XicQq+fZ4SjrRWVuuzgUskAJz8QCL2C1t55C4ihoWMtPdwOn4Hc58rGb7HynKHGrc8XsdFpXlP5mUDzq+Urb1f/IqgK52XsipgvSsgx8yNTPHvweS5rB9dnM8H8d6J5T52ZzBm/9PAAE19Vmuc1vENziygxDLeGqOtoaH7c43C8ya5bv/cxTsqgqz2cqAF6E3U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c669e7ee-19e0-4a83-5516-08d6406d48a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 02:45:42.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Roman Gushchin <guro@fb.com>
> Sent: Thursday, November 1, 2018 17:58
>=20
> On Fri, Nov 02, 2018 at 12:16:02AM +0000, Dexuan Cui wrote:
> Hello, Dexuan!
>=20
> A couple of issues has been revealed recently, here are fixes
> (hashes are from the next tree):
>=20
> 5f4b04528b5f mm: don't reclaim inodes with many attached pages
> 5a03b371ad6a mm: handle no memcg case in memcg_kmem_charge()
> properly
>=20
> These two patches should be added to the serie.

Thanks for the new info!
=20
> Re stable backporting, I'd really wait for some time. Memory reclaim is a
> quite complex and fragile area, so even if patches are correct by themsel=
ves,
> they can easily cause a regression by revealing some other issues (as it =
was
> with the inode reclaim case).

I totally agree. I'm now just wondering if there is any temporary workaroun=
d,
even if that means we have to run the kernel with some features disabled or
with a suboptimal performance?

Thanks!
--Dexuan

