Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52989C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990142156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="WuYKkZwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990142156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeHXOov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:44:51 -0400
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:34988
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726676AbeHXOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgAdCYu7V5u9d/7JYRTexiQ6rjZd587QfDULdKzoRJA=;
 b=WuYKkZwKAhdDjfzm5jbn/f7U3J5e0SAOB7bPLdPZBH6IkIx6cm60My5kV7OE8IdH8jV+Q8LNgyI1DrEH/E3/9LvMbJPcmwNt60DrQRAuqhXuz0INgCjp6ycHeK0f+4vmPLZMJNcUg0PY/eUMG5JmOOn5iZkoBgOCUBQLfD+Up6c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from localhost.localdomain.caveonetworks.com (50.233.148.155) by
 BYAPR07MB4920.namprd07.prod.outlook.com (2603:10b6:a03:55::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Fri, 24 Aug 2018 11:10:31 +0000
From:   George Cherian <george.cherian@cavium.com>
To:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Cc:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        George Cherian <george.cherian@cavium.com>
Subject: [PATCH 1/2] ipmi_ssif: Unregister i2c device only if created by ssif
Date:   Fri, 24 Aug 2018 04:10:09 -0700
Message-Id: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: BL0PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:208:51::33) To BYAPR07MB4920.namprd07.prod.outlook.com
 (2603:10b6:a03:55::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 313f2319-cbb6-414a-246f-08d609b235b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4920;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4920;3:m+TK3/pU4y4sXRFH7bvUWUG/OIatAjxlU3TUG5AgIuQp6THc9vQCy5gM+pj9Z0P7A3fUZwoaEv6s5vzth3lu4+2XA33Gszjsr8cDID9cv1OtethG6MqE2gCvZaf2kFIoYnbjUdXl2haAXFJlkrLW7cXnaU8qnLUxkDUxP6ECkeBFzNtlZvs8P5qhSx5wR537Y4DbImVzzmoJYePoj4ks/SoQa2zaKKViapPU6ummvL0T8uO+9+uQt1RNqog6nn7n;25:o8LPRviLA6y/lgnRccdahg9VfDIOkO6hKaYCNqGJYj2SqcvTLIqTS59u84T+27/PV3jIbgXaex4l2HRMB69GUmNdhlUgSz/Ubvo+GxU08XmUF8oG1JUAu7PKL84izMXFnn2Np3MSYvOdbTaVpzbSlGsQ7EL6AiHZfrte7e2TCMF0TyGaV7gcQcg9WuBvEf9h+TQ/Ob6aqihFC3ZDm3GHbWeb34xNL05scpuzNCWWe+LBKROXusfBvUq8vNVXjutkPQeXcS8k4h4SMNcUfqKHy1O9IX2hhSH+qAOkZM0GHD20/HWyHjfwRM3tN7bgrBidU2xQf7j425AdADsimeriUw==;31:U8iqlhbWVSSxU3RycdLO1edCvtfAUjC0uzfbw0mv9EkTXGttSy7eJsuxtJpg8wPuCcSp7AO/CxtqBvYeEd4VOh0nLWOTyJg4XBef4cUWGMUGqvcKTkQU2tcxrrLABYf/hmMCjOG7ziOlGDHNHGbSk6mdbUbe/k4qTqLf1+bOJkBIJfOh/xa3ze8FG/uzswhHZy8ChGtAaYEJY75C6yCEctj6PHO3pU97WxK/OszPjOE=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4920:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4920;20:+R7eWOPzKT7vj9r6GZtFpwW5K9aXGMv1isxiD66XAobWgjGwx4X+Us/0kG8BssAkQd5Uyu4KGAu1A0eN/iaytgtDN4MPdXLE3Q7J2nZfsXU/1DF/9fWM+fD5W5aljAUAO5MzdqLRS/akMD/niN1gKKORD1ZknZdYMk5DdNLzSaladoygtFOC9kr+2ykaJ1XrX5JCwFpgRZwhUqBqDXTTXfSfUPHQABMdOtPLpStsNO3fEHaxP+2HgH1iN+SRLyGC1W2JfYv/WCYFe7L6vSJ6bWZiFudz6i8d2e4/HzRVokziZ8OTXn5jlOvKetgSOONs/v8lL2qf8IHuODBWsKhOg73WyPcsxNSh5H0lNxJJ/fn1eKY1P8dKXR6sSid8rNpxFSQ1QjagCxkknBKaPzAVKCZ4Mt0eRGfu9aZu0IBeL+2VCyHBRbKvS7Fa8D1f0dYaNiW8YrnWGl1lVCu5IACNL91sPpRYGx5GNgeug7gpg6sXm1mrv81hFgj1JYR0PLI2;4:ADWEhLCX4pdRflNpEcyU1Z6uwILXuSSJ8jsdt8Y+yni/GKlAp0PuH0E6B7UNfb1Vz6OTRjciy9Anh4zwAWyv3G5hRrI1FyOlkwAUMpa9PtO0d7WuD1FulydRq/G+TN3knVRt6diY/b/W5AYXZYzk7LOeE+YCQwolnpQlsPVpY9K6ir+E3GlnPWMARaiZ6uqT3bD2Fpj8fKU43ivd7teaaDb8h6UhpTuCdDKLsRHBUnok+Hy9vEyT1ZSi/6K2Fy2oBNcFgb5mT08/tzXmSO1/MQ==
X-Microsoft-Antispam-PRVS: <BYAPR07MB492009AEC9F1B81A73EAE9D5F9360@BYAPR07MB4920.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR07MB4920;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4920;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(316002)(16586007)(68736007)(305945005)(53936002)(97736004)(6486002)(7736002)(107886003)(86362001)(476003)(6512007)(14444005)(956004)(575784001)(81156014)(6116002)(47776003)(81166006)(50466002)(486006)(3846002)(44832011)(8676002)(66066001)(48376002)(4720700003)(26005)(2906002)(2616005)(8936002)(6666003)(50226002)(186003)(25786009)(478600001)(4326008)(36756003)(51416003)(16526019)(105586002)(72206003)(106356001)(6506007)(5660300001)(52116002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4920;H:localhost.localdomain.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4920;23:bH+8V7kkSd5BC1UI6x1X7LOxbhV52wqXKqMn4R8DV?=
 =?us-ascii?Q?ktq5qyCvD/cAVjqV5dXHkLaJUwtTS91pQDfBJgAiIljeYW7Rg54xiu405UIt?=
 =?us-ascii?Q?FnajlFROXtKYDRifAUnIXJKGTFQLiRx4lHZyvtjEZE80tmCZB6dYuK+X0S7u?=
 =?us-ascii?Q?HhzKUcO+E0IW6V6U9ayV3Bn8sfTpMtAnczfZqUL45wfV1WFaOxECEphikzxL?=
 =?us-ascii?Q?cwFzg4q6lcXxikR32voL2ZBBwbcPUNsZYGLGYGP5gS3203SVuvP3XSMQfeOH?=
 =?us-ascii?Q?DSpbwKFrMMsRlWcHvR3aBd2PbQ9Ch1Ppvh7tP3trog8Ua3GffUuBEPxUTffI?=
 =?us-ascii?Q?OhsFID97Wn1etOAYxVGOyGlnDDunehZsu1dxCdtUCNE8KIHIIsRzDVu5ihS6?=
 =?us-ascii?Q?A0ivWcvMwVorwj4KE0xeZJkgVzyYvkkb/uHhIHEKbr2HXp+ilWG9uglUR9Ce?=
 =?us-ascii?Q?fN1cyEGxWepKP1Jui/ak4GHW0XoKeSycVU6A808rBmIH3l5+2EMAB++dmXlH?=
 =?us-ascii?Q?yVhuZcDMZxiYuELr1d/InVTRqouxhr3LLZA69ycQw4FpgCGnLtjAI2u1FVhD?=
 =?us-ascii?Q?X3woLf3zRm41LB6dBCQdMlC0kWuDYdTHq7ZztRgReTKlnmiUuaUyOoQ8AcYs?=
 =?us-ascii?Q?GIlrr02ZSUR86wWEt54MzF8ncmXj8cnOQ1UUI1I5lzTZ2N2BF0ahppGcRVSX?=
 =?us-ascii?Q?LUIlY9y+/A6+1RvN1hGHzw27exVJKLk0gqXeKctz5anGp+W2y0MBe0Fk+VZR?=
 =?us-ascii?Q?pn4aIkqEYKLAQC2P9Shp18US679k+h8J2+zFhQN+HKF70Ta3RNkd/6XTkjm5?=
 =?us-ascii?Q?71M+u1abrmFwppo2FbwTCE9lpMdgaSZe/zaA7AckjCkygoWk9oPEOdrceeD0?=
 =?us-ascii?Q?hh3ezIOjIIq14IN4Oj6NhmK+qRddCaOSOeYoOB0hhSmYY92/sQxTm2wcqO6M?=
 =?us-ascii?Q?AB35Yab9HeyD1xrdg4HBHuB1uk88Zg1FSyghHrU7Y6JrYpDi6Wcta2LwV6K9?=
 =?us-ascii?Q?lNdEZvziijwTakfoO/Y5zQqi5HXfX2zkDejIVEJHUWyeEWS0i80MUdBSvaw8?=
 =?us-ascii?Q?E3HPtiFF0Tj8rTerw3x/caT/V2aDLFwWSXUL7smG6gug3CAUGP0xHUzo5kU4?=
 =?us-ascii?Q?qqZL8sfHPscdA79igl7mFn8zLsPx/KU0o+Fr2NvIP0OEGkAX6GDwEoIUjmjo?=
 =?us-ascii?Q?ndrYeHED1/INppoE85bdtjM9kXdEQkScMXMXvDAeAMC4f7TXJJVI1iussU0F?=
 =?us-ascii?Q?qaKO62x7iBupEECZy4=3D?=
X-Microsoft-Antispam-Message-Info: yW82ZCzcAEgJ5LdGIyZyVq/FfKFQYltYqJJaGeFOG8obujS07XQvPGpuetZpZpmp4n/nUmQIi1E1uXTfjWhC9UFkhWyy15Veo69F2qM5Zkycafl9CNwfYT86qjK+P1/S95lW6eDt5Mx+5M2m/baSEhpH0XtBRwB3LhFtyNt5asT2fiqz4Nl7tszP6CQaKQ1zhVNtRs9xHEWeYa8Nwn8iIYjE6xd8Fsx67z/FlwA8ohuifuobgD7I8Ib3xuwWwlukcRiwsHuvaHJND7soUz5gwp+FddnTbFLnAEdQ5NAg0gv+rtT1mxn0fDJAnZfI5eWP6M/+fUwjuOe/jYh29VguxZcWnnn2nMeev5Rj6D9ndNA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4920;6:s4FxNDAsd7N+hU0D+HrPSTkmVePbg222rtKY5JmRwNGiNs8MyOZH+R/WuJmQD7o+1yhTb9WyYd80eqc1C71AeB3AvzMWCK/HHNN/7lhtxRK5fLQuW9ZcyvWUN4Oyyj7xaO3REs/v1jWGlXbuFzd39qNGe/pZUkHumTzZdqgomOcouQ9Fcl7L+oPjH0Y0bWq9d6yo68AI2/yHPD9yf8vz3FcFogKq5s6j2T11pnJh3jVmkgn8L4QSmOnylW8feG61vnKrx3u1pIecW0iKswQuWi418Es/mEx/hyKjQDqqAOeQIpyslqQRj4TKdMRHA/b0QFFybn4OYygnpAN0N//GX8H5GY17Mz6bu4z0SDCCnuSIKmboU2EOMmSbf3tIY4DPmi8i8tplCb44R6qtUmx7cW6IYScbOv3I8zoRn/I+sxoWUCc21jhhTZeQuvT4R0Rekc0HQMZzQ2YQfXcnQNlcxg==;5:aq2sOdvoeKmJHB4ArWHvzptL8egbaE7lFkyPsqPlhNJZ4Y51a6v3FJOhHd9s7WF608lQVpI2a7b6/lqCtEWYPusvXgw2NG+NVL7kc7BD+0s/3WDGSlhm8B9rO+ntQ7tblJqForfqFss/YPbla4rjVPnPmgROzDyD6TYHIQQ+pYo=;7:2OMP4WT82X62md6fl6GeGY5xudxSU8WKlwgrn0MIcxQwGKRMnnhcEel2lGcl+FeKjFiC24f00CDE++bnKYKjrL1N87bgUTWO0pgjzwx1wSW4nzaMIdNqdKlPkO+wEZQ/Z5hhpGzpSOGyPQpzG/6mLcBW5NK/UpfaGmCihXMj8dlstMYHA5mBPqeNOvvpUb/4/37JigFEaavX4jDQ41s1/eLLeAP+ktzLmHu56j7VVW0ARVv4TQV9a68dssSishVC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 11:10:31.7709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313f2319-cbb6-414a-246f-08d609b235b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ssif_probe error path the i2c client is left hanging, so that
ssif_platform_remove will remove the client. But it is quite
possible that ssif would never call an i2c_new_device.
This condition would lead to kernel crash as below.
To fix this leave only the client ssif registered hanging in error
path. All other non-registered clients are set to NULL.

 CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
 Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference firmware version 7.0 08/04/2018
 pstate: 60400009 (nZCv daif +PAN -UAO)
 pc : kernfs_find_ns+0x28/0x120
 lr : kernfs_find_and_get_ns+0x40/0x60
 sp : ffff00002310fb50
 x29: ffff00002310fb50 x28: ffff800a8240f800
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000056000000 x24: ffff000009073000
 x23: ffff000008998b38 x22: 0000000000000000
 x21: ffff800ed86de820 x20: 0000000000000000
 x19: ffff00000913a1d8 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000
 x15: 0000000000000000 x14: 5300737265766972
 x13: 643d4d4554535953 x12: 0000000000000030
 x11: 0000000000000030 x10: 0101010101010101
 x9 : ffff800ea06cc3f9 x8 : 0000000000000000
 x7 : 0000000000000141 x6 : ffff000009073000
 x5 : ffff800adb706b00 x4 : 0000000000000000
 x3 : 00000000ffffffff x2 : 0000000000000000
 x1 : ffff000008998b38 x0 : ffff000008356760
 Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
 Call trace:
  kernfs_find_ns+0x28/0x120
  kernfs_find_and_get_ns+0x40/0x60
  sysfs_unmerge_group+0x2c/0x6c
  dpm_sysfs_remove+0x34/0x70
  device_del+0x58/0x30c
  device_unregister+0x30/0x7c
  i2c_unregister_device+0x84/0x90 [i2c_core]
  ssif_platform_remove+0x38/0x98 [ipmi_ssif]
  platform_drv_remove+0x2c/0x6c
  device_release_driver_internal+0x168/0x1f8
  driver_detach+0x50/0xbc
  bus_remove_driver+0x74/0xe8
  driver_unregister+0x34/0x5c
  platform_driver_unregister+0x20/0x2c
  cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
  __arm64_sys_delete_module+0x1b4/0x220
  el0_svc_handler+0x104/0x160
  el0_svc+0x8/0xc
 Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
 ---[ end trace 09f0e34cce8e2d8c ]---
 Kernel panic - not syncing: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x23800c38

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 18e4650..ccdf6b1 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -181,6 +181,7 @@ struct ssif_addr_info {
 	struct device *dev;
 	struct i2c_client *client;
 
+	bool client_registered;
 	struct mutex clients_mutex;
 	struct list_head clients;
 
@@ -1658,6 +1659,8 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		 * the client like it should.
 		 */
 		dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", rv);
+		if (!addr_info->client_registered)
+			addr_info->client = NULL;
 		kfree(ssif_info);
 	}
 	kfree(resp);
@@ -1672,11 +1675,14 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 static int ssif_adapter_handler(struct device *adev, void *opaque)
 {
 	struct ssif_addr_info *addr_info = opaque;
+	struct i2c_client *client;
 
 	if (adev->type != &i2c_adapter_type)
 		return 0;
 
-	i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
+	client = i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
+	if (client)
+		addr_info->client_registered = true;
 
 	if (!addr_info->adapter_name)
 		return 1; /* Only try the first I2C adapter by default. */
-- 
1.8.3.1

