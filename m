Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E449CC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCCF277AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RDumG1FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCCF277AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937056AbeF2QsP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:48:15 -0400
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:51345
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935714AbeF2QsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0ZPIPni+MHSrqJfqy3y7Vp/Q1+MYbOKE2DBf7jAwD4=;
 b=RDumG1FGbW7NjHarvFPrntiSM4q6JZxyjWo6fSCu2xdnifVlvkX20FgGvRe7AGlwu6eeNnO/YO3Onm9X8rpss9PGsgReWnMsyKxu7u1H8gC0jun8KrGE+CtkGf1Mh9BE0e/m3OpZ8NCLVBX/hSEiFG95942VtYv3PoszYccihas=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 AM0PR08MB3249.eurprd08.prod.outlook.com (2603:10a6:208:5e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Fri, 29 Jun 2018 16:48:08 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, dvyukov@google.com, glider@google.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v2] kernel/memremap, kasan: Make ZONE_DEVICE with work with KASAN
Date:   Fri, 29 Jun 2018 19:49:32 +0300
Message-Id: <20180629164932.740-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180625170259.30393-1-aryabinin@virtuozzo.com>
References: <20180625170259.30393-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR06CA0140.eurprd06.prod.outlook.com
 (2603:10a6:7:16::27) To AM0PR08MB3249.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da2f622f-d3eb-42a4-9d93-08d5dde0185c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;3:dPpWbC3pr5rfXx34YSCTSTmxvCaaXH5Cjw6cfZx8NKzXsC97uZ3uFWbJ2gVmNbBawt9L/CiTPveSP0YnBRTc7MDD2J+Bs/3Aou89UAlAyjDCciA71qhIC9WBb1JLhMi54vqydkQ/vnTzbMcUA4E3VEGa2vHXO4TIfN9wTZPS9nfPC8rUrDS63+7j+RCj0bVKIG2Dpz+jPOWBAzy29jjs8/qXrfkHW+tOPulq2ulhWF6icbPWIS86HXbyiqrR2njg;25:xDiikLuOE1rw/ylsbMbYh//9Bnx+UrTv+IGwV8w8+dhPSR54sKRXQGEnIctS8E6p5VRSxjgaVWQ0NFvuOhB4IMX6Lnm5IjlIHKJgAURg3+YgK7gf+uNguur2fJeBPYEeHc8glG+kxjip3o1rFlq5Oz51iZ0kMDnKELzpauhhutdNwmU3x2Vij2CZcDCfuuMu6E5Hh9c5mY+l/3gHH4DLyfOqt9m+BtZ8NdR6MPeBw7BIUUTmmHcIpZ0xjy/yP6UM7TbIrP/Kuezs5tRjjq3IPWHSZQjyKlRXUTRPL4jxomsBLpgam/pnhQT7HDN7+tPpvbLKS1mOxRL7EkjtP3HaKQ==;31:8MlbFXtN7FCf7Lrjyhpb4dnvU6Sj+7rcotgWzTNHEeF3DzVCa3jZjHn6DjFBfh2BvaU76Zv2SyN+9L0HZ12keYRgKTrxh5iC2kjc0Jq+x9NHiFpR4xU1rOnMvRnAOEA74+dsnfw3cGmB2hIrn8hPG2laQQX/Rm0b6akKGcpp/oaR/W7h6RBKlpyNf2ZBVAMy67veWSL8CdRzS0ZmtZG2X1reFYP9Jxc0nhq2v09aPyA=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3249:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:zCKiJ/x9JGIrxH6aHotTmdbxt1Q0NVaMvS94ZLH37ikCiz+gmpvookBtlNWssujpnzv4PmYU+6GUUSYLBZ67n2lw7gcGA4mI6jo00y0HbP1RDJno3Ar71Y84PGzx162hmtYN2TSY5bRIg8ao1aD/wWto6XvI58Np2j/pZ8Klo4rDIY0FTsBJViJeF9jdDEdfiwKsFPpUuD1DHH3eetNInXpHwJ6/JBs6DrFw9uxqAQNxWGozxiI/UX3t+eQoKvB+QET9kFWC/l/G8MMeQ0Fts2QbcpuVBBk5oiYckWPow8YdzM8LpJQqRizPCDMMkX+S3okIH9F06GVJlgv9DbkmSlXTKmuFqNlLKeL8fHgXMCfV3rBfE4gCg9Qe3WXWndkz8E7t7v5FxfqV/Q3soqkxVr4f1cehn+4B+8VXZ4joBG3oh/olIJI7F3bv1L1is5KeGM/n1RVKjdeiRkJXrumcL0dFCFhS8kmieGu+ccHfQh/lXLFheYoxbx3KHWaA0qME;4:b5EWYCzZR6o8AD8U34QNqgSLWa1NZ1vIHdBJpNB9ByD0LUVMwNc9wMnZ76Xb/mg7FNEOBGvQF8JgN3S5JPY0lsAj2k1hcwCKbDZwyvKi121hvFd2bSn3zlN4DnylZWs6FJI/OLarbCZ38fgmh/d0qMSWvSKoyVfiWYzRUs0XLg0Anmeig2Hh3tgjFU6BeKZSIqTdh1p9e6WNZQP0EN9BWga6UtP+/0n7jMDGqt5jaSh8398GYNmPSkFeAauvXH2cE3nLwhj0599A1rz86dogR3TWK70zfXGsh2wgJEmbeIA39tx3Y03GVoRfZK/lLQyl+xiGolUdDBd5FQFSMKgTSQBL8WAD3B73DB5x5Pln227dPqr4utEmBG5Y26J08nqe
X-Microsoft-Antispam-PRVS: <AM0PR08MB3249C64546940568697CF25BB04E0@AM0PR08MB3249.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3249;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3249;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(2361001)(5660300001)(48376002)(81166006)(81156014)(106356001)(25786009)(4326008)(8936002)(2906002)(8676002)(50226002)(316002)(956004)(486006)(16526019)(2616005)(36756003)(68736007)(86362001)(1076002)(3846002)(11346002)(575784001)(446003)(476003)(16586007)(52116002)(51416003)(26005)(2351001)(186003)(6506007)(97736004)(478600001)(305945005)(6116002)(50466002)(386003)(7736002)(6916009)(76176011)(6666003)(5024004)(107886003)(53936002)(6486002)(66066001)(105586002)(14444005)(53416004)(6512007)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3249;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3249;23:aPxCxYutc+2nuxKWUteJSdJI8gEglogIBctI0zHw1?=
 =?us-ascii?Q?r+TF4rxx5OG9n2t7GI3MjoIaS1H5hQ+jyplFPwduH07NkefcvF7HxkzzioxI?=
 =?us-ascii?Q?Vd5wWzT9mtquawOOzakDXO0Ui7Bea9VM540bgV2ZkLV6cBF+fMeYrfcJFi05?=
 =?us-ascii?Q?VP1WmSxlNZyqUL9OLdaUzttL+Oj7f1SD0H5LXEEr4blugBdd8QeSfo3hRkvB?=
 =?us-ascii?Q?2pcyNgwFrP2Z3WGgjqMTuAM4aiSG0a3jd+iV3EpP6eIwaEu2jkJnVkOTwTB/?=
 =?us-ascii?Q?1ng3/G8A+gjcRdoPUW/a/hyXB9Zqij9afTFT+XtUQm5LZJxVXQSQ3xprKmVh?=
 =?us-ascii?Q?L8eRignDl7YKmbKGCGDv/L37p8b1kGQ1Sd46XpX5eOCp33gQs9ui90GPftGf?=
 =?us-ascii?Q?5CApCkhPRQrmQaY9dL9KUWtNTDTTIEguXHKnr210yzUPWbdD3B/lVfM8YgP8?=
 =?us-ascii?Q?0sXV0CQAXIXo00WkG66KBgNOT2ThjXa17HH8M/U5WbO4+IIGqG7jOIADJRmK?=
 =?us-ascii?Q?PZYj9a1bQygWmWXQNwkEzESu8lrDbyeRAyb8Mj9SSc6j1jK716EUarEabwEl?=
 =?us-ascii?Q?6wAAHuia+X7ZkxonKJDmsJTzjWloB7EDnILsLOlw77Q1Jq+xyGotKhVdMHlq?=
 =?us-ascii?Q?ybLfHxT4rnvxuQzF9004upECNegiXXzj+HsYbSdaTx0EYhAsbOfmqmwPxGAO?=
 =?us-ascii?Q?QSXsGHKH4wKZjUPOFMmerfQm2YiNV9PgZcJMQ1uZkIVYxoM7Vcu2L0l+1SQ0?=
 =?us-ascii?Q?05JYhB9Ei0lsDf2ikyHxHDdhbq4rZlTLQB1L/nt+ou/y6z0QHh1dY7sY/eyH?=
 =?us-ascii?Q?o34K8yuGQ2ARo3Lu1/csOjw32yG5VURveYQms7XJlY+jyG3BN+3oyQ9iFL9n?=
 =?us-ascii?Q?nvfqck8zC1fur6UxBE4uQQ+WmRRf4r5YWzYjwygX1GlxKm9LSSSTSbHJYTAn?=
 =?us-ascii?Q?oHW5FDXXnjpBeyc3l5JrI2rLfkxC3NeSicEDAk4kQwHMgXaOYjQPhnzEfv7v?=
 =?us-ascii?Q?nzhn9VAEiST8U8Y/Gjt/KP2xdID3x0d+2WIamrjRFbO4Cv5OU6JMa5q3Hp7o?=
 =?us-ascii?Q?74f1x95cw+YtCuOulz/aIXwJj8nt5b65olgMI8T7AwgidugSjzf0PHqD6hdj?=
 =?us-ascii?Q?LJ9X8TsTXVen1EeNfhqD3PtRMAFb84oSEe69LciZUYafUADcgo+ZZRFPqt6j?=
 =?us-ascii?Q?RLXa0d0g+A1GKGjOQKVqRytwv1kbK2Y7AwOaTpb40vYNj4gT3lxGTez/oC5/?=
 =?us-ascii?Q?2ZapMdJZlEz3Osb4TwFPfHV3M3pJNWHY0B3LONYoUTZZkcTafnRQDJYKCbzf?=
 =?us-ascii?Q?9cuKEeQh37m+Vze4KzURLsvoud2NzNDEcsWEe0fVmU2?=
X-Microsoft-Antispam-Message-Info: Y75nfb07FRODkMOHXNUZ2MhQoWUsDa8d4QvUcbK+WV0CfqgV8wItClPmaPOhu4+0RAoX6O5l1WyXMQCdZvqUcFCbA9vhkib79ZTjdyOS5UD+xaNQGpe2BjEeeVAXyVBr2smDgXEyBI7pa3izERXKfZkwH+oYln5qhPAyB36K+HwmmDtM7c32Olb3Zh/ZAfqAdCPuNF/h5rror26Xyc9CIuei/a+rM5aiVYTw20bujosQYV/sr2cl5WDClIPJ6KdS1mmU2aNA7vezaMpLUVnDk2umZvyMZaNH/c3dH3a3HQY5ZAICSKXeIxmr7lKkwBBiOMkF/H32CV4RszEIDLBsbsMvMzOFWNfAZG0fFYKIBxI=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;6:nnz2OMpWrUbSwh1GHh+7ZLS16jwALEpucBQEaiWv8fCWcDWd/Xs3TAvrjQ6YZx7zMrSa5x24zj2IZJOZ4HSPN6ZNKNe/EXnRdpW9h8oXbQoeUSkaBkvVm8wLME2KpS22RxnLKdQI45jlGV+vu4Xo5BT5dh6rzYtTeCagzkf/1ptMhqLb6f7cIhQoIfav+EsqXcGkKmoYbWjlARAWuFf5cdZfFXVPbUnynxl0mJJrqzoGI64S/mLFlTIcWSQuI0c0v1aRPV1FbBfHa4P6/WNZ/7cIOJcfVQZUcS3gmoSjuzvfFUlUKZbFTEa3IbuK7LAQCpsF9w42qKFjoNiRKzDI+ocsys0guaJpAiNh7uD5OcFIQe3InCr2wpBRDtHZNg8n04RztOhq6J+d8e7slECvemR4GDNdCOZT8srWI7o2h9a0BQX9WVrnAwPU4+jhe4XDsUpIET85gR+7r0jA4MzBnA==;5:bfwKg4WMZfRpDKdMWCKGWYFf0DmHyQKz8mfDawagnyPXGfj5CZRsGyea4hrv9LPOz3xT1ZTh7RaHe5vmuf4dQRGlPh5fXm32iDtBM5vpTLu9+QxPXGrQqM1/D4omtiiABOcgUiO3xRkhbZ7kbYCIUXX+lWoollnRdxHEkj6EbY0=;24:Y/EeElZPg1DjIhmwpckjz9vJAbwrNFSOiNSarHQiTbQkDDhgRWaWH3ghI9nCC17O5KVmS5Cwn+YVQ1AmTN/u5xxgYh9t7cffCcLeX1qEv/8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;7:707dX39QIA/i0AwulA8e6uVnwAeq0IlIN2R/FZQFLCihmByLDMUQP+LSjjT5YocewFcRX2QRqs5oz56Nxa89zzXf66XnZgsfA/+q2B8aSIYIkqfdGjwB0/jH/VVIwtgPwJhPBfNiGwtYcIqZjKXVLbbn+145hQMoo0hQLWi+uJhSy1lWBH5cRtVYQBZN1blUJW0zzqXcuE7+ssQlNlWZoiWRj8QkdSKRJPJGLIH7wc/oJZaMXa35s5StirFt7Pzz;20:8I3DA0/EAJhJ215VV35/LXiU1YVxxwzGQTJgN/LqCmH0hc4GCJ26AwqR7eken9sN0B2xxQs4lrAyK3taxDsKeoARks4VxHveP9krIOuu2o6m1ebjyJ681LHOM3UJOFbU1yK45EyekmT/To1zllyopiR7NKeIEFDQwLbjbyTw/Jc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 16:48:08.5177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2f622f-d3eb-42a4-9d93-08d5dde0185c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN learns about hot added memory via the memory hotplug notifier.
The devm_memremap_pages() intentionally skips calling memory hotplug
notifiers. So KASAN doesn't know anything about new memory added
by devm_memremap_pages(). This causes to crash when KASAN tries to
access non-existent shadow memory:

 BUG: unable to handle kernel paging request at ffffed0078000000
 RIP: 0010:check_memory_region+0x82/0x1e0
 Call Trace:
  memcpy+0x1f/0x50
  pmem_do_bvec+0x163/0x720
  pmem_make_request+0x305/0xac0
  generic_make_request+0x54f/0xcf0
  submit_bio+0x9c/0x370
  submit_bh_wbc+0x4c7/0x700
  block_read_full_page+0x5ef/0x870
  do_read_cache_page+0x2b8/0xb30
  read_dev_sector+0xbd/0x3f0
  read_lba.isra.0+0x277/0x670
  efi_partition+0x41a/0x18f0
  check_partition+0x30d/0x5e9
  rescan_partitions+0x18c/0x840
  __blkdev_get+0x859/0x1060
  blkdev_get+0x23f/0x810
  __device_add_disk+0x9c8/0xde0
  pmem_attach_disk+0x9a8/0xf50
  nvdimm_bus_probe+0xf3/0x3c0
  driver_probe_device+0x493/0xbd0
  bus_for_each_drv+0x118/0x1b0
  __device_attach+0x1cd/0x2b0
  bus_probe_device+0x1ac/0x260
  device_add+0x90d/0x1380
  nd_async_device_register+0xe/0x50
  async_run_entry_fn+0xc3/0x5d0
  process_one_work+0xa0a/0x1810
  worker_thread+0x87/0xe80
  kthread+0x2d7/0x390
  ret_from_fork+0x3a/0x50

Add kasan_add_zero_shadow()/kasan_remove_zero_shadow() - post mm_init()
interface to map/unmap kasan_zero_page at requested virtual addresses.
And use it to add/remove the shadow memory for hotpluged/unpluged
device memory.

Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
---

Changes since v1:
 - Compilation fixes.

 include/linux/kasan.h |  13 ++-
 kernel/memremap.c     |  10 ++
 mm/kasan/kasan_init.c | 316 +++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 325 insertions(+), 14 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index de784fd11d12..46aae129917c 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -20,7 +20,7 @@ extern pmd_t kasan_zero_pmd[PTRS_PER_PMD];
 extern pud_t kasan_zero_pud[PTRS_PER_PUD];
 extern p4d_t kasan_zero_p4d[MAX_PTRS_PER_P4D];
 
-void kasan_populate_zero_shadow(const void *shadow_start,
+int kasan_populate_zero_shadow(const void *shadow_start,
 				const void *shadow_end);
 
 static inline void *kasan_mem_to_shadow(const void *addr)
@@ -71,6 +71,9 @@ struct kasan_cache {
 int kasan_module_alloc(void *addr, size_t size);
 void kasan_free_shadow(const struct vm_struct *vm);
 
+int kasan_add_zero_shadow(void *start, unsigned long size);
+void kasan_remove_zero_shadow(void *start, unsigned long size);
+
 size_t ksize(const void *);
 static inline void kasan_unpoison_slab(const void *ptr) { ksize(ptr); }
 size_t kasan_metadata_size(struct kmem_cache *cache);
@@ -124,6 +127,14 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
 static inline void kasan_free_shadow(const struct vm_struct *vm) {}
 
+static inline int kasan_add_zero_shadow(void *start, unsigned long size)
+{
+	return 0;
+}
+static inline void kasan_remove_zero_shadow(void *start,
+					unsigned long size)
+{}
+
 static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 5857267a4af5..172264bf5812 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/pfn_t.h>
 #include <linux/io.h>
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/memory_hotplug.h>
 #include <linux/swap.h>
@@ -137,6 +138,7 @@ static void devm_memremap_pages_release(void *data)
 	mem_hotplug_begin();
 	arch_remove_memory(align_start, align_size, pgmap->altmap_valid ?
 			&pgmap->altmap : NULL);
+	kasan_remove_zero_shadow(__va(align_start), align_size);
 	mem_hotplug_done();
 
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
@@ -223,6 +225,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		goto err_pfn_remap;
 
 	mem_hotplug_begin();
+	error = kasan_add_zero_shadow(__va(align_start), align_size);
+	if (error) {
+		mem_hotplug_done();
+		goto err_kasan;
+	}
+
 	error = arch_add_memory(nid, align_start, align_size, altmap, false);
 	if (!error)
 		move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
@@ -251,6 +259,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	return __va(res->start);
 
  err_add_memory:
+	kasan_remove_zero_shadow(__va(align_start), align_size);
+ err_kasan:
 	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
  err_pfn_remap:
  err_radix:
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index f436246ccc79..7a2a2f13f86f 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -17,10 +17,13 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pfn.h>
+#include <linux/slab.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
+#include "kasan.h"
+
 /*
  * This page serves two purposes:
  *   - It used as early shadow memory. The entire shadow region populated
@@ -32,22 +35,59 @@ unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
 
 #if CONFIG_PGTABLE_LEVELS > 4
 p4d_t kasan_zero_p4d[MAX_PTRS_PER_P4D] __page_aligned_bss;
+static inline bool kasan_p4d_table(pgd_t pgd)
+{
+	return pgd_page(pgd) == virt_to_page(lm_alias(kasan_zero_p4d));
+}
+#else
+static inline bool kasan_p4d_table(pgd_t pgd)
+{
+	return 0;
+}
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
 pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
+static inline bool kasan_pud_table(p4d_t p4d)
+{
+	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_zero_pud));
+}
+#else
+static inline bool kasan_pud_table(p4d_t p4d)
+{
+	return 0;
+}
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
 pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
+static inline bool kasan_pmd_table(pud_t pud)
+{
+	return pud_page(pud) == virt_to_page(lm_alias(kasan_zero_pmd));
+}
+#else
+static inline bool kasan_pmd_table(pud_t pud)
+{
+	return 0;
+}
 #endif
 pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
 
+static inline bool kasan_pte_table(pmd_t pmd)
+{
+	return pmd_page(pmd) == virt_to_page(lm_alias(kasan_zero_pte));
+}
+
+static inline bool kasan_zero_page_entry(pte_t pte)
+{
+	return pte_page(pte) == virt_to_page(lm_alias(kasan_zero_page));
+}
+
 static __init void *early_alloc(size_t size, int node)
 {
 	return memblock_virt_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
 					BOOTMEM_ALLOC_ACCESSIBLE, node);
 }
 
-static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
+static void __ref zero_pte_populate(pmd_t *pmd, unsigned long addr,
 				unsigned long end)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
@@ -63,7 +103,7 @@ static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
 	}
 }
 
-static void __init zero_pmd_populate(pud_t *pud, unsigned long addr,
+static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 				unsigned long end)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
@@ -78,14 +118,24 @@ static void __init zero_pmd_populate(pud_t *pud, unsigned long addr,
 		}
 
 		if (pmd_none(*pmd)) {
-			pmd_populate_kernel(&init_mm, pmd,
-					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+			pte_t *p;
+
+			if (slab_is_available())
+				p = pte_alloc_one_kernel(&init_mm, addr);
+			else
+				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
+			if (!p)
+				return -ENOMEM;
+
+			pmd_populate_kernel(&init_mm, pmd, p);
 		}
 		zero_pte_populate(pmd, addr, next);
 	} while (pmd++, addr = next, addr != end);
+
+	return 0;
 }
 
-static void __init zero_pud_populate(p4d_t *p4d, unsigned long addr,
+static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 				unsigned long end)
 {
 	pud_t *pud = pud_offset(p4d, addr);
@@ -103,14 +153,24 @@ static void __init zero_pud_populate(p4d_t *p4d, unsigned long addr,
 		}
 
 		if (pud_none(*pud)) {
-			pud_populate(&init_mm, pud,
-				early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+			pmd_t *p;
+
+			if (slab_is_available()) {
+				p = pmd_alloc(&init_mm, pud, addr);
+				if (!p)
+					return -ENOMEM;
+			} else {
+				pud_populate(&init_mm, pud,
+					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+			}
 		}
 		zero_pmd_populate(pud, addr, next);
 	} while (pud++, addr = next, addr != end);
+
+	return 0;
 }
 
-static void __init zero_p4d_populate(pgd_t *pgd, unsigned long addr,
+static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 				unsigned long end)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
@@ -132,11 +192,21 @@ static void __init zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 		}
 
 		if (p4d_none(*p4d)) {
-			p4d_populate(&init_mm, p4d,
-				early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+			pud_t *p;
+
+			if (slab_is_available()) {
+				p = pud_alloc(&init_mm, p4d, addr);
+				if (!p)
+					return -ENOMEM;
+			} else {
+				p4d_populate(&init_mm, p4d,
+					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+			}
 		}
 		zero_pud_populate(p4d, addr, next);
 	} while (p4d++, addr = next, addr != end);
+
+	return 0;
 }
 
 /**
@@ -145,7 +215,7 @@ static void __init zero_p4d_populate(pgd_t *pgd, unsigned long addr,
  * @shadow_start - start of the memory range to populate
  * @shadow_end   - end of the memory range to populate
  */
-void __init kasan_populate_zero_shadow(const void *shadow_start,
+int __ref kasan_populate_zero_shadow(const void *shadow_start,
 				const void *shadow_end)
 {
 	unsigned long addr = (unsigned long)shadow_start;
@@ -191,9 +261,229 @@ void __init kasan_populate_zero_shadow(const void *shadow_start,
 		}
 
 		if (pgd_none(*pgd)) {
-			pgd_populate(&init_mm, pgd,
-				early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+			p4d_t *p;
+
+			if (slab_is_available()) {
+				p = p4d_alloc(&init_mm, pgd, addr);
+				if (!p)
+					return -ENOMEM;
+			} else {
+				pgd_populate(&init_mm, pgd,
+					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+			}
 		}
 		zero_p4d_populate(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
+
+	return 0;
+}
+
+static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
+{
+	pte_t *pte;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = pte_start + i;
+		if (!pte_none(*pte))
+			return;
+	}
+
+	pte_free_kernel(&init_mm, (pte_t *)page_to_virt(pmd_page(*pmd)));
+	pmd_clear(pmd);
+}
+
+static void kasan_free_pmd(pmd_t *pmd_start, pud_t *pud)
+{
+	pmd_t *pmd;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd = pmd_start + i;
+		if (!pmd_none(*pmd))
+			return;
+	}
+
+	pmd_free(&init_mm, (pmd_t *)page_to_virt(pud_page(*pud)));
+	pud_clear(pud);
+}
+
+static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
+{
+	pud_t *pud;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		pud = pud_start + i;
+		if (!pud_none(*pud))
+			return;
+	}
+
+	pud_free(&init_mm, (pud_t *)page_to_virt(p4d_page(*p4d)));
+	p4d_clear(p4d);
+}
+
+static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *pgd)
+{
+	p4d_t *p4d;
+	int i;
+
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		p4d = p4d_start + i;
+		if (!p4d_none(*p4d))
+			return;
+	}
+
+	p4d_free(&init_mm, (p4d_t *)page_to_virt(pgd_page(*pgd)));
+	pgd_clear(pgd);
+}
+
+static void kasan_remove_pte_table(pte_t *pte, unsigned long addr,
+				unsigned long end)
+{
+	unsigned long next;
+
+	for (; addr < end; addr = next, pte++) {
+		next = (addr + PAGE_SIZE) & PAGE_MASK;
+		if (next > end)
+			next = end;
+
+		if (!pte_present(*pte))
+			continue;
+
+		if (WARN_ON(!kasan_zero_page_entry(*pte)))
+			continue;
+		pte_clear(&init_mm, addr, pte);
+	}
+}
+
+static void kasan_remove_pmd_table(pmd_t *pmd, unsigned long addr,
+				unsigned long end)
+{
+	unsigned long next;
+
+	for (; addr < end; addr = next, pmd++) {
+		pte_t *pte;
+
+		next = pmd_addr_end(addr, end);
+
+		if (!pmd_present(*pmd))
+			continue;
+
+		if (kasan_pte_table(*pmd)) {
+			if (IS_ALIGNED(addr, PMD_SIZE) &&
+			    IS_ALIGNED(next, PMD_SIZE))
+				pmd_clear(pmd);
+			continue;
+		}
+		pte = pte_offset_kernel(pmd, addr);
+		kasan_remove_pte_table(pte, addr, next);
+		kasan_free_pte(pte_offset_kernel(pmd, 0), pmd);
+	}
+}
+
+static void kasan_remove_pud_table(pud_t *pud, unsigned long addr,
+				unsigned long end)
+{
+	unsigned long next;
+
+	for (; addr < end; addr = next, pud++) {
+		pmd_t *pmd, *pmd_base;
+
+		next = pud_addr_end(addr, end);
+
+		if (!pud_present(*pud))
+			continue;
+
+		if (kasan_pmd_table(*pud)) {
+			if (IS_ALIGNED(addr, PUD_SIZE) &&
+			    IS_ALIGNED(next, PUD_SIZE))
+				pud_clear(pud);
+			continue;
+		}
+		pmd = pmd_offset(pud, addr);
+		pmd_base = pmd_offset(pud, 0);
+		kasan_remove_pmd_table(pmd, addr, next);
+		kasan_free_pmd(pmd_base, pud);
+	}
+}
+
+static void kasan_remove_p4d_table(p4d_t *p4d, unsigned long addr,
+				unsigned long end)
+{
+	unsigned long next;
+
+	for (; addr < end; addr = next, p4d++) {
+		pud_t *pud;
+
+		next = p4d_addr_end(addr, end);
+
+		if (!p4d_present(*p4d))
+			continue;
+
+		if (kasan_pud_table(*p4d)) {
+			if (IS_ALIGNED(addr, P4D_SIZE) &&
+			    IS_ALIGNED(next, P4D_SIZE))
+				p4d_clear(p4d);
+			continue;
+		}
+		pud = pud_offset(p4d, addr);
+		kasan_remove_pud_table(pud, addr, next);
+		kasan_free_pud(pud_offset(p4d, 0), p4d);
+	}
+}
+
+void kasan_remove_zero_shadow(void *start, unsigned long size)
+{
+	unsigned long addr, end, next;
+	pgd_t *pgd;
+
+	addr = (unsigned long)kasan_mem_to_shadow(start);
+	end = addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
+
+	if (WARN_ON((unsigned long)start %
+			(KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)) ||
+	    WARN_ON(size % (KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)))
+		return;
+
+	for (; addr < end; addr = next) {
+		p4d_t *p4d;
+
+		next = pgd_addr_end(addr, end);
+
+		pgd = pgd_offset_k(addr);
+		if (!pgd_present(*pgd))
+			continue;
+
+		if (kasan_p4d_table(*pgd)) {
+			if (IS_ALIGNED(addr, PGDIR_SIZE) &&
+			    IS_ALIGNED(next, PGDIR_SIZE))
+				pgd_clear(pgd);
+			continue;
+		}
+
+		p4d = p4d_offset(pgd, addr);
+		kasan_remove_p4d_table(p4d, addr, next);
+		kasan_free_p4d(p4d_offset(pgd, 0), pgd);
+	}
+}
+
+int kasan_add_zero_shadow(void *start, unsigned long size)
+{
+	int ret;
+	void *shadow_start, *shadow_end;
+
+	shadow_start = kasan_mem_to_shadow(start);
+	shadow_end = shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
+
+	if (WARN_ON((unsigned long)start %
+			(KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)) ||
+	    WARN_ON(size % (KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)))
+		return -EINVAL;
+
+	ret = kasan_populate_zero_shadow(shadow_start, shadow_end);
+	if (ret)
+		kasan_remove_zero_shadow(shadow_start,
+					size >> KASAN_SHADOW_SCALE_SHIFT);
+	return ret;
 }
-- 
2.16.4

