Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2638C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DF720883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CDFXPxI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DF720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeGJSYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:24:24 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com ([40.107.71.125]:42333
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732266AbeGJSYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSXEragfqvmTkRA2wqh0SE/ie5JlYdDn5SkKbcJ7juY=;
 b=CDFXPxI+Jy3BZj+08Xc4i4D/hJIe0z1tzRb5qlunjcZ4FXezOhXwj576GbgZygiDn9K4XTcRu+zwMQ5ieV0yca/dGRgXcZWAn/q/22nfyojsle9Div66uW9AOC4HkaZbFZpm/Tc/OkRbnX0sIUbiZRctLKaCjyPmnntwEAlxoTg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 17:59:44 +0000
Date:   Tue, 10 Jul 2018 10:59:40 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180710175940.rbjmdcpm54gfrael@pburton-laptop>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
 <20180710074815.GA30235@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710074815.GA30235@mobilestation>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:404:109::14) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 349b1b6b-ebfb-4012-a995-08d5e68eeb02
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:25t4iuxSVssGfif9/ZSpUX7bOp7aQ8U97SfdDaDpEJJyo7V4nuEHsLDSbpdNtWE9PUfztmOl999Wzk7jNi0HBftzW6wxW5C3FwCCVlNmDb0GdgIm7nb0s/C2IvlufzIUsMHK6AiiA3wQSaSCt9m/9LD63Df+qGW/mQXuAbTSQn5+yUPI/0WPvSgJxmA/D+voXcTihQdBmt5FZKANvQctG8rso2OauNVhWVABy0Gie0ae6sFctuLXY+/TIpT6JqXo;25:XylM8ymDboiiJrdkOpTnf1MTqKtIDGreVn395+qS2zeEeBkxlZxwAPcEQs+TNz9g+bqVTbOEKkbVB6OfCqtCWrqyh8OndHkuK7VYB3bmUTEC7MmrLHOsZDdGM2uiBmHDSz0m4Ae0TfMHYac/TfI3xolfG8kJBZtfogATj71U5oJL+jM6Abra2lqOFr0JwSn05Af1V90OXs9kQHk8RR1FeomMSMJdhi8a4XCWuzzwncqPyuUO+hu2J8P0fPmF4Yyvxl6achFSxqOD3UIJ/7dKEnDHDETmV+WO24jFmH6Cv0hRvTRj2djeAeWgHoe6ht38kfAzNOqCFZh+FuL8sL1D7A==;31:Sp/Jp4sGIRRJUT6s2BwkcwwQaxiwNAcgFHKhVc+PBMLJUbj1yjC7TAxHsgXYPsveyQFoxKFhfHbFCxGq/KvYCz0qJVNe6txcqeXe/lSVfYEkWRWWWmHcgU7mFysKcqdoZRZzpIkE+7r2pL0s3f7Fp7WIu9Xltt3f1Vn8I9twIko6AhaJyUxfTvAgrqnnz0xzxYWxohidafXdhnWLHTA6+b98Le4hAi9PBrcFxTD5l6s=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:RicUhrcMISNCo+IQ/QgO3bctJCM5J6xq4ceH14+qcSiUXETbdfocmbqQWGxAAJ+ZnGgmakn6CxyYEQpaDHgebysBW35ZaaIbUN90Io7FcT/evAh5TQr6ofA4clEZjOF1JdDaSZRoxhCveQCVdHHbIiztO3OO9DzIlHtbGPzRSn0WPNENNeyDqyRtbXTvy6L+sW66TSWXoCUAOLLYnil0C92+QZJXL0zbJdlEqT6iG/F/Ka4hIwmHxkMS/00jQOHc;4:tnpG3d7PTxRK4nFJWrHMpleafJKrkYkDLmndFmGgveIGSS1ArYX+kpkmY/o9S0gx3u+NKzdDUVi7hga6+c9IIOpMxko3YtbrWNheoRcLB1JRlVtaEQI3fvgkHShhuedTDuNyKWuLdmZZm9r4AhiZqnbw51wd+GlGkysQgf9oj4MmoHcXUXByBL/cpoXNLldDo6XHz4bCuVkXjqNKwG4whilnV+lXtr+3X4CtS+Ai21Co/DZw0T57VwRrw1j9daUEDKgDrspiW705B+5r3lP4sVRz/NZio0JSGavxjVC/qXgHetXNikRs876J2LYzGoQr
X-Microsoft-Antispam-PRVS: <BYAPR08MB49349CA70E0AF6FE75852BA9C15B0@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(366004)(376002)(346002)(39850400004)(396003)(199004)(69234005)(189003)(52314003)(33896004)(25786009)(47776003)(229853002)(386003)(52116002)(97736004)(53546011)(6666003)(44832011)(14444005)(76176011)(6496006)(9686003)(6916009)(478600001)(53936002)(6486002)(66066001)(33716001)(58126008)(76506005)(316002)(50466002)(7736002)(305945005)(7416002)(8676002)(106356001)(16586007)(68736007)(81156014)(81166006)(1076002)(6246003)(186003)(105586002)(8936002)(23726003)(5660300001)(93886005)(42882007)(476003)(446003)(486006)(956004)(11346002)(4326008)(3846002)(16526019)(54906003)(39060400002)(6116002)(2906002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:wiSGjVNczWqVMAv2LZEi/+QOLe9kJRUBxqWHN+hDV?=
 =?us-ascii?Q?aJYqzuMyGw/GhUL8MXV6G8Y2HdNgVZSK/0pJkw1vMiK5UYQ/EQNUj/CIt4Tn?=
 =?us-ascii?Q?0Oa48ACNvIRWo5j3SiE9s2CveuieXrMSxb8z9NwkDEW8yVHFdMFeDeaw4E6l?=
 =?us-ascii?Q?s02fPEwjmtC3qW7/cgZpa7VP9o0dvvwguXEUmEduNK4k6GxLac38MGSSn7sz?=
 =?us-ascii?Q?fk91HBwRZQsNdQuDs29ebRkpqI6h2UmQEiOdOiTcGGdgfuDha7Xk/MvU5vjf?=
 =?us-ascii?Q?gD3yS/nUGGQpNH/YxSw2p+kENHibWq6aqLZsdzqSIRa/ZyuPYzs4XX9WsDr/?=
 =?us-ascii?Q?FJThjSEh0uxmTnpuFNjcBlKs2O0j8+vH1x2fpCJ0jMimDu8leoCfLdwChMfI?=
 =?us-ascii?Q?o8WIgy99BO8iPQ19BFxMWiX+hOOGkZ/HeaJjKcefk6Vwmzt6+O78a2WMihrz?=
 =?us-ascii?Q?rWdfmrNFuMO0yo5T9XySE0Rt51yunxvFgxCxcZiknjW83CwDduLt67DvAwH/?=
 =?us-ascii?Q?qod9ODE3FHaAOcjQ1mmucOGTApahbHpXNho7HW6C2+8mHeugYUHW3wdeyrw/?=
 =?us-ascii?Q?T+BAnVFxf1oGIaoyV6hY93p8oymTDx9Tx3nlBKu9e4rZTD2hGAnP7visjXV1?=
 =?us-ascii?Q?Hr4QRGBHKp4Fw4TB4PPEkq/qYN2G+1mzoz4a/9qETwfe4AcsFUdDy743VP2K?=
 =?us-ascii?Q?l+4xPzwu5NfwQlDzIWAMCXYxS6zehpaL24elAULzCcn/xTr9vxYj4wbaE3kE?=
 =?us-ascii?Q?Ra9NloGbUcw79gtHOlrcbdjNKVHXlZkuX2vr9x3iBpCD4Jb/KWyNIVyaeayV?=
 =?us-ascii?Q?ky0h7b1Y4gXlNmeA8yQ5ggfTJWrXaccFCMlQirntYsDAN67lfskeNHlDspyM?=
 =?us-ascii?Q?HxGoUT+rBN9VIZ9FgWmtp9Nz5NXMdeiRFRaijt0htVCd1U1eIMyhzyfi7B1Q?=
 =?us-ascii?Q?AsckL2kHL9RFmCFmRwK588gbaJwANNgn/+9HCdcsCA6046sEL5NOcA3wMEQa?=
 =?us-ascii?Q?z2lVzJ9egWKBNyfLW8WzuJr6fRmwll1Dw/06ol/LD4x6BzdsUqK2Jn9arJJx?=
 =?us-ascii?Q?DinlInnBgx9WED6R2IdJrwgusjCVCmNhZ918eP4/UXyYEYvbHqbcZd/U05yh?=
 =?us-ascii?Q?XYyxdUADnBrZZ7Mt7p9f5oy4F53wsf1+F9aNflDlQaDnFelYL5mq8eUg/TRa?=
 =?us-ascii?Q?+Kp/xb7Ln8jJA/+3W/0xj5C8DKMMYvAuAXyb/1pCbUH5RsU5z1s3fOSx6hSc?=
 =?us-ascii?Q?Of9PCxLww5MxOGQgSQuCy1Fmx2mx1nTo8OR9FGuS84qazb7TyJZJrtYe77d2?=
 =?us-ascii?Q?eswwgaeqgq1iZs1AQlSrufFizGWA7aAxSMlRyrUtSckQg8GZ+pVEXVRcCLdR?=
 =?us-ascii?Q?vQeWxgYYBnXfzzvyVVSxoa/aiIskzmK2DHhWOc9bV5CLpPYVmk8bjoR49f6F?=
 =?us-ascii?Q?4u+B+ZZGhI5vgt81hp3ypFYPHVgxW7xGH2Mj3PetS5Q9DzqsptV?=
X-Microsoft-Antispam-Message-Info: 8qJQ5TETHvcwPcTScBfsYippNmVNcGPFuM1iPatCOjtGdnZX0z+vmlGMQwUBPmdGo7NqpH57VB2hGt24cmeXGamdImnQHkEpZJ+qdz33SiYsEtr2t13c2ImE+zMDDuv44GvHApgmhccD0H5PIimIJNu64YN9QUpEF3u5rcnqtYfOPPKUaOn7KUQMuUe4U1F7K2R02FyuT6ykAo99f5u0B63FF3u1es38kdDNEwhWkadz+nXomwxjyRH/qhjRslc2nINj/EfMu1hF8SpBTQIZwVyTBsYhmDQ+MZyxoX4X3aI2+PNDIIzzgbcAM1vxFUuNCQcsbDWVPRbsaZFPFGkqsnFsjkES3BfSzUkyeMjSBj8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:lNSQGixhDxEOO3yDQ6Z+nUpXWp1eV5HnhkpenoJL5BP/rvYaFZFkg8p7tRaLV3BH3JmMtfRSt71m0DOCtmyrQHpIo2k25ggyS8gCmEdI67xXHYHgATa/KYIkBYEs9ajzq7RUn7UBCEkfb8uduOMFjfNfCBOLudjJEOIpE286WfnqN80MD1siK/oIWEvHvDVRQXk6yxFhXCEyn2LoYXU7VrzEBIJUcNRMNGuOI3wZ1+4nmZ35CZXGHFxxv2Q9yg/Yj/Tf/do6IL6koAfNoQpmFjuiLjhsPvVnARtCdlvPrkOmas4TBDrK98D287G/slK5Otw9wbX8X7kV1fj+6/kcZmc86T3KnoGauOopImp8b0pLYl93AVTRBDscaeoo0UGmI9q/4pE3VThTQ1MfaGmjHYAX5twVctrnWsNS8wvXHhBleLBJ7P8+Yq9bbpcD8LLuaEHKEVQGzOL84hv6wcEmmA==;5:4vw4UfzueTecAHqPOpDNh3VauD2Bz1bgBzzrTmJ1R1E4wvxBJ/o2TgnPAYkY4LfhVOT+qGBBbOpGEV+yQhGj+5L8UwAPquisZ9bP8WBr+CuSqRao/5cCI3iRIM5kBfyfhnLHAxiA+DtmoDjEsPqIkaS6YnSAtNjOYsWpeQKMyzY=;24:lXCkS9s/gXKf/n6zcZlJ2vEIOT/kpk8Z445YfvQdjE0WqwWRQ+aja6bQJESwD1VxFZqg5MaK9OjCvAsVstPf0YyrzK3pzLvCRUkxy4p7PTw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:SfSwj8WrwEAsdM0qiXmuS/FxawGX53dED2o7ZR6NAgnnbL9+BuP6qi3VeU4/iM7zc85vjSY8Yy6Saxlm1gcjWuncTJ4VpPIh3+7cUoeywBAVrT3GW0aIUlyE8mqv9231AcuPrh61++8T4eS6Jfuhj+XtnJQ+R+9NRazOk5rYpukgkroIC9ti+DmaYPqhmt3zqDF2h4/vzmwccxSx76eXL7ibGtBaA3GeLHQTreD8AUzBMI1Wq+XUeRaiiwvll2iP
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 17:59:44.2265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 349b1b6b-ebfb-4012-a995-08d5e68eeb02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Tue, Jul 10, 2018 at 10:48:15AM +0300, Serge Semin wrote:
> On Tue, Jul 10, 2018 at 09:15:17AM +0200, Mathieu Malaterre <malat@debian.org> wrote:
> > On Mon, Jul 9, 2018 at 3:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > Adaptive ioremap_wc() method is now available (see "mips: mm:
> > > Create UCA-based ioremap_wc() method" commit). We can use it for
> > > UCA-featured MMIO transactions in the kernel, so we don't need
> > > it platform clone ioremap_uncached_accelerated() being declard.
> > > Seeing it is also unused anywhere in the kernel code, lets remove
> > > it from io.h arch-specific header then.
> > >
> > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > Singed-off-by: Paul Burton <paul.burton@mips.com>
> > 
> > nit: 'Signed' (on both patches)
> 
> Good catch! Thanks. Didn't notice the typo. Should have copy-pasted
> both the signature and the e-mail from another letter.
> 
> I'll fix it if there will be a second version of the patchset. Otherwise
> I suppose it would be easier for the integrator to do this.

I've fixed this up & applied these 2 patches with minor tweaks to
mips-next for 4.19.

However FYI for next time - you shouldn't really add someone else's
Signed-off-by tag anyway. The tag effectively states that a person can
agree to the Developer's Certificate of Origin for this patch (see
Documentation/process/submitting-patches.rst), and you can't agree that
on behalf of someone else. Generally a maintainer should add this tag
for themselves when they apply a patch.

Anyway, I think we should reserve the Singed-off-by tag for patches that
quell fires. ;)

Thanks,
    Paul
