Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6390C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3EB20891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="tPhgbUOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3EB20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965494AbeFOC5w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:57:52 -0400
Received: from mail-ve1eur01on0069.outbound.protection.outlook.com ([104.47.1.69]:33194
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936073AbeFOC5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWNrswAa0YRYcP8aBN0w7wvT7l6J3pLBH4tcXY0oubU=;
 b=tPhgbUOHSJZDPd04uR4Cx4BY5oOCWhQ8TsvMtuYd52oVtazXkGKU0JE6t8DrpgQwhrRIkTTVgCr1B/37y710AysnhqtayUMenzUujU41mhpbmtKY3tq+5c4780uR4JoeUkk0fdejuaHjrotcXXoz+LmE1ZYBap4Gi5GbKvybkwE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4461.eurprd05.prod.outlook.com (2603:10a6:803:43::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Fri, 15 Jun 2018 02:57:46 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fTevj-0007qO-Ob; Thu, 14 Jun 2018 20:57:39 -0600
Date:   Thu, 14 Jun 2018 20:57:39 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] infiniband: fix a subtle race condition
Message-ID: <20180615025739.GB29138@mellanox.com>
References: <20180613234947.15767-1-xiyou.wangcong@gmail.com>
 <20180614053446.GB18426@mtr-leonro.mtl.com>
 <CAM_iQpXxHk+yFqqK-Hezsc83_mKfbUXr4=jjNnik5DwGscRKUA@mail.gmail.com>
 <20180614070108.GD18426@mtr-leonro.mtl.com>
 <20180614142448.GC24762@mellanox.com>
 <CAM_iQpWz9b01ksW_OUHgr1=pf-bNsq_TxoNCQxuDdhUXfvoyOQ@mail.gmail.com>
 <20180614172441.GE24762@mellanox.com>
 <CAM_iQpXFmqcCQWkyGPmev5LrPpDoEc=wpXQVDWJx2UQWPhwb2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXFmqcCQWkyGPmev5LrPpDoEc=wpXQVDWJx2UQWPhwb2g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::15) To VI1PR05MB4461.eurprd05.prod.outlook.com
 (2603:10a6:803:43::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa788097-9ecb-4c92-494d-08d5d26bc5b9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;3:/DD4nQZGySWGJPdMuyHJoITtUY7BcGmEXZCjcQMyWZgS5PVO6eLV6SG7BlDz5J9a+bUSnapf8iNY8uTyvKg6YKyISJkUPkyloNUKIFJctzEaviL1HytUFD0tZpcfFPjSS21uymiwfciPVTJlCrM1yycaqvVTRyo4JrVN/hmR6+jfGJTF3P+9yKDwqanAXilLv8iJ0KS32p4/wG2H+tAePBJplpuyldULugm9OnDqLVGXbnVmmZtdqbqI+1Ycm3Bv;25:kAqk6NkDQjb60/j917z06Nt5ncUhLLp/HAro0bO2FHGAPLay9P8O24ODnRUYAkuq4CbBexaYxS5JAxxT6TCv+c4sPuUvRPSHH2TN0IH4D4EwTqGSBl4GjzZ9K/zbRoPebiB5pi81H6CP8Yv/XF04fs6+VGrOFiiF5TlbfUD1MjNq8DG1w7BD15u3jyJPZmXSE49d44g0X08PBRDP1tp1C053uCJFUfzLs8RVL0bQgCf3fyrVw9TjcxAwg6LoYX6EkjyCAduCSpGSF1yeP2/XRITE3TAbn37wHD4TS62o4D+r1AC27rR8sL3gRHPcJz5+L7/dVLl5B8mA+UlQ7IdiPA==;31:DaMV1p4GyoRZBH/bsLjsvmzMAeVMEiHLtqQkX6W5Vw8zSAatMHERYW1VreDp7swYpErxVMh3YRvEih59kgQLh0vlGp3tcRrnIA9qLRjziaDL9+Iq4bwoQbbieyO4bf7HOQOJaPv/QvNFMAcxIrEn7dPz0GLmlevlw8sWsyq4P42xZhY8Ppu96oct3Xbv8Dv+FesOH345u/4oiKEROmhe+DuI+fcNKzkHTQYtk1wWyuc=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4461:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;20:3ti3FnThD1Yv9GyPdbc6R3KauNwFJ9bC/OaoMmla8EAluCKHVbPyJ/KGu+GeTvOyUA5PfCDxTNeH0ew8V9QtqdoL5gcXDh1Qw/G3qlG3NpZjAk934CxWJDjanlMyv7IfFL812m/XU//91vJ+PnAqxdLDW8CmiTLpal1AVNvop0dE7lMfBZcpfIDmiQbKQ4TXiA77lzkPE8S3Y1EUz+zqT89LCZrvza7G0DcXXVewgfp+v9fEK36JulumHtlezm8dUNKy2l0xi4slKVUk5UTS7JrpqNza7aodMVVvyOROkphPQqN8eM196gpLTh75T2vrIIzBeBkHKDwk0g9B/9gqyYBEERmCGim1PWdksy9UYeDHrBzsPoI4OlIlAcuLEOXSipcqoGGWQdAmNyh/Jf7c03TbJaLJ08ssoOs0fu5JbPWVi6/hszKipcgdfaYkKdR0xsyqMZM9ylIUq2bMNHnfZvhSt4suxBiGo4+Rz84kM2m/xikxxXvx7qvDEwQIPoLV;4:bGqW9MPqd/+KfxHKw9MGcM+nOp3SKHE+nW6apv4mTGBdigycBSBH+ckeltgZaJaN6maLhX1V2epR23MPX1Fw2+DAVw0glOve4Or9mVwwoQ9Ch3XWPn/RDtlYEfF2XSoX/wL9W4D2a+fP17pxH/tx1qrVA5ma6ogFmgXTkQj53YvJCjkYiyZMW9QzfWirbX1DloUmGsq3U1PONa8Xx5wS8Vig46w52luP0axsLubITHDYxck0+P5J9CtRIqcZhSVH7clOqZQ/YSHE/kmQ6JpOlg==
X-Microsoft-Antispam-PRVS: <VI1PR05MB4461EC1215EDCC80666C5DE4CF7C0@VI1PR05MB4461.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4461;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(46656002)(386003)(6916009)(52116002)(66066001)(23726003)(53546011)(86362001)(53936002)(186003)(6116002)(3846002)(2616005)(486006)(476003)(446003)(478600001)(39060400002)(8936002)(11346002)(68736007)(59450400001)(76176011)(5660300001)(1076002)(47776003)(58126008)(81156014)(97736004)(8676002)(316002)(9746002)(57986006)(9786002)(16586007)(81166006)(33656002)(305945005)(2906002)(36756003)(69596002)(50466002)(26005)(54906003)(122856001)(106356001)(229853002)(93886005)(105586002)(6246003)(83796002)(4326008)(7736002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4461;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4461;23:NkQhdHMz0v5So6U7Du7A3d9xw+fqtffz6MVt09G42?=
 =?us-ascii?Q?s6KQ1F9OHFzCKbUiTtBGJkC7FmajJ10dmuEEOjEa7lQQQ6R4Vh17c/u2u71b?=
 =?us-ascii?Q?prhZK/lySMIolv4g+thYYfQ3pFxvCH43InfMhrxyEWBozNAXjeaBqkPD7HOu?=
 =?us-ascii?Q?d/Bowg5e+dRI1hg3zig3Ceb5B7TJHiwQTtF7140n0y2r1cL61G2mAh1OmKt/?=
 =?us-ascii?Q?azKe/xwwRNNLMn+35CL1/z4JPrwlTfCxJhzDrYtZW8AadyDLqL50ME+VgQEp?=
 =?us-ascii?Q?/X6+zLsGzGiY3BwCyuKD90SFi9L/MXwJFPfYtahfNf+zUTe0uAbbf0DRv2R1?=
 =?us-ascii?Q?LdB7rpsxAXORY2rV3YdXY0RSbWzJEeVilKIHspubh2gcQ7G+4RN4EPf0y1IA?=
 =?us-ascii?Q?tcToUGHrRSZ2Y/YjpJN1lCR7x/WhH789//x9gh4n1C2LPdYNLsOx4G4v++XC?=
 =?us-ascii?Q?nEC3GuTxpsPjQIpWHcn2JlquW0PfVdj8SVPu+8BK6cpv66m+io2BkEei/Bjp?=
 =?us-ascii?Q?vMyGoiVbmimpN8Nd9sjN+ofKIDSnPMkAxigYtkqtFJtv80Fm2iIaQ3ChLQvN?=
 =?us-ascii?Q?+VMxWH/XJfRdzRCWwfFwqf0D9HsO3bOkAnM7+6DRGMYuREAphiEnVAn9Fo37?=
 =?us-ascii?Q?wm0Hl5BE53O9gvTDmH50FBH1Rro2T6OHkugG2oPjiEzCyIESV2q7WAffipht?=
 =?us-ascii?Q?hhDC1ZCve66gHJVv/myIVS9GPynO7YOGQl/0pBN0XRQacSheuyMAls+2kr6X?=
 =?us-ascii?Q?/MRLH65TfgAYlUVy+rfAchxZk9iQ/HefdDrIGMs3eaaJET4sia80K/benSAa?=
 =?us-ascii?Q?ZnfTU7t2Jy1Jsrq44dv3koiVj0CPlbTl12rrVHXvi+r+bt8NF0fNsMicqVTc?=
 =?us-ascii?Q?bIuSPpMYtM/r5et+mdR4f2UPMMD2cUi4gXvf+5pWZ9s2qHVkSEiX6cGYh7OC?=
 =?us-ascii?Q?W+bGE2OvNTCpq8xyq88HO3GntTa/Bi3XL0wpWwNL7iwV6Vey+05fSPIMwoAf?=
 =?us-ascii?Q?K1Xi3AAMr8Q3PU+AFi7W+RYi0gDBcMzy+CCmkzhbXF4yigQPi45ypKqyweCh?=
 =?us-ascii?Q?U+rs2zo4OoXsaHaES1DRroZW6Be2AVuOk3GRtkj3CJaJM/c0rFaY9ZVR6s+u?=
 =?us-ascii?Q?3j+EhdufDmz1UIUd6TtoRs8OmhJ3pbbumjW2lr/4E2ptSq8i+J1dLxC9ey2J?=
 =?us-ascii?Q?E5/XtyRxOsmhAvc6Qgv4exCqhYAgabxNTckwjUyT5N5IxCY19ULsUMRj0vnw?=
 =?us-ascii?Q?AIQvqU2Wr+In3fPaeNP70ZKSYW1Cf+W4Pzwb5L/sC5PEHx8EVF0Bs7DSTYJf?=
 =?us-ascii?Q?cVBVjgF4wLJu71VyvVp7E3I785K8hi4BxsyQXZPTfZXPZzsiePjdgaHoDwsn?=
 =?us-ascii?Q?B4p+oSfSC7kupKh/WvnPIiR8r/xwmtA2lr3/k3UsR0xQVNUSnFogwDi70zDR?=
 =?us-ascii?Q?o8vvIdWNY0VLZIpqMvSxgBe3gIAuq8=3D?=
X-Microsoft-Antispam-Message-Info: 93U3rDSL6qP6PV1CUgqT2NU0TWdotAmB5SOlvf4yycci/cm6ARAAlQrEIuTpHnRFVh7D093Srg4h8kQAEXnJXexAvoqTg0Ub1oCcV1jYNFpoKyGghqU84Xj9YiMCuMGs4MJEQ29kXx+ndR0Tukt5T6VBJPJujbT85YKMsc+DGY6yaont+DOmfIjkstYjjhfR
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;6:PBY8H+uf/9p+76lgcTJbMgVnsaYQajR3CLykCPEA9cuK66R3idswf7JS/N/JcojfI0h+klBQ1bywGijooNxj2lRdt+aQPt7ytqg7zfGAP/27GXmlGsDEfWjESi0ioq3OGMmjbBziD5e190XCorUXA5RKaG3pl8cO1Y6scPmZ4uN8boy2oX2iqAzG0h+k/CempHs+vP+Pd9eyDSjOzuVb648q5XLPQAaGKrAoRmeX0m25CwNJodOJbzmSSGxAEIivwMLwnz12SuB+cnDJ9p2Z4NGlTRr4g5UzZTU7HgUfoLtYYEXB2iuQnl/xPeNGVg/Y5fDyU9PcjFH918tLgHp4ajhXyFO9IWRjTFOUUcDS7Z002ztSVhPuYN/SudEV68T7h0z07Z1bGbv8j7Pw5fv9mG75OweDE9aCfaL0Lri74fSwMU6/dLtNMdbkTrNgYTpquiPBROm7ux6AaHm7RByKSg==;5:+ybz4Wh2Kfhw5AKmXwUO/MHfD40X4Tu5p+rYiyEdPXY3/pNu6VkCiQYoMUfr9vfYwkQ2q4PIVyLi29e2aeskZqzK2HItNEKchjPU5+vt9MQh8lql2u7q1HhIW1CWttAmmZb2Ci1UyWby7druTC6RZg3LzrPdkBmBryEguOb7aJs=;24:OF1FYJAv+qk0V/753t8GBjpw10mFJ9eJMk/RK9Z/boR3qkEQ/zwVns/ds359M+7+OgIY0+j0K5riVZ9OQcc1uo04f5NgjVBOhVcEzlyk4g4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;7:fHcRsIRkPk+6ridywyiSXUYj1qB5SWGfQJUm/OxIDz0AZhciKvzkLomxX27pdlSjMPa2m7uDBLAC7h/JIuUW9AehK5+SRMMTTWcG3WtBxSRGDf4wDQeVw7pkcVELRE2DwN1VgY0wAF23hH462Isiv4I2tzC9oCNdh7u3f+hBL/lLLiCVHN6wHrWC8A3Kf+xJTEXGRZPhnGL6DgpPrea4R8/alhBLShGMu1i9bb8L0ETGCZfJxa40WvW9F0rc+2iy
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 02:57:46.1469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa788097-9ecb-4c92-494d-08d5d26bc5b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 04:14:13PM -0700, Cong Wang wrote:
> On Thu, Jun 14, 2018 at 10:24 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> > On Thu, Jun 14, 2018 at 10:03:09AM -0700, Cong Wang wrote:
> >> On Thu, Jun 14, 2018 at 7:24 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> >> >
> >> > This was my brief reaction too, this code path almost certainly has a
> >> > use-after-free, and we should fix the concurrency between the two
> >> > places in some correct way..
> >>
> >> First of all, why use-after-free could trigger an imbalance unlock?
> >> IOW, why do we have to solve use-after-free to fix this imbalance
> >> unlock?
> >
> > The issue syzkaller hit is that accessing ctx->file does not seem
> > locked in any way and can race with other manipulations of ctx->file.
> >
> > So.. for this patch to be correct we need to understand how this
> > statement:
> >
> >    f = ctx->file
> >
> > Avoids f becoming a dangling pointer - and without locking, my
> 
> It doesn't, because this is not the point, this is not the cause
> of the unlock imbalance either. syzbot didn't report use-after-free
> or a kernel segfault here.

No, it *is* the point - you've proposed a solution, one of many, and
we need to see an actual sensible design for how the locking around
ctx->file should work correctly.

We need solutions that solve the underlying problem, not just paper
over the symptoms.

Stated another way, for a syzkaller report like this there are a few
really obvious fixes.

1) Capture the lock pointer on the stack:
  f = ctx->file
  mutex_lock(&f->mut);
  mutex_unlock(&f->mut);

2) Prevent ctx->file from changing, eg add more locking:
  mutex_lock(&mut);
  mutex_lock(&ctx->file->mut);
  mutex_unlock(&ctx->file->mut));
  mutex_unlock(&mut);

3) Prevent ctx->file from being changing/freed by flushing the
   WQ at the right times:

   rdma_addr_cancel(...);
   ctx->file = XYZ;

This patch proposed #1. An explanation is required why that is a
correct locking design for this code. It sure looks like it isn't.

Looking at this *just a bit*, I wonder why not do something like
this:

  mutex_lock(&mut);
  f = ctx->file;
  mutex_lock(&f->mutex);
  mutex_unlock(&mut);
 
? At least that *might* make sense. Though probably it deadlocks as it
looks like we call rdma_addr_cancel() while holding mut. Yuk.

But maybe that sequence could be done before launching the work..

> > I'm not sure that race exists, there should be something that flushes
> > the WQ on the path to close... (though I have another email that
> > perhaps that is broken, sigh)
> 
> This is not related to my patch, but to convince you, let me explain:
> 
> struct ucma_file is not refcnt'ed, I know you cancel the work in
> rdma_destroy_id(), but after ucma_migrate_id() the ctx has already
> been moved to the new file, for the old file, it won't cancel the
> ctx flying with workqueue. So, I think the following use-after-free
> could happen:
> 
> ucma_event_handler():
> cur_file = ctx->file; // old file
> 
> ucma_migrate_id():
> lock();
> list_move_tail(&ctx->list, &new_file->ctx_list);
> ctx->file = new_file;
> unlock();
> 
> ucma_close():
> // retrieve old file via filp->private_data
> // the loop won't cover the ctx moved to the new_file
> kfree(file);

Yep. That sure seems like the right analysis!

> This is _not_ the cause of the unlock imbalance, and is _not_ expected
> to solve by patch either.

What do you mean? Not calling rdma_addr_cancel() prior to freeing the
file is *exactly* the cause of the lock imbalance.

The design of this code *assumes* that rdma_addr_cancel() will be
called before altering/freeing/etc any of the state it is working on,
migration makes a state change that violates that invariant.

Jason
