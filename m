Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 69736C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC3120864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QSdIwWeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC3120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965139AbeFNXBM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:01:12 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:10848
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965039AbeFNXBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbVZpHq7RpyRRLX8BZAPCZ8xHM8aeAfxq2IzLiJlt5U=;
 b=QSdIwWeO965DNhNRUC/4mt+UaeRu+owMPbgKKC8U7bqxKlMqrLDhN/Zu5JZVv0sxkMX39LyKbmrlt2sc8/WG2j8yxwa/5jFYjApccjJiJAA21Jap3HwhsILGXfU4LvSptdgSMC0mS4SX2hZI0Ql+I2FbSLXbuz0X51WF1zf3vbI=
Received: from BL0PR2101MB0913.namprd21.prod.outlook.com (52.132.23.150) by
 BL0PR2101MB1107.namprd21.prod.outlook.com (52.132.24.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 23:01:08 +0000
Received: from BL0PR2101MB0913.namprd21.prod.outlook.com
 ([fe80::e964:9479:a8:5802]) by BL0PR2101MB0913.namprd21.prod.outlook.com
 ([fe80::e964:9479:a8:5802%5]) with mapi id 15.20.0884.010; Thu, 14 Jun 2018
 23:01:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Liu Bo <bo.li.liu@oracle.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 038/268] Btrfs: fix scrub to repair raid6 corruption
Thread-Topic: [PATCH 4.4 038/268] Btrfs: fix scrub to repair raid6 corruption
Thread-Index: AQHT9mzXN5kiloguQkSDK0myTLF/jKRWxCOAgAi/sgCAAPZ4gA==
Date:   Thu, 14 Jun 2018 23:01:08 +0000
Message-ID: <20180614230107.GA72173@sasha-vm>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100206.374694208@linuxfoundation.org>
 <1528483367.2289.105.camel@codethink.co.uk>
 <20180614081858.GA20773@kroah.com>
In-Reply-To: <20180614081858.GA20773@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1107;7:yKzTb502Zvm3FIMqtJz66HIMFSGXJjfcLlsRO6Ie6U9+U+n1x8iHh6Wf6kmjo9u0EXCyEwJc+5bBc/2LsG9J2Y8CYLEaV5x2inyz9NiWHvOcIh/m46ysLsRYctOPhJjPGUlwZy47P6nicatwhvkcPhZAgoBtPTv/N99Atc5Pe2Y4YdXqQpNuPyUdgY9EnZriXHhCiCStCYOHc7J46g9/PTzB/oCSaNBjsCFsrZWVXadAKQSoEj3Xf9/ZO9fTunD0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d846c14-49c3-46c3-a319-08d5d24ab753
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7193020);SRVR:BL0PR2101MB1107;
x-ms-traffictypediagnostic: BL0PR2101MB1107:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB11078DB21D80FE06490ED854FB7D0@BL0PR2101MB1107.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1107;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1107;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(189003)(199004)(81156014)(81166006)(476003)(11346002)(486006)(446003)(97736004)(7736002)(93886005)(305945005)(6486002)(33896004)(6512007)(9686003)(22452003)(6436002)(229853002)(6506007)(26005)(10090500001)(8676002)(8936002)(186003)(102836004)(6916009)(76176011)(33716001)(2906002)(72206003)(478600001)(3846002)(33656002)(99286004)(5660300001)(54906003)(14454004)(3660700001)(86362001)(3280700002)(6116002)(66066001)(316002)(106356001)(5250100002)(25786009)(86612001)(53936002)(105586002)(4326008)(2900100001)(10290500003)(6246003)(68736007)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1107;H:BL0PR2101MB0913.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OHE6XfCBZasTswLFjBs8DLenF5NO9f6KIUteM6bdxssKqBRGGfiZcHrCmmtWe714mKPDDRlSbTDixkLI3WcXi/6exX8ypnkK5aVAhId31SBvhH95XTCEM/8ehuGzRP7Vc9pR17Ni0aFY1NvRuMXa1Qhxueul9yhsNxw/YOUSa9aTjSSLylCVJz6s6hGicepv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <760F67C5557CA64AB1D65AD708FA42A6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d846c14-49c3-46c3-a319-08d5d24ab753
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 23:01:08.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:18:58AM +0200, Greg Kroah-Hartman wrote:
>On Fri, Jun 08, 2018 at 07:42:47PM +0100, Ben Hutchings wrote:
>> On Mon, 2018-05-28 at 12:00 +0200, Greg Kroah-Hartman wrote:
>> > 4.4-stable review patch.=A0=A0If anyone has any objections, please let=
 me know.
>> >
>> > ------------------
>> >
>> > From: Liu Bo <bo.li.liu@oracle.com>
>> >
>> > [ Upstream commit 762221f095e3932669093466aaf4b85ed9ad2ac1 ]
>>
>> The diff here is actually from commit 8810f7517a3b ("Btrfs: make raid6
>> rebuild retry more", mentioned in this commit message).  (Sasha, please
>> try to work out why commit messages and descriptions are getting mixed
>> up in your auto-selections.)
>>
>> Maybe stable branches should get the real commit 762221f095e3 as well?
>
>Ugh, not good.  Sasha, can you fix this up and send me patches for it,
>separate from your pull requests?

Crap, I see what's wrong. I'll send fixes later tonight.=
