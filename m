Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 54313C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CC6208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="aO69sExV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CC6208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754787AbeFNRZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:25:00 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:60892
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754526AbeFNRY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw+4jUGQSSyv3wXCF+dDQgiaEUj5YUolckB6kw8442o=;
 b=aO69sExVAyCAri7tVOvhz86oZzyJ0cx34ZEOfvZMT+mjQk2RAbcRLF+pJ7jwi2VWkaDpUsT8vn2VZm4spg1pq2/EPWK6rksGAELrqL4a/u+xoygKnBzFobxUuVifebiyxv2mnfRJhqF7UgySN7XDI4dWLvVdJwJI36crXQfXfWs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (2603:10a6:803:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Thu, 14 Jun 2018 17:24:54 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fTVzF-0005I5-2c; Thu, 14 Jun 2018 11:24:41 -0600
Date:   Thu, 14 Jun 2018 11:24:41 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
Message-ID: <20180614172441.GE24762@mellanox.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com>
 <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
 <20180614070108.GD18426@mtr-leonro.mtl.com>
 <20180614142448.GC24762@mellanox.com>
 <CAM_iQpWz9b01ksW_OUHgr1=pf-bNsq_TxoNCQxuDdhUXfvoyOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpWz9b01ksW_OUHgr1=pf-bNsq_TxoNCQxuDdhUXfvoyOQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR0201CA0101.namprd02.prod.outlook.com
 (2603:10b6:301:75::42) To VI1PR05MB4462.eurprd05.prod.outlook.com
 (2603:10a6:803:43::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89efce19-609f-4f70-00c4-08d5d21bbe80
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;3:g5Xj8LW9nDEeOVe9ddyu0c5TZS+2GVVOUToI+JtrVwkFBM2kJduumy/v/y9bXsjWplD6EVyJ1RyIepD5w9rq+M2mUsnI7aDnZV26LOAg/MHueUvjixZsReuLcYL9uN0TRSGYSDNt/77FW/r1n1fQp3ufEwjvMM2jocObUXv1B+kclvJQdhuY7Gk6IADh0j98S/ZyWxtxa9fvsXp0IKdq7g+kcTQtwI8w4uJgnyF5MUVvb6YfOg0kqvhmqVux6i8e;25:RFtQ8uFTZa/PseQCgW2iJM5dSDZ7/2QljvzRT+aPuG8NJhSZrUmwBpSj2cHkSg6eS2M4CBT4OWe0s1nmh7HBIg2ZUMVM0fr4FQBXsBS8uf0q4l8JItxhqk/m5LCxWzSDfMpWJeDEgnDe/2qrv5Gz0VGrVRK4VJ+qYnchJju0eaBUEtzVXgNBzRFrn7d0BiAXetsh+g9eEgDgOTAZTiJpQhNaZ6r25VBdi6Jp+kT2oq5WG9/k0OtkTj6DPi3XfURAYwGjFemIMDXjDX/p1yVVtuUDrKQ3x4FO826soXxDvpkSGYzgJjiWSOCiBQP4usJwX5Dw65PvOG9wigKST11OMQ==;31:YVMDUWSfZdF39aN89ER9zNQSoNP/SB+HPbraMfLNFSSqxXSUB13r4Io9fcLGM+ntctpJSPYtnB453Zb7l7ibKLDhdAtc/P8rRAlnVmoIg14W2cKR1Ud8Ht306XIRgVqh+p6+nrR9T6+rNMUrHELNG1qu021GKMMNxlivR0c9E3KmnqeLhOSywgX80D4svo6wWRcMsuMk9lAMgqr0dw8wGI2SewKt4dfY3zIfOO/VW3E=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;20:veabV/HEcJVnzHEWeIL7OP7V6204bUTEcgi1JRqQoV6JqOTy/49+XctO+zlKWLsThjTt76zMyfGn4kFGZ7EH3q/KQKCWkWdlUsmIZfPAwwOFBL0bLlN+hIXbUvA4PsPmdRYr10Gn1ObZe1O3gOGAM3q6wR6IlrSx1Kqd/W8ZBivzrkaxbZIuJ9bhCd4wp3TshCetfc/KtqyrZPmpG9TAQAQC+FrB21V3/Z8qYSTu6/+f6Yhh2On1WTzjxbpKJZ6HBeSg//kYQay68VIlc+H+aBo3xeMlnAz4hgQyVAZGZUEZ2r+nQvxXe/YC2IWclWTOvPLhH6wqH01LlFe5wwaOz+FWO5XnKscXV5evuRZ53P8Buu1c2U04EtqVsplQvOvpQval+mtlYVNlrXBJGgYkq+2e6lEE/wf0B5rOpDf9/CguoaeMsEEEuTZUT5UzD7T2DnWDtKW+gLC9EH4csdMVz8kt5Jq6t84n8yvVHeZi7QLtsBmstyBF93IQ2U+HdfWz;4:rPOvu67zuEXipmRofADeIC59kdhiOGtWxk/NiabU4b2d3qhYh9xeMEWxAJTCM4ljDy6AJnfiP+Zl3dfdGW3zV3o1/+mWThQFDO5Xdp8MhXpJrKeG3vx7s8j+156XCGTmprBfLiaNRKZorn5rSCZ2pMrPleWAM5J6R6EhqIPayDr55TS9ti6ChiGpgAGA2tlyI59kh94iV5BwYnLyGlxvhf8Tk4HER7sFSlrft2SQHRIRRGipPi8qO0IdmGiHxUc4BBDS4NhLuYRnGnUrx6Qfuw==
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462E15454636A933BE66A42CF7D0@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4462;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(58126008)(76176011)(386003)(53546011)(33656002)(6916009)(8676002)(86362001)(52116002)(97736004)(46656002)(478600001)(486006)(36756003)(186003)(26005)(476003)(54906003)(50466002)(446003)(66066001)(229853002)(59450400001)(11346002)(5660300001)(2616005)(316002)(3846002)(93886005)(4326008)(16586007)(23726003)(6246003)(9786002)(9746002)(7736002)(305945005)(53936002)(2906002)(68736007)(47776003)(39060400002)(122856001)(81156014)(106356001)(83796002)(1076002)(81166006)(69596002)(8936002)(6116002)(105586002)(57986006)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4462;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4462;23:lHEd0GKcS7M9/OJh4r7fZqAMIhdoPeuJFsaKKzZt2?=
 =?us-ascii?Q?d1tBZeLtqMchRiko7i42lg2oSsi8n9izRPmMMKV60xwu4ycaLaHATM8eL8oO?=
 =?us-ascii?Q?FSVZAztLvMazofbgJPXweU/oRhyQQlgtieCjBhRr3xfe4J/B0GtmW6sdCPKv?=
 =?us-ascii?Q?bsn7jhJ+rDEqFGbkC/OEXZohomsZAUAS+FFNXJDZiUOfoKPviX/mL/K9wzBi?=
 =?us-ascii?Q?DYgUQPDaqpYsUa+j3FAIGDavgqhpD8yHjley2NK3nAJgxwDqg0SNtAj8bHT/?=
 =?us-ascii?Q?4cNXUJybSm30V5i8OVXrrWlWQfbqpnBpb/6Tz6N5QkRXBUAmGwo5E5IhJzja?=
 =?us-ascii?Q?owF8JYSk1TNy1yaboLSht4/dvOd7bGu4IR3v07Qd5MEzaDoHtbjkt8kSOP2K?=
 =?us-ascii?Q?yyDIHt9wjD/A0R+2sCpf5mh5UabKmYdvxhu0vXPmJxv2LNSN8e+iyPKKceFL?=
 =?us-ascii?Q?d/UiHx08gePn/St2Eqt7Y7YNoPHfahmHYs1nyA1LD2VNkunhXNpXePJ8aNvq?=
 =?us-ascii?Q?lD1sXQBdrs10kzxk7jd4ChVKAbliGc/B9JaevZZhzJ1qz2Zwz67hMwlRavah?=
 =?us-ascii?Q?mUGS1RZWqCN0yRDqYYKSkG0Ij66LU17N0jv7yP5eXOoNhlr+oldozudXB85Q?=
 =?us-ascii?Q?5NCbodOM7N8gEDJhaPlcrnMaVxe+fgGRBodDz/dKLKBUODqOYv90rIYvMosZ?=
 =?us-ascii?Q?7v9zylW6a6/QQXqyQsyIV/teVb/CHBGXNf01enyy3GMzaiEtkVRxzKezW1kq?=
 =?us-ascii?Q?DeLEERrtHWbMBHss5ehwBu57NQBuFhYdtwmp+cZNdFQwhMGr29sBVXm4AGk8?=
 =?us-ascii?Q?R3bVopo/yRCraUMN48wXDXnWvbH4/7Gu6McXoseje/zyplX6RhZwD7DsbAen?=
 =?us-ascii?Q?dzpU7BgcwSh+eDQkLCKTJ156M0x5Ld/ZT5kTg/vBQ+cL1oMbhbspIQW9BBml?=
 =?us-ascii?Q?ZJT9H+g54zoNEqH5n7GnDsFxJdjx2Y11OfUR2FjvoGwz/d9MXLy9PJzxJf12?=
 =?us-ascii?Q?t2iIb2avrmE1gV++st51o1HbQILwL1h4LXXzG6OZOP5r+0QrZqv2lbo1DIjE?=
 =?us-ascii?Q?yOt+ykOF00TuAfBOBzdApbVMWo018eXUvCsOF/qqmfu1QtVBbkLtaPjIbiwz?=
 =?us-ascii?Q?bH2JLBTOJOcPUc8Fwu6X3wIKcQOkwyEr0YRBQqOSp1eAYJvvgBsk1M749OR3?=
 =?us-ascii?Q?eV4YKlKM4KbdzFMrpFjTJW4uKc9xCpxE823kUHxdiECxsIEgwMkxpBrkywpF?=
 =?us-ascii?Q?FUKzGjeFVcPtimQ3Alwj9EXT6tnZj3j04nbdWVeU30P3bS+1OOzSlfIfuas6?=
 =?us-ascii?Q?Kz+H3qM1D1qsRQvBwpeWn5iM02ZJLGKwlT6qZsF7dL2ZIGQffQtr6OIocvuc?=
 =?us-ascii?Q?PI532jrt+DEPWuw2k96GBZkf4ppD7PCteIKtySqyEuUkHAYfQ9rr0G98HlVp?=
 =?us-ascii?Q?pU+KE06lBZcU/Cye0u575K7VSmuQas=3D?=
X-Microsoft-Antispam-Message-Info: 6KrUq2G7HbxWmsbkUEs3YCZOFzYYmm771J2N9fjcUPP394EeIiaWDsPQ1GjYjvd9H46SI9RlgPIM3Y6i/tCf/eJgngyMtXS2+iLDVUNnfABvk6B5bwcA+SEFMN+xN9zpAYWMoEtLWuo4KkKLv95CYYxKBM5xvw6J9C0vS+MGxN6PsOU/X65hETmFJRw2lNnW
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;6:rYgO1NUB9PBYC6DAX4LsqRtJlr1qrZIehEv8OQWj+9o5HLrsEaKKLuRNdRKPtY0hpDeu0lfDMU6rH241DxdORBdOTYM6zM598AQlIqvnrv+bnPqM+0D/e5xCbxPF34SYuTZKweZ0LU/IQgNitCgRE4dby9VkGY5URvImubGvyyfuKUtFywB0NoIzVGL7NJdrfmZ/m8yg3oy/y6q3C1gKSB5HL2ics5Dy9qlHGBHVsRpQxf3ZIljjAl6ljErdMZGMRCCeHR3ttQPEyOflrT831q9ERqAEKTXKONWXs+I0fi3iv9SIh+i9tHJ8PNuE/+c/cyJdI1kzC3aGA/elWlgeJyRkVQgFi+aUFZzpAkmp1vBrqEbb6DBLn0A9YcBvhhqM4enb5NkD8iaFqg+lgSPznX45CbPe/KKYsapWjIF+l/Hpc28HYFHIJfIip6suHirtiUauMlUAlCbWU6KJzAslDA==;5:oPhvhyglLWoySW0gWG46RaNOjTJkZFOHdtEseBMFbbvTWgydI+wsPxXiNhSR36lCrTcCnXl56rzPx8skX3dZt3uLeiWRPNO5P3RCwhV49wmygG9u5hRrZWtPbhlEDlT8MKFLDzI7cJ5RJ7xHpAsL/4ewh2Z16yrTbJHHuU4B2zE=;24:aPxyhtbH/ozIClFXatQsVMYsXhTv34KPnu0mFZ02G2ILGE/vwxsVQinw+BRXsW7KCIHo2nKpfwpNKPD6ZauVf02kTrThxMTpqKipq5KC4wk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;7:mV3Px1sH9UDhN27+giyn3Yv/AWACU1U+uCJJDFhf4Gq8f11S7cpfh6yy8d2EsAywo5taEAP/DpFD2lGuliuFIO1wwtKcsKWssFuxRScwCrjzhrwcI8CHUlD4KhPQq9C0u0CPBlYuaDiEfO6KNXeAdyU4lLhMnVGRfrezK7v4nr1bFc+Vo5mlPuGKB4NYr9w//0PvceK1iCU2tlcwLol8+Wb18jP7WDfmheHf7OGqBdwNuveZ04LSu9KcvFzczEwz
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 17:24:54.2821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89efce19-609f-4f70-00c4-08d5d21bbe80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:03:09AM -0700, Cong Wang wrote:
> On Thu, Jun 14, 2018 at 7:24 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > This was my brief reaction too, this code path almost certainly has a
> > use-after-free, and we should fix the concurrency between the two
> > places in some correct way..
> 
> First of all, why use-after-free could trigger an imbalance unlock?
> IOW, why do we have to solve use-after-free to fix this imbalance
> unlock?

The issue syzkaller hit is that accessing ctx->file does not seem
locked in any way and can race with other manipulations of ctx->file.

So.. for this patch to be correct we need to understand how this
statement:

   f = ctx->file

Avoids f becoming a dangling pointer - and without locking, my
suspicion is that it doesn't - because missing locking around
ctx->file is probably the actual bug syzkaller found.

If this is not the case, then add a comment explaining how f's
lifetime is OK.

Otherwise, we need some kind of locking and guessing we need to hold a
kref for f?

> Third of all, the use-after-free I can see (race with ->close) exists
> before my patch, this patch doesn't make it better or worse, nor
> I have any intend to fix it.

I'm not sure that race exists, there should be something that flushes
the WQ on the path to close... (though I have another email that
perhaps that is broken, sigh)

Jason
