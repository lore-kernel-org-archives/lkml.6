Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBECC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AE920866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W4Tqi0A8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AE920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeIKPKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:10:55 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:22448
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbeIKPKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Cm/aDBz3hNxAAUv9j8pJbdD2t8s/8zLQKnQa/Vb33U=;
 b=W4Tqi0A87Md99Th7k+CsITBNZl29NwaNdKG18iLFKTs+mlz9JK9vMzdR+86kMpxU2+8KxtokaO0mWJd68lUbWWZDD/PESF7W8/94iP2WfFVRFrQeSP+73dJCsCSK5G9NszfW2qLP+sjqWpeYQV8tR6RV6+tUr6y86X9O5Ze0jwo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB2019.eurprd08.prod.outlook.com (2603:10a6:203:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Tue, 11 Sep
 2018 10:11:59 +0000
Subject: [PATCH 1/3] fuse: Change interrupt requests allocation algorhythm
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, kuznet@virtuozzo.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Sep 2018 13:11:56 +0300
Message-ID: <153666071673.19117.1104907275035187545.stgit@localhost.localdomain>
In-Reply-To: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
References: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0021.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::31)
 To AM5PR0801MB2019.eurprd08.prod.outlook.com (2603:10a6:203:4b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6044afe-020e-4208-643b-08d617cf0352
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2019;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;3:FG9NN48I5K3+jsK5fB3iqCl+/GYAnJ0OMWBLtUmieEZCBhBZ+eQLwU77yd7FzyHkx4D30QykfhWVeOZBkDmbyV3MkkbviYk1U1r+PG9XWAzYOJPBjHLxKarYGL2+4fFmof+CpQ/iSTaNWJncwHvx8UFS2TWVgSaFXYkLITSLOTsL1hpnO/m6R1bKRoGXoW7Ixk1VOjskhF9aX2x3SB/ffSLDrggYXKSbAoLKfhtoJC4pYof1DQjSajbX/Pkkyh4W;25:63LbuVq9HN+C1VPj8TKTvw2mXaBk3aXx71AKGjbSnmG9STr1C40xrXFj7PT+fCEX5r4Pt0L8Ibmgly9Vm3gl/tnzJQsIzTJ4mcCR8qvRyIHqFoLuSZAHXpgJtvVOEDNlWeg7oAT2TkoEaXh8eP2/SsAt3/A666VzRkXdNYUCZUNOOIASsqh8999+VcZzqMr30Shki+qiPgIrZeOuAKrc5Q41Rgo/iBMFfLMLWLwJLLbN6fog79JqbSinNVdo5ATS9IEc54ySNEbfVs0c/wXPdS8SLrOy1fdNnA0G9PERzUiuVsK0cl29btcQeEKxpgfGYpm5HjBaTKcQO6XxTFjNQA==;31:v2ZVAZnXyAKiS8Oy6JiZUeV7dqNyszJduRJYPSP678SrH5m7+l49go88kT+Icr0aymtPA8sgNBpQjUDkdK8VqPOJzKIqqwjOzIJY4wzLBx2zSpaIIcRw7PUZ2HVTl6+rYo7g38k8I64fndOgSHYepmuwGSNT2dMeWJ95++UAD6Qk0kpcqJTCxmsYrJiXUqA5bdV9UzNPSw39DE/P89F27WD3mlfHKPy5liixnCu+acg=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2019:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;20:jIoYe0XtwZZgYudPfqB8RZzujfS3N6PPQx2U80F1p+PQzfjHOPPlwE+dfgJ++DzK7i/3LlwC3/tkY4dxpBdwdvblve23seoAcCPSZSgyN8waXT3R3rGvcka92nw2bhJpH2VqygPJYlo/HYp+DxJ7AjvuqE/or+c3z7gvwAlv6N6iy8jegfEq9YH6kITVp7z4sCN9szXAC0oGGQzC2SQfMOkoD8g6wJXqIZdTQXVUJ34Osx6brkqFtPdrtERZ6uIrDilGdXc9A4nv8yl6L1yo5f4BklHSUCdi3v3fMBfydIn/yN0qTBT1HxMn9wfaJs04zQ2YdELYbxtJpKbqqsJIN0NO1F8MT0KpTxt56dKmjy06kGGbow/A3GDjEKSugqZe5bHdrxZ67UZEEc9MB+fyJu6Qc3r+5NoTegvvo7/Thl7M3C2jGZVbn95kiuuvxU4HrLybRUUadTtQsb+f7KdhbaY6RlhUA3HKrNhKpCYZY4Davl8TI/m7v+RimSKzrxGn;4:Uw4mydoJ2lDMQPKcDkszI3EM6Zjtu7IuyZ+LczCnGx4mMky4MF4KnnRymcOCFth+xWwCalGpm2STsKQ9MGkVBppesj/6yn00peanUu5OkqZK2WqBcCmImsqsScYAh9OeJvVVdWeqAH+h3/nTo8fSxDgQFKkAwusRYmyBl/OR4HU0MyWIO1yMe3OWLwTd+w/n/C4bm0DGGYyKoBXATxWTYo+2H3AyV+SAeuiPVc1NX/KOvZpBRGIdhvqbKnBLSUzLJl6HRvF2YYDnDrIIVpGIIg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB201902E18F70BC1507E8D896CD040@AM5PR0801MB2019.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AM5PR0801MB2019;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2019;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(136003)(346002)(366004)(39850400004)(396003)(189003)(199004)(97736004)(47776003)(61506002)(14444005)(478600001)(58126008)(66066001)(230700001)(956004)(11346002)(5660300001)(53936002)(7736002)(446003)(305945005)(6116002)(8676002)(105586002)(316002)(3846002)(106356001)(103116003)(68736007)(186003)(16526019)(2906002)(7696005)(486006)(76176011)(23676004)(2486003)(6666003)(52116002)(8936002)(476003)(50466002)(9686003)(33896004)(26005)(386003)(6506007)(81156014)(25786009)(81166006)(55016002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2019;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTk7MjM6VElvbzhLM011U2psYVVRTEVueXA2REVT?=
 =?utf-8?B?cVVta2JDRGdpdmxIK09wak5pbjVKWjlCakllVUJocXkyTjBkUE1CeGJ4MDhw?=
 =?utf-8?B?OUxnd3FybDE0ckRpMVBQd3hjaVNNYU9ONitsT2Q0Ym80ODBhclg4T3gyeFBm?=
 =?utf-8?B?TjBDeUt5VmREcm5mMlltcTQwUERSRk1XNElBaGtOU0FnTXhiOS90QXFUNUw4?=
 =?utf-8?B?WFVLRDd4aTNJMTJqRnVUWk1rcVE5N0VlM1ZMcW1URmNWdXRFVWpWNDk2Um15?=
 =?utf-8?B?ZXh5YXBZVlJYV0pvNmpKMVhQT2tPR0dzRzFVVkVCem1jZExMSlBZYVpnWVJj?=
 =?utf-8?B?a3ZzdG9TRVJ4OStEaURSd2NTSG5RUGNLR0d5NjdTR3dqUVpObW9mcHBXME1H?=
 =?utf-8?B?eENGM25MK2ZndFk3cEtHd3VIUGdFTGZiZFRXRGRtQlIzSllyUzc5YWpMUktT?=
 =?utf-8?B?dGhYRldmTE9zNkdiNUxLaUQ4RkFLRUlEdHU5QUp2Y25Xc2E3UFZVUUcvakc3?=
 =?utf-8?B?cU9mandiZHJMUkdwZ1lXRlR0aDV3YkIvK1h2SGJlU0F0ODZCMHowYXBZTDlq?=
 =?utf-8?B?dXRKSm9BZVQyU3NjeG81YjlUdGZyUXEydUVnRUpsTWJEOWJwd2IxUFBhTkRx?=
 =?utf-8?B?VHNQV3UzVGc1QURyVitFdHBJVDhRVjY1anMxTVIxSHVuSnpYMW92NTFraGhQ?=
 =?utf-8?B?dGg2aUdmQXF5aTBxL1VxQ0htNEVZcFUzMGZVa2dyVGdUVERwNkQrUjF1RlBN?=
 =?utf-8?B?TUFPeENoUjljMnF2S2VFc3oyY2d5M1J4VFUxV1hyZHFFdDNkS3M4RjIzQVpC?=
 =?utf-8?B?NmoxWUFvRkhkbFFjRTRBWjFXS3BVclRUQVpIWTNxMUlSTmR5OU1STlZiV0py?=
 =?utf-8?B?d3M5Y05yak42OVowRTl3VU0rYUpaZWNDNWUwYTB4QVlZOEdjVlJyWW50TzFD?=
 =?utf-8?B?bW96UjlCVzFWMGRnQXpVR0hENzVJUkYxSFA2REFzWUNQYXk0czB0SWZFTVdC?=
 =?utf-8?B?ZDB0b0E0NnIzdTFJektKUmZvK0tlMlhBUzNzNTJsQ1cydG4yZ1BLSFZZVzFu?=
 =?utf-8?B?aWZLbExCWkNUVnJwbDJvOHBYM1ZUeHNkTnVHTWxkMjhzckg2QWt0eVNZdFZC?=
 =?utf-8?B?QzY5WUI5QnNackJwRlNPYzFXckRYRDRUTE9lY1ErK01rYzdlRGExMGJMRWxZ?=
 =?utf-8?B?RmxjUDhOV0VtME9naDFKWkg5NTNWc2hQSTBuQWVUZFM0NDFtNXE1NlNVZ2N4?=
 =?utf-8?B?YTVYeHMxL3NXVXhNdFpKZkR4TzFYM01NTk1vTzhpUnNsQUtWc0hyK2VzL1Z5?=
 =?utf-8?B?UmRMM1Y1aVVPZWxJbDFaNVpkOXgvaE5wdExqMVFwTmN5alAvdjg2S09BdXZq?=
 =?utf-8?B?N1lFRDhwdDh1TDJaNkRMQ0E0Wm9uUGs3a2M5ZUlpZHFhemJxZXdyaVVObjZG?=
 =?utf-8?B?OFYyUkFPMjRvZm9Sc1VuYVFRd0tYdEhaWE9zSmU0SE1YcTFrM09wSWlHUms0?=
 =?utf-8?B?ZnU2enBhdjhNWC9GajBMejlWMDZYM05EWTBzQ2Z4ZVB5a0o3azBoZjhEYU1Y?=
 =?utf-8?B?NWFxZzE5OWNubUlLeTJzK25KOVJzRDNoV0dTaGpFYm9UNkZ3b2l4aUlDSDdH?=
 =?utf-8?Q?iBLE4BaQ1i26oIV/Ad4uYT?=
X-Microsoft-Antispam-Message-Info: JlT7nFrYdikHc//tl4l5umE3iHdWQ9mx1N8V/hZsj8CxYsDW5Nc1v882Dkx2gA6V7G1mrXcFb9JtwPvfuvsYPX36bvnx8C/eIwfjLDsBajPEs1pcEySsdtG7PTHPoNAnQD2bAKEpw3588cLjg1dg9IlXQFc1YJKQ6J5kd0/Rg0awd4mCba3wUDcRIKYBDjIr2nhOauU99dVzkH1IKwfCDWkLP6lqrVqcRbOVgFX/FVVrqLhRcEH0khAvzrvPafmfJrttEUSCoy5N4iKEtTV7dW1ECJiZBPrtWij3jDxAlwOqQDnPjcUBXBcif0iiaM/OD620n8uP8GhW2dgBI2WbHIDZAUzXP606cWwwvxeX/Cc=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;6:Fh0iOz5FSN53aaM/dlbfZMJoe6NyAp4imnw0Wc1gIxW0bK2NY9MeJm7NlkycyqlKdb+HVh6gCbaIwnq7J8wpsw4501f6Zy0+loMb7lplgW35O3tSB1yyhBIwtriu2CYRJOrfEMBawuoNGBDD1MO/Yv2MHiixNPNxixkymbAXQgaP4E+JBS72+OBRkxLbfafhbomeXPv1TDrgh2yYXm2p0nAtG9B1j2YXpmwOtH/f4ybo1Rds4LvpLwv2nXpq8WY/5NNVda0yacAuPmKSxBf5REzW1/YNbVTN8cCk4X1riVH72lFbtZpAeAym4GhmbHZQDu/ElHvTMLfrd6n9ZTn5BQFZ6GcdOtOcDdgLucOXNzmZHasdbqHswFnInW3tN2Arde8ZkYVgo18uRY46TMgbUxNQ85W/DUuJZk+DhEhdqlw7LOvUgaJei7Ve6k8nj58L6CDpgUJt+/sBBNvyg19klQ==;5:xQl3ptH/AJeuBneW6/qINuRsYjglxBEylEUhm9ll1DDi9x/R7VkIAvz78cIc2P8EEJneOjfFXYiwXW0CluaBPHZUbvTynLF18Ew6LPG3QUBhWPiIxy7Z60g2D4p6aqUxZmk2YQYoeIAnHXCLHJL1Bn/7MyL0AdwWVF3FaIwCS10=;7:6cWHUta1x48JZboKLv7xqe0Vy+UYNs7+ZS4vd0lGWctsHFmO/wiauiQqaoyDNrd8DQzDjnyY4l6csM7/6YdTnt1m/YjCnDDnISE5rfSb2ACVuHDuKlSz3hT1eeplIep8B88a2vvyUPmcFPRvIEv78010YkzhJ+EKlAy+zEdsRsa2ueA62KkizlFd8dHJHVTQmAnsrihCX1yOONwrWrZydZDli3MDfsj5uo4HFohwFuOYjKQQBWgfvDgrDDBJ79Vf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;20:nmReKeyyVN8q2O1A5itAr98VE8E5g2ZBxTJyFYHGvy09/SjZwoD9ovEjt0G/29VGEo410PFoVfe48W5L58G+j3vEEHZWunNbbgWdpIBhJG28/flWqj8oVaJ3BLFNQcomO93Suv8kfk387GwYRsUaD0J4Crc0kH1Cs7LH70Pgsrs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 10:11:59.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6044afe-020e-4208-643b-08d617cf0352
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using of two unconnected IDs req->in.h.unique and
req->intr_unique does not allow to link requests
to a hash table. We need can't use none of them
as a key to calculate hash.

This patch changes the algorhythm of allocation
of IDs for a request. Plain requests obtain even
ID, while interrupt requests are encoded in
the low bit. So, in next patches we will be able
to use the rest of ID bits to caculate hash,
and the hash will be the same for plain and
interrupt requests.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 11ea2c4a38ab..f24fd6f61a7a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -25,6 +25,10 @@
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
+/* Ordinary requests have even IDs, while interrupts IDs are odd */
+#define FUSE_INT_REQ_BIT (1ULL << 0)
+#define FUSE_REQ_ID_STEP (1ULL << 1)
+
 static struct kmem_cache *fuse_req_cachep;
 
 static struct fuse_dev *fuse_get_dev(struct file *file)
@@ -319,7 +323,8 @@ static unsigned len_args(unsigned numargs, struct fuse_arg *args)
 
 static u64 fuse_get_unique(struct fuse_iqueue *fiq)
 {
-	return ++fiq->reqctr;
+	fiq->reqctr += FUSE_REQ_ID_STEP;
+	return fiq->reqctr;
 }
 
 static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
@@ -1084,7 +1089,7 @@ __releases(fiq->waitq.lock)
 	int err;
 
 	list_del_init(&req->intr_entry);
-	req->intr_unique = fuse_get_unique(fiq);
+	req->intr_unique = (req->in.h.unique | FUSE_INT_REQ_BIT);
 	memset(&ih, 0, sizeof(ih));
 	memset(&arg, 0, sizeof(arg));
 	ih.len = reqsize;

