Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E73C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9002075E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XWbkDvMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9002075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbeGKOmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:42:24 -0400
Received: from mail-eopbgr40129.outbound.protection.outlook.com ([40.107.4.129]:10720
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388075AbeGKOmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntacq14+sONblmmmB0QaGg5iOfk97y/I++nC6xvs4cQ=;
 b=XWbkDvMlu8NgesdfrZHzucs0TDZJzGerUkJcbtWCqVLbQ2saE/vLJSx9x8tTeL4o5U4wJY+fQXu2ndrr2kkRnU3kIWJs76+/Wq+WneBBmGRFgrTGhSEcj4vNDc9IpHS0HrXh5TidytWr3GMpzqwZO/bz5BRzd6b93SKW448qed0=
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2025.eurprd08.prod.outlook.com (2603:10a6:3:50::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 14:37:37 +0000
Subject: [PATCH] fs: Fix double prealloc_shrinker() in sget_fc()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dhowells@redhat.com,
        ktkhai@virtuozzo.com
Date:   Wed, 11 Jul 2018 17:37:34 +0300
Message-ID: <153131984019.24777.15284245961241666054.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::34) To HE1PR0801MB2025.eurprd08.prod.outlook.com
 (2603:10a6:3:50::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3222517-2f72-455f-74fd-08d5e73bd9e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2025;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;3:CyP7Jc/Z7NQak8goAI+AC9J+bY6TCLaJoXIoRN+BtTZKtHk7QOJ0j8kc+7xrZNOm92+pnT+ar67I/Du8QzKq45Rnp8ofZzR+1rCrd2bULMYO+r3mU1af2Dx504ZxhUmaHIZgGAicah9+P9Tn/EvUHTg/pt4oSoP/IX3PGpM7Fcl9N8Sge+0pIuQgdPG0TW5/yKosQ5yo/QVPiT5jIGdQ57cyPxcxFZzggMVqjjbnKrKKmrcd9tG6+QzsJJHDBT5y;25:dftJVS4Fzk9Eq7FeeNur/7jROmLfNacIasgb2UQYkkrEkQgys91kfWrtZiuNYSGL/jHQnaJKwwuQZPSXD5uT5+aItYzs1Vo7dFn+YjSR4Uhsn3iCDVcl9JV5VME+JClTfod33mv3+68KBnIy6hyf1NOKI6/7e0sREhXHLy/G5fb9H39v5pTHJ0IO4oxLy/uN+CcT1o1o7T0ej7E78F53a1/oj/BpOfRdzUC8RIcHUUBARerk/2Ll8lkTvwGLmD3ZorSCXfBVUUDUoiM3P8cE/Erv3HVWwJv0+IeYX0JQEQgUaDZdw1fhx4VTQJ162aKdk61gaWBAOsJszxVkO7Cx1A==;31:ILh0TPDMg7et/Pl3bneqZx5gMMb9P5CHSfJrnR5R65RgldHbFsd6VfWonDA8XX4ZkXosr6IFF+WVPBKSTJ94JG3Ma1FY+DFS+VVghRejm9XsmqdQ80YrycnUzpf7xjr3arWHSbXTq/Zh8PhGePyQFfjqgRCyiZ5sVm4q1QMiLE6JMKCZB3hsRJSCaEQ5DiRnGgh5yZVB2lhSqxp+J9fCVRrLDs3N4bDO8/N0iUobAjw=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2025:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:u8PtjPgAJ2EjzPT/FehnJXiJF7lvIQA3PLbuLUiCZ5BSzhdLd7cw5v8wTFbIJbrG5UWm92tkpSl2BytMxJNVUd+OnxvwoHzbhuqSYZBeDdTVIR3w9eEQHLzJztrIqWikrrxDkIiKTF+m1tkep5UDy6nDRibm9lMI/w0+cHWXVC91GA6o+oCWG5GdCJzAjFBqStwjzKlEBBx/c36F4nZsiLqiTDwchexgHjxmRfGxc+vU753Q3zfmAJBFNSVhYPvDMzJhvT/9pXDZxDgRGm4DF5uEMQpDuRYbIlafVQ/T2yV2Z2robcYcY0IyU/iRgxLHRrZeB9qgJag5y6yNepDDOOqY9XquD5YORYjL5c8iCPitrwEIR4gUVtSZP0JwK++CJphLNqy6/or+AZy10AiBcey32FCGQIW+Fhl67MnfksgkJBkVuflqW28yOH31yzGKqumDlR0wegDtPCDwP5tvrjYWKoWdY495Q+rn/hkmtXCHYWO/5AXTJD0GirpPIH96;4:d0JSqmOBS4UhpfVRgjt128btPXFKdUkahQXN9Faw4uVXVlpguQz1moCIUQdukhouYb/jgajnK+MVKkIhqiSRrZSWT8syByB186EgOc7uFdJKgNA+LoH0SzMmoSSjY/zAhfnsO20Btq1ATOlk91UNuYizoqwJc8nEJQCV4rGfyEIOuiMCxPqpYIbXGC/eipox2vQQkJRBlJPxp93BoVveTar/lWng8Df4KRslAzi2FH+1l1Q9ucaFm7QiiDs1NSw4rF8Ik5diKghaEngNkHqkqA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB202582E7E764CA32F42E13BCCD5A0@HE1PR0801MB2025.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2025;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2025;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(136003)(39850400004)(396003)(376002)(346002)(199004)(189003)(68736007)(105586002)(106356001)(230700001)(8936002)(81166006)(25786009)(81156014)(956004)(476003)(3846002)(2906002)(26005)(53936002)(486006)(8676002)(6116002)(186003)(14444005)(50466002)(47776003)(23676004)(386003)(97736004)(7696005)(16526019)(1857600001)(86362001)(6506007)(61506002)(305945005)(66066001)(2486003)(7736002)(33896004)(6306002)(55016002)(966005)(5660300001)(9686003)(52116002)(6666003)(316002)(58126008)(103116003)(478600001)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2025;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjU7MjM6ckxDR2ZwNjU4Vm5zOHdMaXNMOGpmcXN4?=
 =?utf-8?B?NlMwSHJkUFJJYktXbzM2K2JCVmROTXVZMElDekFoL2lCeDB3dkJlV2lBS1Jm?=
 =?utf-8?B?RzE4NjdWYXVGcXd5NEdqVFYzS3IwZEx5SHVwQnFtTitrNTJ0L1VHWFg2aFU3?=
 =?utf-8?B?VDFXQW8vRWdxWUoyM3puYWtId2YvTjk1bmpBcUVCeXpEMlBSU3BiVUcxM1Vs?=
 =?utf-8?B?WmtjYXBHZDZSaVQ3V1IrS2ZRdDdsdm1OUXZIRlBtWUM0OWdqUmNDSEcvcWlJ?=
 =?utf-8?B?YVZFQ0Vpb1NRK2NPMFJRZEhTRUlXeU5rWGRjUWNRM2R0bVVGdW1hU2IxZ3d5?=
 =?utf-8?B?djMxZnpxRUtjMWVtR1RJN25LcGdTbG5pNm1Nenk1aGNObExkOW02R2QyYVZn?=
 =?utf-8?B?WmF2VWVXUDRseWV1QjhSK3o2bDFSdDkySExNMmY0bHUxaHQ3dUJnMklqdmM2?=
 =?utf-8?B?RzhGVGdtQ1hlWERld1B3Y0NnTWxvYk1iWERZbjQvVjZxL25yNFdhRlJzVlND?=
 =?utf-8?B?Qy9Vb0llYjZvb1djYldTTnhQdkljbzFiOEd6bXEwaFBNeEorZkZXM3BRclFi?=
 =?utf-8?B?cnFSVmozNG5vYkxEVXB4bThUckh4VTdKTlEySFVWM0FtV0lBV3BFaElXKys2?=
 =?utf-8?B?NTZqZDh6QldNS2d1Yk5pVUJWSkRueWZsRkpmblcwZXlEUThnTEVMb3UrcXNo?=
 =?utf-8?B?Ny8wNlRseWN0R2xBcWhIWDRaVjlxWkhzcWZVSmIwcCtkOHNYdEMra0k1VHpQ?=
 =?utf-8?B?ZStZRWpUTlhLWmFhMFU3TmhObzFFQTZQZjVvcm8wMnVkZjNTWktCVis2ZUlw?=
 =?utf-8?B?OTRwUGxzeFlRWk5CVTFKT0FDci9mSjdtdWpQWUYrRVJHc1hSMmdkRlljdFNr?=
 =?utf-8?B?VElhbUk5cm1HUEEzMFIyb2ZUSVVPZWhBYlg5SVJMVjN1SDRJZHFWVlRjdW1o?=
 =?utf-8?B?T0NHeCtLU0FFTjlXNzRVeTRycGZpUm5UYXNoTEhTMDF6RUx5Zm9rdTc5eDRP?=
 =?utf-8?B?ZnBYWjIrUXkzSmYyWkEzM3VwY01qdEI5a0xkbXNwRkpWeENQRjlTL1h2RG9r?=
 =?utf-8?B?djg4V2s2Rjg4bnhzZU1TTVhvcWJ3WDVQNGNNUkYxbXBhNVAwQ1dFT3ZpNHIx?=
 =?utf-8?B?c3FqZWVib0EySDlzam11Vlg1VU93ZDJKS2x0bk5DQ2ZnMkVwT3IraEhTMmV2?=
 =?utf-8?B?SHJOdEYrRi9GTDRhdXZKVG5vcXpnb1VsUFBwNStnWndLcXFKOUYvQWZzNU82?=
 =?utf-8?B?QXN1dFVNK2d4Z25xMFBNYmFGMlFnVlpTb01nYk50Ty9QS3M2MTY2SWZmTXZ6?=
 =?utf-8?B?KzVVc3ozVkt0SVM0RXBXU2VuUUtkRXc5L1FCcDNySXczUER5Wi8rUVE1dDBD?=
 =?utf-8?B?aEhIOFZmTUFzeVhqeDJ3bFNQS2Y5aU1NV2FtUGxWUzlPYnEzOHI2dWRhRWNS?=
 =?utf-8?B?elZYa3lvRzRsaGxyS3pxNEhLZXY0cUtKSWw4TFpuZWhQZEVJNlJlN1JHUzcv?=
 =?utf-8?B?SkhQSjI5U0o2OHJDNFZUMkRQakZZN1ZZYXFqOEMxL2prMWw3YTNSUnVHMGdp?=
 =?utf-8?B?U2Nmc3RXYlJzUGo2VzBUVnlwSzdTUWg0bjczc1MvUTJRUHF1S0ltQkxOSE82?=
 =?utf-8?B?ZFRNbGpSS3BrMTJIOUwraHV6aGJnSnFrK0Z3Yk1TT0k1MnBIUm1BcmJsMGZZ?=
 =?utf-8?Q?5d31tI/iLNu63XCjq5EQ=3D?=
X-Microsoft-Antispam-Message-Info: XW/8yH1fcsEJAxCV/mh9RoimJkFk2Dwghkgtf2nw3xW4eGYi8o8i03+JUKDZCRhhHgJXgYGohvWrsC34SKCABhidEwOptK1Yane1XO/bg+yWk8/Tt/6x7YNo415lO9XVmYCrVKgQ6v4mbfxgXm5U//q2Q8V7R0dYLmWXi1BmbR8g+cFUQbAoiOYFovwyTlMbnkNjmWLzqVL82QrAy0pq+nNeFGrYy07TuW5nS9rBybiaFYgCWAvECxtWf2zWeX0chFWZ3avmE6P4LsfdWaVhczazBtbu7yLmzZjK6xFIcI0XIuUYeDgDbktHkUp18BKdZGAU71U88USnowxmTxc51GBOZe6FZ1FWSgawW72WLQM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;6:0ObBDqaleBFllCLbJPSOmxdVooPZ57AlCZ/hFTiJ8B9bNbNyeT/ae5+siRakidIobT+TD1NiTbgXVxr6znsa5NVVAr5WEqagarYzhBX8jTXJWsFCRr92XZ+6baIHUEj4ZY5wiIshPOKu1vaBe0lL32xE3kcO9XkkAd9TnB/cJtIdpSRKTs1HIIKOdKk8KlhZt0iZfcQJlJwcHm+UrkXnB6Y9Hjdrwhc+VGgqKq9mFDXctSxdxY/jlnR7bj3hB73lpJo6h/sAw2ZPCzDLS6e2uKsDtOkzMWOnFjS1t47D2lEVUyad6REpXkxcyY+TC78tFhJWDC/Zm5xEIEeDXYrTZ4pgaddn2lonSxEcmXLL4iami2IO0LVqo/dH8VMh2ON0Kr7oOShmWgU8yVRhGUmoDn71Jp7FtM11/kz6RhZjNNUjSrNhB/vwJHX53XQS0y0NCDL/W1sUygGKUqJJLKDKwA==;5:j4yhdEd6kZNVUWDacu5coOEkeHvzkz2jeKOjF2prTLsvj98imnspBYrL4rqHsF+T7Mwt2ogQszhWMLP5nyMkfndCEGGZJj51xmu0dF+zQtz7BJM7/mdbiy+v+78jeG7PETnn3faFgkvSeGQFfWaSD6Fe1wAaHQRwz0iUxp4K9tw=;24:OJU5C1Hp8AB/bPN1KKa/DPKCW7WxsqTwJNJYWRtg2KFhLivsjhmI0AwDTvkCQ9GW6BSo7UVZJRzv6SPVGaFfyg4vXmQoEyR0LJ3wnPvg//4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;7:/RkA1ptBu5NQMr80lqg+NQ2GpibHMyVtFcwx1JbWcOCPQA13mRnM33xch9iDCZA5Hfyvtbnh3yo2FJ8CcyRzjJkVgCN/xJ3wl4vdLdAXxcXqHpHifClaZReFkUOnhAMDuRoAvU0P0S2bAWMTNtOz5TEIdSoUMEpy2r/518zpnOF6EgRZBablYop/T42vdG3cUMI8ubvVSPfuQNoB2C5+b3xqsK9jTn980KJI8C4jVxj1YTfWcx2oSigdv8kPTCKn;20:K2KuCKjLFDObe7LDGeAoS92bnELWIvM/Rk7+hbSU1QTaOxtnittdwyPZAANxYEVi76Y+UMBwOu0N1PrQjM413AvVGymnKECBV3O9nvgxZ5tH6KK21DVpeCIYAKKN0HMJpCkj+Lm6bSGW7MxU3LsipcItWeBdWwWacOD2o9tYUZE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 14:37:37.9490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3222517-2f72-455f-74fd-08d5e73bd9e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm observing "KASAN: use-after-free Read in shrink_slab" on recent
linux-next in the code I've added:

https://syzkaller.appspot.com/bug?id=91767fc6346a4b9e0309a8cd7e2f356c434450b9

It seems to be not related to my patchset, since there is
a problem with double preallocation of shrinker. We should
use register_shrinker_prepared() in sget_fc(), since shrinker
is already allocated in alloc_super().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 13647d4fd262..47a819f1a300 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -551,7 +551,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(s->s_type);
-	register_shrinker(&s->s_shrink);
+	register_shrinker_prepared(&s->shrinker);
 	return s;
 }
 EXPORT_SYMBOL(sget_fc);

