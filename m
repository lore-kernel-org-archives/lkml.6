Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nfZbF3uKHVuZMAAAmS7hNA
	; Sun, 10 Jun 2018 20:30:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2D92560791; Sun, 10 Jun 2018 20:30:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="JMHRgrzW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 66864604D4;
	Sun, 10 Jun 2018 20:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66864604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932264AbeFJUar (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 16:30:47 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:42607
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753681AbeFJUap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 16:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JbhxGDKxTOcA2UCMlPjMFrr7Kkm25jk86i8ePMaSL0=;
 b=JMHRgrzWy/K81lWfPkZ5arDnUcZEgwVQL2v1o3Kvfo71TrD3BP8jL70DR3VHo3wF/IB5KicIHK//OwiaLpY1NvncFcF3pwliVfy7j2j0ygrsWFTILRa+kQpntgJeIWrYInrwi43+lzSxB5Mx+9Wg63W/WLKWnl6SCEEQV5J+0eo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4451.eurprd05.prod.outlook.com (2603:10a6:208:5a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Sun, 10 Jun 2018 20:30:41 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fS6yp-0007ZN-DS; Sun, 10 Jun 2018 14:30:27 -0600
Date: Sun, 10 Jun 2018 14:30:27 -0600
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
Message-ID: <20180610203027.GF5560@mellanox.com>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180610063028.GH12407@mtr-leonro.mtl.com>
 <20180610104305.GA9284@bombadil.infradead.org>
 <20180610122505.GM12407@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610122505.GM12407@mtr-leonro.mtl.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:300:ef::17) To AM0PR05MB4451.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4451;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;3:CCZHD5GpUhwjHqJngsvcOXET9EgoasdFzTymQZxRROgot62RdVS8JRwg8r6PhH96Ay7vNiC/L+MOape7VSDVMH3WnCVdCD7kGVu012rcOxnXsITvBnCIqeKDCqPluK+Kmi3v0PCUWRqF5RNgGHOt93Ez9iH8DUjHNUsQgI4ldicsMRElsvT79Zp/YGqiaeTUNPCowCWyacLgqS06JMmwfw8nMhysgf4bL8Y/Z5oH7ejxn6FfI/SgBHbXEJaTH0Kn;25:DPi5kL+50ZUNQyrMXvi3ZyxY5bidqCqBdrWAmHZZz4n8VZ0ePE0cmy43EENQCdmMGymFiKZy3TqfxzWCf9IYAgMR5Cjr1jqxbybfjWHBwi6R/G8NGUHGemVjixD5oE7LRL3RxYijVm84P+27T86lM9E7zcD5rs+EXSJnSSDPo4EeVUIEkBvvW9NqoFEhZSsATmvttPedX8sBk2TkG14HoXelrtozXWLnXzK5G2/2y09zgHO0z5qRjw8j15inLnvFyxtXRnzy/piUnpKXcuDmvbyDPVfqBBbZKKBXS+im8U6XImpq7mwCPOX6lS3xqLmlL5DgdgvCDQVtIFUYz782cw==;31:3V8C20iTfoHdNstN7udnKDCbiKDmSlAoH2ljShEL2MgTvIUH7QBn6uLHIo3xeXxDKpG9Z4EongHrKZAWWeqCis6jCxX0edhQlWHd4yJOyc48FvHuX9vms16q5TwJa8FtV7O0NXbkbhl4WfNoDxCey+4gASOp7Dp57LPbe/cL5PY3zomMCS1zNWpx3sjtL4Ooa2IjoyBoo6dxZOMnpNOXCmQSpk2KrYfWIgb0fMC1WXI=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4451:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;20:i8iKvZJznifWpazbEislfS67JrBy5ouxAdvoWE7b/RTK0nNOjbW3ipP6inroRQ4hP0Vlm3seO9ZP0y9nb0TiWSAZfHD4VXF2ymGLDHpvMb/K4k2GJadv/eUItTuRU/aOdixtCFPxB0W1Z8GAtU/VpfB0O0CyKzD1obQ8CNluF44ZWlT2fKBmdF5u3bYGxh5HwCjbHr1bgXpe65mrmMvquEPd4KT9HpDtmbebz4ThB4Nzext6fiV2xtVMa1r4SZc+sfIGQYh82/Fq7e78XkPrLIB3SXNJXFvBDuZWHaXaGWt970+am3PFagMi1qiNBB5tv3/u/07FBSMtW41/PpS1uCSwyQA4DhyK+SCsbfQsqM75h8JYiI1LwYEy5atKtcA0po+X1N1aGhnZ7dgdhYNQq28mBVhI5/mCPeGkO29SsxTBq813qZLuVoAS5cOSjcCHEPg0c3rVTixR3t0D4gHs+jrFq/TkiXRLurv3SVRhVVkLbtB/blkR2z8QJvanUtSB;4:LIw2T2P2b0hG07qbnM1oqgnagEiCvn4YmKeDeFeFnQgrofjwsz/9tMIUZHbSOq3uqZSZ3EhMmSLHS5fQX6pkoQtxUDHQnKh9PHCDRcGs0lCRqk1wLMF068iN360u7Hmm3bWyp+x7sqeuBRbPvANx1mm3NuSrAeeLyipjqX8rnGCBc0taqrvhmTQ/eQ0CCzydxbAkesAwwMz/Ufpc8tn7DcxMpu57viwgHfbDp8i+dqPP4K3WDxg/Wsq24f/i10ex1HTi0bO1/DVBwkachz43+PVgrPcY//mr7PIHdrsgLNOWjC/VxnB39Vrf1nA1W4Dj
X-Microsoft-Antispam-PRVS: <AM0PR05MB44519E99AD0EA259EF4AA9DFCF790@AM0PR05MB4451.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4451;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4451;
X-Forefront-PRVS: 0699FCD394
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(346002)(376002)(396003)(189003)(199004)(4326008)(54906003)(446003)(97736004)(2906002)(52116002)(2616005)(5660300001)(106356001)(53936002)(105586002)(1076002)(83796002)(11346002)(229853002)(76176011)(9746002)(9786002)(68736007)(122856001)(386003)(69596002)(551934003)(476003)(33656002)(86362001)(26005)(50466002)(3846002)(6116002)(8666007)(59450400001)(6916009)(6246003)(39060400002)(316002)(16586007)(36756003)(58126008)(486006)(23726003)(57986006)(93886005)(186003)(8936002)(47776003)(46656002)(66066001)(8676002)(305945005)(81166006)(478600001)(7736002)(81156014)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4451;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4451;23:gWjoL+8J8zFR77VHbWtHeFM7VM8G3BF4hd/1Oy9xs?=
 =?us-ascii?Q?CJUfH+NQg4OuUKslw/QCp8ygjKTPVHYTU3fU1O3B8HjESbdit1g5AwLOXgEq?=
 =?us-ascii?Q?QGxe8I362hTWIYxbrBzAWVNVGGLFqi+rusMjt5inynNLPLEtrygfQP1HuJtf?=
 =?us-ascii?Q?+kRvsiGL4Oxo3YySTIZ9l72Ep93pi+8KFuebOof2E0F8/S7IYWHFivdqPENT?=
 =?us-ascii?Q?0NVv6lxihdhDqqoHSd4nllbyNY66y0owzLTGWC7EP6pI0vLo8SEiz4AdQG44?=
 =?us-ascii?Q?tog7xlfLL6n3iyqFT3ApzILr78GfUHsbOuDXCbE0So5I9ENttkkH2hg9n69q?=
 =?us-ascii?Q?vHgUXuUPxDBAFm6FGZ9IDgHXPuxYT9aDFUZYg1lKgArKQb1hVi/bzQtHJ3Jo?=
 =?us-ascii?Q?x3s5JGzn4kseia6SEgbxDZDtkFCLlNrpfj67XqpmavG2ClFt1undzTv4uPyD?=
 =?us-ascii?Q?nkEUtnIt0WXvtz/5YUBQdBLNKKfID/yeYJfiRv9xKWG8c3X/ImHAb7VNuYiU?=
 =?us-ascii?Q?hilBbBOMxCeCAYLF5SYZoyZsYnL2pv8pfiDwvORrv9+myVq5Rfne0GykPZTs?=
 =?us-ascii?Q?7fezAqo6MNijG6jDcmSDOpOS0fhrKrhdM894ZuFgzBcTT+SaZ8uTUMV/zc82?=
 =?us-ascii?Q?kHJ1gaxRNeVYCl6djOsVFYreCmSVlofisEsysdT0JGCXu5Qzl7QkKSkKxZu9?=
 =?us-ascii?Q?qCRSZ6akYQ6TfSqNxXgV86CY5ULudy0SJ4zS19e3cBfw2ScPUPPDsSio+qoe?=
 =?us-ascii?Q?jsEl8UTVKRGYdDoiT1Xe2JepCm1dRF0YpFg/PAt8w+X1q14c3GN6JropEre+?=
 =?us-ascii?Q?RXSlxTToTspdbp7NGT/tDybFAiPn5pXd4FeDESPPwVQ9sqTJu2Iya4OLXYMH?=
 =?us-ascii?Q?tTgr4x/c5vMkPMprujmFSfgJ0efOagjiPf3XGL0g8bmj1bc7YXdGsMj8ED+C?=
 =?us-ascii?Q?1xoW35d9SLzOoUcJ5MANwXCDBIteKxRkRMxebSjfcgnGxbXyxvxs1CTuCGGe?=
 =?us-ascii?Q?vfHWfgHpp070CFXPpqWZjZAMAwI6nB+SV2+fCWJc+poP6Zmsp6GkP49O1rHr?=
 =?us-ascii?Q?ZleV6wNdzNQYu9gRcNSGLWLi/N4+HYouG7q/iGBTHknhpzTHtTsdtTyb7Ezg?=
 =?us-ascii?Q?qjUivjZc8cbnCNoiMEe6PveeexhU99tTA4MImczbpiJrwQd4ZAzVULZ0V/QB?=
 =?us-ascii?Q?8NVIMqgDgd/pVVcjKEX1kyJ/213aEv5PbKas4VkGznblvCIvJkimnIaAkyY8?=
 =?us-ascii?Q?URxqzi1tS5bEETVBIEVQGqpLV2Cs+a7457AEWPRhgnVm8jbJq7HklDmZ6d+G?=
 =?us-ascii?Q?xO94bMydQJBh4ereYltt79SyoiYKfwHmiToTL7bhxE1jPqBc7bNF8Rfe7NzH?=
 =?us-ascii?Q?dF9yE13M/JcgYuW5O59bog6cs/d6iIDnz7W+Fzaunu75wRjyb7ywxVX3zWXT?=
 =?us-ascii?Q?xIuXDH4By8oP2IWuTtt1m5HOC/YoomAZr1CANAZpDUW2gKu9STx?=
X-Microsoft-Antispam-Message-Info: Hmu8Iv0DMLtQ+Xab9JnlkeQXAoSAgvHkXTyLXv6ASdmgIftfYR8edyUf+1s3i4SRJefmpCVxiHK0EDNXM9IHY1khcyxkm5T9V57pe7naOPxjQBNk6N/bKrtLs6Oz9w7uerHG2vp0WO3gy7A1JaOF8iU/tbosx3ZUhA7Nvi/JiOvsaf9bRUhXhZ+g619Xflga
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;6:qu2rm2L166vDkPpMah+2m5QBS7VrQ2uQhzj/gwEtHgNvk7iwnroNlKB80EQdSGXtNC77PrF3AeQXMioHu1fBA5FWOJb1NbFj11lplGq6f/5DX2fcGeUREZtcNdSxl1zHzV/eGaCKBZqKB0vKLOKdXt8ytYHkqaFHZYxoElGrhx+Il8R4QXNLAgMyxmxHpQlqPiGmwTRGMqZ0vmp/aXXCJodigorERkv6ihDbM2qnvWCQLasVWrHVu24L/CqhrHRk9/WqC8T1w2hFbHmZCZsCsuDbcZdF4IgCjTFRzX61PYkrgtx2GoOa2TmT76RYkpbljJT7ENwAIlLvVuit2yo9uO9gjBBdxgNKF4kZ0DFpaBNjlo0IsUXp8LIWuvlIy8W65a+5X7aqAtfH2ycvRkTsyXwjwqxkcc1m/01RDyIlMIasUGVIl+pCoqvNpZGaJIJTGZ2/DtP9y55ZDZbsNEGPAQ==;5:RFDyUtJSAnny8RJWtCpS8bxt9/Pcx8QfMJOc93oU/mcOVIf6GZHJ8z5DVD2GAd3hwiSpZw4047RsaIWl27OdHa5IBA8Mf9qR2tNg4ZUcui2a2loR+QQAcE1wTB8lCCTmpmqGzebc+7lZb4Ct478PLudpRGCqlfdiL0Wd++m9kdE=;24:yIf6KT/kcY62KOF1DPJyn1LRFZl2TrAnlE0EaDGBgLM94oUw/JSUVcnfaYZ0O7tdN031+Y1E1fpxNI63IRnONY3eS5CUSkuf4TYgaxTgysM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;7:HaCrZZ5l8k/9qrZJ22XavLeLD2FQ66roWPiVuQsutPcxSwUid+Wdlz1gsvdDJPMVuIxFvq8/uo8hZLwXlBdDQkUEzRiXeIUbOMO1llnz7rj2ZXSNn2eDJXU3plHGl1FyWE0sVzwRGMN3pgdv9Qlm2Oh+6HnctcXabotJTpsQ6Im3jwqYMwmaGiobJTcTzLC17C+MRVFlNZFQ4zMwF/UaM4bNIWP5NVh5g8zx6RZJT9HPDCTDvfvCJL1CYjcVcPIZ
X-MS-Office365-Filtering-Correlation-Id: eb2a39ac-345c-4202-0b67-08d5cf110908
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2018 20:30:41.3847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2a39ac-345c-4202-0b67-08d5cf110908
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 03:25:05PM +0300, Leon Romanovsky wrote:
> On Sun, Jun 10, 2018 at 03:43:05AM -0700, Matthew Wilcox wrote:
> > On Sun, Jun 10, 2018 at 09:30:28AM +0300, Leon Romanovsky wrote:
> > > 1. IBTA spec doesn't talk at all about the size of TransactionID, more
> > > on that in section "13.4.6.4 TRANSACTION ID USAGE", the specification
> > > says: "The contents of the TransactionID (TID) field are implementation-
> > > dependent. So let's don't call it mlx4 bug.
> >
> > I was loosely paraphrasing the original bug report; suggested rewording
> > of the comments gratefully accepted.
> 
> Just replace "mlx4 bug" with something like "to comply with mlx4
> implementation".

Well, it is a bug. Blindly replacing the upper 8 bits of the TID in a
driver without accommodation from the core is totally, bonkers wrong.

The original concept was that the 1<<24 limit would come from the
driver and only mlx4 would have less than 1<<32, because only mlx4
does this thing..

Thanks Matt,
Jason
