Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB52E208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DuZZcjLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB52E208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936313AbeFRJrU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:47:20 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:45388
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935855AbeFRJrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd8k5ieE+dT6noL9HoFCu/qoH3d0TWOTBxaLsB+Di44=;
 b=DuZZcjLy1q94Abvt/6yQHo2xzVTOLVYjEM08ElnEcwnkEZ1bg1TQ03Db3354GyA40vC7qGWGxL9JFxjLmUR2hUfJultBuIopfCiNkpMa+/URJ20Ek2+QonLDtwszMkdNXOTaiF7zfwpyyOfGn1iz5Rpftw5c9f3ejRsBDKuyXDc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.15; Mon, 18 Jun 2018 09:47:13 +0000
Subject: [PATCH v7 REBASED 14/17] mm: Iterate only over charged shrinkers
 during memcg shrink_slab()
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
Date:   Mon, 18 Jun 2018 12:47:10 +0300
Message-ID: <152931523027.28457.11459863641054983899.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0248.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::24) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef6913a5-dc82-4dcd-a373-08d5d5007884
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:tFCbi44h5ZYOv0r5nnTT0Z+Bmmfv3cd6oJdHRd0Q1Gf0OiVNusaVySWi0FmIPZ2+cass/SCPMrN1qe94gGepqouFLz+sCli9o/rvDJQB6xXR2pe6SU7pWRGgfCwzkIryfLaaKVp+Pfx6kgh5CfqFND0BnvmyOxQIwDlHDKxFFd24kLNDZM1EhvU2YP9YYoHHEe6NR3L8lTq1bmQFqPTYHrHE6CC3ewYEh60nOAv4kNHjs/ehmVVqJky86RKTIukG;25:RDNPbPD5X8gFeSZCBTV7EVkTKJTO+mgkWlVGBg/D0Z+p9YwrdR3f6FyIhJpZTRtPHfU+uZN0Yc+u5gg6Kmhiy96RGqhcS0SMi56f0UUBZKn+A7/XZI1avjadWVK8hK3IRn1yy9bzSxziNJUyz68SuIi21pH8alcsZiGFxV0MDcly6Gg0NyEkeUHaHWqmJbFn9pRjjWbur/Nv+rpfyLnni98TICLOpskGPBzDOFxdgEGuIlGs8INBzUgAhwL2S6c8turpRQ3trV/0UeXwpdoh3Jxyj55FXD1Q3BVCPHPxnn8Ulhj9F/d99+Z37xtzLaL0lEZML9df6KdeE/UPJ+ystA==;31:5NnRYZrMOioN7dHlYJ2SW7dC75cq8l4gFXmqwF8Y5b38WYm4gCseeq1cpedbgdit8ewOTn47CC3W76ZsP+h7bmdicnyLJoovA4TFDNha5/DdHskrPd48AscwB9s5ByHB44BN32iByS4CR461CqIX8G2wqMIFJARq83zY9aXHd9KQAE8nPQbfiBvPHpy1T8apKTCoOM2nVKfSU09KBPX4Ejoz92O0Cni3PbFWPg/vaSM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:tThE3rdr9uMN1fmw9Bg/0L+F+FL/pXjzdsOuvXKkGSBi+itvrxzYcXrmWTLerFCWDbMJrosla+c3gBmiQE72+842WmUW1aR2yzNbFmQCr6pAAJcYt/0sZ0MU++VB6mA8+3JUyhqL+x0VLZCJgf8Svw1aAP82JeyVSV4IdaG1U6JUs/nwTQF9Xn49rAw4ZuISyzL9k8Ih4l/Gq8oaM31gPGGxS+H2VKGkdOjFvF2POxUgxV/pZKh5hFX0pD8XQIbjZSCsa9xTm/df5/WmERWMLauSLBnIyn7x9XHANfBWw+zSZokiHdDwXmv3DrbxibP86MNelml/7nnPPsci2jCbcpyWSMslUP5P3zHOI3vbaCsGkawfEjDo9sDjDhhvLgD65wfks508rfNUI9qEWEQSmz+iAvzkAiv0NPw64p2VRBP0iJK0LVUq8wpzdYdHc2MZ4YK1WDjr8tAef4hm3zwsUoP5jm/sHme8Lrw4CUDpRbfhhNjo0qpNisnBP7i5opao;4:qJkX6/Zc16ob4mOonAFXSNWCpzh9JeMcetwqHquc874hVCkMXYnzrfSLQDCw18fQleHE3lweoQ4qSHTKHYpRoUd8kY4XDydDXdLGdvPCYyTu5eb11LWYAbpkXLRSjlhUX31SYcAmDkEqGF2iInUp1esBSWMv9Zbt5OhXWWjN1khx7wVZlr8856SnegbAQZWCeFwUgpGUYk5rhZ4LIWdOZl+iK1ycFspTXUrHIoyvUEwp03Wu4tCQBwuLfNaRwONyBIIs2KYgWsYYjCfpFtjhVmDhbgatAu2i8ZRHeLMPWAVI31gJm39zhWfmNAZnejrZTisdX69UvJhI3SzfhUY0axMgKz6pep3azk1i2Qpp9P1xew5xz9fykbqBG70gg3Mr
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337B8F13F29EA6564C248D5CD710@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(396003)(39380400002)(376002)(39840400004)(199004)(189003)(25786009)(3846002)(105586002)(6116002)(55016002)(59450400001)(33896004)(97736004)(2906002)(58126008)(478600001)(103116003)(316002)(5660300001)(106356001)(8676002)(39060400002)(76176011)(7696005)(8936002)(55236004)(386003)(6506007)(9686003)(476003)(956004)(23676004)(68736007)(26005)(66066001)(86362001)(230700001)(575784001)(61506002)(47776003)(53936002)(7416002)(446003)(16526019)(305945005)(186003)(11346002)(6636002)(81156014)(52116002)(50466002)(2486003)(81166006)(7736002)(486006)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6RllCTEVTcVIyS1Mvc2psQlVUcEdsWHo5?=
 =?utf-8?B?YUxNUHNJQUE1MEdmT0QxWDFIV0N4TkpHNkxKVlFaUnB1SmtpMFNvcUJLOUdp?=
 =?utf-8?B?bkxFaU9TQUxXck9rWmE4OHhVbEtmU3pxUDNlYk9GTkczQkJXRzJIRVdhL2ha?=
 =?utf-8?B?SEdHZVljckdwVE9VTjk2S2F1UGovS1Y5Ukxnb1F3eDlsNHJOWmNVMG84Z0Vp?=
 =?utf-8?B?YjdtOVBHem9XK1VDWkFGR3p0b2MyemwzTnpXM2ZSVllBVUhFQitaa1VtRVJY?=
 =?utf-8?B?U2tKRmp0U1lTRUt3ZW1yQnZmSnovY0prUkMrOTFMcUhqS3kwb3Mzb3hNZGdU?=
 =?utf-8?B?dFoyaHRVYzI2b0R5Z1NOUUcrNCsyS2ZMZ1AwM3E0N0tnU0hWSHcySmo5MXJJ?=
 =?utf-8?B?azVUVENudHg4UG1VU0xVcENuZ3MvOVdBSTYvYnIwdEFGcDkvMmtWSU0wUTY0?=
 =?utf-8?B?Vms0QVB6VXpObWhFL1dlUHRjeHJrdmFXM21CQTJYU1EwNkZremlWM2llMFNR?=
 =?utf-8?B?bTZXQ0s1SDhsenFzeSthQ1VjR3BsVUlHMXZ4RzMwRXRpakdRZ1N1Q3RTUmRV?=
 =?utf-8?B?VC9Kc0xRL0FPeGJSK3lkL2NpQTFwcHJ0d0RLVFJOdkdFeDZiUC9jdEhHNmxJ?=
 =?utf-8?B?MGZNYUtReWxSdFEwTlFqUnVNRDBPRFE0MDJ3OUQxQVUxdGM5ZHFUdUZqOS9m?=
 =?utf-8?B?OFFUSWZnU2dsZHBNajJyeTRQdHd2SzFxYThKbWpRZWFjOHpmdXA5QVNPTkox?=
 =?utf-8?B?bjI4VzdBMzVlTUVQNU1PYVJ4YVNHaEQzWStkbDlGVEx0eURwY0FFeGVySDJl?=
 =?utf-8?B?MWk2Tkt2eFFvdkcyM3dqaDY3dXlMa3ordDBhZG9jMFR5Qi9PV3dsQ0pxUnNE?=
 =?utf-8?B?SUFITk5XYXV6YmpROHNzdWM5ZFpmSFVrWjBqV2JNMVlWTUdNUFA2WVpQODlU?=
 =?utf-8?B?UmEvdFN3d3ZtdDRnWVFkQlhQZi9oVkQ2YlpSeWUwWitGWVprd3Y0NjZKcSto?=
 =?utf-8?B?ODdOMGZ4UnUwekxsb2krNVZ6SHNGbitlOXVoa3JNcGM1NWxuU2gxVFBpUnc5?=
 =?utf-8?B?ZEVxWC9naVdyZWRsNGNFNnJoWVVRNzZjNDN5NzRtcldhZWpjUkFuek56L2xJ?=
 =?utf-8?B?SzN6SnRibm1tdjRaV0ZiRUpVbTdQWmp5dFpBZVdzOFJCclBTQVhHZ3hoZFlJ?=
 =?utf-8?B?eFZrNTh6RnFqRDJsNzFmblpJd2hHdGR3bWVPUEpnd1BadjY4SzRWSUFQbktp?=
 =?utf-8?B?K2NFS091ak9iL2JMampEd1pmNk92RFd2VDNTeHN2eENSK2lkUVZhZkNYRnd4?=
 =?utf-8?B?OVhtSjlLRGRsZ0MzT3Z6aG0zbXBhUlc0RXdzM00vVEQyMk9qdkdvZnJMdDR2?=
 =?utf-8?B?Rnp4TzFYazBNbVZJMjR5S0Uxa0p6Z2pIM1loM2c4akFtMmdmT0RUVG9Xdm1h?=
 =?utf-8?B?QlpGZjNxNExtbHg0YXBTOXBzUTNNK1NjaVU1RXpNQ1FzaWR3QlNPcHBFMk9K?=
 =?utf-8?B?bENjUjFvNE4xZm05ditKeDk5Z1dRbVpRT3N1dDd5aW04YjZOQmk0bTF6SHVQ?=
 =?utf-8?B?aXhiTlhIQ3F3UHZCdXEyQ2R4T29FYWFoNjRSMmZiSW5BN3VnRjUwM2U2RTZU?=
 =?utf-8?B?TlZXcDZnRmsrL1pPbjM1eFhEcGx4aFZ2eEZBMFkwc1A2cHl1TTVnaC82cHdK?=
 =?utf-8?B?TmRISWhJTVR4R293MEtZQ1lNR21md3RydENhS0FMeklsNm1qUFgwdEp6eTdl?=
 =?utf-8?B?Y2tmMmJhTHFadGc2ZkxOMW1TSEQxQ2JZc1dMellJZG1scm8zWW4vZEtnMFJY?=
 =?utf-8?B?TjdKcjExUzZHWnluTTgwN25yNXBwT3RjWDhFQmNHV2hIK2dmUStYd2J4NzdJ?=
 =?utf-8?Q?szY5kWsPZWLI8=3D?=
X-Microsoft-Antispam-Message-Info: k56F+y6LMlNGYlyZ2pzubuIQetwbsUyK/+nPNZRzrjXHfW5+N+VHKx2L7tEUsYXaolRMYFV7yElAIBolUQmQoG/Cdu5SALSUXqpQRkkejUQyOQGyrrTblH8VZLE0hPTi/V92oWS7FAFCrMjnwS/icgwP2i589rfN9tK9POfHATnOm9mdiriXQL5uEZca6+If
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:HTXx8J9fSUzeiYfdlk3fV6WNxgBZn8jk1s+Gu899IlO6k6NnluDvJlz7CyVkGRj/8HxI5Vk+jGK05mnMaB64e75qk02+YrPOr8n2VbUD5CuJQQrCxhRrywze7V+xcBMhF7y37gb4Ow0DQJl+aUGvhXnW+wqwQa2YogsEM4escl34ttP+C8D3JrYEe3Mlp6v6B5zZAF24idUqyJXXLh/z02qIdyMSYFnBCBxkuz/bryLNI0foNB/pLy281dkUBCHOJ/ETuo2auz2KZ25mwNOmOqEKaTBKyajwbzYwwApZjQY3wBG/appRejhob5xvc+Y/zC7K++3asp8DoqXo6UUSSFK9on3ljXwC1noFGPlJunolMHvzdKTpUpP7ZhlBghkNh+F5tjr72S+Ltc8qTYKRoeDghd/93cPnCIeNL9zhKzPsk6g00qmaR8RPHTNPSNqE8Gxt+51xAlmAjGD+es36RQ==;5:gDgSe291tLUXm1sWKLJ5eTtW8PMwq8ZSyu9hug6DYlfCE04Hqsm0o7k84R2m4DiiwALy+ZrF04fTsWzL1PEr1Lp9ddKEi/qUqehasCXSnxFq1avS2v2AvcuJsr6lZV3xkIT2DPvZRjvWSx7mOG/xXC1onT9NWXCdj8bywHUwtas=;24:iuYVQaoNzzrZrv/YzFWQNcOeiMDNhvtFaRlR+js29kzlg1hcZahHuSTNDSaSkAZIZreQfelWcdqP919i+g2hb8ATvKtDk5kydqaoFNagL3U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:Z3zuBzD0w2lfn+POsLrlGJSKniSPP/gN4i3u9UET3lxPjTkudWPcQoxNIR5xyKp99Y57Nuy6LubGG1ClPEeXKHC5vFZ9ZGZtEerYm7uF+aYDEiQzWhef/eabFu6SdML+kpk7k2mEY81waf0/L24J/RLKuyVn+IEfR4D0El0rBIAQK32l127xi+IqdDpwg9bopj64WsHd5LjVXfGmUij9eF+uXyH0UmoP5udLKI08GyfsoZSTHRfV/4MZO3hToqXx;20:PX8/FB663oTC5uqa4C+qaJ6QVg5ofUi1NDRTOHvIFjdnjueSrsv6gOqE4+WifgB8YCcKLQq7zeWvHKVPt2kS+2W0LB4tLDraGTOymkcutt2kPc/0+Bkf2DBwUTHxiBfmTnWK/KUbbbmzCohcH5ROvRC3spO1r4EOz+HknmgGg4o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:47:13.3811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6913a5-dc82-4dcd-a373-08d5d5007884
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the preparations made in previous patches, in case of memcg
shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
bitmap. To do that, we separate iterations over memcg-aware and
!memcg-aware shrinkers, and memcg-aware shrinkers are chosen
via for_each_set_bit() from the bitmap. In case of big nodes,
having many isolated environments, this gives significant
performance growth. See next patches for the details.

Note, that the patch does not respect to empty memcg shrinkers,
since we never clear the bitmap bits after we set it once.
Their shrinkers will be called again, with no shrinked objects
as result. This functionality is provided by next patches.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 51c3d1a0fc91..07361ac766f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -367,6 +367,20 @@ int prealloc_shrinker(struct shrinker *shrinker)
 			goto free_deferred;
 	}
 
+	/*
+	 * There is a window between prealloc_shrinker()
+	 * and register_shrinker_prepared(). We don't want
+	 * to clear bit of a shrinker in such the state
+	 * in shrink_slab_memcg(), since this will impose
+	 * restrictions on a code registering a shrinker
+	 * (they would have to guarantee, their LRU lists
+	 * are empty till shrinker is completely registered).
+	 * So, we differ the situation, when 1)a shrinker
+	 * is semi-registered (id is assigned, but it has
+	 * not yet linked to shrinker_list) and 2)shrinker
+	 * is not registered (id is not assigned).
+	 */
+	INIT_LIST_HEAD(&shrinker->list);
 	return 0;
 
 free_deferred:
@@ -541,6 +555,67 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	struct memcg_shrinker_map *map;
+	unsigned long freed = 0;
+	int ret, i;
+
+	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+		return 0;
+
+	if (!down_read_trylock(&shrinker_rwsem))
+		return 0;
+
+	/*
+	 * 1) Caller passes only alive memcg, so map can't be NULL.
+	 * 2) shrinker_rwsem protects from maps expanding.
+	 */
+	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
+					true);
+	BUG_ON(!map);
+
+	for_each_set_bit(i, map->map, shrinker_nr_max) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.memcg = memcg,
+		};
+		struct shrinker *shrinker;
+
+		shrinker = idr_find(&shrinker_idr, i);
+		if (unlikely(!shrinker)) {
+			clear_bit(i, map->map);
+			continue;
+		}
+		BUG_ON(!(shrinker->flags & SHRINKER_MEMCG_AWARE));
+
+		/* See comment in prealloc_shrinker() */
+		if (unlikely(list_empty(&shrinker->list)))
+			continue;
+
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		freed += ret;
+
+		if (rwsem_is_contended(&shrinker_rwsem)) {
+			freed = freed ? : 1;
+			break;
+		}
+	}
+
+	up_read(&shrinker_rwsem);
+	return freed;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	return 0;
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 /**
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
@@ -570,8 +645,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
-		return 0;
+	if (memcg && !mem_cgroup_is_root(memcg))
+		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
@@ -583,13 +658,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		/*
-		 * If kernel memory accounting is disabled, we ignore
-		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-		 * passing NULL for memcg.
-		 */
-		if (memcg_kmem_enabled() &&
-		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
 			continue;
 
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))

