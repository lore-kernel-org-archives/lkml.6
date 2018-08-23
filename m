Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC076C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2DF2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gJvqjzYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2DF2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbeHWNzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:55:01 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com ([40.107.1.94]:19727
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbeHWNzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybxUWa84wHBoyd+O/UM1ZW7q2fKYFypTjY2n8DtjlBw=;
 b=gJvqjzYHRFu1J5apeW72vP4tVJ9+IOGSxC0/5hD+ULdtad/mDtD38wYipZeSUtSYPiHCopKTmglaFUScQanCHVu3xIXHKwcAV2TypP9HxeWBMk980QLOkd6AhJX+20VoKqgzTt17aPVKsNirEbl5B9C5WYGBILboe4g5CPy1KI8=
Received: from snorch.sw.ru (185.231.240.5) by
 DB3PR08MB0188.eurprd08.prod.outlook.com (2a01:111:e400:504d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Thu, 23 Aug
 2018 10:25:52 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH] tracing: Fix event filters and triggers to handle negative numbers
Date:   Thu, 23 Aug 2018 13:25:34 +0300
Message-Id: <20180823102534.7642-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::19) To DB3PR08MB0188.eurprd08.prod.outlook.com
 (2a01:111:e400:504d::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19625d18-351d-4381-3bce-08d608e2cddb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB3PR08MB0188;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR08MB0188;3:m2fxBOvLR1wDKshb353QTamh4wzYao21ZPexhuYz/UKMWs3I4tg7W1fzEmzdmkJpETKu5cEtJ1EosWdKol7sbayDTPKtOGdqOGyp3d15Gch9TxTq/4eqr0lCXgWM2sXtf+0LvzHCZWRAG7sNbe49l2MFlSdVFyIHAP6zfLWNBwRzGdjoopVuoda2FGbfJ5FvaKEkjYKOHzLQH7GYaeoPwwN/iTOoFXXKwa1EXTaXzT9hn8DWcym1pjUDbk+2HNX+;25:DD6mMO/JzC4V0+JkwLiz2+ODiAklhmLRVHOclrfjytY0ZyFmD9RBR8rwPSWeMUHfVz1U9GZpiPyyJnE4TJH92ReAMezls/vzIeYZpNuhLx9NJ5LRKDDe91+4onJDMbN8RCNp1UrABRXGWvyTZF+JPOf1gu5Uqb6/8N3X/kgvj/oN/aRxJZQ1PSfC/PpkSxziIFOkEKm2xKYWa/ivIbpsr/TGbIEIrS6+byHdVlfdZLVJz/6k3fo22y4ZmEdguX+7Ej/eBZUDkQk20rjW6eEaOvMBEWcpVGV587ckzmHhV9PvevRRiTlm5B7IjoseI9e8KZKSfvfGEPBcr6o2mXcfGVGfCxJgKwsBsxOBdj+DwUg=;31:BWo8tqQk8mcPRAzok2AU2JrRM/5tzyt28q5GP843y9CpctU+dEwMnj7ibhbn34BrpJiwpLTSdWWeq8mZJue+6jzFRP4g1wDoNxLfT+TE98hjMuW7YljpD77lWrROnkGKXuVDdqb13qpCeifqhnTkQbk4/eUTQsvliXhKoKCntZKe+9YO9dXzgqI/6trC08L6uIIvI45DjJMVfQ6qh48GMXvBxGmcKEFn9zNTkH8UZK4=
X-MS-TrafficTypeDiagnostic: DB3PR08MB0188:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR08MB0188;20:UPr0NZRal6evT+YwcLDVJ3IK8WsvAPG6yPoSimiM2wo2kfmRQCyRaB1Y6IKuOnFIEriwu/03ECzW+9BduY8Sfpp0sQsYChGsPlc5eXZXuxQYz6969Ulse+ox/KzWs9azn1iYAUXeVM7PhaGc7yKloo3XlNzdLTgzopz0+JChJfz8J6fulpQr9a5WDJ+oI7wf8eovPiIsMUrQarhER6Xneok1D/qV6ElcG/V4KBufj5eYp4nYYl0S8mxltQl3Jwwj4s2Hy+GhU+P3ywOteJz3wINzAahnmQpr29Zl+2NBdyplI9GUNYcCaHKkYv24pRyEqiA2ZBpnaAb2yEBqvkou4Bca0F6tOoK6wN3IdzPKLrqdRXqWcPbsUX/8kUBMQfa+3MkTize+nHZKrnvJZPyRhaM+ZoVqMYwZjUFbMHJM4UcFOfH8bbXcrF1HbAbaTXa6ZQ+L/Qh9cJpNU4EsZNGp537geN3E25oFffpWGCo79DmNxlVtSpXUvP0+ZEEaQQ0B;4:6M3rFdlDuRxVB02eUTG/gINKPx0hH1+fXh3UZnEOzBwtSSaE8EkQmWGc57cV+smLq18h9Kr5G2JVOWxsBQMFb6sha9R2ooalNulcS3rQUpw51CeQhtkZGcWHpDc5//zJ575lgEshUlCVqhblrAAG1ZTb2HO9BSTT9bIPBgpDGdrohRUvAjFggpKfURDssrdBT9iDvI6izsVvJ7LOy4BZiFiiWB4fgIfmte1sLeE1b7iinhfz/aoJzaPxHfl4x3PtGW7Q0HsurB+4hu5MX4ZkFw==
X-Microsoft-Antispam-PRVS: <DB3PR08MB0188682AB3E2ACC5DE031D22B7370@DB3PR08MB0188.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:DB3PR08MB0188;BCL:0;PCL:0;RULEID:;SRVR:DB3PR08MB0188;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39840400004)(366004)(136003)(199004)(189003)(186003)(16526019)(386003)(2906002)(36756003)(6506007)(26005)(14444005)(316002)(6666003)(6916009)(6346003)(16586007)(1857600001)(54906003)(86362001)(476003)(3846002)(486006)(2616005)(6116002)(956004)(1076002)(8676002)(105586002)(97736004)(47776003)(50466002)(69596002)(48376002)(6486002)(51416003)(52116002)(5660300001)(107886003)(81166006)(66066001)(81156014)(4326008)(53936002)(68736007)(53416004)(478600001)(7736002)(25786009)(106356001)(8936002)(6512007)(50226002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR08MB0188;H:snorch.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ptikhomirov@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR08MB0188;23:U1GW4Ne+G6QatyC1ewBxNd84coA2PCtbmvwz58HRA?=
 =?us-ascii?Q?1NkCcWAq6e44eWXKm7JTCzVydwAZ1Gc627V95Qx8tL41gDeIGqvzMzBJ4hR+?=
 =?us-ascii?Q?A1DO0diOHIZzK7Q7T+9zQci7nsTWtaWSTtRAq4Y6yyVh+H7bISYtiJKgfFY4?=
 =?us-ascii?Q?VHA84/m7FdHNUz7rTSrWk7zcjNF8ciHm7Kvp5u1i7Yo2ZOVpHSBTvDS6dZxo?=
 =?us-ascii?Q?pZftwP2Uve+SgadJg4lMDWnFZ64ywAZPTg3Mf8/lAOotRH++AvYk4DkffN/o?=
 =?us-ascii?Q?0AKD9PCfRW/+4/nxilT12qWT3N1JO0AYOGqpu1YapySDdre0ZZm8UC5RROOd?=
 =?us-ascii?Q?fCn7ehBJ/OkPIf2N6kIeoHDLwHcP7GPoR4CRjcSvO1YX0MbCOAQ4kwIYZFlI?=
 =?us-ascii?Q?E+qjsMi10Ffs4oy0WeYrtBZNxtw0FVU7T/igBqcxuWWncCYc1BdjdL7Po7pN?=
 =?us-ascii?Q?GIza3BU4SiI7MlX8rGPqLrU3kuorhyPmWlZIQByRcUD5reTB7lo5xppAzCN2?=
 =?us-ascii?Q?VpazuWeVVrTtlrrPlVF1Y+kEiXNOsl3r/zJSjdkLzn9oWI94mf7957Fx5c6l?=
 =?us-ascii?Q?cU65O92qIi9/g9CEvLk5BNtA7wG1zxazcDI0stTZkrlPglGLdVqvMUquROqG?=
 =?us-ascii?Q?r66tv4em4SThy0m3k5z4RAK9mWqaz602hRd5/fb9mcGy/CUnflq1uuZNUqoF?=
 =?us-ascii?Q?nmmCeAXMCxC6LAn1gJ35/iDLhTJpyokyAri7uycQ0b7Y24qCTsvkT/yMO954?=
 =?us-ascii?Q?uW6VgOD/4SdqRtPzt6q+foD6EUiuZSxUyWkL/HBeRNwqLKc+nayVXwiB+ud+?=
 =?us-ascii?Q?Ayd41/TSmM52wMYV3DoToufOUrlTGTM4TP7SaaaKPPz1GByzY9JtmPa5HEJ/?=
 =?us-ascii?Q?CBlLyjhRdVqRB9fHbSkOD/bQp5NeqLgQslwccu11chvEhvKikw8INo+bjUSz?=
 =?us-ascii?Q?uYXWVG0MARzM2BpPFZr/4wcrr2HYhF4Gn8eBODxjhnQ7v23hxP00ZyVG43G9?=
 =?us-ascii?Q?fLOfexUE1rSZ58erx9I2sLraTnyJsAzV1Ee24YoGMo9WIdR74isj9GzvmLZy?=
 =?us-ascii?Q?uk1r1wGMiRasKXXUM4vgKt92clmdmbWb+wTMml+XGllGj7SiPOIjfoqxr8S4?=
 =?us-ascii?Q?3YO1pQmfRpXyi13rwWMLW5+Cqlkv/lZ5Owlwnb4ASAiWsVfIyMtvE6GIbLEA?=
 =?us-ascii?Q?bKpu9beDFYqyEcQz2rqWFUJOB4tOplB9Oey2FJIJ8cfqH5WfBAv9cWFlfQSF?=
 =?us-ascii?Q?/akFmH5UG9jVptL2oX3oTKQpmEC/zXFis00nXyt?=
X-Microsoft-Antispam-Message-Info: 1HbrtsjzrQfYhmwTdST/X5isZ3pwsUD+IIsCKCE+3EhS8Bbk3GzDZgefdV1D4+QyK2ORKdIKTkuTqcg7g5kClsqUxrr4njcB7ujIfWujaB97qNq6Q5HQm8tBPmNKktfJtuUTlm73iS2gd5oQjc/OEiILuUMUwSPRXkYkkwQkgzDRXWG6wDHzds7cOUDfc/MWhkm5Nc/aRFGHaSKdBVV+phQK8a0ghHSLWYbIVmfu6uUO/VzzAcLMTC5n3H1SzB2P8f5EfPioucVk2wikOXpEtYuNeTe+bUhzi3rg7vKXiK+U/2U00v8iOoMVZFeAhWxL4DDk4LIJaAdhIEw5KRqRm9beu1Em0fs3CLRZfVUnB5o=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR08MB0188;6:AZikWqBCK6ldsw4ukk3gE5XLPYn0RWOaswq7SfnG9Hvs11rV2ERo0ysTP5m5MQLcRcALKag2/G5NubJeLpkUvcQrf1D8dSJt2ZyLFpVnwGGlNchU00fbjCMLUpidlG9WuNCiEdsXpUg1YSTCCxcHukGxLPdRDnW3U/f1mnL6N1vQqZpiv2cSL7rkjS7uw/i2Hfi9Rkfp5/SSqk6Y1xR9yvX13P4sijIHvLtjDrzXMfwCbPCEkAXbcpNO+H8NQk8D2iGWc+B40QWYBZV4wfiw4fgyV/JwiMQPSH032MOHfPIbi4FZjsYAhJdL8mDuejf8SB7ykBK39+FrwTHXM9JyYb8sIg6XtgNlTVv5wNRr9a1U84vzOIzn5ZNHG2khTrgYAaQya2xPH0UW86jeddXYYw1NWn/oE3yZALMm9Vg06wI/DUi/whhHf/olggBLXNIHVEvO4WYBftvfx+l7wuVBbQ==;5:GWSBcpZ/11jshcHmD2/pAysljsWp8OVxypplC/nOoZhQXpLJBzdxNjvDfrpv4JvyYD54Y2Md6Azh+hIoELKS5jTrHSxhLuj3b0il34FWcwfpThQWh/n0w3pQPhEqkVpL3TV/5cxiQEaf7p4k3tzJUVswg+2MkxuOM5DkjUwgv40=;7:E4jORXDdaakPKlcjUHLitZWqG1igx7tbqcSQQ5gUfNh3X6FDa9PMtR2lGrRvT5fiFSsr6mPjz7C3X9lGLIOfMzOXLeP6yKeXN24ZPXsXH+p5itBJWAXh57XVMxJn2Pdm84v5+dyNJqxFexR1ddvgLtMglkspGuZN6gThuBYMAZdCKitPG4jlFd1ojN0VCzK44IaYAudRexkj5/dqvJq/8P988V9eVVmMF42BBKBSq8i0l2UH41L2A/Ic+Dx6UHtC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR08MB0188;20:8hdAU3y0KAE4ktOvbwYUCX4djTqykDXMvTI7/5wMZIxmKkSDsTlHw0Xfu1Twba8hNzp6n2vC3u5kRjtKG0eVCdEzviYxzXuDr+me5ASvo2DwrHdjTjG8ohPYW6daTsko8s5L1guJY04UlquoE8LfVwpoEfixHQ42nkfKwBeWkCA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 10:25:52.3737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19625d18-351d-4381-3bce-08d608e2cddb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB0188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Then tracing syscall exit event it is extremely useful to filter exit
codes equal to some negative value, to react only to required errors.
But negative numbers does not work:

[root@snorch sys_exit_read]# echo "ret == -1" > filter
bash: echo: write error: Invalid argument
[root@snorch sys_exit_read]# cat filter
ret == -1
        ^
parse_error: Invalid value (did you forget quotes)?

Similar thing happens when setting triggers.

These is a regression in v4.17 introduced by the commit mentioned below,
testing without these commit shows no problem with negative numbers.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 kernel/trace/trace_events_filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 84a65173b1e9..2ba449292561 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1299,7 +1299,7 @@ static int parse_pred(const char *str, void *data,
 		/* go past the last quote */
 		i++;
 
-	} else if (isdigit(str[i])) {
+	} else if (isdigit(str[i]) || str[i] == '-') {
 
 		/* Make sure the field is not a string */
 		if (is_string_field(field)) {
@@ -1312,6 +1312,9 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
+		if (str[i] == '-')
+			i++;
+
 		/* We allow 0xDEADBEEF */
 		while (isalnum(str[i]))
 			i++;
-- 
2.17.1

