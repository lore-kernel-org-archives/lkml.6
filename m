Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74CC215F2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ko33IE7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74CC215F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeHOKYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:24:09 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:35329
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbeHOKYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWJJDGPvA49ZoF7j5Rnj6SLXT2uISKxqRVpY6fHPFpk=;
 b=Ko33IE7nBGei1OjOlxCKT6okeFS8N7TA2YK98oikW/8RzlUw8yt/Diq9lQApqElM8XTnHktC1qwI+PebAnR86ktO+JuJuwmsmiXqzxLqylpI9F9mn4xcWJoSqjjyeheQpJ8fb3hm7KfHCsfVnJ6e2KUdRrDmaIbSj2aPrCzlqdc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Will.Deacon@arm.com; 
Received: from arm.com (217.140.106.49) by
 DB5PR08MB0774.eurprd08.prod.outlook.com (2a01:111:e400:599c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Wed, 15 Aug
 2018 07:32:56 +0000
Date:   Wed, 15 Aug 2018 08:33:01 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Cc:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
Message-ID: <20180815073300.GA2100@arm.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
 <5B597628.2020103@huawei.com>
 <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
 <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
 <5B7293E5.7040702@huawei.com>
 <20180814083500.GA28101@arm.com>
 <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
 <7a2dedda98aa9e677eb7f85b6b55e34e0128d2d9.camel@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2dedda98aa9e677eb7f85b6b55e34e0128d2d9.camel@hxt-semitech.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: DB6PR0201CA0014.eurprd02.prod.outlook.com
 (2603:10a6:4:3f::24) To DB5PR08MB0774.eurprd08.prod.outlook.com
 (2a01:111:e400:599c::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c59f997-71b9-4dc4-40fb-08d6028151a6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR08MB0774;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0774;3:Az3EY2lqyzx4POqw07jG00pTazcNg5x8pdFBHtxRN6tLGEy0R2qtFkA88Ax93N6iikF4O8uKmzkHZ8nRSjRH5j2/N4PF0xvnrWoYVYN3UD4dPjeYeQZjq3c4mgK+LoGmH1grlPw77B/hYHLkNIcLCP6i5acmAGGyKn61B2Pl6tEHX6T5Aji54p3gbvqpKY4ciX5+IacCx626j7zWKu1GJYBpR4LwP4taBL75uVuF8MimDDpxBs7uH3WvWepcHewj;25:gD/IivrvAhZkaGJjC9FHgQijU3yZmQ0yBAjhurqbM4JMMbeUUx+dbKJ0mR/JC+QUBeIOBPrgTHexfS6nZR6679ogcIF5SASberWaxeS9ZClAfEkWM40VS7NHD7pH+vAgkqf0TAspZuZ9rsMJtqbirndoQOdPbSthwFwa6iLamW67+ljmuyJSQI+PKE6nc6sWYLIeyf2aoCoEIqFvuDM1ONV2MXw+czcmHTG6xLsBwlhumPtxCurAVb7/+R58fSvIcKkL79CELQMydOSh7lXVf7nhh7qdArB1LF3buqWuLY3z7uKPrsxJ/CevhKR/19+TvKrZXHDeuqS9Kzq5w5GfNQ==;31:7lGnZOkAkYfOrhaw68fG93JorrxOslCpaqsnWVfyWAoYJRWG0j6+NTIV6wR7HCNpog/RRmCSbKg+mskSyd18+g2FYEe0dd1I9sGJ+vy+WMIDoL9zAIpcu3iswFPEPbp9jBDH5/aZ6ScxuNAcQsEswEHBcQmYrsMAn0xLf55bUX+OLBT5XxUWqSXidzn3RWsCJFM+IvzOnOp5IPRTCEKn6e9Y0fObHss7eoEugiXm6MY=
X-MS-TrafficTypeDiagnostic: DB5PR08MB0774:
Content-Transfer-Encoding: quoted-printable
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0774;20:8xIZQUw87syt6iKTJIJD7ARd/JnIMvF/6oVwj7VsZn5zm2UsLCTG0qevGYor0HJSy6z4j0sjBqduauzyAZpGBa4kyUBdgR8om20JNQaSPAYgBdwuL1Na/SCu1LlLlba4BfR9RoZlmpMgy/QzLbYhR5hUDhMjKir4wTTKV7f/kj+FJ9BCJKUF3iHvr/CxHPhTs8GnbtM3+tlfo8LAleR/jqGk0W0ZS2zgufaXCu/nkGRF4YTZ9SE9t694bju7uvFKLCbeBFv7aUcXT6L8nbPmrBt2kJmBexq3+y955UbwFjfWMJsCGVsOz68sHezjaThTlcsYr0x6gGj7sileBtUb3dxvedhOIgkBFLkf7uy5+E77xyDxJVQlAzi2+Ui9aheWWjFKzqtZ8Iof1yo2QGWHZ8Q5bV+wbguq8alrOUiXHyZ6rmWONYetWmSAu1B1Rdpe9UocnOCRoQeJYeGh3GVKiz6M0xcFKLk1lDjKJImehrRadTonUb8I8hfsbergo+Hr;4:T3LjKMC2rQV8glpX1RzO+jXh3Q0VYFr0SNMmm+nmyk0VDTLAsr/c0okdpXc3xJZ2vJlX7OEmNH1WpeFTDHOYOWKnAVpgPWtkEVpHG2g8onktZi9VdZNxsTbatbjafL8DAsFasknqMNHJgkwkkKgVR8T5YKRXnaGkZHTv7G7MHLgjcLmusnAb4gqoqxjZYU8TIe3K7iv4o/r6AJP1bZOEIWaljcmSOWbKuWwb7XsI0grElpZYFj/J6wTOwjmf9Sjk/2LkBOT+PSJgJXOTD3j/De8F65h7UcCxFXESodOX33TYoY7M6S/Hz1RTUP5QegjK
X-Microsoft-Antispam-PRVS: <DB5PR08MB07742116F496A2206ED91021F93F0@DB5PR08MB0774.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(223705240517415);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB5PR08MB0774;BCL:0;PCL:0;RULEID:;SRVR:DB5PR08MB0774;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(40434004)(189003)(6666003)(33656002)(36756003)(2906002)(97736004)(58126008)(54906003)(6246003)(5660300001)(81156014)(316002)(8676002)(1076002)(105586002)(106356001)(23726003)(6116002)(6916009)(53936002)(305945005)(93886005)(81166006)(7736002)(55016002)(4326008)(229853002)(76176011)(25786009)(3846002)(16526019)(68736007)(47776003)(186003)(386003)(446003)(21086003)(53546011)(11346002)(26005)(50466002)(14444005)(5024004)(44832011)(8746002)(476003)(2616005)(486006)(956004)(72206003)(66066001)(7696005)(52116002)(345774005)(86362001)(478600001)(8936002)(485344003)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR08MB0774;H:arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR08MB0774;23:dTSIlDlBtm4Q2LI9dxgv0AExSF8TyZ1hv57WxpCYQ?=
 =?us-ascii?Q?tJmNKnnfUcXlZ2Ul0bSsMi6MP5UZT21MioYllTxswTERKNc/a5F1/JISZEm9?=
 =?us-ascii?Q?cwNoXpfeu017LMWcWhiowB/VtBK87PkwlDeZr//+wauUq1DDDyjkik3IK3nJ?=
 =?us-ascii?Q?EUfHDxGnp86JqrCh6I4C6tfKbrBBVWH1x4KwkS+Tv7UiSX3WkIsCBlOjhXoO?=
 =?us-ascii?Q?b/MLTh02+ap0v/JWocoit7YMG4x2BPYAR/dbG3QhmehnI2uuTfDYgKNyxzEO?=
 =?us-ascii?Q?fmYiwkdeprdyEKvfWbP85RLdNzkT43YpWdMyDi8ZHpRMusK+NxRMAmmRlo9P?=
 =?us-ascii?Q?IpmrxJYi6f7liPveUmO167tod6LGtXILUF9k/hQTOdaFUyVrqGWJ3x1YOsBv?=
 =?us-ascii?Q?M0PTGBg2gViL5YbDuakmohAvI9qpRpf7NIslNEv+RnX6JS59rs8V6x8K7p8l?=
 =?us-ascii?Q?XBxSC9DY/E5tRocrla5U3KLXywhrs6S09F4a1wRPTcYXyU75kVSAtb/oeXc/?=
 =?us-ascii?Q?+9Z3w2UDKhYwyktaTmapWUyd0wTqzigrlZ4zF3z4Pigrnaqd0FAuBdiKq84u?=
 =?us-ascii?Q?MEH2SnhmX2PgQtgQL1hp6TA9oLYLtDHXoxjQKCYEBx7HhveyGq84XcqKWPjL?=
 =?us-ascii?Q?kU/XpxEEiPOp8oDwEr4P1xc9pK6ueFYQbhsYNgLv9rTwwPoZyPa89pUjEs1o?=
 =?us-ascii?Q?z8qSpRwKNhfQTzQmue5XM/k8Iv32F+S3tTR/G81HOJreBgH1QlVIliKSEeOx?=
 =?us-ascii?Q?dHo6N29bI7cw0OoUM/WgrkCrl1wQtRpeDk2+c43vGcz6a5bqdZoRDElNxgtg?=
 =?us-ascii?Q?gobwLGfRjFOv/TpSZ6neguWJLvn0j+I7pmZ84RySQFcCbh49Sxxo4aJHzRja?=
 =?us-ascii?Q?vVXB+wnjY1qVueP34sHiY368u3KdcA1da5094mG75oUrf1MzL6EfGaX8o51Q?=
 =?us-ascii?Q?ZCJGlSftJWDnyGUizYLIxz/gqLvuYV4K824XLuxE5v0icbaWueDLowH1EOTT?=
 =?us-ascii?Q?nXG6zAuB13MInqMngdxFzIHsp9mExZULUOzQdP8nxkDtholRilKPOFYMWI4g?=
 =?us-ascii?Q?KEbxSRXQVrWvTroD5E6rhjLw5RNKjAcgtUKA7R1gtbvtJdfmFJdXDdWYRgy3?=
 =?us-ascii?Q?6wXQyuWsh4DYJe1QJyXxy2dGRw/D2wWFZElqrmgSPU8X57c5Hwfr9jrq0JB7?=
 =?us-ascii?Q?+RObWAtlBfv/3IsLFbrzrgDpddSyHKTG1EuzivOFbGE2wFiIjA+nKiwHN3A9?=
 =?us-ascii?Q?V64aRY61gGCafwwPP70jRIaeURtPFIdsEiTmfbqWn+JG+Ac05d8jLTIcnCpQ?=
 =?us-ascii?Q?wI3201WHdnvpVTqU99WxXiYmr/170u1bpxzJstvp25HWuEnz5FDu5YmEHoWO?=
 =?us-ascii?Q?rzxTvp8s9vEhLZBE6sMCdRSPTbFeMJ7csZJyn5TcUXPv912TvBKtDw/68b2L?=
 =?us-ascii?Q?1QmjY9LOII8Nr9jXwJv2tH3FD0SE8WtyckXmMdMl3fD5WJhYBR3yWiHZX9RT?=
 =?us-ascii?Q?tn0dE+blpgTqeG4uvSo8wOYmp1zig0Ch253Htq4xi/QxOd7qFWYrP2l2xIZ2?=
 =?us-ascii?Q?wPVQDCmn4Sk/cx8XQLbWy/uG+IcmY1UF8iKAzc=3D?=
X-Microsoft-Antispam-Message-Info: v6AavXHDHVJeOGK79GT+/Ww2jpWF3X8gkicQtJZ65QRV0bpzDas1eU24iqCMTqkdJ7GdiZVv4/FueConZln+8euhC//o2OfSWfVl1rTz0ThKihSKDrtg5JUKA8Eu2wMImW04lIFJcBp9vpD3XmTPmk8YatGZifGKRKfz7oYFjaJoNbpMMNIvgMbOe6H1me/bWcsN2ISHWTLrPsgIwViwwrYvvfLs5Y6c+fgpJK3VrIUj+bgQ1jgXPS2u1d0UW8lIvKJASyhvhBpwhm5YpJSd4m4Z6XCzJwqmVvKTMW/rUJmlbElee5LXGEBDy9SWAq9u+xIFwpev10q4vyxc6YhlMzjetK7iextK9XgNYZtZEKY=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0774;6:a7u3Op2MhPCzarZ1RxKWAtvic7WP+YpZh0XEzhTwXKVLFi8Emnu/rMj7DE83KzfrTAJPOJ1yl4QaXwOBJyVGoHs3BnoKNsYUk+xsUPUCt6nn3VAe3deNtJ3cSjagQ1IFksa1MUeiLazl6uMWXDk1R6NQj55vmdI+D1tjBXiNGM0AOnYAo98roh+whB76NxBtTCvd7Bp7DkIXIJIEXZfRi7Ar6mC5nZb/taDzmad3TsD14oWJ27FZTz7yxrSMrt/pJXnkBvFAuUVpzWFgHoIaEe+U73beSLiVaaegA7MtAeJv5s6zsZxlB1WYWwAGdpVNg8lwJt0n2/lRjpYe8ov3QLFr/RjO61MbSEkiCBovI6ByoNhS+y8Y59PdTtmi3twmJgAMVWO7SqENQvkOicM1el7NwQKIjNQTrtKrQQ6d6VwaVerIZEZOVmv8s3tUxIUVc48SEIGo8j5rWYItdvQlbQ==;5:ysI3p1ULRnM93x3WUql77dyNeUznlFXsEu30yKCvrcnxfUYt4NVS6VSWtN847kK1VzEHxASxd52yAtl2JkkHeZkIj/WkHyW7ek8Qei/QKYj6aU1Vmd2irrqF3+qPQptveO1cM98Kdi9nGzp5GuuoMQK5mofiTMVUrwMlRl3wARE=;7:ZORjfbgWNtf2gAIEDihXJwG1p8BYbTlsUj19f4XkuDK4hb0XvrKG2b/APjIj86QXTPxufwYBJgVe1lIC0+C4ypkNLdkACOBZmKfxTK267JTvxSLu34JFwSMhKQP8izu+/WTweIwm4c+bXI0KzbkYrGGg3T2qor0FGQwoKMkcGM/925Vbb4pDtUd5O2aRBs1DO6k7jvzaNL27mniPyZseKD7cJBfKv+uQ6Z/PkuYNfwCHi3DrW0zenvCL0cy6+am7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 07:32:56.1984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c59f997-71b9-4dc4-40fb-08d6028151a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 01:43:37AM +0000, Yang, Shunyong wrote:
> On Tue, 2018-08-14 at 11:02 +0100, Robin Murphy wrote:
> > On 14/08/18 09:35, Will Deacon wrote:
> > > On Tue, Aug 14, 2018 at 04:33:41PM +0800, Leizhen (ThunderTown)
> > > wrote:
> > > > On 2018/8/6 9:32, Yang, Shunyong wrote:
> > > > > On 2018/7/26 22:37, Robin Murphy wrote:
> > > > > > Because DMA code is not the only caller of iommu_map/unmap.
> > > > > > It's
> > > > > > perfectly legal in the IOMMU API to partially unmap a
> > > > > > previous mapping
> > > > > > such that a block entry needs to be split. The DMA API,
> > > > > > however, is a
> > > > > > lot more constrined, and thus by construction the iommu-dma
> > > > > > layer will
> > > > > > never generate a block-splitting iommu_unmap() except as a
> > > > > > result of
> > > > > > illegal DMA API usage, and we obviously do not need to
> > > > > > optimise for that
> > > > > > (you will get a warning about mismatched unmaps under dma-
> > > > > > debug, but
> > > > > > it's a bit too expensive to police in the general case).
> > > > > >
> > > > >
> > > > > When I was reading the code around arm_lpae_split_blk_unmap(),
> > > > > I was
> > > > > curious in which scenario a block will be split. Now with your
> > > > > comments
> > > > > "Because DMA code is not the only caller of iommu_map/unmap",
> > > > > it seems
> > > > > depending on the user.
> > > > >
> > > > > Would you please explain this further? I mean besides DMA,
> > > > > which user
> > > > > will use iommu_map/umap and how it split a block.
> > > >
> > > > I also think that arm_lpae_split_blk_unmap() scenario is not
> > > > exist, maybe
> > > > we should remove it, and give a warning for this wrong usage.
> > >
> > > Can't it happen with VFIO?
> >
> > ...or GPU drivers, or anyone else managing their own IOMMU domain
> > directly. A sequence like this is perfectly legal:
> >
> >     iommu_map(domain, iova, paddr, SZ_8M, prot);
> >     ...
> >     iommu_unmap(domain, iova + SZ_1M * 5, SZ_1M * 3);
> >
> > where if iova and paddr happen to be suitably aligned, the map will
> > lay
> > down blocks, and the unmap will then have to split one of them into
> > pages to remove half of it. We don't tear our hair out maintaining
> > split_blk_unmap() for the fun of it :(
>
> Thank you for the GPU example. But for VFIO, I remember all memory will
> be   pinned in the early stage of emulator (such as qemu) start. So,
> the split will occur at which operation? Maybe virtio balloon inflate?

My memory is pretty hazy here, but I was fairly sure that VFIO didn't
always unmap() with the same granularity as it map()'d, at least for
the v1 interface. Either way, split_blk_unmap() was written because it was
necessary at the time, rather than just for fun!

Will
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
