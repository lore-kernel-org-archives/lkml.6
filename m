Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7536AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1786B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LZvcV3am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1786B20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965430AbeFRJpl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:45:41 -0400
Received: from mail-ve1eur01on0104.outbound.protection.outlook.com ([104.47.1.104]:19136
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965354AbeFRJpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t80llDOULAFp4akwFSvGNElipbHhSFKGEi9if1Keqo=;
 b=LZvcV3amElDhpJWV9WLFLq1pgYYhOwmkdD+mcdECAtOYuCL7cngzzZrS3hJpIi6G3BMQpHaT1MhLtJKqSIr1auYo/HePFoGCamaOQPWILtOu+1YM4qiqpcmKAnhO6vdx1ahQcDfyhJWWWbPMOrQsQyyHnm8TKBuhqJ2ELpvZecU=
Received: from localhost.localdomain (195.214.232.6) by
 HE1PR0801MB1339.eurprd08.prod.outlook.com (2603:10a6:3:3a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Mon, 18 Jun 2018 09:45:30 +0000
Subject: [PATCH v7 REBASED 04/17] memcg: Move up for_each_mem_cgroup{,
 _tree} defines
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:45:28 +0300
Message-ID: <152931512870.28457.5926882193578999662.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0901CA0056.eurprd09.prod.outlook.com
 (2603:10a6:3:45::24) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ece5c9-bd59-4f1f-0b5f-08d5d5003b6d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:ngJ2CXER/u7VVTh8sRG915U+sX9C/3Q83w7XUvf3iP96dvjc+peTh4EGxPhtVvOiV4PtXsqw5cSG5a9rrz98uMmSWdX4UAthVQnffZdcdTYrvKz3Vef53kV2RXEFf3EPrEsKTDh9ED9Y6opt9v+Ul9NK8jF2s2KJ+KC5AmvVyK2bKLbRcVyhDz3GRpf6zftYQH2Fe2H4jGHFsOq91+2XtfI6+GZMWrHLDs6AE+1OsrFIjZqTSdtD8cT396THeDfA;25:5JjaWOOoXZOPNIZMZOMBKFwmxelw3r5AdD6hl35bAkrZDzScDYZtI8AtNbPvVUh29L/2RXlhLfENd/EuRkhgP3i+UaGHm8RRZKd1Xr4gURNOA1VXabZd7W4XjrED6bDYsLlQM6Nc4NG5nVgKh098URopiElh/AC1Le9+sZxVc3N03uJUME2wscw+l2aqaSFRE+FrldpZqMStCwxudvYzYBVt0rQEVX+Q+t3w7OWLjQXnD5vmVTGFnOVvr8zGLgiFkQGZUUTny6NTO0X/Zlckg7ixdAtBFU8eybyXa7mQmJ+CVc3cxM7oF5XfbG8mBHuHfK69+xdwpOb7/C+7PxHwKg==;31:ZyC6eIn+47d/QC14CBosevzBnIbJmX+n3aj1urkp3wzGpaVPmYDeZIxTDfIrJUMvIwzqmSVqhACGsq2M4/AjbdLdwoD1ndZWWuvoEs2hLe4XBHId93qFlyk8S0YK0J0CL9JfCbjAmw6fklVeImWtzQAxBcXy/5VEHpIPodbTDglUNVo2Utg3hAmNP8UqNkbiSE0clRj+G3x+lH/7gbz059h/KbeQdROf6EXvAsE6XoE=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:6D5ScJoBWqX4DpHCzO5VsjmnfKtkyWkTQRlyGGIN3IKAQtWgqA6jLX5vqjquVFOlTFoDjvlupeqW1ceeP+YaGBX/WzaenktJ2QAT/51O3bt2F41WDMUqPzH6W/WRuQthDxlW4MBLbreT/PgtTvfS6GdJfxniaaJplX9kTRxPb2jIt0xKHtjOT+cyPt9YxX7aJXfGqapLCxehyFM1N4nffWNIDkHsXF54wAC8W+5QnYfWFjwGCx6N0fdISU0Iy5Wiq/I3eo25csiuFgdfAgFRwcPPXiOpqAWVOQH9ABFB2j5JP65UOHaNAIufEVDNDNg0Q7xTRPbnWH59izXu/yYgKDX46Cy7G1IEhUTe6s7+oRkDSSAsJIKqbE11EIkyioJl1SRxPWXgzWfw77XRh0QvGdgG86/blfBQ3FtSRO+6d68pMd1tSSMMupZNh1YaNt5C2ESkXyKR7gXC+ed/PA+2d7NpFWUOkllLE79d+RR5hodbuwmcuXP/lxOdRs/Wi64x;4:lpmPl2g4wxRlKCXgsOrw/Qu0R6svyJy4nsRkeoRnvO0zH6R8aGmVxwe1Ws8RehIBpN45o/9CgRZaBf26U3AlrxMg7NapKT0ngIPbnGNDO9TH/fMiNt2cQOrRURY4B1jyYd2GxZmca1jboLehGnlBa62Nq9UM6Q9ljTdE+z6U+M38KPZd4hOc/h8LaB6kKbyGNEwitJeMOBUTI3BUTG6TPkHLIiS700/EobKr467qjnvJ+SKoxAAbaV6ZE7R+KvUbHGieiMR+eiTAdE89hE77NV30i0eJa4tDqLJ5iC3NDAnsOGwv6xbqzT7vg5CNKlBUayDLKjKvsxLRNnh6dy7WF5cNWYOTNLyi6U5tDq1aZFBmcm4UmfYBll3JTbBoSr7Y
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13393B979EE481533E0AD5DCCD710@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(346002)(376002)(39840400004)(396003)(199004)(189003)(476003)(11346002)(3846002)(16526019)(26005)(478600001)(9686003)(186003)(105586002)(486006)(6116002)(106356001)(86362001)(6636002)(446003)(956004)(68736007)(103116003)(2906002)(53936002)(39060400002)(386003)(8936002)(23676004)(2486003)(52116002)(8676002)(76176011)(7696005)(7416002)(58126008)(61506002)(97736004)(305945005)(55016002)(50466002)(47776003)(230700001)(7736002)(5660300001)(81166006)(55236004)(81156014)(33896004)(66066001)(6506007)(316002)(25786009)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6bmdUWTZSaDlGZ0lEUTRCeTEvdjVWbVpu?=
 =?utf-8?B?eC9NU1dZL1VDbU84Z0FjREF6YVhDQWVjZnRVUUJLSVoxamh1TzYxWWFjeEQ1?=
 =?utf-8?B?ZnRwZXpwNEVWN2VUN1VYTGxWTEE0QWdjbi9JaDlDZmRqbElhMlUvcERkOXR2?=
 =?utf-8?B?OFBSc2ozaVhYK1hYYjgrSEp2YnA5NzV2Q1ZQRTNIUXBCdklyT1BTSlFkd0N2?=
 =?utf-8?B?cS8xTmdBRXV0RTh2TVV2d0NRbkNQLzdyZHc2NkJiS2ZBanpzVDFacUJDNmF4?=
 =?utf-8?B?NTg5U1lTWEFZcktNVkxBWTZtZW1DRDZxOGg2MEk0TzRnVGxINWo2UWp5WFdp?=
 =?utf-8?B?Uk5IamVBZ0Q3V1pldUZONUh5STNYSFN4U1psQThiUHZ3enUrbklGbTIySXRh?=
 =?utf-8?B?a0JaSm9qTnYrTmNiZXJhVHVnMzg1WERjUkpoYmxnRXI1VmFxazFJRy9LZzZO?=
 =?utf-8?B?Unc4U1VxQ3NiR2xoMWptbGl0TGVPYnVabVdWa1N2eUU4NGo4Z2YwaENyQXlr?=
 =?utf-8?B?QnVvUEE2WXpVdWxiYmlyQm5pZjZjZTA0amw5bUxTZHlsSU9PSzZBRGYxU003?=
 =?utf-8?B?VTdYUVRjSUJGUWhCZjVVOWtuQXZibnJsR0ZYYWdLSjc0UER1VFJQOVMzVC9y?=
 =?utf-8?B?TW9HUEhHY0JpTkQxeHJ4S0dYaWQzTlNlZnFkQUZwcm1JS2dCWXErUFR1ZHpO?=
 =?utf-8?B?S0pmOVlPcnQvWDAyYVRkS1NKd1RFNkNiOXduRDNhUU4rL2IySFJXOFk3Q0VD?=
 =?utf-8?B?NzdVaGdDWGhwRHYrZVJ0U1p4WHZlTlU2RjdaODRQYlQ5eXpQUklQMDh1M2hy?=
 =?utf-8?B?ek9sSWRya1F5eWdldUN0cEtEZFo5MjlJMitHVjQybGxqWGk1ZDRHNzRaZGJD?=
 =?utf-8?B?UzR6eURQWkl4dy9ZaFpjOHgxUzRaWFhYbUoybkh1UnZBNnc4bTR4QlhjSW1s?=
 =?utf-8?B?Qll6emFLdWFPZVFJQWlXOVpNeXQ5NmpuYUYxQmlnaDZKKzZ2dnhydE9TOEtD?=
 =?utf-8?B?bUIrQVhYQmFIY3p2elNlZWFlWlhpUklWb3d3aG9KSU9JTEdSTEhGSnZZeHl4?=
 =?utf-8?B?VEh4aWRUTXc4azUvWHdSYVNDZEJKQTBVckZVUTBUaEQwVm9HVDNvcmNSNE1i?=
 =?utf-8?B?L0h4a3JVWC8xQ1hqNjk1UWVvRU9GSUR1NDU2Q1p1WnFoZnJpZDZRemdDSnI2?=
 =?utf-8?B?SlVMcVJ2TWRZVDFLeGJqRE1CVkhjUzVYR2QydGhlS05xMGNpZUE2SGV0MHBo?=
 =?utf-8?B?dU5xdzlDUWxaN3p4L2t4S01xREFQeW1OTkhmZFdFbE1kcmV1eStiYzFkek1Y?=
 =?utf-8?B?cEdqdExueVdFejZYaTRsUDZPakhSeUUxamZPRExxSE5raFVtdVkvc2FVb2dr?=
 =?utf-8?B?aHhHVGYycWFDeERCbG1HeTlrbUxJcVhMZk5UVEhZOUJyZlFoeit2S2paWmdQ?=
 =?utf-8?B?TGc4SkdxK3U0dzVJVGxPd1FmQUpZT2RpcUtPU01BMlVab21Ea1B6NHlCcS9X?=
 =?utf-8?B?NXVoeTFqZzAzRUtrK0ZYZ0FudlpGdEloTzRMOVpPczJXZkhZc2VkUDF5U2lk?=
 =?utf-8?B?aWZSUkRDZVBsdkJ3U29DR1d2WmVid0hSTkt3bW9vMkRQR3F5UW45RzBUS0VC?=
 =?utf-8?B?MEhjWnZYWk9tcUQxRWNEV1hJNDFURzA5UW1seWJYWDdLdnA2K3VqQWhOS1ND?=
 =?utf-8?B?MnRLdU5LYkFLUnYwTUVuWDNCblVvMUloV3RYYVlKbnR1S0N1dkJyL1J1c2VJ?=
 =?utf-8?Q?tPFPjkBQPlia8O3G1KlSMDHYaPKeyEQuXeUmjOk=3D?=
X-Microsoft-Antispam-Message-Info: 9kXXQy7+hYSMFSHj1LjzhBWg990vSS3EA78bQS+qYPKEhHTrU/plCDK8mQsAkrjHlHiREYYi3UR6e9y19O1Ko3reteC079MuVTj84QrFeipYeSubTR0mjrkjDqGkv+Qksa71Y7bk+OOIwRSL+AZKRpH2GQ1v3DCw16X5GzR8g0s79bdk/IP9GAysDQyJY5Cb
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:bMHCAK/mY9+stcO8WKGNK6I/fi6fNMEASELaYuS25JwsIglJxS+jCX8POdHRnJLjU0XdyD5hfU03q7vZVJqRnMvJvYXTVDBgtKP2BNlgYwNEKODVQRqqgukCI4Nu821TbZzXMitALc6qAtneEnQ7WvjwH7GN1eoQMaJ/92IIoHgNhdhR1p314Maz4bSFxjMc1hxNNq1N02zpKYosvyKSG91dzB1/Q4j2SUvDyx1jPkxURxKdJqb9CYnHUpIslSw3jOMldiX9IdD7Bf1R9p850yKBeE1383/gDB9AqY0IlJDdwUsiZdb5/DbyKF5MGXYDAHq/UlHX0LlMIThDJ7+UoG3uKBXyUllVeMVeVdBoF6FZ18wh97fgRk9qskyUszdPI8tiyrR9f8oSNwGCOYUXge8uSy2O9dfITccCKWQ83k4vPO3EvHzosZMUHcgufIq14IX1hkkDXahYyDM7xnBlbA==;5:AcDYI9WxEq/NshMa+zn6Cn86YcESZn3UdS8EKJBrFhzy4ih0zxeZbNh/wdPRjKPpYd4qHK6J183T2qN3AKLvU6d9ksb/E9KAEwaKTRcziko2+IUFPM1me0rmVKTwKSrJP6gnF9rwFjvq0lGVSZLQQLfY4mg6Mz37EPOgY5mSwqc=;24:DzUCfX1FggEDHZT0VQJPEHuG4Ijh+iJ4CEYBqzlnpOuJoZAyItr8H+AS7mZx7opOikTw0dml3ZezwJj8JKUj5QEyDyA3gtt4PqpI3e8sQtQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:AkgxFqVQYuQ7zUtuVdUYApjUpig/Uwy29raOh6ehWziiwpQb2mDzDa0VrevwadngH2vV3GK7EGmP3817cpPIdJoJJ64d92xWq5FlmuEQD6fmC/oyIdYdzqRH69Pj0B/EluNpZnG/MbeLk2DuGWb32r71nM+vRcmilhB4ETcbFB5nlHTqEw/U9j2etIpyE3VY1oKRG5CWnJYYo0m4A+/JdMzzWf+Jq0+Vnnexl+hcF5pjJNeHMC+anQIyaHuaAqzY;20:i8r3uu+BW9nelTGZKAcPbZqcivkACiHHWXahtannRNSxMsKmEuOm1L2Ml5jOztMS9WXK9Wa7nVbzflT9joXu+UCuFcP28qBUTmEAD/r8+DkENIPIXMp979+rm69VozfjN7tYO928IsR/UQghV5Fm8VkaJcWOkC3Hj+IX6hJzuTQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:45:30.8815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ece5c9-bd59-4f1f-0b5f-08d5d5003b6d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patch requires these defines are above their current
position, so here they are moved to declarations.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fca9326fba99..b36229bc2df8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -233,6 +233,21 @@ enum res_type {
 /* Used for OOM nofiier */
 #define OOM_CONTROL		(0)
 
+/*
+ * Iteration constructs for visiting all cgroups (under a tree).  If
+ * loops are exited prematurely (break), mem_cgroup_iter_break() must
+ * be used for reference counting.
+ */
+#define for_each_mem_cgroup_tree(iter, root)		\
+	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(root, iter, NULL))
+
+#define for_each_mem_cgroup(iter)			\
+	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(NULL, iter, NULL))
+
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -862,21 +877,6 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	}
 }
 
-/*
- * Iteration constructs for visiting all cgroups (under a tree).  If
- * loops are exited prematurely (break), mem_cgroup_iter_break() must
- * be used for reference counting.
- */
-#define for_each_mem_cgroup_tree(iter, root)		\
-	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(root, iter, NULL))
-
-#define for_each_mem_cgroup(iter)			\
-	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(NULL, iter, NULL))
-
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root

