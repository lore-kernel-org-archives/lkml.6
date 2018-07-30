Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F657FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054F120892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="TTqNhwmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054F120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeG3MZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:25:58 -0400
Received: from mail-eopbgr690088.outbound.protection.outlook.com ([40.107.69.88]:52359
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbeG3MZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGkKyiXlNX3mlfpzREbW/ktqIKGASeaPYABNoNgbESE=;
 b=TTqNhwmfCDB3JZTGFHguRImmhG5X7+H2K1chmc/Kt8roBwVKOcg8aQyEh3s/V0LKYDWCNzzf6SB1D5Ih3LIwAD4FUUpyFIz/NdnRdskQqErpG6FBTJ4QIEX1M9OAxgl7g7+QsJOIsdjNfciEuC29Gje6Y2ll55e5cRkNmqH83mk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kamlakant.Patel@cavium.com; 
Received: from kamlakant--T110-II.caveonetworks.com (111.93.218.67) by
 DM5PR07MB3564.namprd07.prod.outlook.com (2603:10b6:4:68::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Mon, 30 Jul 2018 10:51:27 +0000
From:   Kamlakant Patel <kamlakant.patel@cavium.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kamlakant Patel <kamlakant.patel@cavium.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        George Cherian <george.cherian@cavium.com>,
        jayachandran.nair@cavium.com
Subject: [PATCH v3] ipmi: update ssif max_xmit_msg_size limit for multi-part messages
Date:   Mon, 30 Jul 2018 16:21:08 +0530
Message-Id: <1532947868-21907-1-git-send-email-kamlakant.patel@cavium.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BN6PR2001CA0031.namprd20.prod.outlook.com
 (2603:10b6:405:16::17) To DM5PR07MB3564.namprd07.prod.outlook.com
 (2603:10b6:4:68::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0534ce3-021d-4ed1-66b3-08d5f60a6807
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3564;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3564;3:V/eYtOdjSWkYePT0jv4r4F4QfgpecI2r9eZR7JImJSvNVJmMK7ORI1Sgm/csbR7JBcxYwuXLJ3wXs8g5UBdRX4mKsaf+xpZhKAw1yB7QVyX45wR1Rb6UHNS+o3TOExkqEfqY7y385hCzCgpnEVpN8pPBxaaKuZLW014eljKSE4kXTI76BFJaqGn3j0arF7mkIzSYPBgg9G/st85OVK2lZ/7RO645AHPZFbP/nru5svts3cwb5APUVJXJwLGvI8fv;25:hCVMBCiC7eBspwRqVD/ZGFHf/xCLUsbkRhIJA6Lkq4rZ5t6WVX+AW0rYSoGM9jYRgfrjAu+IhfSzXSjmS487sDlIREjVdH693T2GSNoQHWiSvHBGZty5s+oZUkbUFMOd2/pPC4V+svDQRAn6dmHRhDcWhsNdUZPfGcbXX0Bstbr8oJT44c7MG+GdohhMcZzHWGkxV1zIGE/rm0IIhbrtRYXxT8o40y/xJLinHneQAaJjH3iiDDGhroH9L2TsUL9a1IuYR3ORhFMSrUKT08WP1VbCmC/YQjRs3wXeHv2FhR+7sd//DcjmiWqYWkPiVZxbwi9FpzQlYXFYNG0YM1VbFQ==;31:F6P0HCkz/IDYI+LEis8pGUuoX2jty861YhlpbTjEvAxTMTyojsFnEiM3w+Y4wD4WGj4q4KCL9lsDNXuuuyA1cr/kqeBxg7hgxweziLMPNMJAGbKfB5bSnFULPRcxXM8Ly1kQrwz7A3ygQWYnAuLCxCIoY9tgNnLlFJzFkcEE+SPBadMVJpMml/B2ZeAgeDfyDpM9meCiVIvEo3DUKof2ulIHoxJd5EZcYd6xG5iWr30=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3564:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3564;20:dTBB0Y1ixgwKOo/rTuh69sQLd9ZEholbxE0y3WCdjepYXcPw5WK2/9rspQQS0YRIn1ZkqCR4OICT3kD09xAbpD5AItfgmzXt8rIANp95JWd7Jqh4KSfa8CYjs9Fqzh4QVCZR+aoDW3aarjJNu2+z2dN4A6mNThfQPBuDISU22q5eL9H3i4bSyHANz/dr3st2dZhKKdxjwELPA1d70WDfyOX3lVyYklimyi4hL9p07Fw+b59lEFBQdmw2azX3i5UC9uJkgzVutzG7EZt1KHgUbGoT0NRimZbFx31zDB4Ii5pdpIdJNa/lXUXPY6lsrLqTX9StZh9my0OEJ2fZYFahzE1A5zc9T1jzA2WylnZj5tVRkUqB9OvimOeNgpctct/TRkcgabcHUFJWDtkbVdJBNovCsK+TjImkLoAvLeRDPBZNkEzl+GgXgbNOhZEzCyc3UpjO6L05qMiWmNZ8mhGJDyPl8Ht8j5lwWhKH6GvLAtZ4CQrQKzUr8CkcW4gKkaeU;4:ohqtbsi+g3EGEqkcqIyNiT8xarwlaQ+kBgtqeLziCMEO9A/Ix6t99ksJiL8+2NKP3WNioA7xsYLxI0K1aj1NpJDLqB6vbi4NPuZ3SrzKE6PWj8RAwc9I54VjN4wX8gSXP+Eflow+ARuaN9HSz3PRx6ai8nTKP0qNYmqV1iS9HNM8tIMH+bN51YJwVKgNqAwyB6h0edKo0pT6K9sMvyF4tC0M2mWepPZw0AZgXqgaH6h8aM04oJlSRnu6ifOaFYtC5Eksn0V0YyHa+YJof20FMw==
X-Microsoft-Antispam-PRVS: <DM5PR07MB35643FF7F01880559A739873882F0@DM5PR07MB3564.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3564;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3564;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(2906002)(305945005)(110136005)(478600001)(7736002)(54906003)(316002)(16586007)(72206003)(106356001)(105586002)(186003)(386003)(16526019)(6506007)(551934003)(26005)(5009440100003)(53416004)(15650500001)(52116002)(68736007)(3846002)(6116002)(51416003)(956004)(53936002)(2616005)(6666003)(48376002)(50466002)(107886003)(6512007)(66066001)(47776003)(69596002)(25786009)(6486002)(4326008)(44832011)(81166006)(8936002)(81156014)(8676002)(486006)(476003)(5660300001)(36756003)(50226002)(14444005)(86362001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3564;H:kamlakant--T110-II.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3564;23:LzzhAkf+XWn0bx74tuZHlYdX57hPpqCWjgYISL2mW?=
 =?us-ascii?Q?jO9mKeV/qym0BN6lyQL14M+FjWKo66PhAgD//lgMiP8UBlWMxdVO41H4IkdN?=
 =?us-ascii?Q?0ORk8poJuuGb9OO9rhHTUFJte9qR0rreBnsm71fVpMzB38NHz48+WfsaUKBe?=
 =?us-ascii?Q?66nXpG7STbMPApzVVVzVjQYX3DkvJfWDR9qSruyBwIO5a2Njdb0+Z5xWQhD6?=
 =?us-ascii?Q?y1AYJR69y0Hn+k1NOn58SCKI/NqD3QN1c4PggL3XZ9I5HOvA6W08wH3f2EXO?=
 =?us-ascii?Q?NgK8Y9srlrmYzW+yzqWydTI5wqYod/yy+hrbldXzyd3SE3nQ888NGXVzKSGj?=
 =?us-ascii?Q?QTSP7zjdsUddoPYrC1ORAKwN4vsRoeGqhsFP0kC+2g6k+P+oDQgknx4yRPXt?=
 =?us-ascii?Q?knbR/3Ru5+DZZxua7Shs6Q7S/DuLGnT7/Mvcfwo8BvAUd2u9CvfEds0qwhjj?=
 =?us-ascii?Q?AxiqX5/TzvToUggazez4tge+aqPBMHhgaUGjVeRZTqaE84h8lTUnyf7GLtVv?=
 =?us-ascii?Q?6rFm+ZB2SPKeTwsW9rxkjyYN86f8JCUtirVxb2p6xW0UGliB4SJ+S6VajX7B?=
 =?us-ascii?Q?5DKtgMHkl6iN9cyFr+MZLncyxWuD2A7yZy0pZMa6ogklmUmUSfjqP4AWzvAX?=
 =?us-ascii?Q?Dmvf7wkkQBPlOp9aLnS5UJhbAnOprHNzwOsMdyFQu+aqT73Pf80CVOqY7PGA?=
 =?us-ascii?Q?uzxufpqKXxkmYCNR8KSLw3YtdsgivTqqfDq85iUKSZZwbVuet/u/wXvfHGXe?=
 =?us-ascii?Q?17XgowB9DP3AAuerhgYKgS94uTlIvTxN82vgivzCSu52y98d8CQgMdSgpmrv?=
 =?us-ascii?Q?Fy0fkGX4k2Zk4tq33jmEDgQTgnvgjBjrXKAFph+WSjFYRfcG1rb58x8mQW69?=
 =?us-ascii?Q?abxaxa9sGSbPgJXc/U/ULR47vLaX7K+HY0AQLWCMkZPeGewY+4yurG6QJd7t?=
 =?us-ascii?Q?l+UIET+JDO6X6wftUKmmOoo7Y+Bf/MWmLJCH/IRaXb7gcMfimruVXTQ5Ijmp?=
 =?us-ascii?Q?R827SVVaEd2zZTUeL4rnT88rMzngf2DeMXSPh6UBKCmo7PsIJOTOWaKQbJE6?=
 =?us-ascii?Q?3Nsa5xErFrvstZK4gU6f+WOBVzxyc3s8VgySmJSsOc4jxnVCwGTiV49DnI75?=
 =?us-ascii?Q?VcUHhehWHQkxTH9cBhnDS3TAA8p+BKXaZzCEkxLQJhpA+zzH/dbWlp1oU8VL?=
 =?us-ascii?Q?n77JRAWT5oQjqHyMBvtFjb0hEUMAkboNuxGB8dov+g8ojdkxkAQbUNlSagcD?=
 =?us-ascii?Q?W1drappauvmvf8r8wiEQpPKYe3VCxlpbGECnU8XL2m8BI68K5r+yqzn+qbEx?=
 =?us-ascii?Q?i7i8OgT32gkADtlWknYL9jCYwpzxwphOR//wo9urSXE?=
X-Microsoft-Antispam-Message-Info: SmRTSI9sU1oSVgx5+ZwXAWqnnr6L3U7I1LDM8WZ7hu3CEHsyBqCVL0eKKu8qCGCFuh5zFdFQPD1yM8JJ31RRhRTp5ylGu+v56oglX0/SHXd5Px/CAzJnW7/ZuYDB5djSVmULyD14VUYsuj33hgzf/xHn91EqqX1XKhs5LN1aWsWZWUMGVbHSxmCYe1mG3MVWJIHC2BmRgbD7OMzYFylO5LMazr50ivzSRfJpghD+GYRpYk/ge26ugag50vOSGlfFikLZ3J2hbtyjK+1hzYfAM9Kh8Rr+XhPCLX7rKbY5VJ1gPKPF5F+BI7QqAQUJcEiFFWj6W5GG4CkwdY6upsTFJMXStOw0yV3eHYTtHUFRaSc=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3564;6:3iG8O2Si857eM1damWWTe8gOukyI12dc7357nWis+qqKUXs8K91wB7wtnR7ZLw9NeO0jJyJAI/9/4QtcYZvq1W4n0lJKgP7HIStOCtPTMbY6dV6iF8JDlc1CAtsqbaHLEKJ5ufPL0hjF/Eswae4C0sC30yZw/XurCu4JvA+FIPheuvx8pifFXeAxtR+J3s8ykPm3Zc+cMoSycsFdaiitQ2cBsZ9n6td+FejSUuXy0m/UzUP+VEbYvoiHqILCKN/4p1WGpZeDCkCKQJ8EsSRrtG4rYiUeyd+H/z3eR/pTcnOR03SdXtbKF0V4Hk2XbX8jpDtNuJFtA02QWOIro85rhR/AXapXHqv3sCs83nXItCRBF5PlCi1zFSrXLzEsN/Ri89+6RoBPfSNjgg/JiZG77dnsgTZWURa3fjbRtmiQQUzyabddwGST5+MWbQuj9BhRe57l+AuYqmJ8IxjXLH9Oow==;5:7AS/ccgBoC3MDnqJFLcP7Q0PVqHCTk8OHN+mWdktg5GJz9uWuG5wGBKap4wYA6aV4sUfzFEV+/8robHGC5f8zGcmXLiqpcQhqBm9IlCmVg/9TmKfkulJgHNZMMqJgEcIpEIYYeeebIpD71aiUsn0fD1LYfq85k4uSrqZQSWpP+o=;24:ro4t7wDIeBjtTBrTUUjhfwqI9gHurehxXP8eSFsI7NNW9ndwH8wyAW0Qx5+FjYZRoAQZPZgdkCWlp3+lT6q3mJLaLnJZxRNQSxbOatWcrjo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3564;7:DboCCYFVJzNd1K6Dr9CTMGXCU3M4TFMW48CIOvCBEIdp1j1lGfIX14L9f8gdprq2vvo+MfxSkt9cIOumX6nhzFUplFajWh5mn6MJ7y3l+D6emXFdhvMdy6vPhtGkt3ZKwrRSB+LBuuBGQDbQNvbMZv4ZzqBf1wZO/72YWisMMJ/Bp68qUzi/ot0loNWemi0KDWDNQdOrrflcnTyn5Q3nYg8tR1rxYxPfJdSkl9bWQZ7TuN+hY268VnWbogZPAuXf
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 10:51:27.3236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0534ce3-021d-4ed1-66b3-08d5f60a6807
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, by setting the xmit_msg_size to 63, the ssif driver never
does a SSIF_MULTI_n_PART, it falls back to only SSIF_MULTI_2_PART.
Due to this all IPMI commands with request size more than 63 bytes
will not work.

As per IPMI spec 2.0 (section 12.15, Table 10), SSIF supports message
length up to 255 bytes. In a multi-part message, the first part must
carry 32 bytes with command 06h. All intermediate ("middle") parts must
carry 32 bytes with command 07h and the number of message data bytes in
the End transaction can range from 1 to 32 bytes with command 08h.

Update ssif max_xmit_msg_size to handle multi-part messages up
to 255 bytes.
Enable command(08h) for End part transaction.

Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Suggested-by: Robert Richter <robert.richter@cavium.com>
Reported-by: Karthikeyan M <karthikeyanm@amiindia.co.in>
---
 drivers/char/ipmi/ipmi_ssif.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 18e4650..ada59b7 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -60,6 +60,7 @@
 #define	SSIF_IPMI_REQUEST			2
 #define	SSIF_IPMI_MULTI_PART_REQUEST_START	6
 #define	SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE	7
+#define	SSIF_IPMI_MULTI_PART_REQUEST_END	8
 #define	SSIF_IPMI_RESPONSE			3
 #define	SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE	9
 
@@ -88,6 +89,8 @@
 #define SSIF_MSG_JIFFIES	((SSIF_MSG_USEC * 1000) / TICK_NSEC)
 #define SSIF_MSG_PART_JIFFIES	((SSIF_MSG_PART_USEC * 1000) / TICK_NSEC)
 
+#define SSIF_MAX_MSG_LENGTH	255
+
 enum ssif_intf_state {
 	SSIF_NORMAL,
 	SSIF_GETTING_FLAGS,
@@ -887,28 +890,39 @@ static void msg_written_handler(struct ssif_info *ssif_info, int result,
 		 */
 		int left;
 		unsigned char *data_to_send;
+		int command;
 
 		ssif_inc_stat(ssif_info, sent_messages_parts);
 
 		left = ssif_info->multi_len - ssif_info->multi_pos;
-		if (left > 32)
-			left = 32;
+
 		/* Length byte. */
-		ssif_info->multi_data[ssif_info->multi_pos] = left;
+		ssif_info->multi_data[ssif_info->multi_pos] =
+						left > 32 ? 32 : left;
 		data_to_send = ssif_info->multi_data + ssif_info->multi_pos;
-		ssif_info->multi_pos += left;
-		if (left < 32)
+		ssif_info->multi_pos += left > 32 ? 32 : left;
+		command = SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE;
+		if (left <= 32) {
 			/*
 			 * Write is finished.  Note that we must end
-			 * with a write of less than 32 bytes to
-			 * complete the transaction, even if it is
-			 * zero bytes.
+			 * with a write up to 32 bytes to complete the
+			 * transaction, even if it is zero bytes.
+			 * The number of message data bytes in the End
+			 * transaction can range from 1 to 32 bytes.
+			 * As per IPMI spec 2.0(section 12.15,Table 12-10),
+			 * the BMC Multi-part Write commands are:
+			 * Start-first part	- 06h
+			 * Middle-part(s)	- 07h
+			 * End-part		- 08h
+			 * Update command for END part transaction.
 			 */
 			ssif_info->multi_data = NULL;
+			command = SSIF_IPMI_MULTI_PART_REQUEST_END;
+		}
 
 		rv = ssif_i2c_send(ssif_info, msg_written_handler,
 				  I2C_SMBUS_WRITE,
-				  SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
+				  command,
 				  data_to_send,
 				  I2C_SMBUS_BLOCK_DATA);
 		if (rv < 0) {
@@ -1499,9 +1513,11 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			 * start and the next message is always going
 			 * to be 1-31 bytes in length.  Not ideal, but
 			 * it should work.
+			 * As per IPMI spec 2.0, SSIF interface supports
+			 * message size up to 255 bytes.
 			 */
-			if (ssif_info->max_xmit_msg_size > 63)
-				ssif_info->max_xmit_msg_size = 63;
+			if (ssif_info->max_xmit_msg_size > SSIF_MAX_MSG_LENGTH)
+				ssif_info->max_xmit_msg_size = SSIF_MAX_MSG_LENGTH;
 			break;
 
 		default:
-- 
2.7.4

