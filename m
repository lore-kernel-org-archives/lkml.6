Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E15C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089B257BB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="CEHbRW6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1089B257BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nextfour.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755293AbeFYKyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:54:23 -0400
Received: from mail-db5eur01on0051.outbound.protection.outlook.com ([104.47.2.51]:44977
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755242AbeFYKyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com; s=selector1-nextfour-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bDj/EyNRzwpw2NFrC8emmskeR6H/WeEpW1X0Met6dA=;
 b=CEHbRW6jmYtcm6UfMgGu2nZroSXT2zOlgKRmbD7XjGavqaQe4HYmR+EBULxqFrZqEbSQnardXXBgSnVxG7YXumQ/l6FRs8tKzSbh+qMl2Pbu7qUlQ1Tt3jG1talOI1kfuhjIKCFUm0pmvPV9j0TpgzmIKLqe+fRPDJlDDv3P6xw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
Received: from mjp-ThinkCentre-M92p.nextfour.com (194.157.170.35) by
 VI1PR07MB3341.eurprd07.prod.outlook.com (2603:10a6:802:23::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.19; Mon, 25 Jun 2018 10:54:17 +0000
From:   mika.penttila@nextfour.com
To:     Peter.Chen@nxp.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>
Subject: [PATCH] Regression fix for Chipidea USB
Date:   Mon, 25 Jun 2018 13:54:05 +0300
Message-Id: <1529924045-28556-1-git-send-email-mika.penttila@nextfour.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1PR05CA0194.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::18) To VI1PR07MB3341.eurprd07.prod.outlook.com
 (2603:10a6:802:23::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47212c55-6deb-4d58-3b3b-08d5da89ffd1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR07MB3341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3341;3:Otljh/487Irdos0hEFecpL+SHO157EEMKyP4y+hEazws6kHbospY0/1r4Qi5P5igETKbazI0HveVdew+tMYlUmnDedUlsY/hvAPPLHzyzoQbfyz2/fpfmHugaI+eHz1N+maGRoq7D2zMENEYGtUKwf25HQoDgbaKiK5dVIrMFgV61/zEoO7sctnZqCYUQ7sQQZtLwaaRchkESufaSWVWKeI03/+B2jO+GEgMA2ZMToaSM7ZF4YSveftdyk7r1nzW;25:vnMxrKrTKmxAlODmS+25Fqr21c7dOHNCk4eNTvxSUmZ7yCXMJkjuX7Hb9lNDoq5zVAmHPoqJEDeMggvAmKqUpf8je0dR/+dxUzWfPMetdtoWi6noTqVbyb77yqXyp73VqVBNJ0zly7GC01ZCE1L75Bhi+ZWxgKOe9wpDZ7/FgTN+ZW5ydrMNu7OLXlHyDfOnvvMA4bUXlfw15ff2Nl+ciCA/JMjedxm1sOqQWnlbudcM5CbWEXj7PIKZtAKaCsn/z8XiUFNOx9LyeL433jsvkxdFzu/HJtU2RJr6gc2HqMsPOCjax0P3ay1p73HdZ1+h9nNPgLYFdzdW2K1owxWh4w==;31:eVHxEf+HoUfPpS1Ia3Feh/cY07IjX0LGI47xCwLhFRA917kJr/86zqusYzEidX6ETvz05EWbSlsAs81PXaN9ONPNcmh+sqjXj53nNFLmEsNuB7oPpDcwPLDLA2K33lGEGJdI2fY5IFNRmJYiCTk8bwr9QGL32+MNPtRNHUfJD5IapjdYTkmUIMILh6NCoPe905KsncjzjWvHrwvN0GcF3xezLxIOYrssWgeMc4t5CMU=
X-MS-TrafficTypeDiagnostic: VI1PR07MB3341:
X-Microsoft-Antispam-PRVS: <VI1PR07MB3341582AC108C3320EA2DFAA834A0@VI1PR07MB3341.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(8415204561270);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR07MB3341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3341;4:xQ7dCHSrRxveAeCsK41S0px90J9zBhMcuNJckAK5IDNVjPbB9ArJtcKPoGSLvuMzURYJo3au95UsF7CrTVY6Ug20qOMyhnYyaFYRe92L/F664T5uaZ0GgU48cOuCr5bwjpXWWxqCpZoBdV872J5P/i1bK64thi1yD77kas3kkRKbWqqYW6yWiMsGw4QnFmQuqDiQ0XUcpHi/zDkc166GhaHnKTJTzgtJ9ycCEwzf/Rs3GlSSYoAjZczdfZG+cK0HXXtMQ49kiBBzEbPd9EcFUtv+9dUCnknGCoPvmondYdLJuMiwS4pHUusMmZ8eKFhv
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(376002)(346002)(396003)(39830400003)(189003)(199004)(9686003)(69596002)(6486002)(85782001)(1857600001)(316002)(6666003)(86362001)(8936002)(8676002)(81166006)(81156014)(2870700001)(2906002)(5660300001)(486006)(2616005)(305945005)(7736002)(3846002)(956004)(476003)(6116002)(97736004)(106356001)(107886003)(4326008)(50226002)(25786009)(53936002)(478600001)(105586002)(53416004)(386003)(68736007)(16526019)(186003)(36756003)(47776003)(66066001)(7696005)(26005)(52116002)(23676004)(50466002)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR07MB3341;H:mjp-ThinkCentre-M92p.nextfour.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIzMzQxOzIzOndQa2FIUjJzSCs5ZWhOZG94cjNVMTh6MU96?=
 =?utf-8?B?WlFFbDJWbm5xSjdKUUdxeWFRMHB0b1hYWnFPMSs0d0lTalYrRnZSeDBxM0dN?=
 =?utf-8?B?d3RxeHUxUVp6UTFkcVA1cFhoVXovTDR6QzlZV0trdVdsS244VUF0SlBMQXI4?=
 =?utf-8?B?dmp2NEFQMkhMQ2szaFZnQkRLV0RJTFFkN1VFMFhwVlBETW96c05nYzBQMHBL?=
 =?utf-8?B?cmQxYkIzL1NNdFBRS1grS1hYNkd4eTFYdm1kaHIyajhvci9zUUlLYVc5blN5?=
 =?utf-8?B?VFQ5Ni81WWlEdlQ5V1ZpakJ3djI4SEJLK1M0MExPSktLY1ZiQVcvNG4vSVhV?=
 =?utf-8?B?bFpIRitHV08wOXJDbmNHTG51M0tOS3Mza1JmKzFkTmZ4dE1yWmduOFhnVWlw?=
 =?utf-8?B?dVhLZ2hKUTVuNXFkN3VzYnFkSHY4bEFFNkl5SmJiVnc2U3VKZ01aNENMZitk?=
 =?utf-8?B?VzlJdDAycmtWamdkekU1UEd3SU0vZ3hjenJBcDRoOFY1YmgvWm5RcmEvdWN1?=
 =?utf-8?B?VDEwYkxGdkh0T3NPRjJXMlRJVHdQdi9KcDdNTmtTc3pJM1BrRWpXTFZIMWtZ?=
 =?utf-8?B?c0w5YTNDd29raW1yRjd4WVhHZHlycVh3VVcrOVRvV25wdzNMZmdBTXFDZkh4?=
 =?utf-8?B?dEx4T1ZRMmF1OVMxZzV1ZjJaUXhpVE9pYlRydGovYTFjUUoyZzdwNThwdE5a?=
 =?utf-8?B?d3BWQ2ZRTkNidnJHQ2Vubm4yQndsbml5MlpMS01rb1ZBVVQ3MEFETkxZRENk?=
 =?utf-8?B?Y0NSQ3UwMi84ajhqRXpuTk5peTRmb1BJZTlGK0NtTTBhYi84SUxpTTZ6Vi9W?=
 =?utf-8?B?NmtSeFhRVllwSVFJQjRJRjFXNW1aR0RBeUxrcnZuTVEzNThxRHVldUNWdjBS?=
 =?utf-8?B?eC9MNzhqWS9XcDJCMzFTVGVaT3oydlQwQ01CRVR1SUJqVExUVm9zYUhSYXVn?=
 =?utf-8?B?UVJXaWQvaSt2Zm80bURpSGFaaWhtdmhETXlNM2pkd01nYWV5VERTVXpTR0RQ?=
 =?utf-8?B?RXFtdWNsQWd6NVBkdTF5dG1Jai9ZbHdIOGs1S0VyTDA0U2t4RUhhWmtJaHln?=
 =?utf-8?B?NXgxcWFSQ0pFNjNRTGwzbnV1NGV5ZXk4UnhTVm5XMDhJTXhoUzN3dXV2S1l3?=
 =?utf-8?B?WStTQVUzelMvTlFiMlVMTlY0ZzR0cVNaRHoyUklHZ3ozcVBuSjRyK0tqMmZL?=
 =?utf-8?B?ZmJtQWxOaDhXcVA5SmFSUG9hRnEvTXp1cUhPZEJ0Y2xkdWw5aW5Ddy8ybjNU?=
 =?utf-8?B?TVhUeFFHMFhWYmQ2OVphMm5IbmlGSGFKb1NOSmppTGxGcC9lUXZLVzBwbjFL?=
 =?utf-8?B?Lzk5WGhUakdOdkp3a0ErVnBXSUNtY0kzYU8vcElzRGxCb0drYkdTOStNRjNI?=
 =?utf-8?B?S0Z0YWV4MUpMNU5uLzNxV3JDSWFFQVRCajErUWo3ZjN6Y1o4cG0rdERqT3Vj?=
 =?utf-8?B?Ull4N0JTNm9vOWpJWVRwTTUrZDhtckpzK2c4V1NMSFF5bytENGIwelN0cCs3?=
 =?utf-8?B?eFd1WXU1OTlwSzFuOE5jd2g0eFVSQ2JuVDgwUXJYVlZEWU82ejhQUEJ5SDBk?=
 =?utf-8?B?QStzR0RuVkxtZHNaWG9TMEJ3L3hpTVRsWlJ0anBWWUFxcTZ2aGlCcmI0M0JU?=
 =?utf-8?B?NDFuTndjWk5HNW44alZwbU5TMUVQNThOMjFDS0FKaGIxVmh1VThMWHVBPT0=?=
X-Microsoft-Antispam-Message-Info: sRR4XrZGFb/K9+mqfP/FOYS/EFllnaTKEOWByAEBICUIFK7/wu5QoJmjETSPpJlBRL+Qd2WONPvzWGdJxs4t2cmLlBct+Eenb3DZjl/fG7bVQKzMc+sgi2BYkBKPojy5k0MIQZudesOZE/sF0CsbAfloyVHHhY6PZoYpGS1u9QmC8M9vKE7z/fj50eNtVTSFaZfbBJFVfl3avn/PhdCIxAPeyGzEKtxZtTBpUwIKK36n1KRk5L7wb4REXsolIoqqEVkhb7pEFFQgQYf3Flw8hZgwxqhUMSTBJ7Yya43wHjTgeZNcbwpyRRHjC9wxPTO6v5w7GcYAvQvd0Qv2m3e5P59n67J41Z6mIQ7nE9ZspM4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3341;6:5WP/UrWTRpS+jwJhLjI5q7vZJQceMLtCidbHLtl54gRDy3ekvmXy2dJIE9vbkZxwVon09TQU0+83oFZn/eT9v0ajSp4uSBk1pQDz047poJZuzUHBpigUOVUDtmNjqBp55Ao4Z9hrVNI8hd/tOwYT8iuZY4RfuaFhvNtuyXCx/p/t8IR1l2JwnxH5ZKh2sRIVacnGT6kEmNyliLvr/Mrjb8ZIs6DeIhJjnR25qsfKhJkXQYiXU/w+2taP4lfH3OaDLpDouNu1Pumt4GQasFKby/KwtKPTmTUweRpqqrfUdhpyC6OiMcy4ALKPRJZ4kpWB79JBOl2RKAbaATpY93dWdisXjnR3iuZ0eJ8WlRXRFbgKXAlg7D0OfwxLQw3ZXcFZOmvypL6svlznJDkUwZ8icStHKwsNlLVTDDFOwiNMB4WBL23cOC0fF5B17EPCqmdZJ/yOOvmPVnh+iJRvZuCeUA==;5:SLxONledzXpUotEAop3s7wg39xl4boo/MG2ljhS2scxknbIaRUzdoz65VBZ4lrgeGieZ3sIsTpCnmjjwQ+N1D9VGFTO/1ugyZdXlXDhDmxwIykcCrJDl0DZEOdvVExBqgSpuIVXLyUiOAc25t0XjZGEOrPrmNuyDr9EhDshJ4zA=;24:+ia8QsCT+OOtMyinYql1Fmp2uPsCP9NYvQVZQJnUJXamM6nDJsj41/XGgi5JHWnUf3no/zqEabylC9EA3gPBynoV0+C4tMShn6kSLhmopQQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3341;7:5yN+X3ooY0G1dqdj42Wg0k6d+r9RdybhsuUCYceWA4qEU/739Wbad8a61C40Ow4ms0umUeRh9cODHB73otJ3xMcsrU/a1FqXCbImD7OzP+Og9aqa4/XaqlhG+TKIYyKTMB2wLWmu1I1vIJJK79Vr7V/MH/L+ar2Uyooi/RHgYh46ohgitntRhqoJH91EOPgrKASJdGAz0fQdGBfBsf8CPfTD39/nm7z288vH2uLCy7PHbplKsBNbOQ0BIJPtElGn
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 10:54:17.7298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47212c55-6deb-4d58-3b3b-08d5da89ffd1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Penttilä <mika.penttila@nextfour.com>

I started to see usb failures on i.MX6, like "nonzero urb status received" after:

" commit 4e88d4c083016454f179686529ae65d70b933b58
 Author: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
 Date:   Sat Mar 3 22:43:03 2018 +0100

     usb: add a flag to skip PHY initialization to struct usb_hcd"

The errors were related to some scpecific scenarios, like usb device reset, disappear etc.

The fix below worked for me.

--Mika


Signed-off-by: Mika Penttilä <mika.penttila@nextfour.com>

---
 drivers/usb/chipidea/host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index af45aa32..c45d081 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -124,6 +124,9 @@ static int host_start(struct ci_hdrc *ci)
 
 	hcd->power_budget = ci->platdata->power_budget;
 	hcd->tpl_support = ci->platdata->tpl_support;
+
+	hcd->usb_phy = ci->usb_phy;
+
 	if (ci->phy || ci->usb_phy)
 		hcd->skip_phy_initialization = 1;
 
-- 
1.9.1

