Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2768AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DA520C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CsxLWjgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DA520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIYP7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:59:35 -0400
Received: from mail-eopbgr70133.outbound.protection.outlook.com ([40.107.7.133]:4416
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeIYP7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N+D9X37VP78BUnv/CUpmF7NSaNUpYn7PWoTyU/rw9M=;
 b=CsxLWjgzcT/ay3GOImdAQZkxisil91Akq+Z9ec+1S6cfyuFZT0C7VsYmZbRyonVSJqRO+fwFpU6BbE0P2SUrQs5+CfRCNFggYy3ks9eEfvPjFazF8Xs/8Ht0j0qDwkFzGU0yghSIevmO63LnufFixgn3fdrgA7LuHHgGYpJLVeY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2030.eurprd08.prod.outlook.com (2603:10a6:800:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 09:52:45 +0000
Subject: [PATCH] fuse: Fix use-after-free in fuse_dev_do_write()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, dvyukov@google.com,
        syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Tue, 25 Sep 2018 12:52:42 +0300
Message-ID: <153786915356.22029.14929917223689579717.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR08CA0076.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::47) To VI1PR0801MB2030.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2dc89e0-4328-4214-f1bb-08d622cca51a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2030;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;3:ab2JCeu5u/wgFrSpcwX/iMEPHwQ6WoUI2iY9aLASmDG6DLEYbxMV/DLG8QMF6zia6GHCC9DDnjIiJwf4lExMxJ6ULN2VvQ3S/RLVi4257GTkSZlSt8B5bvzjSX4OX9wb8FU067T3PD2P0L4GfegYjNMT1PeHJqHdqXOIbWJKFhGAI5E1cY59/xSpyOCMrklJUm6ix2nQHSoHOAUwtNAVZNdUh4jE6BnyM+g8gtTBTyQ5AaXd60LXW4PiA+DQkf6M;25:7T6Z/0ueg3rtjVc0thiXJMU49ue1bIXW0RhaXpTbydea5qEGXQEUxWtGSWY1/51357JAHqIF9I8oc7bJVxMGGNlwiqzLzql/2ZlJYWtvxzlb+UiV1uLIPYPjn+7JEXjZ6SebkQYCFQEgtpQ1MKZluG6THnBIPddeb+O8nTz5mGOXDV/sdWtstnPj1GcexTiRK9YEjSRo4RKcKvb6YzFXG6jWk4ekB3SF5KbnMaLas4zQP4c/+bltkxIEq+MN3PVZh1w5uayZgaTGr40WLpLs3cwhS1IDBw4ngbnN5YBA34h/SvoElkBJJ0WXtyrIgJCWJBICkDmK9NtTnTjCF7keyQ==;31:d9cR7sJFvRC8MiHNWDmBvAF1f2m8/HZm3OsHEIFGWZB45ZQelUEDFgMCkG5M2mTUasb6w/EDc6rBhDCF8RGV4GtKuyRE2sWxh76rQAoASdLkKCrFvN1VwbveaqSwhXsBPQ/qpH1dvbL2A8EV7fGS1mB4IYmZmTwLOyWDxn3pgW7OiQpFzVTHc+1zm0U0vns0YxpUWJlN2GIODOpifnGX40z5E12RvXTuf0+6UqlVJCM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2030:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:heKhGrWsJU43i2kouaWn6yJRH7OwBn9QzWNQbVSIWiItIi7+4iEiD9xYi1wpQRbIAieyo0Qju6kUYEY0jWw43oJXsKCriiKDQU/jOp1Vq5Lk0cfsiRf7sUSB/yFvVOicfckmdYmEKj3MNmXT+/DOQJscXfj3iS7UVtuuZq8h9Cgv7U5sdNoaLQHe1Mq5hDusncG5fBfv9Ql+qOuP6fnKs+YZnc8UOos0eYxoKoSVbCBYek0ujIBo6zfma15GNTir8aaX4dwqIc+X6sPKl38HDub7eyHtsfn+iSAwft72fbKyHF51G/HS8g/AUDzovdlqdLRxpe9jexX/IKlof3e88PMfwvxZJZOqrM2A8o9KsgFxbCaNBvAit+Q7vQFkgfcwVXRwz3qi1wQ+gEnCcntX60O7HY7n5Ja1zdsNesHC8pEihagWuNIyyTJxaDS0FqB5im0DhePxXEqV4kJUk18vRQkNHudDpU1s5YuB5Ih/bahKxXma5Qu8xaGPoNHv+WEQ;4:MvpEtIyoqsG92pKTHPybFuxpyvBNHJCRqr50D3Y7vTOzTe+DzfLyLxv5z6AG3JjYUEkIEkUjAoSAGigmDz3O+PabYVpiP3OlEZQzWdiifHEWgGo+176juksQqbyQDInsRvAB1sPvWuowSAFUjMhHupFh5owprCgKPNRQUKkRjfovOr7e9ICChiqwOU/q0YHaUKQvmJR+/SBi4LRRk0ocOzjfR1me5rPVOSIzKge8lxPjaO7BrXEfF31NPnkTHoxeKkp5LsVHZDL0NE06Pq+ukA==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB20306BCD52FB0F5C4288C550CD160@VI1PR0801MB2030.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR0801MB2030;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2030;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39850400004)(396003)(136003)(366004)(189003)(199004)(58126008)(6666003)(186003)(55016002)(16526019)(305945005)(9686003)(14444005)(5660300001)(1857600001)(7736002)(3846002)(6116002)(386003)(61506002)(66066001)(26005)(68736007)(478600001)(47776003)(316002)(6506007)(97736004)(106356001)(7696005)(86362001)(25786009)(230700001)(105586002)(476003)(33896004)(52116002)(486006)(23676004)(2486003)(81156014)(81166006)(8936002)(956004)(50466002)(2906002)(53936002)(103116003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2030;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzA7MjM6ODgyOGJkZFczM3Fici9nd0VnK3dJNlNK?=
 =?utf-8?B?RFgwQkpsU21lN255a29FU0ROaTBlZ2U2ZzZpK0hRR2NTaExIZjEyR1hYeG5v?=
 =?utf-8?B?aTF4UEpBaUFzMm5RaFhUTGtsbURnOTBlWUtlRWl3MHROdkJvOUZhWFQ2K05k?=
 =?utf-8?B?Q1pMNTV0eWxwS0lQbUJwS2pOdlNBdGVqU3c3VHdheGs5SnU3NkwyYS9NcE9l?=
 =?utf-8?B?eWI3SGpvSnkvMTJqa2t0QTYzR2JWdDcxOVExSzV6MTZDclJHYU5ibVpiaHUv?=
 =?utf-8?B?dW5meUZIM09jdTErU0ZXUnNUcTgwUnNoOW8rTURBUExGaW01Zk5ZaGVWdTBV?=
 =?utf-8?B?TnBOM0k1SWMrRFo3TDVOSHN0cU9WQlMzd0tCWEx5SUhUUit4VW5DajVuYWpJ?=
 =?utf-8?B?WXhEWDJVT0UyejQxY1JyUUhTVVNOYUN5VzJrcHZqaXM4bEcvdy9la2NiU1ZQ?=
 =?utf-8?B?Y3FLN0lzZ29SRUg2QnZGSVFvYjQ5TmtnclY3UHBKOVE2ZmF6WGRPV1N1UGUw?=
 =?utf-8?B?QWhMVnorL1EwSTNPRnk1NFo3TUpqb3FjTFMraWRTZDJrWUdpZTlSOHViWEgv?=
 =?utf-8?B?N0IyU2dnb1ZLNnZXaXRORitva0hQcjBOV1lGWXVzOTg0REdsTUpsL0prQUYy?=
 =?utf-8?B?M1FRTnRpYTYyY0ZFWllmOGw2blMzTWpJUzdBY2EzalcyWlNyWlF2NmdmTUgr?=
 =?utf-8?B?ejhnRUsyN0pXQTd5NktmdUZLVDdRMCt1ZGNORHBEN0N4T3Y3QVAyOUNvSWlv?=
 =?utf-8?B?UjhxOXJqY3lveUdPRTd6K21hMW4zQndydGlCY1c4VmV4RndUeTNMUzVzR1NV?=
 =?utf-8?B?clFwRTMvT0hMMmUydDNzZnVKUzNMYi8xcXMrRjI0UlRxb205YlBpQ1JHbFlK?=
 =?utf-8?B?ZDdaSzJ6T25aOVJhSW5acmdjbzZ5UXk2Nmc0dUVhbjJqUUIrT1NpaVJNdjRY?=
 =?utf-8?B?WElPUVM1QmorTm9GdDVwa2hUZlZJdVRGZkxSRy9EMHVlL0VUczEvSGRNOC9I?=
 =?utf-8?B?UVphRTJ1aHAyVEE1RG1ic2VMNnFrK3hld09ORGhnU0dKYWRhZCttNDRDR2Jk?=
 =?utf-8?B?N2tPZFU0eklzYUdDSVQ3dk0yUUozK2ZuZWFJMHFZaXp6b09TMUZlc3V0cDZq?=
 =?utf-8?B?d0gxWFk0UzQrTTJBTklKNUg2QkUzNDlsdDFXeFNyYlNBV1JhN1JJUUxXQnBG?=
 =?utf-8?B?NTRxUGY3SGtoVlhLa1JmUUJQeGtQMFJSY2NrU1lvTGN4cHBiQm5YclBYdDFB?=
 =?utf-8?B?RVVaamxnUWVrb2lhN3RXbE9aMDBXYzBQdWpSaHpMY01Sb09SakhLMFIrLy9R?=
 =?utf-8?B?VkdBbjlVK2g4T2NKRVQ5Znp5alZCV1pUdFpOY0hSQ0lrQXBwSjVWSXE0SVYv?=
 =?utf-8?B?cTNnUDE0RlplVTFSTElkVm5UaHgyWWlTRExrZjFjZmlnL3FvVU9hajlBL2g1?=
 =?utf-8?B?bzlrVWF2cjBTMHFPTTRmcnZWSEhabHFNc3IxejJtZ3hGcGN3U0ZMTTY2K2s4?=
 =?utf-8?B?M3o2MjEyeW5pTWxBem56MWdWbmNsblVpRW8zejQxVFlFWUpvcTI0eTZPZm82?=
 =?utf-8?B?REdJMmxRTGZzMVp2SnFaTUw5WnQ1TTZ3QWhpa3phRlRFUzVCT2pzM2c5djBl?=
 =?utf-8?Q?k=3D?=
X-Microsoft-Antispam-Message-Info: H1kB8k5J5XvQdg4tIZl7b4UawWN9TlnQK3N8ry/xCXscB6OXM6vWa0ldaSdOPX/d16Vx7X2yiBvbaMgcsBKf7zpcNGOaoabwpaD2GTQdPfjVGyByC8wJABUWrI5Sl25Y/0Fd2PQiGtTYxO4Jf3Xlthq/LSlfgJ5jWeRh5IEx1knReo7iF9Txqq9f/0vbM9L+4LWyg9pii/YCTO+9GY1JtBAnAt/LHrYmrcWjsnkdUyM9ypu5t5oSyrslpZ+KM+gPezuOzwGsPBFWgLSk7TMXGRIcqh1O4agvrcuWDTa3L0Hk92BW3AYvpdISvypBvSbKTG+5JWdUxK22Axj7idzq6qrThb2WABLwEdM7e1NnUp8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;6:nulm35lXagZ2udmXTnKF2TXm6/bx8+csB9W0njJVpl0zsMF0NRhJIR9jOjcOETiLyjjlx/JdpFJmEi7VSDuDxfNMdEUFpS+9VdEGggQf2Zl1JWue/Uny0DKf8KAVdEFeVmDlsuG9n7SQf9mNpk71rObMYCLckVt3QP6N1fUcYFNuJSkiXt0ZDG3fvshKmF8w9PbJSTGursagHUF6ILs/iNZfL4oZp80V2N0soxycuqHlKsMbxlsa54cQoF8WBAgp0XnK/Y9Zl0RqCSA7ciNTOjxvfok/l7p8LM4SUBmP5oGxwdRDJphivj3Erb+vwo8RrXkaPtQd4jfTKwVxfYdyLwDKOu/Spazn60bUPYTcAu05+kKtN5m4vnM6/eanvTD8dz6mL27/buxTj0tYXSiA7h9CTLgi755qHHdyCZtNxDSeotvuOGV2gB3GGORWRChv0Qtk3vhnhMAKh6zgM2FePQ==;5:YE66tTaoikQ41/fjKBFqUEH0EAZVLTtcBdxnFbZfgyVZidIgpK3NnG298ObkHLHFefRpaoK2akFnUptDt0qmktQkO0xAFx9yavd4GIen8ykGTdbsEDa1u1PdrlFHXGB6BBJdn2bMEggtsrbrpfGvXe8dGV3oX0/YM/wta2hsCX8=;7:QOfdo3ku6+bT+NtN9Jc0ltnn8RKGGlHmh01Py0c9MYE4C5qY4yZntK/zqCIq1BxbuT+IK8WvNXV+6EEC06Kn9C3cj4nLFJWQA0w9f/X1HwgjQJdhmjgjJR8jYRAUHauFsaySTiec8j6fDUl+1z9O9/cDQqvSpRntdK4fWXAp/jfrDX/MFr9q1F5lxB5CexU+lf68UqFl0GCbE9qCeUwkoBgrT0P6hkaCTUFhZRpuNWYcTGU2swPJzlkbCyNdeQT7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2030;20:U3sqI0a1Q8L9RXU3UCXfti/l/j/oHuDGpRTIunPb3EcTZgeH/R0hXUSkD6aY2yOSCGUjP9qp+8Ax3BIhK75jjEPk3gOXDVpNZ+oM9pKeuIbp4rtjc3BWGlX4mqTyeF8nQU3yGwXfQ0sMrPWeXEKcwNlNCR4w7uSV0ws6NG22TFc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:52:45.1308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dc89e0-4328-4214-f1bb-08d622cca51a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we found req in request_find() and released the lock,
everything may happen with the req in parallel.

Keep it alive till we finish touch its memory.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 675caed3e655..c2af8042f176 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1877,16 +1877,20 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 
 	/* Is it an interrupt reply? */
 	if (req->intr_unique == oh.unique) {
+		__fuse_get_request(req);
 		spin_unlock(&fpq->lock);
 
 		err = -EINVAL;
-		if (nbytes != sizeof(struct fuse_out_header))
+		if (nbytes != sizeof(struct fuse_out_header)) {
+			fuse_put_request(fc, req);
 			goto err_finish;
+		}
 
 		if (oh.error == -ENOSYS)
 			fc->no_interrupt = 1;
 		else if (oh.error == -EAGAIN)
 			queue_interrupt(&fc->iq, req);
+		fuse_put_request(fc, req);
 
 		fuse_copy_finish(cs);
 		return nbytes;

