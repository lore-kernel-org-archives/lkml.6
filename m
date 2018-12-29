Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587EAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC41218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="QDFruL5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeL2ESp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:18:45 -0500
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:10223
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbeL2ESp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 23:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82sywlYOAeV8UaIFIdJCf7vcII62g+c4ZPgXSn4ULUk=;
 b=QDFruL5UTYveCEXxAczX3pBVczqTgiCQJ6BtTvjU0jPx9sFDiZFf3hEHRaQ4QtAtcXGBRwZAJ7xcMRzdo5t8cC8GbCoPm+CQhbbEZrYMDaq73cBfl/Us/W3zJxRc9bwcu2qS66NFgVJRgvLc4Nv7OPdiwVrnwf8MdkiiQmApeK0=
Received: from BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37) by
 DM6PR01MB4027.prod.exchangelabs.com (2603:10b6:5:2e::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 03:14:24 +0000
Received: from DM3NAM03FT062.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::206) by BYAPR01CA0024.outlook.office365.com
 (2603:10b6:a02:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.20 via Frontend
 Transport; Sat, 29 Dec 2018 03:14:24 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=bestguesspass action=none header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT062.mail.protection.outlook.com (10.152.83.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Sat, 29 Dec 2018 03:14:22 +0000
Received: from callcc.thunk.org ([208.250.98.2])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBT3EGU5017675
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Dec 2018 22:14:18 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C6BC27A4918; Fri, 28 Dec 2018 22:14:16 -0500 (EST)
Date:   Fri, 28 Dec 2018 22:14:16 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Maydell <peter.maydell@linaro.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        <lucho@ionkov.net>, <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>, <ericvh@gmail.com>,
        <hpa@zytor.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>, <rminnich@sandia.gov>,
        <v9fs-developer@lists.sourceforge.net>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
Message-ID: <20181229031416.GH5864@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>, lucho@ionkov.net,
        libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>,
        ericvh@gmail.com, hpa@zytor.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov,
        v9fs-developer@lists.sourceforge.net
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
 <CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
 <9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
 <CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
 <20181229021157.GG5864@mit.edu>
 <20181229023721.GA9291@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181229023721.GA9291@nautica>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(54094003)(189003)(199004)(229853002)(356004)(97756001)(47776003)(23726003)(486006)(246002)(36756003)(1076003)(90966002)(88552002)(305945005)(50466002)(2906002)(75432002)(33656002)(8676002)(8936002)(7416002)(16586007)(26826003)(106466001)(446003)(11346002)(106002)(86362001)(316002)(336012)(36906005)(42186006)(786003)(52956003)(93886005)(2201001)(46406003)(103686004)(110136005)(126002)(186003)(26005)(76176011)(5660300001)(6266002)(478600001)(58126008)(6246003)(39060400002)(476003)(2616005)(18370500001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB4027;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT062;1:nVbC1I4pg41P+YMuZgyj+aXsa45tqTSt93fmJk9oEkkTGUDPO9LT5ifnFNBlpTIof4uZkzq6o1EvpnEsTYujjH7wCZBIb5dqrA/lKZiR99T3+eTpGy0C/XyD4oQ02QEE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae6c5713-1fa5-456e-d120-08d66d3bbb9c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR01MB4027;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4027;3:da4dnnipEWxOFhw4/LLePD9NeebsLryNlugGBcSi+taneS8UlRkniQ+wz06CgYassXt1TFtci/wTtq4rn4sbpn9drlX8R7it+BohQLeYRaQZoSarPeGcZxL/vHnjGb0oKw2j3PCmkeP2Xnxrdg07reNzpSn2NdtjcxQllmCRba4AsB002WeJBMA+R3vXmXro72pbqLfWdE5NeW+WXLzS3u4tgckMyQqlmQ68MB6FKf4pdnQPPExEabm4sEylfFq1c8/IZ/8RX35BrTXla2fkP0TeX0lm69agdiPyUN9Oi3HFrsSFoFO4ZmGOjuDvtxLKgOIsz0bvh/WmkyfxrzvX2A==;25:+DNAdd5jrsh53fU1xVni4OLda9pxObIhbeEtauwrXDMspbO/26cJpM4VsbGzTccY6XmFAIaA//mBU0YgVfMQqhTFGHKn0e//7+3Iyybq4/hUw8VYjVB1TJzjBpQqGDvMFEAWvMWgogE5Z5+h9upZ/r+Fvr2psG7KoaJP6XowdEKpFeJxzIIhU91o0RrfLnfVpDB9bYmZ/Mixv8EFkCAkSq/J9d5hC8KkahxwGg8uG6WzExOSwjc2lLQkLlZmct92VxT61/enCdc+p2mgeifQpco9npwON9uZma+EKV8cw65VOFz9i9Gkpw2UGlmgccWS7dgVfsoJ0qMQYqa6etVIxQ==;31:NwDJheCF/sBicQ4CH6ig665jcuYzSSc8VV2w47r5ssql1WpG/my1IGmz8wqPzdmNpLFjBhqWiYMeOYS+42bWK5QEIiLu8pbz2W4f7tqB/Kn8n6HeAEc2TBIqw5LmbK27kz9MHuWngrdEhW7UYI50ubjNphj1WjXvFEMyEveXx7B5GBQCUUAXvppa/eDwYcOuOmx8/FabScC/cYN4PQd/sM9zFG5hsBECBhcgp7vRnoY=
X-MS-TrafficTypeDiagnostic: DM6PR01MB4027:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4027;20:0MAUzAKQKDdKlIuv8NSb1763Dr+bPVjuLmg2T78cHULSDK2olSYMK3izzKtiE4qwo+4+NzVLEqO/HkwFV2BVssd+HJu+7DCoAql3auBWs0wGYa3kfOUxoh3TLPnRSaHqrt9/enaEPyCyI3ySByBnBYpFbtTHG3knjYTLMFJpFQntzmCl7JcqaEGRdOlrsg/3u3zTURgjz2FP1mtarsN+mfGt3T6/zSSWjyz/eSYFOm44M9y77/seZpFKoJdgnXuusEX8rNS0NRFSpiWI2Og+crWTr6DFEXyvaanymbiOJH3x9ignLh6/YMIQ89qlRbsOBwJ7tHj5hTvkQMEOLMfcHbfxYNJPE3IaJjHgAmeoADsmpodcP7NTzzQ2itv/loSzZ4eat464+4CwhTo4rm9uSB57sIYM8LvzsWyMxSQfK5qHlP6oHfCZdBFeA6qv/RxzZHcb3jee8bZiaYWFER805OpFTcpZvqSPOIGZEjukTaTCOYHF9UPm2RZjXf+dmYLJ;4:g0B8woMNIJrYJKZ72fMdfAfwr/HjMi5Ap80fCyxNg1cAecl42DZfN6PXnbUP9ZVe2H0I6cU/jK3QC/aj4cvNdViIVGhdfQGb48e7fVaBVEnRCngmk/fBuFgHBQMzMEWEDRdThZfI6v6G/jCGFxPCk14oTtL2NnxObZ8NCCkJp794dh8fvoe/yzVynYv48Uuc0dZNVlVC6ff3CEZHZ0C0joZMeWF9O3yKE/j84PtHKTfrrSePJOGyfBndFLmSJXGb+ookDT2ZG6n5BDxbiXmLXA==
X-Microsoft-Antispam-PRVS: <DM6PR01MB4027716DC5DF00924AA5BC83B5B00@DM6PR01MB4027.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93004095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(201703131423095)(201702281528075)(201702281529075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR01MB4027;BCL:0;PCL:0;RULEID:;SRVR:DM6PR01MB4027;
X-Forefront-PRVS: 09011458FC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR01MB4027;23:KpT1yO3tJN7loE7tKkh7V4owyxxfrAV/awhYnSCXs?=
 =?us-ascii?Q?QkKS7l8QhfbE2MJhI4LlURIjNpixf3A3WlLqEXa9YjiWgCqZjsDBdQiLVB67?=
 =?us-ascii?Q?YDdtEAGygvv+rYq3paDfwgnCoS+AE+E8kxkxzl7S3aLSlS1vFsPFjDSzYS9H?=
 =?us-ascii?Q?9DRJTUCBzqhP9QrrGiUU29rPJ26zx2yG6Dw01gkI5ay84RGYvzwF23xMKoEl?=
 =?us-ascii?Q?3o+RL2h5RwpKbNv93UnSrNWVizYza8t40OqU3JrFpv2fQw2rHTGxRyBAKiew?=
 =?us-ascii?Q?ltLacWfw9Vbk5qtthQv5yIHG8O4o+x6xSuCuUcFfPj9fmrRY7MaMBu4f2bsC?=
 =?us-ascii?Q?AjAsAEng96qWBe3S1s8vlUjsanhNgSbQBRoTxmF9xy5WhKyGDSEtRIXUWzF9?=
 =?us-ascii?Q?MbOum6IlPdC8zFq41eSdnS5Ze5+1XII4mYAtqqR37SJVtxVtajuAxVxVWxNJ?=
 =?us-ascii?Q?raGE0TzGJ61ig89JUfrPiBsmrYCePZc1cmK3mZB/XxUtXu0lrmADAjjNLD51?=
 =?us-ascii?Q?0J2dvEq+Gf1u0KrQ+Ashw9avGoo+QcF+ylvbb9qu2V08uTxayCmkUWx4VhP8?=
 =?us-ascii?Q?fONp0ZbYzZKQVFhNq0xcb6YTPGZTE43fz1R444X67v+LTL+bmfJ5JlWR8q6i?=
 =?us-ascii?Q?khmDNaVTRRKjQKTqi1lZ5OJ2ko9LXH5DGTwhDmI0JkIviBbRUV62WrtO875h?=
 =?us-ascii?Q?gVjvn4FpGQh9W6dK+MgY2Vd419Aawk57h59iUASNkghu6VdVimviinvO2wbK?=
 =?us-ascii?Q?l9fqRtPuJny0FxzxrmCPwI4Kd/042txscWo7xJcLKPjTSCn5xMuCeHUQnZL4?=
 =?us-ascii?Q?TP4sTYKIqbkivmtxDmMWfut5JNplF3M72FcPhT4A9SzRzWaDGTSNrH6ROBMS?=
 =?us-ascii?Q?w7qLhd9q2yR5h++gUZRHpH0wTa80kqDwBRHVH8FMtxR/a5SwYLM9HDW+ky95?=
 =?us-ascii?Q?cZuZr/lezVoNlYBunrfBJTLeheqtekg9v5iqMeer13eKxluaBZNxvINY3d83?=
 =?us-ascii?Q?ANRHrEtR/EyhWlVaVDAqafuw0fOyvPwn3LueKs5S4+Oy3Q9o//KwWS2o3KWj?=
 =?us-ascii?Q?OislA2Oojqoxw3SOKxSfOtYmvA0R+VYxn2+oyo9v1+bJnUdqmTwktyVMdN4S?=
 =?us-ascii?Q?U2o5LtrDCWhvuf0pR4VBR6sU1B1YfLJWOKeZRDQ0RLfHEyWJa7cF8I69FZ4B?=
 =?us-ascii?Q?sDs1sD3A4Tw6GKcPb4RPG4K/jA8a8isFhwJFBur90wo1NBzBpfrQzVEtBFcg?=
 =?us-ascii?Q?ygX/qfEJ22Z5tK3HGlmEQBh2Ll2TyhamJ7hJr2mZZo+4z8XVHaRCRdcH/YRz?=
 =?us-ascii?Q?2zfj9Zfxq2Rg9JiByH21K5cNtfefS0JKo3NoEueqzI6/VZiw7VNe43pSrStU?=
 =?us-ascii?Q?PoVLZliYu2TPPI2IJFpdJpIVeI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UvyvORi/VScIeHE9wxH3vu22hZlNSCs1wg03GljD3AdjP+i7OCNGPclnnUtit7l9o9sbyMBr8Y2G5G4HF8EleK/wUSt6i2MPykNuosN85V5fTJ7pWUkq8OmSc2dXze5uYxrKp/q2pd1ZTHi11+ToTgDziKKC4gzrjZkyVh/hOWF0jzPoS9iKaNxOStOx40VcjkMq15NdB4JFtHeJEswOvB+Oeru9YIHV6ZX87wB/0HQHOlaKA1cNfz0TdPgI6JC+DnIlmql29id2lQ4ZZwDv7rSvDP7WszHS8FVYUuq6ttWfX/LH85estmVAgrtYXmUy
X-Microsoft-Exchange-Diagnostics: 1;DM6PR01MB4027;6:GG+lR04XejByMu32rqCH27e0EvvRvYk6xdN1FRWfrosRzYnDd7Wh5pp3KwJYtbJL8n8gtU9CnVOMe3Jmexfe/zRJINxfcICfUa/nk92QeNZf77v4x8asKjkt+9PoUl7/O8RyrXYTS6Xix27dCHBu8qr05xBL/uwruZ26ofqSu0YJS4zIt2VQ8YVAyxa5HQunV2ak+PHQHtynde3J7kJU/fWdrtC03jwuye0UHjVWc/pStqzzo4HX9UjtVy7o/sWSpv1wlNWSLGAaQHd0NTLEbAuGdIlCJUTQ/Uw4rl68XvYB0m+18OOTqtIZABABObLnIP/6k1AuBeC4H8ROn5nCij71wtb9xD8XXPafQAXy4s6PZB0Uoe0puaq0BS4vwHyn/xOevj/ybYq0n2E1A04GA6EX41oo90RTjbBBNbvSz5YQvxwII0iWuVgnclt56k8PYYbK3nQgEkqAUg7BeH1mBg==;5:HCzV7hWcES64gD0LwH+B8aQG13nwo6sjHwh6B8dDB/22J5xgFkdF+dmqAPvC0PIkuF3XsumpUEMsCCbmDbvO1Wvts95gO+2T3kZ+IjYhzjtWKEdI1k2DZECcjfKimC0WJvufaXWFmbcgkO/gKUODzIJhMQlIgqFCBzIcPj6S4BM=;7:wJ4VPAVKyzRaDB/aWmyPH+RoQKBw6briQ6axWcREvC+kfDAw9+3VC3QK1m6xOTN4Jblt4+RmhTUJWyL4AKQ35JGrT5Ne5dcU79mtTs7BHbaksYLLmi8tlk4zYDl97242zuWp5RB9N+e/zRxMpPTVqw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2018 03:14:22.8243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6c5713-1fa5-456e-d120-08d66d3bbb9c
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 03:37:21AM +0100, Dominique Martinet wrote:
> > Are there going to be cases where a process or a thread will sometimes
> > want the 64-bit interface, and sometimes want the 32-bit interface?
> > Or is it always going to be one or the other?  I wonder if we could
> > simply add a new flag to the process personality(2) flags.
> 
> That would likely work for qemu user, but the qemu system+9p case is
> going to be more painful..
> More precisely, the 9p protocol does not plan for anything other than
> 64bit offset so if the vfs needs to hand out a 32bit offset we'll need
> to make a correspondance table between the 32bit offsets we hand off and
> the 64bit ones to use; unless some flag can be passed at lopen to tell
> the server to always hand out 32bit offsets for this directory... And if
> we do that then 9p servers will need a way to use both APIs in parallel
> for both types of directories.

How about if we add a fcntl(2) mediated flag, which is tied to a
struct file?  Would that be more or less painful for 9p and qemu
system+9p?

       	      	    	    	    	 	 - Ted
