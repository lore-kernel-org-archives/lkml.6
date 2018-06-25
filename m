Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E1FC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4F925E97
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WlOUtgOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4F925E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbeFYRBp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:01:45 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:27942
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932981AbeFYRBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMRalR7u5eZNVWOFhJkOnmCFa2U1+P2jp7PPVhRfLwE=;
 b=WlOUtgOyyrtTH+BSH39TevaMIl/w909OqgILbKvhE7QL4djFA87bRZ9oa/Hv82IpMrxTjvrXOQcMFhBGGvrXBG6uMpk6vaTxmaatvYHkFNptxg9YVCq10/vp8oy211Xr61RZf4pcbbBQs2t3QStmxLLIfpKWT/ZeEa286GL7Exs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (195.214.232.6) by
 AM0PR08MB3249.eurprd08.prod.outlook.com (2603:10a6:208:5e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Mon, 25 Jun 2018 17:01:37 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH] kernel/memremap, kasan: Make ZONE_DEVICE with work with KASAN
Date:   Mon, 25 Jun 2018 20:02:59 +0300
Message-Id: <20180625170259.30393-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::14) To AM0PR08MB3249.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e41344f-77a5-469e-fdf3-08d5dabd50d2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;3:WxfARI3LQ4ex0C/DmN8qB/sVLpD2mI+Re2/PwYtWo3Y9v28sEDSMRBz1BVZNbQrdyFdqKqxw08DSAbOiGOgfE/27RzZhAjeM9rnkgdwwPYfwIc1Su5i5CF0UfFmzKT2QM6dftjjAYbM+ykRjX+8P35pygS1n8b31CrcmFMWvZMCt6DaGLLNYb+hr8WQm6k226IZhH7ywwQfRfsYveWJ2FCj5X/WdN69850KrKQ/VMHsVGTV6qkJS61cGM4Q8pakm;25:f5SWip4EisMHp1cH/3VjsuNgnEjadg+Z7eNzPB33N2TMqoc7KZlfiEe25jusmTsslDNZq9UVC8tqaWDv2N9pl1ue7CHWdziI3oId6qr4ZdZAYOc5njuaDDp/ohDRK+UcKRY3xlbh7/k1RSQ/gxmXsG6s7G7vN0iNSC8g63JQyzZOdQqurg76d1UnTp9Y/gIKf++2ZSqO23xsS4ZzKt1R08PXwMrm5nb7uDuG2m4zw+k0LqUo1s9H4bx//4kVHMga4i2dojMKTYwND9n47xaYwRtCaQPcRszNOHkbOKA/N97DB4lOhnGBhkgaJgnfHQyukWL+PfHSANjwSvynh9oqMw==;31:Fgb68hx0HYAFulcFmI5kge6ev5bA73IlVxxYLcoW+iAg57s8sQHLSJTrEwdml9dvTmFBkliOnfYFUIFy/tqVdNWMJuLyun78OLzYnmJdI1N6Ti7DrWKbBwUyMieZb3TXRqQ0OkbJir011HzQWwPWzt5YSiCjQuiO08iFw9V4bRWNL3Og5DE9CTlD5Q3AyC97fc/2s/JNvlRimRTSIR6nsrSGZNUL02kkNNFnQGnGI38=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3249:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:uxbpcdsTThE5CrGJ13ynEKf6/b8Kyaqc22xFrjZeLOc9pgw3APHOiUdfcSX1xbbMfur2tuL5Ws+gIqRLWOcDg03uJuGn4jgn4CGzMA8vkx2PD6wOGscyJpTSux7WJinl6SJm+KpIG/hniMQVfbllkr0jmgPJCz581MBMO/l3g/nDha0Ozi/yQlgJi0BU9RRx11TpDIyvb7iBv62Jt1cZ8gZiVbd4RHH4pwfLHlf6Pl/tHdE5s504SKvlVzimAVtW+ED/LPofMJyET+dNhcuBraeC3N90UduI+Y16+hhsdJXw4U+qR6SSjU52pP4fBHLRfw5HagLcuCJX2BWrtg44qniZ7jIhDWruJLl3MV0lA6fpLtJZoMON0D2qCemwGNhEupOTRQxPbWh4jDY3YNZLqXTF6Kn1WAAnoNTIxLFVSyhxr1QVbrpPjahUtjCfh69HydYja2KgzA7qGU5YNTvRsPbZ57P85A1le+1LwINSejA3gVwlnN0ROCCkEz0jI6X8;4:lf89HfTgJbmQrFdaMSJcn2H7g1ApB5C9Hqun+Y6UNRPmK2Q8JbU573YdmJlzXXREVR1q85IaXNir8yLpaOZbhc7e96ap3OMJSqD+LOXNexvMZMXT97mHMNyCouEu7we6gJqKAHwaZPkYDeQU5WBN/oH7SCJWkQsMmYiMCBeP1L7djMXdlIzWq1g7Ydis7Hv7zgQVIkYrrHLYka+5O7JJrpu5CfX/oj0+xOw03Yx13/8L4xLWyPqlgsd7Ciw86z0wPak9BHJlUPu8k0ecKM09HKqeWGVjnCKg1Wmxm50eBcSSNF5WmE3Neo0rQ5mmOcQt7narY/s7Dhz1yoiq5s120DGC04qE817HFhbpPFghZbW/DlJ8I3e7rUvh6mRDlAfp
X-Microsoft-Antispam-PRVS: <AM0PR08MB3249FBE80400D9C90358BABDB04A0@AM0PR08MB3249.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3249;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3249;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39840400004)(376002)(346002)(39380400002)(199004)(189003)(16586007)(36756003)(316002)(478600001)(105586002)(97736004)(25786009)(2906002)(50466002)(48376002)(54906003)(106356001)(575784001)(86362001)(8936002)(3846002)(1076002)(6116002)(14444005)(5024004)(6512007)(81156014)(7736002)(8676002)(305945005)(81166006)(66066001)(26005)(486006)(50226002)(53416004)(386003)(53936002)(55236004)(6506007)(16526019)(186003)(6916009)(1857600001)(476003)(2616005)(68736007)(6666003)(956004)(5660300001)(51416003)(6486002)(52116002)(4326008)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3249;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3249;23:d1ATXJ0SSX4RF2DLTZsBqb2RoPuNXu+x6e/YHWjKo?=
 =?us-ascii?Q?3AGPMycKWA9s/CEwG08RqcLE81M1XADQCqVtFDLqsPH2Tj0IYTI2Ro3MHiJT?=
 =?us-ascii?Q?BqGQPM2aA9qrPgmQP7MnlXSPPNHAuSkpliOxhie33+w8N7d27r8g+HAfK54Z?=
 =?us-ascii?Q?VbDnHScLvUT4mUhNTGK4wCEnoxZHPYcqr8HiGjFe4TPfasjOg+s3+luF0nRl?=
 =?us-ascii?Q?t0wIqNjlwyEFvdkv4guLvMzUl030GTpiBpYRM4Nvh+WNLXuPpCmd45VOTQ0n?=
 =?us-ascii?Q?JImRpPj0G+lzqUjFkKGE4jd1oynMg9ws+nXEgDuEJVDTon69FB+kWXbENPTn?=
 =?us-ascii?Q?AvKyEfSMzTVo2or8N8XiU4LF44vkgLH9CIqcQX8VhyuUA+x2X2iJ2P051Q/4?=
 =?us-ascii?Q?8nWM+dlzpoGVqz1E+U5f0f8Rv1veFF1467aX9d4uj6Hq7/CO7gdEjQDkQmVe?=
 =?us-ascii?Q?C6chEhasI0PSo0K6PtmrLj5zeAyir+WuVXUP5F2PdEb8raCE46TJMjuQTBjD?=
 =?us-ascii?Q?Tk7NWsdqSscviweo2NnqFDJQ83t/DAr/b4SuE4CBIdXZ4txKReX0OhGW+XPU?=
 =?us-ascii?Q?d2eOXsa2bIyD3RUZd0gqSwcKV2eoX1UgERx1yc8rbsW/GGMve+Bngj8+sKtK?=
 =?us-ascii?Q?AdUjTVBGeisrOBFZOwzN/fWPd+3p5le2aR69qBn0eOB9MTb7dEMTBusZ+RGR?=
 =?us-ascii?Q?r3gb+q0c472s4JZZCPvZ4t5axFwU2wK/LCoA7/aHVj5X6PjwoMrGFChwlYAE?=
 =?us-ascii?Q?SVMZQVbPNRHExjdxrIzkB6x5lSGUK+XKItHFkmRCumFuxmpWQA/P1jXB7NDg?=
 =?us-ascii?Q?R/pPqDVIe6P/gQmLv665WJaJmDDdPDBYw8f2D2bHF++jGHlfn8iGoFGjCZBI?=
 =?us-ascii?Q?J7EZ6Rkxj/aqSZt+4HsFbPRyI28kwmY8f+FtTdNKjJ7BaOgyNGTxLZOTkH50?=
 =?us-ascii?Q?TJWyKp4tLIIL751WXeEZLK2uPNvVh1DPCT2m7MAWkJM87c3hKBhEJaPzItH2?=
 =?us-ascii?Q?QoVdteQVFAByr3i55EDIAwbEpX8z3RE/5K2sbUeZbRs/DrRvyNj/1ve3PqV5?=
 =?us-ascii?Q?dVafZW3mt62d47v1FCPprwVZAixh6Q4NsUq1MyjzVc6A7nzoUvdkOpPJQR4W?=
 =?us-ascii?Q?T3Ln1Zj4CnMOccKF9tRysoHVAVZt1m1aHX/sjQKoEjtC3Ycr0AkqOwSY4pad?=
 =?us-ascii?Q?FsFKW8Vj1ZS35E95Ap0ms6mJQyRxUmpNwscDe5GPdPSx/57Jd1axnlUI7JKo?=
 =?us-ascii?Q?gEFo77EE3Uc1cSK57VPwQq4mpY7VqSYEUa4rgjSV0dTDKxsqmNNaPrbY4EZB?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: mTyG/9NQw8/tfetj0OcUvF3g2rlLkhiWNPi3HxKgnbQtx9WHMIHLGXf+v3IDJfp6bBK8dJcJcjZd/fQ85XTmDTsIJEW9Cr9xHX01jy6HOVgi9FdU3DgjOwS6SEYzREz4U+Hqyq8YtigxrUIPHg2MyjIQq6WKqBt0e1cR0uUwa21p79mIIORC0PT5UnBmugSowMyePOE3AZBVonar2LGH7kjTZipCXuPV60ag9f+CmSsoE6I2JFJT2QzcF2Mj6PTiglYIAd/wwVoCtQm+G+LtpnIF3e2WKXeDg3aa1HVchkH7gFQ4bYx2p1vJNVHpOwKw+iTiVlmSTJWhnIsuzIc9Bet8OKgUI5RUw/47TWNuAXs=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;6:SAA4v2nbocMOvUT0sfjwi18HwKwIIebA9f+jV6RETjQtoRdOaVQhzkAaZYWlnNixycisvKjPtWM1ur8zsTVFWNwhagGzhW9Cx0Kqfn0DQSE6aT0ksJbQoWzmanpk3LEBWcIcT3Em7rokUejdxEmFJsfGve/wgEcERQP9jpLRgKkGkCkYj3nMB4NK5zArniwX0Vr3q2QScVwCt2bbijEUC9C1gViaZM8gnz289gaR/mNafm7Gw2LEt1Fm1LYsqy0Tphrtg/nyp4f4odL57eNBe0CQVLnlgOF2lE2OCV9aB2sSKAcybwzb4b5RIBvqJ4QKwtEWM6v4a8X4QkD0ehjP5rKeusbL87nVPFxAEzmj2QFlfugBGphS4BrJWe0BjBY2GVEh1r8w0oC99UIXT4WLc8f3VcnohvU9NKpC74yT4XhC5G+7IqeEJB1pJU0dDWdXoPsAejiuUTJ3wdcbduLlyg==;5:Mw5dGrRCg1yWjJfnAXbk7ko27qlYweB2uAAPNf2akdf7ZhFZfsbVAQ/nQCUGdnafyo7fQ38oDvystzGXccvZutVfbH65a8Iyczt/CwUhRJQ1OB+t2qC23am1lMcGWndt2O5Z/nkZejq9yT9iLTDdsNCosu+IM4KErl+MC0mA+PA=;24:kuYomzcYrny1xdiRlcfrcmU7Z612mnhxmcE6nAX7RLhEfjKpEVboZHifAeYOql+FZExDFgpdsQ3rX69cGcrppMY7JyGEbwbXw02YdbdRyHI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;7:IZjeu3d0Xseu1K0sjRM/GoW2IaJF9eekO3ZXRgooNurhjgaL1CgP+qS+9NHJQAdQvFmF7QSdePY6g3TNg5lSigxvuHMYMJQoGQPD0Bu/xDvamjq4wGwAlrEy+QEyhCCFnhw9DSFDpvGf0HF6tQXu1vb6z+WSQPruJQ3Sdkleql/17GDZZFbDr9jbjINQ9gl6V4ppmq6eqRg0N9yBA34JQX+Cenu185ARQz6Ag3+kvnu23cbxzEHOQirL/Ljbo/X0;20:5vT0GQOUiL1ImPt+5kMQv710foXijVsi85S/HvzR5PaT3P9YQBkZ64PfoR2Bf1PTomlOOHtD+Y36j3k5/F1K7IdjvQVHDM+rsz2oCNZYvSoUsyg6hBysLrcsty7ppk//EtMFVrvyEIBS/3IvvIg4iScSKjEgExewLACdAWb0SFU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 17:01:37.5753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e41344f-77a5-469e-fdf3-08d5dabd50d2
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
index f436246ccc79..3ae77df8f414 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -21,6 +21,8 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
+#include "kasan.h"
+
 /*
  * This page serves two purposes:
  *   - It used as early shadow memory. The entire shadow region populated
@@ -32,22 +34,59 @@ unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
 
 #if CONFIG_PGTABLE_LEVELS > 4
 p4d_t kasan_zero_p4d[MAX_PTRS_PER_P4D] __page_aligned_bss;
+static inline bool kasan_p4d_table(pgd_t pgd)
+{
+	return __pa(pgd_page_vaddr(pgd)) == __pa_symbol(kasan_zero_p4d);
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
+	return __pa(p4d_page_vaddr(p4d)) == __pa_symbol(kasan_zero_pud);
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
+	return __pa(pud_page_vaddr(pud)) == __pa_symbol(kasan_zero_pmd);
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
+	return __pa(pmd_page_vaddr(pmd)) == __pa_symbol(kasan_zero_pte);
+}
+
+static inline bool kasan_zero_page_entry(pte_t pte)
+{
+	return pte_pfn(pte) == PHYS_PFN(__pa_symbol(kasan_zero_page));
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
@@ -63,7 +102,7 @@ static void __init zero_pte_populate(pmd_t *pmd, unsigned long addr,
 	}
 }
 
-static void __init zero_pmd_populate(pud_t *pud, unsigned long addr,
+static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 				unsigned long end)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
@@ -78,14 +117,24 @@ static void __init zero_pmd_populate(pud_t *pud, unsigned long addr,
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
@@ -103,14 +152,25 @@ static void __init zero_pud_populate(p4d_t *p4d, unsigned long addr,
 		}
 
 		if (pud_none(*pud)) {
-			pud_populate(&init_mm, pud,
-				early_alloc(PAGE_SIZE, NUMA_NO_NODE));
+			pmd_t *p;
+
+			if (slab_is_available())
+				p = pmd_alloc_one(&init_mm, addr);
+			else
+				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
+
+			if (!p)
+				return -ENOMEM;
+
+			pud_populate(&init_mm, pud, p);
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
+			if (slab_is_available())
+				p = pud_alloc_one(&init_mm, addr);
+			else
+				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
+			if (!p)
+				return -ENOMEM;
+
+			p4d_populate(&init_mm, p4d, p);
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
+			if (slab_is_available())
+				p = p4d_alloc_one(&init_mm, addr);
+			else
+				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
+			if (!p)
+				return -ENOMEM;
+
+			pgd_populate(&init_mm, pgd, p);
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
+	pte_free_kernel(&init_mm, (pte_t *)pmd_page_vaddr(*pmd));
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
+	pmd_free(&init_mm, (pmd_t *)pud_page_vaddr(*pud));
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
+	pud_free(&init_mm, (pud_t *)p4d_page_vaddr(*p4d));
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
+	p4d_free(&init_mm, (p4d_t *)pgd_page_vaddr(*pgd));
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

