Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E975ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7332084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IOITun4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7332084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeGSNcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:32:51 -0400
Received: from mail-he1eur01on0137.outbound.protection.outlook.com ([104.47.0.137]:35463
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730049AbeGSNcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqvMekRDm+NtaeG8WHM8uDBUpTs+1BgmVltTgZfHoZk=;
 b=IOITun4G6++qhpiU/70QcGIiQuvhFw3YOxPVocuqstxjg/if4ZZpwuG4cakagvjvTc/yr9nbLRQwY7J/+FzD6FmPwz6+4p1DvkYwqE4OwCvenRFDoO00x49z6/ePHkAvYxY+71jKBGobZj1cb7e21h6+4L1eC3mEA30D5hPfVp0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Thu, 19 Jul 2018 12:49:43 +0000
Subject: [PATCH] fuse: Add missed unlock_page() to fuse_readpages_fill()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Thu, 19 Jul 2018 15:49:39 +0300
Message-ID: <153200455673.28926.11139427627005446149.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcba65d1-d984-4888-859f-08d5ed761a06
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:fk4wqZpoPF//UvviNs1sC3+//6sZNfvduVfx6CyNG4+k6toeu6b33H1SZdb8+7pg3h+BU+q0rBqBmFmzGb0R58V19DBt7cXmLT99d85UsmWDUO+GDzes+LDqS8dtmd3jGWIjO38lXaXWM1d2M/jHO0wO6as8DVi+NZXcinpMHjJGC7iGgxZsnMdVcxls6hp2v94BlF/TOqtG9N09/9ApKVS51SJYaY8Kzmpnq/3/ldB1TuDHmQwrMGydKWC2ijSs;25:+Xv5dhkuB+UuXQ7HWcNIt6qbpJWaFyBt3EnWTmIBV0WO2eu+Ak6BVSp+7mjGq1vUb72DQK2F6KMv886gPMffndZRYmMGHDaqpGDSSqkup9qKMor2jPbGKV1Cgxo4uk8bniG5LW4gNgJ965CVEkV4pQSOXzYVXP052v7p/WXJwOVCoJPKcn8PAqmLNpG3lClldNMHz3+upuS4d8LwejjZWtBPnEmX9//HlhZwtTXTwN4UD2c59TFOKJ7G+4jD9EwI+jWe01MMOSH4Ji5Is55gPvGju94LoocXCQfBJvazUpEzJZFSKaWW4cu8AGVYvL55jsfZhYgbzM/TED26Y7tJwA==;31:w9V6AiwWxC8Y2qvtNjo0pEPTLIaMgq6Zraa4MO+zHfuC894hLXdhEj0K0JXOti5WdnezaaYvNzNBySAsAGr1jmARepqGeu/sxSlGfyRzvjW0TOq+k3W1aYsEZWK8QZQC4ZiFjtSq7c4qkOquGqM7dUYBwVzXnKrhYy5hqMF3LLYOCYqpIdrd6x2n6ny9gwy7v4LYUuRF9o1XXBqszIqdAgub/3RBCLiIbHEr3wvrxIA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:OkrNTWeYaB60SuSUszsdSKrLUxLhOKVI9khCyv0dFEJYiObuirz15W0uByqyBylmjVvSJse8py8hP3r1TtDAWQWWxpQ1jYUvqJu630zsd3Zsqz4bR8L9frmCC/O/gg+6n0Q1a/NhUqRSyLC0UmsX4M+3SAB98qrb9FvTUg3Wsg3l8x6JxaqoKvxRUVgMY4T1P14kIOUUoFWpwlvdPXY3B7DxGeZYAihFqKNvWbYSm6RDQrYRg3TeAjPNTxS2flHxtJPLl7G0fHE8olKmth1avDH35RMOlDsPiYx/UoAU5bY8FFIwmhj/G0RmO0vgZG/9M5wp6i+6hQfnAB1jxpvUnSB4ooLEGNqKbxFqDFW1QgW5+1rajsNvm2D0RErYYx1disRF49q4V67fAef7/XZC8ck9uqoCSaEoLDqsnupspRMp4fX23wcFOMre1R4NNcxMchXyUcmqVJS/cI2ZxWmauZjX0ytIAm2dcEknWyB9XbIAs9SUFebvxCOTrZWD1pwR;4:lkf5jVj/Ee5HLaZhXMPw8ZTXZCGBGUSq/pkaV9yZO53LjlSsQhXG2y1v9ZP2ev4imfO20JqYiLAuMmSkjM9EROAL9TlkJ7vVhcFOEXRSWNthL29zP124Aqot/LYzpE63vwPg4NCZfvP7d4DxAzVE6SVMLGF5FyLUZ6SOHnQi36LTc7MHS7yh3hmmko6XLrYdBGQFYLXNBQkQEFp96Uzh/lo8zXZ6FBQk6VpOFjiAeAxKVU9F3Wp12pL75gwxouLfTGePZXB0QjcqXpnX3oFI9g==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB202685464A9CB397E4F67A89CD520@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(136003)(376002)(39850400004)(396003)(199004)(189003)(305945005)(486006)(386003)(6506007)(230700001)(81156014)(476003)(6116002)(53936002)(52116002)(956004)(7736002)(8676002)(105586002)(58126008)(7696005)(3846002)(86362001)(106356001)(14444005)(316002)(2906002)(81166006)(68736007)(8936002)(66066001)(25786009)(478600001)(55016002)(47776003)(9686003)(61506002)(5660300001)(23676004)(33896004)(6666003)(97736004)(186003)(1857600001)(2486003)(26005)(16526019)(50466002)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6RkFzZTlRSWNFa2cvTTlXdzJzTFgxdE1H?=
 =?utf-8?B?M2dIUFhjWTh1Vjk3MGpsd0d2dDlEN3l1VW5vWUk3RHZzY21Rb2ZXWi9ENTA4?=
 =?utf-8?B?UnBXMEdtZVptU09EbjVZNVc3NUd3TngyOXdCdC9NT205WTdoUEI3U0xCc2lT?=
 =?utf-8?B?RWs3aEk2YWhza3lxcmxOTTlmL0xuRjQ3OW4vZnM4OUFoZFhUVHYrU3I0WlBM?=
 =?utf-8?B?eVhtdWdneExqdGlZWXNET1dHMTJrNDV0NDN4V2FvQ0Q3bEpLb0pBMWQrcTlW?=
 =?utf-8?B?TVFHUTJlU1NzdGpNVjNLalR5ZGl5a29vcEJENlZ6VEduWGY5enhhUjJINGZ3?=
 =?utf-8?B?OVA3WENkV0NYVmNDeHFjcmJkVWo0UERMUlhyTS9DNU1UNXRWWjVSTlFDYWgw?=
 =?utf-8?B?OWxKWERYaWNHQ2JpUHZBNVRIUTFkVGlzVEh1aXdHSFFZNkxUWmFSZ3hrQUtr?=
 =?utf-8?B?VjZvZGZKaFZBZ1A2OXRNb2xHc0V4VTJvbWYrT2Y5Q0xvajVnajRXVTFUVEdS?=
 =?utf-8?B?MXhXbXBjQVFYZWJGZVZ6bFhhZ1FJQlpGQnFQVENvc0NyQjFTVldYTDVScjlh?=
 =?utf-8?B?aExDNE1Nb1dQYmtKQ0VFblNMRzZsYjI5L2ZWR3lTZzVCaSswYWtoRHJhSWw0?=
 =?utf-8?B?TnpuSUtFN25VMGJTNWdIZnJLQnlYMEk1MnRqRGVXWXc1YmtwS2pBcXAzMVVu?=
 =?utf-8?B?UlBuQUh4UllHVkovVTljQkdrYzdFMDJuQWFhZVd5UDBwY0FWN2ZqSUh4WXRp?=
 =?utf-8?B?YmZRNkZQMjZMd3BZOXhtRXQ2aVROVjh3WXc2OGZ0QzVnNHZHS2gva1pQNzBZ?=
 =?utf-8?B?RFU2MTNDU29PdjhWQmNrK0lOdFJlRnJ2YmIwSEdJY0JCZm9reE1oNS9uVjFr?=
 =?utf-8?B?OG9RbGZYaUpveHFRRm1tUDhYZ2pIK2ZoTDlIUHg2R0JrSnhaeW9vejFFSFJD?=
 =?utf-8?B?aTRWRjBpMmRMTmNkMjJaSlZ5eHM2U2wyNW1MOHFScGVCVXRBZzNwdUdhdTBQ?=
 =?utf-8?B?RUJBZnJCMmtIRkRJOGIrVkNraHQxMGl3Z0QzRjdFSEg1Z2NCY0xCUnZuR1Nl?=
 =?utf-8?B?MG1pckJTR1E1TTVUL25CUjhhMTlodFVjQ1EzWGtiSE42WjJud1M4ZC9oa2hS?=
 =?utf-8?B?SGZBODRYUjc0TS9HUGVMNXVmVDYyUXIxWG9zTEVZNE0yODR1Z0UzWVpwaEVi?=
 =?utf-8?B?eVFCOXlyd3RhcGJsbURSOC9ZNVFWSWRBNDdoeHNzUGxXUnhvM2FlZUtkQUVv?=
 =?utf-8?B?eFYyTlV3N2NCNEtxaDBRaHdTelA1QmhzeGJ2eUY4bjcyc1A0ZUNXSHJOb05I?=
 =?utf-8?B?ZVhjVFdMRDFOdGYyL3ovSG4zWDBVR2VrY1dhYW5rWlN2TGs2d0gzdmo5Rjg3?=
 =?utf-8?B?NW1GOWEyUWRDdXRUREFObld5OTBLY3ZuZUd2VTJQeWJraFAyV2pkMW91TThq?=
 =?utf-8?B?aTV1R0grWjNQMms3UTIrQUV0ZDcvK2FaeXlsWkV0TWJwL0JUcWlRNzBLa08v?=
 =?utf-8?B?Tm5oM28zMy9WbE5DTmZZWTRsVmk2UEJjWjQ4YlllTzIwSzN3K2o5WFFDY1BQ?=
 =?utf-8?B?eVNtcTJrTE9lUldrSS9ycVVHc0J0UkdMV2I1WFJsRDQ1R2I1NmkvQWJaZVhu?=
 =?utf-8?Q?s=3D?=
X-Microsoft-Antispam-Message-Info: zDjVxEjg1m5H8IVTW527GZRPbtNIXm3OS99IF3abgBApWXWJu4/P4+LmHbMYgNfLEx8+dM8mnyE2TsQeYlIraAMc6rmPfX78Y7icmQ80SeIZT0G1Y191Odo21c0eQyxmpKk92K+h/Iwc2hnqxDwQQRpNOtyKlfpucXlXED9vs80ZHY0AiIWgvSDcu+9d3YQCDm3+4RkObgj0OZUXhbl0CLvvRqfv5QMy3mJ2dvj8NttjvJ/6sAZ5PxjZn5I4RHSWGIiIEDkxLJSZ6zbklPszbtSsZjItmvl8T9I9AGuDfgGtuZck82Vo7sQRwgBbltYp18lUxdIzROBXQkRtjc6r0bb78HEPQ/eotRBMz71N0vU=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:RPLJFmKnc8vWPUhZ11ccsIQxFC/GcXnYTz5PnwgqrhkS1fcmFP4NyIUM19GTV9l+ORnSj9elzeVPFNS3Z85BGg+BdsMLYe71xyecx3JaDCpKLjjgIe9bmn6L47qYOiNyCvAV4iifJOIQ4OUMoUNn8xqLL9+R306Pl+Wqz810Kpq7TX3YfydC8Dvw8n1CAlv1E9x7YXK9J5OCFlgiXLfdbsoz0rUlMjM7cvhdK/vrhUT/mh25Nl4G8RfZPsZY7qEkdM99Ru6La3CVmjEf44drD2rh0ydB9U9n2L4W6UPRbMqsrORyLBUgplFkblfcFoMNLH9PoGMuy/gHy6nb9SkR660UYuEyIAXS2OMY7GiPsxdlZl7QG9Dlgyu6s/kvkdPK/0kuWS0NIpzKqXK+8hSDJatc2n2XlwErQ3dm2lMAQuz7XdcXjfMqqtsntaLt/b6mndWxyKIBaZ2r92yvywyOEw==;5:OvyBzZHm3F11uKpEHev/1SaF8iif0iwAdqeSRCW13IQc5IT2LMBI4vi4B670ayl9OVPd0fd8sU/Wyk5xZsviIBvKnUFerkI7hxKhBFq0v8QML7uLLs2sqy3mmLzdSgFPh2WPDoJypWoiZzNhAmS5wp2XH64NjhAfA2vx9F7Kz5A=;24:rrXisZVlIBXRj+PFI7LxerTaGi+xCBBvkuV87phKMA+X3/EddoUnHBZv+MYa5r05t//m0r9srRi94BtxqRMb1tD4sLWEMuxox0UKj40SinU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;7:wAhKphVIg5/gjyhOxjV1VI98uayEbRgBZ9N4QYox/GGhaxCZ9O0cuaFK8Sg7nXL7Aabrx43K/Hz+hwRMK/YOSDheuz8dqA+QsJyaDZN5SarKZfSxFM5pb65Wmg1P+hI8adI31pe06d8259kp1k1A6/IcXemv+3hWOEFyKfc4tbpfVwiCrzAahCS5ZYpMga5I7oqlmlU+rx/TPsXLpRMUgr6BuswNYZ7P38RsvjST0GmIqKV9hRBNIMQBQ63s/sKs;20:nvxMoMNr8jQWUQK+qiWmFJsnEDZGqUf+uMwuu0IX9SjzP13WG5/R9DCwRw+HZ886qjPncDRD3Ata1HtIBwQGofrMOt0/V4OpqulZ2SxRsjGt6ZI2fuExyWsuYp0zgA98UYJii8WVgzfuAUOFraPwEpA5cb8Wmq9qIrkQI9nDzSo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 12:49:43.5883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcba65d1-d984-4888-859f-08d5ed761a06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The above error path returns with page unlocked,
so this place seems also to behave the same.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/file.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 67648ccbdd43..fe8d84eb714a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -866,6 +866,7 @@ static int fuse_readpages_fill(void *_data, struct page *page)
 	}
 
 	if (WARN_ON(req->num_pages >= req->max_pages)) {
+		unlock_page(page);
 		fuse_put_request(fc, req);
 		return -EIO;
 	}

