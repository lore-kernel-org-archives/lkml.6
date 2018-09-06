Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD32C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F0320844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="k38ikjvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F0320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeIGByP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:54:15 -0400
Received: from mail-eopbgr720129.outbound.protection.outlook.com ([40.107.72.129]:18560
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728155AbeIGByP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf1N5Nq4sSdkOZmJRSzYHsEgP2IVCNyJb4+8LOhVtEM=;
 b=k38ikjvOlb0H7qfaok3/7mdt3aeRolQX3mPF2NeThKqSwOXtetX3JHTVTdbpO0pGkZN67OY8Fp/g78bgwHH6Da+FtfJyaCQimhBu14BGJTBSLoJ19qlc/veANcIt10a3+1d8Rwtzo7GPrxcAgwdy9zXm4x/cp9nT3c5hrdEkW70=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Thu, 6 Sep 2018 21:16:40 +0000
Date:   Thu, 6 Sep 2018 14:16:37 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: txx9: fix iounmap related issue
Message-ID: <20180906211637.3vfo77vrgrcftglp@pburton-laptop>
References: <1536207559-31543-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536207559-31543-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0043.namprd21.prod.outlook.com
 (2603:10b6:3:ed::29) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 560c6afd-c39b-4f80-adee-08d6143e09f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:wgeC6WjciBVPuMq731PP362bGFGq4REkEUENSJexGNnCG2prPQr5AK1ePpXNNzVwr1COe9kkAvzm7QvPZu1DtU5S1XIanIw5zLukgTPKJ2c48favon2VrmyKWuS0rrnz8Q4VftKcvkMHl6EUePiAjBn+OLdG7tYTzWZNSekH6RFGDTxCi8xqywohO1KLzaf7c2BWVdqc851iyqwGjCnPsWv0jtTi26yh+9dIqswlYBoD8M7a9hafADMCyqhezfQS;25:7h4YXbCrQQcDRWrLsDmmdBpaYs7ZLyX4JCv8on+k3sRzugbWv8p8IA9Bl7fMTtM9GoBs8IGUUQFGIkgxQOEPEgkn3E2pIs74v2Olcpqtvo0Mo0KOYgt2tW8TozKPFcEyD/2nRIIE8yOemIG/P3jK8CHe8/kXFsXkdUl91VFuDDbkYPB+EMe9EYzvYeAY+q97h+v4iPJVPLHuKoKM/HnI95ZQGJNK/GRvsTlhn+Z/GxhLnkfR3LSb5X0NdOc48LOGu2TX3QZ3tyJWhVUAIcxSOs5WyYFuxIhvEmFwNlf5BhqkhGxgzKrnVGgyo2+isWxN54vaS7HI0uSrI0MrNV97KA==;31:5HZCVEH0fyo79TR+Ow/pwaOLVKnjgEi3STBC0XZpqTHiEtgEr3xmTOzOAp4Tzb+I88o4GB2nmg4kQcDTUwOdMxY4GPr8LntlIz5QZABxzuvnOzhXrRhdhns5i86NeGPK9UyqS1eWOub/dipI0y6FKT+KuOjS+jlyxzkCtgqqqttUjuV9v3RXZmLQkRDUkvqR0ZymjNB0dtpln7wtNu33V6k8pvqoPb4va/dT5UAIJng=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:fJodHu2/pf6ON4ndyPl5O4WHSDvBon0W+/O2R1WmP0Se/8lQdrVoM2LcNCh9IFWA+wk3ckdLpZwxYlAgBqqqMAcUDyP/w6hf0WzPjKXCgvEmxUloT9Vxr05S5DUjUmUhAoHCLr4iIU+FH8Yfx75v564nNMj5J4QDBfWOkz0U74Kzmw+pZjUkxqbthcsLGbJl/02hzzS2tlAjjmk+JUKySMk+80rk8iJJOHvyHXTlOXwX5BxM4go5j8ZG646OA0Wy;4:e04AIZwx1QBktXjTJO1DBYWp3HPecusydhVkvmlNnfkpN97ayeZSk5romABmZXHEzuvqw7raWCXdsnjGwfL7aFIwdqAqC84Yie6kqaQwY4GWrCIQbm/Ai+mr2LXFcFXZv/LWP7q9+AY8CGLGRy7sFXfpKUouXlM0iDswJHeKl7q5TaJCP5l3rKU4oWV4VTC8b0lpmbcrc6ZsKKwsvAwua1s5IoeVuV42AEUTHVWLRQtOIaRIW0eMkNndVxaZqT0PXBT3Zk3zH6JwD7Ph8qBQ4/k5u1JiwYuC9TE14ljwpm+UPqXxkOQt6bGAouvc8dvl
X-Microsoft-Antispam-PRVS: <BN7PR08MB492915DAC1F0F0981AD324BCC1010@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(173505980823694);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(346002)(366004)(376002)(396003)(39850400004)(199004)(189003)(8676002)(42882007)(6496006)(105586002)(476003)(446003)(7736002)(305945005)(956004)(11346002)(52116002)(186003)(76176011)(33896004)(386003)(26005)(478600001)(6486002)(76506005)(229853002)(50466002)(16526019)(81156014)(9686003)(106356001)(486006)(44832011)(8936002)(2906002)(1076002)(23726003)(3846002)(81166006)(6116002)(16586007)(58126008)(33716001)(4326008)(316002)(47776003)(66066001)(25786009)(68736007)(5660300001)(53936002)(110136005)(97736004)(6666003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:4/ogSQHl0hxzK0UN555USIVCMShBpjrdS1JW2adjv?=
 =?us-ascii?Q?Rw9mzu8tztuKJqGxyJ9fdnQQHn4r+FNG2olkcZyKJCiY3VgbkiwTqLExDn07?=
 =?us-ascii?Q?2MuDZzSGt/CTT6HmN8FdLpaMyWEksdAF8gO15zOLNhZL1YrXYVZ2VZwyyPSo?=
 =?us-ascii?Q?/CyEQ59CZDAmA9sLmcFF3bs5BVSLaIF/3dAJjs4NfkHDVD7w17GPBOkWhDa8?=
 =?us-ascii?Q?eMmViaDmtmCazlAEDQW7Q/HVq5K5KpE23RmkFK+MlmdvHwI68DpBauhM6g3I?=
 =?us-ascii?Q?GPzcfWUEqOGexrsAE5eKOjTftxJhNOgIiPmkbMuXsuXfEljJaBQPO+HOj+hk?=
 =?us-ascii?Q?a2b29wG/mQQGd3DT6iG1WjgHuRAD3MdOr1nQARz8sXl4zjEJ5rvHycQqR23G?=
 =?us-ascii?Q?fKXeVqftsQOsqOPhF9caQeprdI3No75x5CQ5HGUxP8oCFcnOvoiHO+74ct25?=
 =?us-ascii?Q?7Nw3oVJaVSNovFdBZh2FwLmaq3PtkeGHkG+eQIgvKLT3eLy9H4GZS8mdI4JT?=
 =?us-ascii?Q?qPZbB2v1OSHOJSafJEJML8ppQbtjiliSOjdUm5UKjqSlIYMGGFIDctd04z+L?=
 =?us-ascii?Q?cppxzib1r8W44ljGFVxcT+/YR1of3gpMIdkMFXEAfntg0jVluDNKy4Fo3rJ0?=
 =?us-ascii?Q?s4h9A1LfhSOO5WxFV/vKPzyEmUpecglTVMa5UhsCJ/cb6YieguBdk4K4wjjG?=
 =?us-ascii?Q?EBxOv/uXmwqkAnPRKn30SHGO12F6U3RySbk4CJQPao/kJ+2/xmPrzAs1Zy3P?=
 =?us-ascii?Q?kVqsfa1ruPsg0P4bdigcayLEtVPf0A8+RiTC4MdiwsM8tHP2f9kbpXfi2hxq?=
 =?us-ascii?Q?5vqG4yAfvYMRmp2bVVM58BEo22gXc3FX5ATI3ewH7/stk+g0diJU40NVG7nA?=
 =?us-ascii?Q?0iUKYZF9kqBQFY6tSQuO1O1YVdZykqkTqXxg0kl+JPfW2V8EBG+isMc1KZ5l?=
 =?us-ascii?Q?jRHeUVvvX7d8P9/5ScHXZ0x/nkd+orH1H/8uDbnOOEaf0aseJNI1vOv2PFu4?=
 =?us-ascii?Q?sVHzmWGYWp+QNrQOvlRqkOGGsuV9AwiOX1pkLRG66AQ3BoHDbF9gq9LBmO6K?=
 =?us-ascii?Q?xloKeSPfBMI+WRZbRFZ3fCo+MvV1Q4Xrk+0Tg7y6Fyo70tqpt9jgXQIhBfnl?=
 =?us-ascii?Q?Dw2oSeKDl1U+s73CWvFvYLsjjVbFHU2KAow8E/+iSkndFDfJUKYZuOHnQe8r?=
 =?us-ascii?Q?QGDBPDUKSHdsloAjhmEaUtk8tseNoAIcpF66STW6GUjI70bI4Tnrscpgrl7a?=
 =?us-ascii?Q?gAMMmdGEdgCVVyOt2E0El3oCWjQDeY3qe3bqxw7trl62TU9NKeDoBZCVTM+n?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: osshO+MNfU1gqro8GxtV/yZp0/2QoZx2WOPe1e5ZdQYx2LJd5bDh0hxlmXBR8n8D2Odp5YHyIWotcTBs8u6QEJVxVeovSHifN6shnsSiCtDbC0V7r0RmEupoZTlEsN3eVD8v43Qz9wO6NREAfnmeq3ridMhPyZWOsFSnDO8FpzW3U4ISy417qf2jkQcTDkPhbyytaK7B4I/l86T7+V6N1WQeLjnf7Phd/yeeoF2Qkj/UkCkj4+ypmSxu+rMsq7W4W7cOvfhuIJvmRdqXjFyOxYBrRGJhJq+Wlx8j+xCzLtqp0nKGlwUZesI0zX9zfsA2gan8LmUjtg2onw5RRTODr7dBHygsKvG1fErExtKhJNs=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:75E7zQN/BoOBPJ2O7DNbVomh3Ek6rfyNI5IIedso2XcVmKAS784+J4xzvjGI8A1lqEViq2o7milFkle+vbDJjIZJszmnNUizlN98dpp3TKnJCymnhq8aagxbTppyoQPR3m/sPMNkuq+4U932UyoTyJQamtRmEH9ppfXbeOMdErMattWbP1T4IBJyTwzEzSYJCokIKBL/vHWrTQdEkFdcQaKdk8hES0Sfe0CV4Grgt6r+26A/CUXGSfYqPSNZ9dQn7tFIc1HGO4yJ8RbE9U9N9GBnnJDZizFxlbuITCyyVkGbVwY8J3GtBbD3/AdCQCSC5SkP+OPXwNSwOwqjp1cXNerfg027zzKMN6x5qoGWu5/Oa4oHrSORBF02e4fVfEE6TbVLeYWkHM4x1jsGHufxjNDHzxH2pZpSee7Ux7nYJzXc0zaf645giBMBZ7+l/B0odorZ+ex+ksXDDe3ox9nvkg==;5:Lml8mDCQtTflzd4EUBvI9zF318Sj4ueU5aGPmn260H14HxcBrtDQUMIbtDL5APUIsvunQgxZ3vFPT5x9aYSw7L6lZS6MeyYWV6/WRaVc25iGSJ/UnoMF6NHgGlCaJsFF6vA39OaHGT0/85cIzswSAcDP/GqQMnv4hQG5+BRzNQo=;7:XldhMVCjuXUSo6ZvWB3RxxJgRUDVVxq0Ou+ofJ9b1DtGbp6echY7onDK9tYU3uS6rOHd1i3CVIbtu5SEX6JnJsjTU+Vze6l6IhQbfH7nLFetK3KFy8uSYjTZ6JQAdSo4isuzIGj32WafRNpNCC6fOnFm/OBS5vHwKrXBDh5spISAnrysd58TazUdmm27XnznOL6nsIxxQ3T/PeIyK3hEDLTc7foBxXrbKduBotCM/pEmXwtPVQCBizuvmtlkbC2d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 21:16:40.4652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560c6afd-c39b-4f80-adee-08d6143e09f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ding,

On Thu, Sep 06, 2018 at 12:19:19PM +0800, Ding Xiang wrote:
> if device_register return error, iounmap should be called, also iounmap
> need to call before put_device.
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  arch/mips/txx9/generic/setup.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to mips-next for 4.20 - thanks, and thanks to Atsushi for
reviewing too!

Paul
