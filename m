Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A8CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFED20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LbDbhnFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFED20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeGSLeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:34:13 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com ([40.107.8.115]:59808
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeGSLeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vehTNfFgsjTZB58WaDgEzkPigFSq2j3cLuZKddb3oAY=;
 b=LbDbhnFqoXvatTH6mjsiLocp5a7nz8Wr/1jScpJvpfRGDJZD/yjwmLB2QR8O9LMc2LTwXvBgKevA1WxSz2R66a6SYp3wvewQMe6knXOoDdMIdIc1XIu9TH/70sj752wKHb+qoucycgrOwBYYqinDee3gxsqnaWVEqc4xbTpfRRM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB2019.eurprd08.prod.outlook.com (2603:10a6:203:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 10:51:30 +0000
Subject: [PATCH 2/2] mm: Make flags of unsigned type in struct shrinker
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, vdavydov.dev@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 19 Jul 2018 13:51:27 +0300
Message-ID: <153199748720.21131.6476256940113102483.stgit@localhost.localdomain>
In-Reply-To: <153199724495.21131.9248876333336922199.stgit@localhost.localdomain>
References: <153199724495.21131.9248876333336922199.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::28) To AM5PR0801MB2019.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4a631cc-0520-48a0-43ca-08d5ed6596a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2019;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;3:4SCVauuz9xkW98JwIlcg5pewuIwECJPBDyRR4T9VSpeAiHWulpaxKeUQMgYvk2aiao0CwHJoPK0eDDA/RlCumD9bsyqNQqBDZgvfIA1sMTboBMUhAtuEBZY7IRXLxBfSyFtFh8jc8ReqzHVO1w1wZLH00t8RmrsamciD494ACOHjSi37EmdtEgPP1Jk84YUKIzJxc6DDI44tvbb6jrlFiZsbc2/DknOH1Su45oqvvhsUZo21KvpSQlUW8RBapsHQ;25:8xS9KFuwuf/ZLJqtj1P62qmR4QRIi+j9spWJOGtTDOKQT0pqOzPLtAY0mxbB66atlxXkH/xbPH+EzulPIBijFYObvktAABCwMq3UJ95KOB44BobUFmJe5u15aNgg4vmQMDygdKGE7kJqZRn6wLvBel+lORrU0V1OxyUCR7oG8t7lsY60p1DNvZSpyC9UdnTSZ9R5J22Tp6RSEsltm332VP4678SHD2jWmP9J/xqpFNAKgQlEPvxvYCfCu2WIPOWaVctjejcq5QyfbY/0lqWb8sFBACyzQyUP8lmSrzPQ94QU4ImuYg6q+kQGqbEnP5iSmd+83iZR4Uvixo9a4AqBrw==;31:Hc2ulWpNp/C7mesjz+12sIBsAs5fifkw7FgwWv5rG1BNdlcMNG0y4uld75GNr3i054PpWo3Wywj33q50vaK3b1UQvptTMqo67hrJeUOMdN2rgY1mPvPlJLrtZmICf8A/hlReOefOVRun5b4vo5sjc369HBCp159JDeGhcQVlgljKRgB/T0JeFcpHubfUrRWG6wusZ+V9t8sLP9HOfTRHKr8nNdeUhG6Gcnd14G8hlh8=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2019:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;20:7rxpvLrnbjpyM8JSJ+VuJyTs6HHXK3pEBb0bEi6T+judM1ilOcJlF4B6V1ekM0fmf+YFedYjSEe1oR9zfAYuK6mK8/21cU+ijtOLrlGiQhpv7D8dUGA+nnu0U51a+8h5SnPODijvKZgVoQd4clgje0GUCsDH3IecLbnOsuzId1NOVMbtE/4YoU7E6DgckdISvJBpAyxbOpNnMU2wB7jKLlNA5NsTvTxgJcGKtpqKeAnpi8lEmCtvdlJscbNtZKWQXVZQw8IIzc9hvdDbrWIBRyvYQ4EXm66oWVapGdqZxWka6zn0ratwO0DAexpqt9Q0Bdes1ERrYOSbwbpj38rAflEMFp2RVv6N9zQdUVXzwHY1NZD8dqG5FVlCT5cxtw2KrkQbIF4ejMx0Q/t1Hqj5BSMXYTvjXUy95MOYU1n2BS2IAt2h4MY5PABbaO1idiYHjOmLt7Bd+cVcqKMFvW7GWiMkGxwJ9Qp2TXowqxz4n26DgZjBxxrlIygYnth851VZ;4:U4SkgGH+PaJX6moxNAf9XrYwBJlXX9oubfeoMxp60Iq8W9+jI7vPSdpS6pTG1Xmb9Tqhb3wr43ak3xCOzUhkoX2o9Yod5zieUm0RNLWKlVq5SYeedRd8NPaKB00yGZhXN15yzDbQS6LnZtAK8SWsBAk8loFsJJmMwi3WT9PczOn0rq13I96g045ZyzqNb0qe/C768wMyGAPP7bpWgwZ5uBdiVjkpx+DjN6vPa8zqA5qBWpdsX+/YVo8aXGY6bymm9v0YZq8uLolRygIgvLdgNw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2019195DA67D512AF343C174CD520@AM5PR0801MB2019.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2019;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2019;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(68736007)(478600001)(103116003)(7736002)(9686003)(6506007)(386003)(33896004)(55016002)(186003)(16526019)(5660300001)(26005)(6666003)(105586002)(305945005)(106356001)(7696005)(76176011)(2486003)(23676004)(52116002)(446003)(956004)(476003)(53936002)(486006)(81166006)(66066001)(47776003)(50466002)(81156014)(8676002)(25786009)(6116002)(3846002)(316002)(58126008)(8936002)(230700001)(86362001)(97736004)(2906002)(61506002)(11346002)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2019;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTk7MjM6ZzhTTmFFR2F6anZzUWU0UlQ0NTI1aFBq?=
 =?utf-8?B?NEdJWUt4TCtQVU40M1JjSjRGNGZLSlZwcmc2Y3J5QmZMVHZBcVl6Yzh3RWdF?=
 =?utf-8?B?RzhWcEwweDVrLzh5dkg0S0IyalJCbjY0RC9hZjNwT1JSalFpYlBmMXljdUZ4?=
 =?utf-8?B?L0p6NmVzdjdZY002alp1MlRXM3czeXVlUHVUTVNSdHcyTVZta3duY3dUWlUy?=
 =?utf-8?B?S05CQXhjdS9WTjl3cStTZE9Zd2N5V2pkdG1kTEw2YWROVzc0ck9rL2d3azAz?=
 =?utf-8?B?ay9kNWNVUS9hVm1iQmlIdlVueHVWS0JNTk54WkY5WHpmdFovSHo2OFk0MzBk?=
 =?utf-8?B?d01PbTlSYTR5dXpYclN1N2p3Kys5WkJtVDk5Vk1ndFNlTDVXbHFQQ2ZqYlh2?=
 =?utf-8?B?TzVRemtoWitVb1A0RDVGaUVlUGV0a0F6dC9TcDRkZ2NpS0lNUDc3N1ZncW85?=
 =?utf-8?B?c2pzMEE2RFpJb3QzekFrejIwVlBZcFdZZndFSzdBV3NaVndWUXU3U2FRd1lP?=
 =?utf-8?B?cUdGSnBvaklXUVphVVcxSWRnS2dKeEpUYkJ2b09kcG5CMkovaDZVQjBVTWd1?=
 =?utf-8?B?RkNCUzdERWI5S2R2RC94cW81dWZGVTFlWEtJUFUzNmJjbFFsOUp3dlFtSjJP?=
 =?utf-8?B?NXB4bTcxQWVhWDV6UERFYmVOWm5Hb1R2U01RZHNXa1VUUmFiaHV4RUhXaEdG?=
 =?utf-8?B?TzIwTVZIS3lIUjZ4TVVlbjVhb3YrZEt6ZDk4WG43NlJJbEtCMUZOTHZWWDI3?=
 =?utf-8?B?VEpMNXhpNVl1d3pmYVdsSUJzSW0xNzNjYmxySnNlSGRmazRvZnN3VlM3VEFi?=
 =?utf-8?B?L0dXR1RjZVJHaVFvMWtwTWVXOFVDT0JwQXZOeFcvL1dwV25uQmlZK2VyZnUw?=
 =?utf-8?B?TGNJdGpBS2JlMWs0NUJpTkphclhBUmtISzhJaVlGeUd2K1g2ZVRicFF2L2ps?=
 =?utf-8?B?SFBuVTluZnl0M0tiaEhER1hnWDZ4eGw4OEdqYkViQmxHTDNaalY4S1lmalhx?=
 =?utf-8?B?WHBFU3NySktHajR4TFNJd01EUmIwSzhBTFpsWkF4ZktYVEUyMkhYLzJnZStO?=
 =?utf-8?B?VGNuRnBxK0N2MlRCUVdqZjQvOXd3YWIrS3hxblg3d1FEY3lDQ2YzZXhhaDJS?=
 =?utf-8?B?ZHJwTUluNEhOSVdpTXBQU1ZNcXRTK0ZjVm5IeHJPMHF3WnRYNE5Ydys4N1Yv?=
 =?utf-8?B?OEFXalhZem1oTVN5dGVOb3dOSkhPK2p5aW5LQ1BFd0puUWdCQ0NyMG9JQnpB?=
 =?utf-8?B?R3EyY3dNZW9CWVVnTHFzZTk1dFdLRDFMQ3pKWDV5aE15SkJUZ3Y3YVZSN3J3?=
 =?utf-8?B?SFh0b1liSXhOa0wzQmFnekVETWptSDNkRzlDMExHMVZBamxjT2hPQ1BuSFU4?=
 =?utf-8?B?emhIeWlUT2xWMHJ1cEtCMzFaR0daWnlySk02bXBHT09LR1JLRXFXWGM2bEZO?=
 =?utf-8?B?L2V1a3Bxa2ljQ0phYXpvcWhEUkIxUElkMEhkbTFSaXpvYVU2aVFhcjU2RGp3?=
 =?utf-8?B?VnUxRTNWaFp0Skt1UTFxMHV2NjF3Wnk4RjBiemlLSnJmS3BaREJCQTBLck9w?=
 =?utf-8?B?M3YwMmxwUEhpY1ZXSFZoYXlZWWdkSzkwWVVqeEt3K2ZIbjllaE1CbnN2RnF3?=
 =?utf-8?B?clFHdUFiR1J1ZTNEejFhUG91OHh6MHBzeVIrYzZZWnFQSWJoeElwRzhRNmc9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: URpd4ggcCNWhU0WF74qXISPhD/qsinaGwedA0a6h2I74P0ZmzrkJNwUNp2fMBEqygWgnguCZgaHmPJBtS47TzOy49ZSoyxmpz1JDMn4Rigcxc6sWBPctV80ibJne9qHj9UlGdjDdiY07tpFIxPDdv9+G+QCYgwuRsggVe1bZiMoK4BHtsGyGAylPFLl2YSdRBQZ6VR4fBYQtc2VUZ3n61EzfnbfavhuxcgmOvxObPq53FmJwSaZhU+BX+of+/jN6Yc75jfhAT8ypF25PVXC5nTWo30uPhWKW2ahGp3S/hEkaU1pR0Sdt2bO4DaKaHgmiP4Z2vIsdQ/zCOgWKW4/z6yZvvcaCsELDCGShsR/lRwI=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;6:XPv2amnfazvy7H7AQ5Fm1ovmRW6UyZYN0tUOIOTOna1RJzp5FJbHRMHClS4R8jBckph4mbakf2AgCV20+1kZ3XLSojjwZGGWRXcyima/eTSPl2nxS23CMW41Lco+/Dps0MZV6AEG1+bEG9tdDqeB4XtkEUxFWP8/otj0KRV/mWWjGmbgQxrr38H11623AagBs7EiwU/Gm0jRWghy0b7omigb0vLiFO9XBhVPq8IhHwm4XqoFDdokqiwmXNWpIpM32XjPhA0ueACTVmOtp8aRE/5+7q6vCL4c4t2tqaTUkfwORoAWlyYWw3vBLdGAOn2ABxGSBdQcRZca+L0bbnKb8+4gsAARk5NJcjPlqReNsdLgY7aufLfIpqFzo8al8Yja+8gbD/ZED/xAYnTqfGu2J+1QKiaEeqYxW/xgNceR/OojbgZQNwmz2AfkUkPUaXDna+gpqvKn7M+3jBt0YDtscQ==;5:CXZPnBUsctM3Fj4ISONJEkZgiiRDeuPyrIeyclnEKPGSHKXUxdzpXGim/3QqklfyZzdFC/ZtS4CT3OYTFyV83qKodlZ3zAHUc+GnZUO+/qlYeCiVK8Sfp1vVD4ZP9yZrKPFdxai9EtjBdB34bDuQ4V6GAwCT8KOBmhOjWb5Hm/A=;7:ShjI7m9IcOYbx0Bw0FQ9BCd0S6Lan8iWzxaQkzydl0wihVN1rFGbctUenWVifDhwuxvBhzH/3PbST5q8JkWtPsSV40OeysFHsD4ZRaGeIGUhrLDt6KvjMYXFthRd/fR3UBBBgogOaxBFN1pTipbpZX3uwlCEEIj0oRyaOJh6qRqbnIOocoG4QUOIpzaKmdUnvLrt50EuYswGGrnTJ+e2kp6RTE2yb5HiQWMC6s/pR250k/Yuc2zUKQ7dJk3+Cww9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;20:dscBpa8dYJ6jCaWkJak39nwCaP5ZW7WuX2o6iVNSYNsAONTtLBf5FXO+Bp+F1GPY1dkeGpKYfAMkRMM+XOdvus3VWfQ5vWrUu4r4uW0G1KQPSSt4rAMBOaGN+Y4S9oEXcnyKwxoKfWvgEVMD8f1RNbuueZDwaeHAZXdbTGGLLhc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:51:30.3009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a631cc-0520-48a0-43ca-08d5ed6596a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are two flags only, so unsigned
is more then enough. Also, move int seeks to keep
these fields together.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index d58aaaed34a4..9443cafd1969 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -63,9 +63,9 @@ struct shrinker {
 	unsigned long (*scan_objects)(struct shrinker *,
 				      struct shrink_control *sc);
 
-	int seeks;	/* seeks to recreate an obj */
 	long batch;	/* reclaim batch size, 0 = default */
-	unsigned long flags;
+	int seeks;	/* seeks to recreate an obj */
+	unsigned flags;
 
 	/* These are for internal use */
 	struct list_head list;

