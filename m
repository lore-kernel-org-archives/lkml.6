Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D46C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A2023F9F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="KhEgSaE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A2023F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeGEKBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:01:15 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:22560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753264AbeGEKBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrJCIxFCT4xakNd3ToQ0qbwCuA4EKgAn/9Uk3lpxJcw=;
 b=KhEgSaE3J+YvBuITE8r8I0Xr0fShVFVeHC7X8uPChlv/xxDJtlnAdyx/vIRT/nc16dF2d9Ku9+ao4dl1GiFmnnyoaqzi90F+nFRLGYbfnVpNGEc90WghiiOlVB1nujpx2SdBZAK91hQ6XGqAmxjVDSgvUNIGBqCQP/m8QzWeQYg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kamlakant.Patel@cavium.com; 
Received: from kamlakant--T110-II.caveonetworks.com (111.93.218.67) by
 CY4PR07MB3557.namprd07.prod.outlook.com (2603:10b6:910:75::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Thu, 5 Jul 2018 10:01:09 +0000
From:   Kamlakant Patel <kamlakant.patel@cavium.com>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Kamlakant Patel <kamlakant.patel@cavium.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: update ssif max_xmit_msg_size limit for multi-part messages
Date:   Thu,  5 Jul 2018 15:30:49 +0530
Message-Id: <1530784849-3376-1-git-send-email-kamlakant.patel@cavium.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: MAXPR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::11) To CY4PR07MB3557.namprd07.prod.outlook.com
 (2603:10b6:910:75::38)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77639713-8f24-4b33-4875-08d5e25e3c43
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB3557;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3557;3:l4GZKiePSpy77XHCrdsWFhD12x0QHypvi93MUYShJ4SiRkXrIlCru88q7p3bzxw9mK0h66VWlecdcWS34LnaURh0CcPlmpnF3BeLpBaM0wREPawFMW1TKrHReS1w4MC2btMfaeCgpvtS9cMCS4o/ej2pCgM/8tFv3WaBxcN7DXcXVMrLbN8eZnW4c++MHueZjVnrFUGg/tTIzjm3afwAX4pyg0MschvSEbkGV231P/PPCzIMyLsY1Woo+Iro+LcY;25:GN9hpnJ6sgJbS5G3iBMc/4Hvuqy354wCXfk296Txp5WaPWboFQwJ+MEhBDj3/IyO66wBpq9rcF71GDeK7paLMPqFQpkf14StiIkUrsIJjtEllTyQvc9GTIVqwISl3u7Yn1AEj8mKnuW2jnDqltar+UpV/fmtFEFc31RFM3MZSMC6PVwjt4yecqxCd+A6LqC1u7Jdygicoi0PhCc0Yxg9sidELWy9Tn1kMDcY4MvLUknqBqj3/oXVvB9jrEd8gwDP0i3HlSi0Konjlys8EXqY31Eo6YGajxVGL9EYobcUXGQea17CgioA+EaJTf84q2OIZ7kyzWZLCmawPh5gXXkp3g==;31:4rT/yUKckNyKpDcelBSS5ohR8Gc8tjpfPNEuqcxydeH3yAz/j3KCILKblGrfZf+QFENJEC7s9LzXeNOGw6gezvDnsZEqZre6qs4A2Duw3To/UpbEUe3ka9FLICrXNFKcslWNPyLwns1r6Q0G2pGF713OCUD3X1DMqz55ALnJq7YD0njuhevjik8oDUfe1+i0ZhcZGn6A8XPr98IdTeqLOkEuCyVEGoZI2VHmGdpGytI=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3557:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3557;20:RZhH7+z2DjIX0HfxuOpAFX5UOPBjl5GaXvLDmDsRabAOPPdUiUM3G/oZuNqXraPgwoaugHaDJ+fK6uKEWo6dktT4D4YSc96NnFEHo25fs8BAv4qTASrjnPZUkOgUGc3joVhnNMtq5KiP7mgn4FDvZbL253wkaFhRGTv83p2mhwkzwoCjmrSCKdbv/QI6hLA3Vp5e2cE6P9Vvz1Wjq3eMJwGyVAh+9mAeRnsZrofcOlTver2vAO2qJwzVEak0o6bAcqJnOOoKF5eukYBAWPLz1i4GTVNEAa2ECZYHdAOaffpnp1/ZG03nzuZ9hpnk3wVZxMsu90Vo+bZcQkvF2xdvH1wMO9RbGP9So0oZ86K7wRQ9g1g2dS7Gy7IRFioRoBVZB/Px55DX2YhgEJgBP9g/kIO/U8wxrtTFYJsApAG8TBhdKJYiETX/pvDmEJKVhjIzmHODCrLWrVVIWcek4H4G5nAuCYm0ftSgvZ4o/nUqzWohPeFp2drPqlcyavb/Vyub;4:YINHzQt1G5H4EQ8d0upFjvZTUYJlNsGEpvITDDawayvn73PF54vWoCAdh4Yl6Pme1BcRszL/uHBb0GcO6eICqeqAEMtTDOLjixTjUmYBq/PdC5yZu8NYiW2585JJQ4aD4phMTJG01IhQ4nO5zHHqypPMBT5ilC0laVToAANtgQvBG9KwJMS0YeMUULo0tsfIov+gShpZGzlPgNbh7CdlLAMpRIGHLo+kQ18VOHNubnURCdY6op4I9UNqKlvaWtxSwydfZW4/BxcK/8Ve6WN9BA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB355745014EF279BB21411C1088400@CY4PR07MB3557.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR07MB3557;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3557;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(376002)(346002)(136003)(189003)(199004)(48376002)(50466002)(2616005)(956004)(486006)(5009440100003)(476003)(3846002)(53416004)(6116002)(66066001)(316002)(44832011)(47776003)(16586007)(69596002)(53936002)(6916009)(50226002)(5660300001)(6666003)(68736007)(81166006)(7736002)(26005)(14444005)(86362001)(386003)(8676002)(52116002)(6506007)(51416003)(8936002)(15650500001)(81156014)(478600001)(6486002)(6512007)(36756003)(4326008)(25786009)(97736004)(2906002)(186003)(16526019)(72206003)(1857600001)(106356001)(105586002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3557;H:kamlakant--T110-II.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3557;23:BSSVF+U4vrmFZ0VeHafZHcy6gLFn9TWaXVFbsb5WN?=
 =?us-ascii?Q?CxHZFaZT82dTC3bapY4xFPaSdthfkzFqHm3vmQSuFNM9fX9Kwjz0JSJhuPrI?=
 =?us-ascii?Q?D7XFkz7BgntQ6mSd6OKzPPjxfhNPkZ/zSBNDRL1i6Nn59JEwJfDwnc2JNMYF?=
 =?us-ascii?Q?eXIDoE6z5sbkIKMHoN/+sKjwk0+9W57jYyS87WGpH/p9Onwy0z433jCiFU+3?=
 =?us-ascii?Q?YfozXY5T7M98Zc77V7w2OmW3D3PVf+VAxZHyhJhzmnY86S6xVX8zJahHlT7b?=
 =?us-ascii?Q?JeUkq+QtDgvaepPb3q3KunrUN8+X6aRJM/YzDGwowTEDpZSOsp5/NKTQZVFQ?=
 =?us-ascii?Q?G0JR/njvRJBLWKm4yQG9vN33d0lGfLMj5rBMtt0z4582KDoDr6VCMcqoaK7C?=
 =?us-ascii?Q?ujbelFanAweN5nUWIZAjTU/ROlcr2DBhOBG5Auq5l4BoCoYN1HwRk6gThUKC?=
 =?us-ascii?Q?BPj9qWr2zfQBRafbaecXsPmZLmlR2veyLDk07qMAZX3tvqhOqBvtMhqxDfEU?=
 =?us-ascii?Q?iWkvSsYQA2m2/g9Lry8nVxfvy4rC7Fvwf27YJWoJG5j3TdOAZ6scQRvdTQwt?=
 =?us-ascii?Q?umcwlGtSak1rChkYiKqvZs0HhV/VgzaM99d6pHXxMObx7ShVJZzZprL/iPg6?=
 =?us-ascii?Q?K42qpJC6v0qMvKknA1N3+1CtN6ieOgPaptyup741/q8G3LMT73Y4Oae2UwwC?=
 =?us-ascii?Q?btfVEnPimKtit4Clq/35sHAQokXApMWLNe4fJ7vXIx6C97foec4+mxInJzBF?=
 =?us-ascii?Q?C/BYQQO+QnQy/EgKAX6eMQDviQoLwLjaznf87XkXYIath+8PRKoltSRlIgPj?=
 =?us-ascii?Q?sMOrd7En3zW9/CjhPhvs9Sbi1CHtVKzOCSL58bzofqDXLnMKSdDsc+PGKtNl?=
 =?us-ascii?Q?NjwSu2zSdrL1d2hr2KV16s+fsiSDV7BbEJS1h2M9Q9oy5Kx4sGYJbZk1aZ6D?=
 =?us-ascii?Q?IuCd3itYN5cPYKUbwQKd+sjCRC+cEdiTBItqVYqo2MV2iuZ32c0qESJ9Phfp?=
 =?us-ascii?Q?s3ZEHw6Iqze4MpKF/eH2drDxQceHfAbrVNPf4BTPtkJjp0PKf6uS9GVJLMoP?=
 =?us-ascii?Q?d8t7M2/yunpGZAMeW22nlFHsSb3fGvPFtsQOADbjmFPNYWTnB86Kts+WAdwh?=
 =?us-ascii?Q?Vaw6c+oj1f9RpcnNuSvddEMlSH26n//8t+SFx2Ro5lzz0EbN/LzGS+Ftejmk?=
 =?us-ascii?Q?alXV9DNLM5lyi996J8v0aZkOkT2T5UeG0icUClBMo51yheYlksyWOoYEGVyF?=
 =?us-ascii?Q?0Amsc4DPUC11xW/llUqtU4WCataJXaYeJheY4qwkM05Xexpnv2ujQTqmMKIT?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: aD+8fcaZrFvwugOQ0OPmFssYUL6f5W+ehM+BurwsKOvWUxW/0wQLHoeqWIT1NHHLKi0OMDnF4/lkigzS0JNyfXZo16nw9vWOn7BU5U1do014kB3gNww1vU2YVc0Sn47XerKRMQCncQAF0JHRurJ3t+1yhP6LaR6O51Mu4BDO+FoHVgtZlO+O71GBhJ5CAVGomupyGpngi46IYrkoggWrONF0VXS4rNQDNIPPnmua7Ru5LmpYkfB3qCJxreSoPOA5/1BmxloqtRXDw7mmuLYIlvusYPJUbDk5o8M35unyl1RFFYxEYhoHHrdIfMy1GuhrExbuKVCu/u7cvvCPeCrlXvNbqxQMAqZ6ZrN8YhnOyCE=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3557;6:rHs+2FVqPJaoEPZ6uQ5MRg/woLrPfZra9MrXIjPaBESwX09XGMlnTllk81DwUzwV5yutbldmhIZ/DYvG4jOk7pArxRnrJA+W1uqH7rBXECBcp6oTbO8nN5jJ19DgaMSPwRgmvD+WWX0Rl5BfxMOoDT8qOMVEpPt8ZCeKxJt0SpZACbj5sLuZMBkNv3zywFxiL3cY7fmhw209CRnje7M1M4LcTazXaGyJ8TlW3qghFWxnCtvir1hmTIFYBZEANTtvc4IW8B+PeNp9uCqC6ERoIlTwPS8/0GLp+LIIpWCankF5662Yl2J7nX8ghkoDIrOjQyv3F4IuCN3BMm17qNKTscc34Nwhu+urveA5uw5kWt3NFXgGldLi2O0OgILrmeKQlI1pGfd0iy6PFiv+HXoV6eKom/vx2+2eK42b9z///TBsVQ+rKi1sE6DRMtZbvzw5/7ZoIBpj5lKg/QFtDoLv3A==;5:gCr6b2MNzgUdTxN0rIg8dcvuqQrOQhlo3snkqYT0coJFklHKbYqsF2hJi+fqGUk7a5YCkuhK0fRDQPFi7V0A4AGfYJpxbxIIJ6AlVKjZCI9mj0Da5s0BWCY0j4jyEBhgdZ29k/Rc5g2xCgDz3ODU0Kya9TO5DhGldTprBSZaIno=;24:US6AfkfCOOiCmwx9fQD+5Cqq0o9KPr2xxOGtQIkSwNSKRzX7T3/anR0Xemj3QbxTMuR0odjDig/KX7sFxfFtPWCi7r0KZMJhIrPRaZGV0Uc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3557;7:+OE2ue0gyhVQKo4kNldwp2dcVKJ75Lw8oy7ufES3tFJIZCn2QwUTTO4mZ7WbxqUlO5f8X5eS9Bvt0VOL1+96s/f9IIBanyQ70AJbsbjZEKH1HENnKCMEdKPgRP0bdIjaMFuw1YHIdrZtwe9SQ+e4/kZSe0doPJUV4arStqMxudBkeF36plOJKZIh3z2X2poJRceDzLhbwumgw9PQ3AFr14k0lAQwAKU/Zdtg39Xt0FlU4+4b/uAxd7wm3jfbvDx2
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 10:01:09.4398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77639713-8f24-4b33-4875-08d5e25e3c43
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an issue with Host name Write command with payload size of 132 bytes.
Currently ipmi driver limits max_xmit_msg_size to 63 bytes. Due to this
all IPMI commands with request size more than 63 bytes will not work.
This is seen with AMI OEM Host Name write command: payload 132 bytes.
When a DNS host name set is tried from host through SSIF interface, the name
gets truncated due to ipmi_ssif driver limiting the length to 63 bytes

As per IPMI Spec v2.0 section 12.3:
The maximum message size returned by the Get SSIF Interface Capabilities command
is 255 bytes.

This patch updates the max_xmit_msg_size to 255 in case SSIF_MULTI_n_PART.

Signee-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 18e4650..2bf6f07 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -88,6 +88,8 @@
 #define SSIF_MSG_JIFFIES	((SSIF_MSG_USEC * 1000) / TICK_NSEC)
 #define SSIF_MSG_PART_JIFFIES	((SSIF_MSG_PART_USEC * 1000) / TICK_NSEC)
 
+#define SSIF_MAX_MSG_LENGTH	255
+
 enum ssif_intf_state {
 	SSIF_NORMAL,
 	SSIF_GETTING_FLAGS,
@@ -1500,8 +1502,8 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			 * to be 1-31 bytes in length.  Not ideal, but
 			 * it should work.
 			 */
-			if (ssif_info->max_xmit_msg_size > 63)
-				ssif_info->max_xmit_msg_size = 63;
+			if (ssif_info->max_xmit_msg_size > SSIF_MAX_MSG_LENGTH)
+				ssif_info->max_xmit_msg_size = SSIF_MAX_MSG_LENGTH;
 			break;
 
 		default:
-- 
2.7.4

