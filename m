Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04184C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983092084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Cf1IUSHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983092084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeGSLdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:33:53 -0400
Received: from mail-eopbgr30099.outbound.protection.outlook.com ([40.107.3.99]:15552
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbeGSLdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/6h2d5jPf5KDe1qzsNnXf4dSQBE06697+7qy+ryorc=;
 b=Cf1IUSHpsMTXV8Np3DP7k/F2tSwiZstd6f6oOn5fHB6HAlz48qcriPeteBLoXIjOxE319PMCRSFODQGgRWpiPEKDQwLmQw8+ath+2hd1tqH5bSde+iNu5WRd6/dXXzEIKqa22Ccad2RLxW9H124KrLXwGp1IkcUAbafGunkDB38=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB2024.eurprd08.prod.outlook.com (2603:10a6:4:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 10:51:13 +0000
Subject: [PATCH 0/2] Reorderings in struct shrinker and struct shrink_control
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, vdavydov.dev@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 19 Jul 2018 13:51:10 +0300
Message-ID: <153199724495.21131.9248876333336922199.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR0101CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::22) To DB6PR0801MB2024.eurprd08.prod.outlook.com
 (2603:10a6:4:76::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e80a187a-2a4e-4534-6e32-08d5ed658c00
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2024;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;3:xHaWoxzWQ9Hg3SGRTh1l9RPLhXSrBX+BQGY1magiy84tOV5HZ9PM6etCINB8c77t+v/ITtQXd93hQ1fvPl4+o2I9B0Lg4Az8B4EWHV8Vo2MRneJTGbzs+hlATKHLRby+D9dVzUjn1Dqd3Pu7LLlize/hCYfwoYh5rEzpRBsXebec1DaCcFaW7ULVW9vWDxNK9rbM6JIZDedlMf2MstR4zLBjr3Z3yzbyC+zUUdgpD0xsmq10rFbeQR/whEZTMNyW;25:yIGPtWEI+Ish0nDBDVbvspuldCjZqn4U7DJxOlDHgcqNGTiX+eBm063LTpkT4DJ2hzctJxp+l1JVD49sBOcp1IFtokQ9ah5GkAobyg/zz4odUfgCT0OR/5hZKB9A00hSr1kfm1rJYVGb98XyL2Xbl0NpHC460jFdaZ+p6aAksXKhA9z3lYfFKUpa6u8MAl4xCwSfTr693NWkA43zwsvy9fd642FR54IcAX43XBTzMmSafdx9zWNn9H6lJTQC3LBkLD8vHDHM8ar9gZHt0Bgtzo1pyK7CWAGt/cXSlf49s0KpCV0deNq+f92Vt7YT6i9CWRP90GY8ktwMDcYbxBJ9mQ==;31:ztB38qvTjI3BP19qu4nvYm17mGi/eYJNNTQuRzbKuxAlrtmL5AX5h9Ld3mVS2QriLVBTFFkqWCVTLUj6cpTIrfp9NalhrTDLAqcQsaZAhhlj3Y47KN/FaIsqCbbRWRbYlCWGSI6etfgBsKhVfoeQ0DBT6KcW2ssxap+uBT9ugea58Y2kX5WhUAvBclIFSVuA8UUUyY9PLOXnh0js+wylel0828GisizKRRfS2hmHbR8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2024:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:7PiCTrjXql3nC2dpD90QyOAq9Qlas0Lpq2+n2n93yiaQnezDGj87S576KvpnRXaSbvg0OZQcWxpRLTIqqsBBvnzUgMivZXguhRLTKvOb56MHB/FriF9LFqEHyL7T0UMjQJwBvi9AjOXnF62osU1qE4g0Y1K63nsV5QyC0nTQVo4DuCU+gFmT6MPR6h3aW7mPEryz+hCyQP4CHUmqxm8s4eGWLJ9mkE2m4O/UNNrifmrODYUAmVkccKcC18OC5Mpnpe0J6tcgqB6vqIbZ5WnHcD6bzcPDtLdA87p2zVvMKbaI2JGa+kYZeuqv+OFmIwxjOJDH6Kp+a9VxUuq+W2iI2Xz6YVb/1C/RBDGXujOyUrvGgmg2IAQGiNc4njPo2b97EpzOqKEZzjfcu1+2r9DeFhBoQXGIBXN7kFmrwhJgHzTEo2KqumNoLJCeI4DJ4ZZjMTBDb2fk4QQP25nr3LyE7orUdP67+I/1xixh2MP0FjtbJwiA2kGPBD9ObUovGKbV;4:PLEtA/oWsg/RJZ4yYkwTAwgnlMLEz0f9LYMZZibs6dxXgknmomhoogAO9cY56BgIvGkI7QOusdi9wWQw8kCRN83MEsYZsxcVw76Hx0tux0jairwbSTzCXI63O6+8wKw9a11L8I7QhyT+22et6+gLf04pwa/8A9rHx+5ryBj8zZvxa59iqyeQUu6kC70tSk5l879cgNEGDvGrK1c75/Yt4StbJ1T9U5/uIph0IuQYhZtm8DW1uarZp1TJsozCaYjNSTkk4Mor5Vl3riunx6Xs4A==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2024E70977E8521152E2F618CD520@DB6PR0801MB2024.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2024;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2024;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(366004)(136003)(39850400004)(346002)(189003)(199004)(33896004)(55016002)(186003)(9686003)(86362001)(103116003)(68736007)(486006)(2486003)(305945005)(7736002)(105586002)(26005)(106356001)(16526019)(23676004)(6506007)(956004)(7696005)(52116002)(386003)(8676002)(81156014)(97736004)(81166006)(53936002)(8936002)(476003)(66066001)(230700001)(5660300001)(25786009)(50466002)(58126008)(3846002)(39060400002)(2906002)(6116002)(478600001)(61506002)(316002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2024;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjQ7MjM6L2E3M2tjR01heVZtZ09xY0NrcEhqVVdz?=
 =?utf-8?B?R2JoTDBUVjNuYTRSSllkRnJXL2E1TmFpdE52TjV2dEtWdDZMQVZoWW94Mzg5?=
 =?utf-8?B?Wkk1emRVSm9OcURhMHNiREZQVndyTGdMSk5zUjBMZzRmUG9RUzQzNWdrbUFz?=
 =?utf-8?B?eDV0TFEyWlY5a25EcHdTTkNZM3orVlZkbThheUlkNWJkT0hOSFlFZ0V0Qzgx?=
 =?utf-8?B?akdZZE0xa1krZUNNSG1LNnd4cG5aRVFTb0ZCTVJsOWZTWU9xQXM3L2lvcHpW?=
 =?utf-8?B?S3RQSGcrajZxNzJySGxGYVNzb29pbmVVczBnUWFKZEVLWHVVRVJxU3pReHZl?=
 =?utf-8?B?TnlQM3hwaDBxbndobVVacWF0Z3NyYUYwamRoQ1Fjeit1aERIWE5rVEdnL1Qy?=
 =?utf-8?B?Z2FsVGd4YkpYaGpqTUdsMXRBZ1JrYjdCaUxFNjBRWkkxbkNIZFdnYXc2SGFX?=
 =?utf-8?B?cDJCTmRGUkJHamd0MjlVSmIxVUs1K0xRUWZ6T3V1cmNsK3o5SFo5YXUyUGp6?=
 =?utf-8?B?ZkhxalVCY2JYR0QwMzdPRGRHMXZLd1ZRa2l2T2VXZ1c4bVRkQlJGUjJBWW42?=
 =?utf-8?B?bXQ1YU9NcStPQlozdEQrMVM4SFhBS0hMSEUzZDhJbUJCZnJPa2c5YTJKaUVw?=
 =?utf-8?B?dkY0ZUNHbE9NbzVzWHlCeHk1QUR4UXJDQkZXdXdRZk9URnluMWpON2VQeE9v?=
 =?utf-8?B?UTVzZkxMLzBmSDJlSkxmWHUwcHJWUWtvUVlYMjlJK1EzQis3VmVqS0F2TVlD?=
 =?utf-8?B?aUFZZEhnVC9xWjBleUpyMTNENjZ4WElGZEp1dllwczN0d0ZIT0NqQzhtQlhq?=
 =?utf-8?B?WWwxaWFoTWRmTzdJZ1NyWmF6ekN5LzZyKzRqTnMraC9RYXR4L1dyYWw2Qmd4?=
 =?utf-8?B?S05GUStKVUxLWVhFbGZPVjduSmVFOHltNjRoU1hKejlxTHFoMEE3QTczdmI5?=
 =?utf-8?B?cFVYVjZqZFZDNzVLdXNtM1ByRDZqQ1ZKVFM2VmFGc0RsVnpzRm9pckpQa0Nw?=
 =?utf-8?B?bHRjNklhZVpCMkVSdnJyN1FsMkxRekd4MFJ2UUJzUmFkZTkvU0l2VHhubThv?=
 =?utf-8?B?K2YwamZ2OFBxSHFnMVp6aWdwVmhzRW5iTHFxaGNBUWFXdUgreWpKQ21GV3d2?=
 =?utf-8?B?SzdWVlNrMzNaaGRFTGdjRTZYTCtXRkV1b1pvaXcxOXFWbG1zRjlFTzE1OG4w?=
 =?utf-8?B?ckVsN2VQQjhNdUdvcVJNbVF5eTZWeHRrNkt1azNMRE84cGVWSmx0cTkvK015?=
 =?utf-8?B?ZFNubnN3WE9RMTBsME40ZmJQN2g3N05BSEg2WDV4RDZGNm4zSkZhRGx1b0pt?=
 =?utf-8?B?NDhka2xVeUE2TnNMV0Evak1oclM3eHZuSTg0bTJoY1dBWklCR0t2cVhUQmEw?=
 =?utf-8?B?WFZCV1h5SW5vQW83R3ZPd0Zva2VQeDlodEcrWE9PcXJ2NndTcXZYenJnT1Vr?=
 =?utf-8?B?eThYM2NZb3BoQ3Y0N1RNQ1FoODdVWkhIUHcwV3NBV1dHMHVIdjYxRStlRmk4?=
 =?utf-8?B?YXExRTNXWVhXTExuV1NHeHBWU0J2VVlSM29FdS9ZVGQxcTlGMzdmQVg2UlBN?=
 =?utf-8?Q?+9T?=
X-Microsoft-Antispam-Message-Info: T40BVfUaXtMMycmzFwfk1hPb8wvGcAWHPa7Ua2SI47HHUuGeBseHI/WtMmzH9DIStZ6C/UY3Y/R9r1iPVnrn0TQUqbyqhomTCkcWh3dxwj5Qm9y76EhJVyHGqG4L00RQMMu2qZVZwOTXHX9FWcF20XuzHzZtp3buc9Oz8CwP2KKS0CktkL0PGt0tZM4VKSZVtRbAoDkKFkGmFgyZ1aneesWnnamX99wa/fnkulcbfy2JBFwZB9zpfFxGBl/icS4fEJ0GB3YtC0B2DPSoolxtZBgGKp/37KC8Xm05zzLwdENpebxPFR9q+ONzTJniYMj9931WjTqHfXinYdcdeiW2vJ0RPLNLrgfTXEqXClsNd/w=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;6:xtVPrlZ4mLee68JA/hY5ss0xwbZffi7qvvx/MY7P5v5TtLB6BtjgIY9asA3ElTK+gEgxhswblqVBBzKfoHIqGZiAycgo4gD9PWj2Zr99i1YYN65hhXCaryP8F58bKYXO5zMdfy7Rs329HNdFX8F3ZIS6dpmCEe+PKjiCOogU45h0mH+7p8BerrSchRgUCRsS04eXMTIqOS9QbDyDuVwRFQ2uIopx3VlErzTxXmUb63PmgdJff4MSU4c/7f6KRjBUhPtesaxsNi+13o8sXBryJzseTpBeysJ0a/HAJux1cpRKpWj5Swfg3CUOkedYJN2ubXHeIxuXRVJud1SYv61UzDWOI+lViWXQWETPe2CjxnANFEQqj+lY5ICSpeV8+WcKQAEONZ+NhaM3AuDMNCKufDB5nrCdlS9tiDeYbDxGuwCeddwSGWP+EIVvVSGiFegUwbmxY3EDY8ytfdn29DZxBA==;5:x8ZAe/KQYmmcPTlk0CixjF3nUb/y8T1A4LXRnTF0yzZZDCIi84QIGSi80HufuhwrH84fs6oSihMZKG+aYLWfILRxWnDvSPKaqQZ/SGqN3kZXScgEvGEk36oeLAqkOdW3OcgHV46oqR9SagwPIszmRH7WejLVc5gnwrITbutQ4SM=;7:2CTaj/NenTFB9oeJiGXVHuz3qD1KSQ+gkhgjuCvFm6xE/lToRL4Q/5TyAXCvE5FsQmDMB6ZNY4QXaxtseezcanKcLgDkHWdsfkind1JoL2pshGYsz+TbfTg0curksTTCPIwZzLwetzA5LCtFD01f39DlPom50OaHGeivK66aczF8UltnRvsUosGbZzTEA8NF5qm5H/JLsxJ0o6xbRkFEVli8yx2BHnec7BA828p0dysv5kvjegB6o2ANrEqxOv18
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:IBe2ASyGTmdDJ0hhZrXkI6a4D7JaHjQXV/gNgaVMz6IGUliQzOlyy4EDGJkhOpFm2oibeVpssKCK1s8wfjSMCJw4J5jMPX7lHpqT2nZklNg1fOYrnfjt5eYRNxt4DRx03yLY176M2knVBwrz1xk5wsshbYemCJ2jGZ/jo4U0YZc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:51:13.3017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e80a187a-2a4e-4534-6e32-08d5ed658c00
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These structures are intensively used during reclaim and,
displace other data in cache, so there is no a reason they
have int fields not grouped together.

---

Kirill Tkhai (2):
      mm: Keep int fields in struct shrink_control together
      mm: Make flags of unsigned type in struct shrinker


 include/linux/shrinker.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
