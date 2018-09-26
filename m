Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34742152B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fTFT41hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34742152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeIZWBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:01:54 -0400
Received: from mail-eopbgr80122.outbound.protection.outlook.com ([40.107.8.122]:50760
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727285AbeIZWBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5GFhhxGNgVj+zkCtytglL1MfS2sqkOpcSZg1ewVpLg=;
 b=fTFT41hpKSqXEYO9xHngtMwN/6JjC0eLSRA61qg08JaD0DlNVUDGLfkaxyYY7OXKwqAFoGtR3bQVdDQRQX644W6QTGqD+aoMpuaz21GTQnmSVcfP5c6PiHa/JRTY7R3gmWgFivOKE2Em8dGx7YvYtN80gobhDi9BpZBufwSlUWM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from localhost (185.231.240.5) by
 HE1PR08MB2780.eurprd08.prod.outlook.com (2603:10a6:7:34::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Wed, 26 Sep 2018 15:48:13 +0000
Date:   Wed, 26 Sep 2018 18:48:09 +0300
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 0/4] IB: decrease large contigous allocation
Message-ID: <20180926184809.5d37cdb7@virtuozzo.com>
In-Reply-To: <20180918144623.GI11367@ziepe.ca>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
        <20180918144623.GI11367@ziepe.ca>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0201CA0011.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::21) To HE1PR08MB2780.eurprd08.prod.outlook.com
 (2603:10a6:7:34::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa9a296-3e64-48bf-127c-08d623c778a6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2780;3:Ilbqnwg1SRpC9FSAKPnEgEGKuDAL5C+6IZQ5bWbh3TEbvi0hxa7Ql53Lywu3wA4AbLzcs702uSoI9jWEWpxWs0dZ2rFbzCAlsrOS2drCkHJVMJd90ur3VVPtpnYc8k9xO1qzsZPF/RGSvm5HuE1Sqvbpc/Li13fwbiBZ9xn5DJ2Dw0NeWmvggLqgfSl3OJfa/n7cB3spavVnVwTU2OXRzrWq4rmfAiWCAa7NgED4OzI6yi5tkVwBMnHJVzFymqUV;25:pYOxj2etrEMC8Dm094vckGyYwXOQ/ajEPlYfoHBvFntWMrIzrshIGT2XZje4htQynGcEoctqovUzrmyH8I3MhqRC9XZKB0+Ngh0Q+Z/dXXlguwmpZIH97J7b+vkQ3G2ywxCGqQZTq6+2t0JFa2n4JsJzSI65PnaTiLlDsvuvrvIMd7Flm8zhrPnyaU3/HrU4MkIC0bus+GRe13dlq0DBNVeaYgJREYN9I38DccJ/cKdsGxfBaHziPnrJQz5aTiMiWG2R3LQQhDRolDvun+Ekh6D3GeUdQdY6w5pEAfO11L3pZDqdLC7APX8Y9TlFmy1iH4MsqGjwcPMpxeYM4a9EVA==;31:U/WLND1o1JsRhyOad9psfyzN09WtdAsRBcyObKSgqk48dFH4yeN59MxOOaFLYhC+yoIv4IsEU7CXHxmskVb3OX/QJ76nJ9qECK5REbo5NP3o6R57hVMpsT1y3qJsY23TXbG6C9cGeDjydNgYrGVhB1I5buR5wFymdajMRQFUCv9Sumdd1XQIPICMhnjALreGgvCJWqbB1I0Q3IscszeuAIuI3KKc1y+I7JqwNr9cOrc=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2780:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2780;20:2zAzo7Eraw39dH3doxPxwEWsGZu4MuDi5iOn5HbBJF8CevlwLe+gve8Z/XwbnZ2WUjk61KAdLPs8TEtAhGTOuos6F/PuVYF4qU/aSI6Ax7Tt9iBymftyPvfX4fLustKUdHs1fk8cd5Zzzt1XE2F3CIacpnxqrrYd6F0inkOwWLiBGqAY9/EioT/KI8yB54QvDejF2dj45qpSmEe3KCwRkqW5wSDBtDlXbapnnq/WJfjjKSsgU1xASSX2yOw4NLbu/9J36uz+VGbkVG3epFzWrDFbTiqxVL8NHhtArmgyJoeeaDhuANHGzA5E1YW+Sxy/3Hl8dVALgU78gh09lAPPcYMujBeyRIMKMvK8ugvs9iS9723Ni59KaFDq/KvdGFGx3bjoNGVHVdCrfjQ4so3HeGRTPLsyf2tvMV00M2HFi2O/mCf09l+WtxGnOW8TI1XXlCywipoLIDVWT++f/pChWUsE0iKiOjyyc5zTzT5oyK9F12tm2/+8WsmovbsdhhLA;4:mOAnVm14EUuJyaAZlgJyVg9FY00eXhgXsom7aRGc4ULCX0mPL7ikcLxP/SsOnxrE4KiRmeHLgUcnlPHyVEi23zb5CYKJrMPx3cgGzoaqQ8lZOBosrlMYxiidVI5+DO/fnueC0eb2z1e2LKdTzvQ2+k0wJqLAEXA6DDHuijQmlDlWTRdOWwSoa9mJSXIVztPpRjhrLGux/G9sjEhf93SY8/S80vptoJRYOMJgjKWKHOtLugAwTWIgQzdvVoC0mXiFtBRsagCTQ7086eKHwIsJxppgHJdRezW8qIQQ3Fe22TmvAEmjzPk8cifP4q3SLAPq
X-Microsoft-Antispam-PRVS: <HE1PR08MB2780375C3EE291B5BB7D3BFB8A150@HE1PR08MB2780.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:HE1PR08MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2780;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(346002)(136003)(39850400004)(366004)(396003)(189003)(199004)(25786009)(8936002)(305945005)(44832011)(36756003)(86362001)(6486002)(446003)(105586002)(76176011)(476003)(11346002)(6666003)(14444005)(106356001)(26005)(186003)(7736002)(6496006)(386003)(2616005)(50466002)(81156014)(956004)(50226002)(229853002)(7416002)(52116002)(4326008)(81166006)(486006)(5660300001)(6116002)(3846002)(16526019)(66066001)(53936002)(8676002)(54906003)(478600001)(39060400002)(1076002)(23726003)(107886003)(47776003)(68736007)(316002)(6916009)(6246003)(97736004)(76506005)(2906002)(230700001)(34290500001)(39210200001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2780;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB2780;23:fJ1VKykOz70NZfo5mwFbblsp5YZVYv/aBRfsw+gHS?=
 =?us-ascii?Q?0uoi5+KUnghbdFJP+74fNCjKhImJ69ecQH/GjxFC6hvQKCWOEU5jt5zIPchC?=
 =?us-ascii?Q?2rmE4Cs9mPdZ6KUxvHf4KXSdLK7oiaZY+FfxLpigYj87rn+WQ82DRmK6dUZL?=
 =?us-ascii?Q?Z2cqZ6qoopJTZ/Vn+bNFU5NIUcJlu9FMnzCqQyFALzeF9Lsgs0C8M35y0m1u?=
 =?us-ascii?Q?j68BIs13LbXtpmaGANpVf8SgaL0GS6wniZmnNmt845HKstWoJCNXUKjNG2r+?=
 =?us-ascii?Q?0njDB7CKIQgBoqvQJJRWFSBUUW6jHkIsvG+MuS5b9jqqsOsAA6v4O139y7gf?=
 =?us-ascii?Q?mO3VrFFGNgBTr87vMqu31Ccbj+OVcL5vHn1ryx7ycSK4FDBTI8bM+NHysG/L?=
 =?us-ascii?Q?pcKcn/T7CtzhmklIW7HH9GhAa+y7vNuxX0xwcIb2JgVM5mT3hd5Qwc49OPAk?=
 =?us-ascii?Q?o67O6zY3usAz7wy5YNOVtGc5IZUYo9KntWr8EawEih2YE+rqTIo8EAz1I5G3?=
 =?us-ascii?Q?dCHTEXgaNdVW35+8DSa43JPZjHuctPKkgh6GabEifqYOP481z2Rf2MCRgc3T?=
 =?us-ascii?Q?okDa2dSWqeKFJswdX68/NP90/FHKmPNdQGJogjYMTBECAUtA4LA5jQlkwOWq?=
 =?us-ascii?Q?svjo7GJ5treKok2BGueN/fEXk9IUDTOWGgaCnsO3ThccTy3uJltXTTZQ62Lu?=
 =?us-ascii?Q?IjCsUhpxoT3fB7b8OPrWTDet4YuQdRIxMKjzBd2dwc0wemFZ5Y3ke2M5vfW7?=
 =?us-ascii?Q?KOpvtG7xo6VxnDSIK7sLpBUDsSFuMztvTjBnbR5tPcojrWvI7vb54I6vmI08?=
 =?us-ascii?Q?RirbDylJwMgS302pJVqicY92W7OIq49VVbyg+2SGOg7ahdcKMtCUBEA8MEuf?=
 =?us-ascii?Q?cP1Z6atI9GrnGIVR1afrKxI+ChG8B2RVMDeZseHww2llRZ6p8nRKmPCvg7kS?=
 =?us-ascii?Q?+kR25A5nU9KQ3dEZZ1apGTManXGZwtJIT5yHNXkEuX/SGksoJ7Slyj4WXtWK?=
 =?us-ascii?Q?FgXgVx4+QE8WFBRb7sf4hyj+ZZ4Rv1/j2f9CDbO2g4OAqruxNpP3KVo4yxcj?=
 =?us-ascii?Q?ZlPkVasQkyULyZEqgYP5YTMCsrJ+7prYJt5cNsDdGuWlxjQl386kuMNEOcnF?=
 =?us-ascii?Q?30NNC+JhqJucNvUTZKq2ZjGG0G0GsP1mh/MgKb0e4EzhyDo/+iZ65dVxz5hS?=
 =?us-ascii?Q?CoL4dcOBn1RZSbwxMW2EyQZ+Us5cUmugwduj9+v6wVuA2mZcRtCEDhX0cOlU?=
 =?us-ascii?Q?U8a4h5nkjCaWvpSR+5IQbAsgGQ6kP55j9LlqAiWnc1LnmfV923gX1YyDuGzh?=
 =?us-ascii?Q?CMK5H7L5vj4v1ofze1wb0AOQmtkaTkBawJ3hnj/hFCAK2RQT8f+vHiCgjhws?=
 =?us-ascii?Q?ITqKGkWfV4mmPDdvJ+gvtqz9+sd+YYq8GGmobA6AwQ3w3uom3IS5sG4mr7cc?=
 =?us-ascii?Q?oQ6YFG4aw=3D=3D?=
X-Microsoft-Antispam-Message-Info: xq+2qMj7Voecj0nuGhVxiVtbSqeedDlvZh7GxbI5N4F5fw9y8sIL1BeTDlPrsXDFafUEJRxOcRVks3prrLu4bC7MvbU4UnhDGaHya2HxFXNDgSlGTzkTNJ3QaM1KycpNLM33xX+VCuA/f+fTQM1/8qbtrYG7UdrJwjRTHWQUEY9+hbcJq1Jak7MkY0+HTM+T8ES5Diq65C5KVvbm1nktDTBJ7BfUQOquEsrcaNB0DEo5H4PxuIDRq4iaiw6oq7p+rSQ/WpwXncsn87PAsAF2MNY/TNchgc1MySL6w160ayPmaZwCcq6+K6+BZwOp6mmR9L9lFT8Y5FJPETFcqcz0KcnVfnqxDFJowb+ubzLjrkc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2780;6:bZuy2M1PK9w4dOCqaub9XXINIifxJTSeyxVcITZoBxfGGzTFSp9JYo1HeOBUOlSco2ShjIbUq8dc+tiu0fUxmkGwhcleAzZByg8UD5n+5ZJ/nD0lX7VSEAiE2ruNA0RojUVPiUQb+bkXOrQEKCpT2AD8fJcIC3ZasgPuJuqkdubbC8ZK1gFwOZttUbKQzukgUYXMKtDSmo5svCIsJxRVZ8dbS4mncKpaCh62Y+X4DEbBXPNMAVh8G6/ozZtM3PVIte2eBMeaRkh23/7cv9HqHYe5M7uz2b7KoOzjSEG64Ri0hWVM5YEt9oPGwRqP/72R9sAVDnT0t/MTlsR2jNV0PJNLKRAh8puT0V2y5q6YpmqfI5EcOwtDq5ilJ5Py0SdpURs83FX9vaxRaZ4S4Kboau/1AFBh50SPqM2zUnNKWX3NYKsJ1LoIl/2y2jACsZkKfMabppQn4Jg9HmpbmsYx/g==;5:dN6/Uz8/avmrdCK3SOXxWu4UO19SeJZyF3VIG2RqGaFKEwyVhcCmDoNZviu/V7JSEHxdWdCZ7tejSI0acAn27wHqMbxAbuo6vesI8uSoLuMXlyPbrthV9vi/wJM4dp0xanzcUEoTuvEB/Cr2mYqZ5aGH8MP5rJM1bDDZlVH7cX0=;7:td9TCs/claWrE2WAuX+6Ar/CVhVGgwjPWKuBzchyydLFYoWG0XFMNHnfqufRfHDV681YKYOI0Wp4klprtZmkp4yBr9F9l+/5zSkZq5U9zyb5zXh3dYwXqYYJbHfn2iVL+29USagwrEBCrDNlVNKko0JFDanbVpiUakWg0Owkwme7v2L/qbA7AKNz0E8bRP2R4GAqbtP3xIpVyYkBXlYrD7Nyf85F2S+AcoGPaoEBG903glCW1z87v7t4ok1Y5NY/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2780;20:jt7De20IswqfIix6n1yxtLN0LMCYGCNb76wqKuB6mjaKHKCdCILlubkxYz1qMk8bpapQvvzXXAxGRHS7sHJzCk7N1E+AbkaQ8gql8qJJdRC0y03sAuwUW7Tsev1Ie8jedW4PdX5riEny4QI3rVAFQ37lx6I+uwFifyUNpCM9akI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 15:48:13.5667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa9a296-3e64-48bf-127c-08d623c778a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 08:46:23 -0600
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Sep 18, 2018 at 04:03:42PM +0300, Jan Dakinevich wrote:
> > The size of mlx4_ib_device became too large to be allocated as
> > whole contigous block of memory. Currently it takes about 55K. On
> > architecture with 4K page it means 3rd order.
> > 
> > This patch series makes an attempt to split mlx4_ib_device into
> > several parts and allocate them with less expensive kvzalloc
> 
> Why split it up? Any reason not to just allocate the whole thing with
> kvzalloc?
> 

To allocate whole ib_device with kvmalloc I will need replace kzalloc()
by kvzalloc() in ib_alloc_device() and then review allocation, to make
sure that no one uses this memory for DMA.

Although, I could introduce new ib_*alloc_device allocator for these
needs...

> Jason



-- 
Best regards
Jan Dakinevich
