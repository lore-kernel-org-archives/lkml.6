Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34DECC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51EA208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LAz6mvlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51EA208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966182AbeFNOZJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:25:09 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:39492
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965616AbeFNOZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aooqIZj5qacndCfGiGh2EVk7zzDHFT+c4yrq1bFNhHU=;
 b=LAz6mvlGMNVlEhwjmo3n4bTHH0UcOJzWbFmkez+RwATqjqKLVz+RP+4sthudgHpaMl8OC45HXNIdF+bJtAwfvgx5fvUo+UpB1HuXsPAGggi8sWE01WQi6zgm9TcNB2rU7ge2EUy2uSOW5wER/B+wqUtcRSJ+2bKYHb3OGJXdvpM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 DB7PR05MB4457.eurprd05.prod.outlook.com (2603:10a6:5:1b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Thu, 14 Jun 2018 14:25:02 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fTTBA-0006aH-6j; Thu, 14 Jun 2018 08:24:48 -0600
Date:   Thu, 14 Jun 2018 08:24:48 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
Message-ID: <20180614142448.GC24762@mellanox.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com>
 <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
 <20180614070108.GD18426@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614070108.GD18426@mtr-leonro.mtl.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR1201CA0022.namprd12.prod.outlook.com
 (2603:10b6:301:4a::32) To DB7PR05MB4457.eurprd05.prod.outlook.com
 (2603:10a6:5:1b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb1b374b-a8fc-42c8-c029-08d5d2029ddb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4457;3:z6rPH7eeEV7JbwnfqZgrtssfMMha+CAaICAGYtKGOt0psxhnY5OPEkyP0q3srIjuelE9c5mcJEYxs0QPygkf5hweSxYgZAiTKNm/1u18tTyiH91Bh7N0LN+Kot/z+4g/6w4KcTdGTLybTAkT9SGum44UlQfJtH1M0K+nTV6AKguFi8hAf7eEUD8zU53s60bmR5BDBuwH2oPqZmTfeC9EKQqK8q0Nr5dKLVVvH5/X5I8mUZcsDFQgGnYVLFCb+EoP;25:3GvmlkNh3n7bGW4Zo0JcmsN9EVfjNeEarDDTOSx/aCBQGYY5OIRkFrkl64tZlwZUs1eXYPIR2G81pj98yukti7ZixHL9wX/Mcr9Tj8f+vPDDLQOamMHDqL2Abypsr+BZTLIiprAkkG4MsaayRHsVmtNeD9g34aXeHj58ODTti0/9vTEgaSZ1vU4Nzdepf/6ttYLhzsiPExHD7bilJCOOT6z/VMHeGp0XGvUIxsPd5FeasHfA9BoUaPtrUtRFIve78okQ6nZCmBhlFSs0CGf/Ka35C04FDI59+ozt1plKYCGlJMsA0pfJU+BJVppQhn+y8ZBlJD8md8vidLLCDZfcUg==;31:pViRMd0Di2v/dCpfGkrr9myXRrD0hF9KkfLrobdooXGA1qURH64jZ9MzlNwRW4ZKy71WXwT+l1C84kuFMMmdrbmdqAlVjkUFKYIodbCu+bchqAiEz2fdLuQ0TqiIWjRq2OUwsT6TtH/GUdcxl0TP/Iay7ops1ggGNH3B0Whm0bNc3BspThw/Gh+xxen1jiW6277CPDr3B95zanhw3Hwo5CdmXRh/spVrYBvW7iaMJu0=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4457;20:UhqnwWHAOW/PfTWD3YnVjh9hwqiJ0RxzdGcFIjK0yZG4yzE6xuYm+sQ/oCY4wvA+ojkUqgnmYQs5HngQcoLnbF50nqFV1fpYzQjhSo6eVR3hIh96Vrkw+KmHgTRFXq0Zdn+9Tl3VKGTqlO46lxso9RE1hgcurQ9++V2hd1X4kBmLB6++YQUi2R7NPLgPQBBX2XPvzQrMMO2t3gaNuM/Ql61fQrQRQAP0RdJRWnEMZKoyyu58Gty6hb5wMy5IY9nRNulqGL7tdKTrHQmo5mCpN/OJeZiK57w+zL7CY2mjR3WxhK6qYvjusOKxH1KnoG4wl+0UaXyc1cbNcAv6A5/KBCNJI3owybwznNlWS76N5U465NiaduF4vP2hcfKq8Tw28hIhLYkd0Aohvn3DHBCVfbvq75AxHNhncbLe5MeRu+Vtr56j2h4BpZ0jSFmXEQF/ubg/konaORZCKHML+mAeRb53yVl3zclONmcnQYppubJhE7efStf3drQgVeK8DdPP;4:YLNFJ0iVFpAsyKPGkOhNiDsQVAuPy8r1+c7IOPni30v0fp74vjH7QYOr9Vx7fYSiiuTnKaF4ODEuzS/wURqARUW/xFUX6YmVVGkFWs5R6giX87dX9W1qYFRwbmpHNaHM65VFz+b0LkiAQRQWYdwolwkyZJc4iXjvXUfYRmB0ft3/AW+BD4ySaT63kGrPZeCON5pQtgdPzD6dzzvgLMqNpaX/frXAgWck6EM03BTuV+dP059klkmMIVEAKvClW7xJS0a7UWRour5s1kYkjG8U8Q==
X-Microsoft-Antispam-PRVS: <DB7PR05MB445712A138DCE71371AF2963CF7D0@DB7PR05MB4457.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB7PR05MB4457;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4457;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(39060400002)(1076002)(50466002)(66066001)(6116002)(106356001)(69596002)(5660300001)(68736007)(9746002)(33656002)(105586002)(9786002)(97736004)(16586007)(47776003)(58126008)(46656002)(54906003)(6246003)(53936002)(2906002)(93886005)(8676002)(3846002)(83796002)(6916009)(57986006)(81156014)(86362001)(316002)(8936002)(23726003)(478600001)(7736002)(26005)(486006)(186003)(305945005)(386003)(53546011)(476003)(2616005)(122856001)(229853002)(81166006)(59450400001)(446003)(4326008)(11346002)(52116002)(36756003)(76176011)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4457;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4457;23:pVllxY1mBWU/vHDnlawAvH+3D42VLAsFS4HQNDJW4?=
 =?us-ascii?Q?wYPRvSo2fJhuJF5pkaPf+mKSS+rPMB+6x90hEr1Fnm2ON/Aro+K+raPfz4Z6?=
 =?us-ascii?Q?oyIDt+hp/i9xUN/YCcu9OuZhLM8Shdr21gMSJFrCcuI+Frp/D2HB47KDWqy8?=
 =?us-ascii?Q?kwdcGrw6sdsh1gtUCAeQnwW1vij4kiI9971qXhUUq19R7MU8pI3/Uf+Mt3A9?=
 =?us-ascii?Q?wRQv73T3lW8P+VdqUDfKOhrPCm+xUMqVl84q7qhVL1Ey8NCPTKbUfidKaZDA?=
 =?us-ascii?Q?LJlcdPI6ortXZn0Ku6M94jknebEYY6TVPvt9Qzt35+6eKeG777fFegBTqdH5?=
 =?us-ascii?Q?Aq3DVR6+8YoHJZhGMh3Eu4G94b6zVgmopjNqVBG+tBgTPTgOGz3lWkCfvCL/?=
 =?us-ascii?Q?WW5N+4z5Whbpre+8+Mid2rfiPWHGh3tQlrHMLT2xI+pPW65LJJSTRGwPXNHY?=
 =?us-ascii?Q?ZOZOqwe6+JNqRc9Keh+MPSzrciMBJ+S4FMYN4hlr8w29Ci12M7wbcHW49nZw?=
 =?us-ascii?Q?STkGGdOmpeTvRIeh3SyYg4y5+0cZSa/RT7BTWxsm0iG4BVBqRcyB66GgclAv?=
 =?us-ascii?Q?ncmZmIwN2I95iNLEDXYVI1hIuJI7TxsdLxEl32Bn4mebFIXCqpt3lASmmFPT?=
 =?us-ascii?Q?3Ppe076VVRa29CYfSbCjSM4OvD8YH/LhDMJQVjGskC76yAX3hp9Nk5E+WzFP?=
 =?us-ascii?Q?GUI131ydDpRBGXb+D1i0F9vyM3liuM8UoIsqyWy9eLM5SaENlsdknHEFP+Sf?=
 =?us-ascii?Q?32dz+4kJkOfg+mDtqhbbB6RYw2VbsKumGK95S3UNzDUBanyrIuXDDOSslnXJ?=
 =?us-ascii?Q?0UyDO5aDAglPhSLKVz/bF+T9pg9eIHJ5Q61yu/Nt4fGgiV7irv6XXjARxN40?=
 =?us-ascii?Q?iM1CF29u5UmHe0cS378RArKGVWP1NkobXPk9o+vFXY0VmTAATz/e7P05bP6a?=
 =?us-ascii?Q?e+0ZNt3rr42ofSWUsrvzPixiJ1PjYkuLgxRZb+URH6e5MRHws/wW5KKvxRpf?=
 =?us-ascii?Q?JI5TR+OCNtIWk4gDtnEk0iIsYaBF1Dklbk1P5A62pLkJxDAVzWztpzwkZiv+?=
 =?us-ascii?Q?G4YYyfJ3VCmgwxf3dXMQDZDn2y9782Z2yH7JHOuIz+nh/26A7k5noLpZJ+yG?=
 =?us-ascii?Q?gpwRsnbhz3A8mqUnb90Jllx87QpbqXP5H4Gn1mYx/YKSjkfVJ1F+vSxUAVJm?=
 =?us-ascii?Q?XSMFka3ja+doqMz60YAyCqFvWn4gT8R3n0HcOp/K8mMz8Scoq2dOqyqLNX50?=
 =?us-ascii?Q?U7Qf/Q2dt5KQrhJMvcNdXWvqp6hq13ZTSJKlpYNc0RubfvOBqV7Nkkpuqolo?=
 =?us-ascii?Q?/Q1Zcqmg7Pyax1RVY4/pz+W6N+7HxTUHmpXSMTz34JTkequl6ptV5xzy/RWR?=
 =?us-ascii?Q?SoDYQJtnhP0BBzsBbxtW9rrlv4B5jKr+ziKKOr3yk+I/+U8qgcq9yNsTYmOc?=
 =?us-ascii?Q?3X6MnK4F20skSs02AQiGG9Zs1EOj+s=3D?=
X-Microsoft-Antispam-Message-Info: UOZRfbozKsmnSzb8uZ5YBlQMVUqe3S8gZhkC+lk+jreJKfzPXXR7C/VigKhidNFpSNs7CiUzwFDB+hxswLrJh1mYQHz2D6eziBZkwfI+dtwP678MA8yrGzWJGClrdh7uROCzQXKf81W74q3+T0hrEI0f9Jo0y94jfuJnUe38u0M7jBGGmVn2pfczj71o1N3w
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4457;6:v744Nj9Z0jW65m4H+q94bDTxl+F7njnK9myImSRDdpeDKkhceTsd6rSe2TgjDpqYXquFkjpozZ1izB0utFgzMMU8pa2KEiydMKl7uzoJsax5QAYWN0mIshDHbUWFPUVcVCUTCtTrngeLIH7WXy2uNQ5YgVadoIEIDR2TvXUZH1CHfu+hzId2h7bvNl/8kpgmX134KTBldCydseH49Yzj2j5HmoYVn2P+1dEVJSpv1t5XPtxxNYEMSDqlpPxNEsyhIIQbA65HbS9HKGaZv931XRhfxSEWeUcfwsAF7aJFxbGiY0v/hTe1J7Hcb6QOeF0MeECZCxHAG22trsWNxxy7jF6U1PVLymjgJlbCfGV6kDbPKFuyB2nOtSSeE+QYB0rfivJYjyf+mVMe38zY8ynYgUbv31PXtgscwMSobCFvQmkVMrw5iuY05fSH4LMR8SLnh5Yif7ZJl0zZeMKu2zOYtg==;5:OIXrH0ptsFIvKP6DrILooVQyUkmtBeAk/GSXLQcxl/yAHGe/jGen4wa8sOpKRY0DyeZBEuHcpgd+yw70+9CL2Y3oDo9IH1CkpbKY6Ktx+yFNJn5UwIZ5Hhy6Dn7wSGHUyL1jaKA+FQPEhIgOnDX2/t8IXPFRqhkPjr0LgatvTXs=;24:fKVD7P5457O6SbrxKLxe4iKqCXizuw8eNq526IbcenQWklbKJSAU4K3TSkPbOBSfHenNiZSr2wKuxpIFtLmyZ4mAAoXXa+9Vt/zoBXKFwX0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4457;7:p3aAojkTQLCkdSjZ4HR6QzrQhqDgU3fkfZ9W3ASjkQgUJ4ZDRrHv3c5eNeiNJCUTYJrXqIGEhYBpxho7+KZZD/4k3xeQa5Zp5ys1vaEu3i0rMp8EcHqOwsAQIY5jFLfVlu15c3KmEQFhkvmenuJ094ceKzu2OD+iXjwaRvti5hGeG3Zmg9g3/5Rw8njWQbuANgVDvTuiLKjpstnnyGyHwZWgwBVsMW3j7i1FUKu/Q8SLGqfbedtx7Hivy55DEHPO
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 14:25:02.1244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1b374b-a8fc-42c8-c029-08d5d2029ddb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:01:08AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 13, 2018 at 11:21:54PM -0700, Cong Wang wrote:
> > On Wed, Jun 13, 2018 at 10:34 PM, Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > Hi Cong,
> > >
> > > If the compiler optimizes the first line (mutex_lock) as you wrote,
> > > it will reuse "f" for the second line (mutex_unlock) too.
> >
> > Nope, check the assembly if you don't trust me, at least
> > my compiler always fetches ctx->file without this patch.
> >
> > I can show you the assembly code tomorrow (too late to
> > access my dev machine now).
> 
> I trust you, so don't need to check it however wanted to emphasize
> that your solution is compiler specific and not universally true.
> 
> >
> >
> > >
> > > You need to ensure that ucma_modify_id() doesn't run in parallel to
> > > anything that uses "ctx->file" directly and indirectly.
> > >
> >
> > Talk is easy, show me the code. :) I knew there is probably
> > some other race with this code even after my patch, possibly with
> > ->close() for example, but for this specific unlock warning, this patch
> > is sufficient. I can't solve all the races in one patch.
> 
> We do prefer complete solution once the problem is fully understood.
> 
> It looks like you are one step away from final patch. It will be conversion
> of mutex to be rwlock and separating between read (almost in all places)
> and write (in ucma_migrate_id) paths.

This was my brief reaction too, this code path almost certainly has a
use-after-free, and we should fix the concurrency between the two
places in some correct way..

Jason

