Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +ZOrAbP9HVvdTAAAmS7hNA
	; Mon, 11 Jun 2018 04:42:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DD1F6607A4; Mon, 11 Jun 2018 04:42:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZuxVaxVl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3815A601D2;
	Mon, 11 Jun 2018 04:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3815A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeFKEmY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 00:42:24 -0400
Received: from mail-eopbgr20054.outbound.protection.outlook.com ([40.107.2.54]:59744
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753893AbeFKEmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 00:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO3s6MNIFhMdEoscPodBMcqyOl6fgUDXP5icoG/uCGU=;
 b=ZuxVaxVlYN1sJruA2c/T6XRWm+jejOOvN+56WL7Lm7xVLjQTgSMgob/Ehx0tk6SMEf0OSkxcit3jjGb90MgSZIQjl90cBiKynF89f+YIGI0AGhpC030Kg0IXIMNtYjtPtm65wjs+PFkemDaBSzCmMSwu4eg0r8d8GvC3Ntvuxn0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4449.eurprd05.prod.outlook.com (2603:10a6:208:5a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Mon, 11 Jun 2018 04:42:17 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fSEeZ-0000UI-Sd; Sun, 10 Jun 2018 22:42:03 -0600
Date: Sun, 10 Jun 2018 22:42:03 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, hans.westgaard.ry@oracle.com,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180611044203.GA32562@mellanox.com>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180610063028.GH12407@mtr-leonro.mtl.com>
 <20180610104305.GA9284@bombadil.infradead.org>
 <20180610122505.GM12407@mtr-leonro.mtl.com>
 <20180610203027.GF5560@mellanox.com>
 <20180611043425.GA21382@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611043425.GA21382@mtr-leonro.mtl.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:301:60::33) To AM0PR05MB4449.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4449;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;3:Ik1I4SytA5Ngm31VQG85eGu5kpjLD+q58qfcwGiU7AyUqLBBrCoUnbIDs2Cay/g+e+GzMvV+5hPaZlCw4OQakwCW5h30NQTXIIlARYHtClLUpDoATyctFd37jo9kuuzOiX8B6JPpaI3gY8p63O8k5bMtrAQfFprkMnHtP340rack4W2Lazt8U6+q+Kdilz5ACdvq9NF9qBkfjfdyVWwvoqOYZxOPI2OodNmmP15wqoCIYfevUL3kelYtvLOJy42H;25:PY8STuv97bFtA0CdkMX+fYOQCQs6PtMDOgELOSLeRnipXlJe2Ng9Xq+ZM3IZB+0esyY388RcCT4C5UIt47YOv7R1o1MmyNgQQ1TFz+v3PSxI3rGMG+My+R1vlqnkV2iyCLp7tDvg3M3YdgSOshb2bduy3UiILOcRQ0aDYPgUbNGDvc7Dg2AWdCHMgeydjotGoyB/3gPnu+1y/msbsI1Gopnbp3vhLZ4Q2Dbyx5hM9SF32EI0VmshPoCPoODp3Kzg+OijEh+YYbjyYwwdlk3oOHBA2wrqSmhQTEYnFxrTLGJOzlIPwRsQDLeXus7FirFH6aWG7lOYFPtAbaMGroHP8g==;31:f07SyEE4WoQZDzFxkurKPi4mRa5OadMVdC6pKPykBGT6WOpPJ+ff6kXDhQVXoiJTFW/lKPVYP6r3FVdp3Z1Hy9H2+xtB17Mf26ZuZxxlkzkFqxg+QcYY1t7AcqfwvNR82S/vSzgqqA33INcOIziSmnx5UNgtAEn62pdyFQpbVpHVPju7rANhNFzeypNKt8j1J+SjLBLuBGOcAbKPSh5HBIL6ERJL9PdYjK3RE4tSWYc=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4449:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;20:lz4PjZTSzgk3ljUxz4Mma8NMwZHtZNkset4beixLgWVM7THW5biOmDrOzxIHFdhw+PL+lPthKSxKvcyb5NdxbFCpljDAE0LpT7MTyCG1MYbIwrEKX9gylOPpl448iqk/bNOnUNsxVyutgWKfAvLAidautBMXpVFgPy3eethlomYHHi6Xkhq9NMMVeBujjbTCP7i+uBbW1zsOlbJf7M4qW9CW0BhTQr5DXEbDklkjkZIl+2raXLIl2ZAaGsmxyYLUOE+WzYQJCW80x5Q3nkU12RQLJb31Xz/0EoGOhyag/x8VHETHdRsCr9TtJ1/5JsZMlFidsCKcUJ2o0zoSCY8U6nOqIo+0RmFhhmNFH3GBwJILTmVL6N3lwuF4Samhpe9FhbN0tDJjXgdw3kbtogGueWtINGefpBH7/8A9NHwH92tVEM8lsqRrbsQPnwBpvSIz7ClGTVLs1cS9HtX+RIc2rDXlONCFOEpQC3rDj2x38QzQb1YomRNPC8pyrIsTX1jQ;4:5xHzu8IGsX/1+Ir8LJBMmS/PYIzphQcBsIeUjrag4+YUmK40nxk4V0d0o6nTJ/fCRpe5ES0ysZpaU43+CxnpJUmBqLEjxY3GLI1lSM5vR2MbjJRdx19zSaQbktaIWf9HngkgKl3i5IjpV8+Vlp9oUcmVTzaLITPUmX60SENLiLnTyAC5Ov9gHTy2H2HeeCJyG2FEwfUEIjMNpDykZ0m3G/r6eGUjya0RZ5Hq24lNMfKW/NDwWGW229R0gYji/3opuxq4w7zIk/whhx6+KTRifgPASM45IPPbo6cWFvEjmmvDXhrvcNtUuxznyeHNgG6j
X-Microsoft-Antispam-PRVS: <AM0PR05MB4449941E84F0C02C08B8EDD4CF780@AM0PR05MB4449.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4449;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4449;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(199004)(189003)(106356001)(86362001)(52116002)(66066001)(46656002)(97736004)(186003)(36756003)(58126008)(23726003)(68736007)(54906003)(9746002)(9786002)(6246003)(53936002)(47776003)(3846002)(16586007)(4326008)(229853002)(316002)(6116002)(81156014)(6916009)(93886005)(8676002)(50466002)(33656002)(8936002)(81166006)(39060400002)(478600001)(446003)(11346002)(76176011)(105586002)(7736002)(69596002)(305945005)(386003)(5660300001)(551934003)(486006)(476003)(2906002)(2616005)(8666007)(122856001)(26005)(57986006)(1076002)(83796002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4449;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4449;23:C1LWUCbcxMXVe9ysXd2gKBIaG1BHjzPn0Xj84c/pq?=
 =?us-ascii?Q?iAX7yma6WYVUrIWMRYoIpw9hqop/IozxaWHe5CbIosA8/aHZMD+xuhxAdCUV?=
 =?us-ascii?Q?ygntF2+2D2evI5dike7nCggZZnZJg2ZZL06PqVbR6o3mPkpzwm8x1LVwL0vc?=
 =?us-ascii?Q?Jb4dJOCoHVGl6Ax3c841+ewwcyEtwcLYqouix63lgtLiKipj67NDr934rmGX?=
 =?us-ascii?Q?/Cb+k4kKp6R4fv0tDlo42fqKT9FbqPIUPijbcdQBm14wevO3b/z8MSNuCRT3?=
 =?us-ascii?Q?+mDE7L6/5QiCwQOWkG7yf/9dyZp5p/iSFKsNMvIG+yOhXBxCWCz4rTzHV/Zx?=
 =?us-ascii?Q?lGbLjdwFc8VhS8HQWr1VqqBAizvnhYy3WcVdWx9c1qDU7blwgjfNTQEt3ALb?=
 =?us-ascii?Q?d2qFbuU1feC9pStkdLA2L0V0eRKb/8N1IQL4/7SxFSYSs7t/vPPY8tt6zLQ2?=
 =?us-ascii?Q?UYPb3YWH3idmAYGkz03szg7JEVrNkWMuI2j3AJsUlE+Mz2zpMbH0GmXHF83i?=
 =?us-ascii?Q?bIBWgpumFAeLt1bgtgW8ZEoTs33RlOqSLRQ2nbAIisxsvtg86WiDiiKRkrmZ?=
 =?us-ascii?Q?GEYWLZzLAk6BW9SrcLMtebk5pfqV+NTYEIxknhDL0+9sTcq2nFekWcYbGkJf?=
 =?us-ascii?Q?wuIrsgXMwQupC7xC33LseoRUgvqt9BDX9VnIVaWqOXb3o0LVGHKnUHRI1I4w?=
 =?us-ascii?Q?g5/VmgCgWAS3CI7oQLWqPYBmaCUDZWES5AmKdkJ/gCP6/yu8z3Jzz0RqH5/D?=
 =?us-ascii?Q?6JSiC97dzZFzBonyTgJjv70h8tuzmDB/znjESGhOhatOe8MPQ2qWW4zjSebP?=
 =?us-ascii?Q?hlzS1cMEkU0YBh0PcbkpQftSM3QvV/24Wm/oUtfwIOUxgBOxE7rtTXem4rsA?=
 =?us-ascii?Q?o/pCYqd3rjvxN3xdlZlKIHPJjXnwAgKshnbCR58IPqWTEdW6Btik1clf9sbB?=
 =?us-ascii?Q?5j6HNnRbYKCL+rBqamyQ5qwuMcRUwKXyUr5/tjjcu4ategNzX0qtNf+2whZd?=
 =?us-ascii?Q?YktbR6BVKA4mqVvopWFwgNn6JAxTWIhHzt7+ToGUU0DYpAll7BbaV6Ep2mk8?=
 =?us-ascii?Q?5EYfkonszrHwoIJ7RhvqCeSrRek4agnIMLBPaeWhcy+kfTWPtTNKEiWbI+bX?=
 =?us-ascii?Q?O7460DNeuh+F/oqUSkcxxawsyFi12q3MmnQHlIWXdTSErgrGEgEwJaBaubpB?=
 =?us-ascii?Q?aLUMOHk8kEPlsDOjc+uBUht3caBASkJK1ucvtYeYWIS8TSP1X80lma1FCSx5?=
 =?us-ascii?Q?J2OIaUm8Vn/Xq/chj8lgGvPDe74APsfuJhxacQHu1GagdL9/Y4BKEwPQLUp7?=
 =?us-ascii?Q?POoE2uHflCr2aVLJ9esSAgHTFJAgPBcSkAFt7qMBGEqqdSa8t4vbioSBJny2?=
 =?us-ascii?Q?QNeTezV0VrjwT7FcV8C1B7o5lD9uD/UgGbkN8aIW/ZLJ3hoRscH/KlG+KVNO?=
 =?us-ascii?Q?56AAuvOFyQZPlq8yj17sA3XHGoYjYk=3D?=
X-Microsoft-Antispam-Message-Info: XWHEjjtcttoCSisbq3Wh1/QJJUHSXg2ZDkjjjK6EXgoiC70X+t3z9dQGc+0TKT2VZkqUopsa+CY92xqg+ZV7pehMi53PDp04jxScnMuk230gEWVEYF1lrepk5XySu18ke5Q9wm0pHcUiMDeNIVD7LkIZFx9zO/72+aksQ9rJyl6vhnatzlqukwCA2sKa7Mew
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;6:R3nxLTnhNG3JnRZzmTslyLMra8WJG8id70VnPp8MasV2ZiG1vOEoZTq9nCaCPOtqW3jrOnvGFczWmDmQDswW6POXwxXDbQ7Y3z27lVXD9eDUEiddwPJkj+gmJHsCFj1Y5H4MnMFkKn1glF/RsxWSit3RkvTGKTl55WAh5PUHXEjz4EBzpWFpaT92+M/t+cOZ3Lg5/Soc1nO/oQ3j1AhHusSlJOZZYe3O8Py2GtKJwJ9/TYmREWVX08WUre30RpM9WNaDhePMPUpNNjDqVbV2OgaxRc+n31sC0MW7WF0NmA2gwgyCglxXARmPSgskq8CoPpbZNSMJo3xJruYsbMSoz7ouMzhewlvj81oHJeb+ZdmtNbZ2KO/Q7BP7GTvUQDLRoxsQ9JZdgIxa8gMJCvFfaV44Hu44BztkteB4YRaEAQAMLmTLZ50uOopKHKEwxb8pLfDbGr1yvh9JK55qc6AdbQ==;5:u8CteeeDV4wypC+zu7HiPVEdyE7xwNdhZYRQV5lErFRnuT7sCYPc1cZjtWXDBpsePIfguKcIs5XZxusoAiWybuKakiripenaDT9D8/jnvEsAyr/oCvQQjT0poEx/1kUGNAu06vjZR8ggom0KBncA0DX+5aVC5cZ0w3VMLuqlN/8=;24:CfF/jE1+jCbzFECVRYrjYa8+qNtyde70rS0Laf7RennfCRoMPb6ohtkdUuu7ZzA7Ai48LiYGoq0EaK27nkbsbyRaUOHs1mNGSQ+xkg9mSxM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;7:7c3cL7kYSz4TpC6tYPzUcoEBjwLckauRNASOAa0atybQHeySF06xODUwyPtyoOnZO9xmjP2yi/WQ6nVnwmrlrvGUBKda+jQkWzLEo5BnzuWIPd9mEVFy4N7b9I28BLVMJ4+c7JsGtCCwM9n8jexc3GSP8Scdu4EajtWFPfa31/zhpIJgfh1TGIKEyPzYfB6YPNipQqPfbk1YXGuiPuhxeZlq3uDs1KTAgw8pTPwMaQqWPflZCFQlQ4nfCt7q9IuU
X-MS-Office365-Filtering-Correlation-Id: c79c6bb8-fd14-47be-23da-08d5cf55b63d
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 04:42:17.7521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79c6bb8-fd14-47be-23da-08d5cf55b63d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 07:34:25AM +0300, Leon Romanovsky wrote:
> On Sun, Jun 10, 2018 at 02:30:27PM -0600, Jason Gunthorpe wrote:
> > On Sun, Jun 10, 2018 at 03:25:05PM +0300, Leon Romanovsky wrote:
> > > On Sun, Jun 10, 2018 at 03:43:05AM -0700, Matthew Wilcox wrote:
> > > > On Sun, Jun 10, 2018 at 09:30:28AM +0300, Leon Romanovsky wrote:
> > > > > 1. IBTA spec doesn't talk at all about the size of TransactionID, more
> > > > > on that in section "13.4.6.4 TRANSACTION ID USAGE", the specification
> > > > > says: "The contents of the TransactionID (TID) field are implementation-
> > > > > dependent. So let's don't call it mlx4 bug.
> > > >
> > > > I was loosely paraphrasing the original bug report; suggested rewording
> > > > of the comments gratefully accepted.
> > >
> > > Just replace "mlx4 bug" with something like "to comply with mlx4
> > > implementation".
> >
> > Well, it is a bug. Blindly replacing the upper 8 bits of the TID in a
> > driver without accommodation from the core is totally, bonkers wrong.
> 
> I provided cite from spec that says that TID can be whatever you want as
> long as you success to do it unique.

Er, the spec has nothing to do with this. In Linux the TID is made
unique because the core code provides 32 bits that are unique and the
user provides another 32 bits that are unique. The driver cannot
change any of those bits without risking non-uniquenes, which is
exactly the bug mlx4 created when it stepped outside its bounds and
improperly overrode bits in the TID for its own internal use.

Jason
