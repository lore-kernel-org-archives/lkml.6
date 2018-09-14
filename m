Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC18ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D49E2148D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZKNWEeEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D49E2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeIODtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:49:04 -0400
Received: from mail-eopbgr720049.outbound.protection.outlook.com ([40.107.72.49]:55776
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbeIODtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm/JoSrI6nPbroLMDxElnk2UU/BlZE/WWzYcY+90tXU=;
 b=ZKNWEeEcVfDGtyICJ6GPoUMXJNEDJP76nOs1ptxQoOUulzX74uLlAGu2ia+aNyxZRT0Rc56ROuKm3EjlTkMQMI7aJnkNe21MAhI0A2ACj1vSA9s3CnyYAldW4xUbsZwu86Zt4sC8jWw6YIFI6XIuG3i2xLGF3BzJtiNJFYhKLoQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
Received: from gi-joe.amd.com (165.204.77.1) by
 BYAPR12MB2725.namprd12.prod.outlook.com (2603:10b6:a03:61::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Fri, 14 Sep 2018 22:32:32 +0000
From:   Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 2/2] Allow SEV firmware to be chosen based on Family and Model
Date:   Fri, 14 Sep 2018 17:32:04 -0500
Message-Id: <5c58c32c0ce89c35a95e151734f5d43a3ed0dca0.1536959537.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
References: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR0101CA0021.prod.exchangelabs.com
 (2603:10b6:910:3c::34) To BYAPR12MB2725.namprd12.prod.outlook.com
 (2603:10b6:a03:61::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf3545bd-1cc4-432b-6260-08d61a91f6c5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2725;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;3:iR/nDEkEaVRuTnp9+jLdGSKoJn6FXQlxRJEup4ZM0WCwRWyAEIxyDsa1v9uU2rIa3KX2384FzOdwmt8ckJcLYDF2q0NLTwbR5X0pi3L5AiaSzTIDyE+9fwpFGKlXX8QkQpYGAawsB7rKjDnZZrE6GAhJVZKAKdcrYghMEo30Nrdc6AbEKj2aXyPWyZLREfFrhZAYpX69xCgkYOGYq4Xo53SfxqgcygmSzOFPyc38i+fS70w4PH0MCQ1rK8XeNPFn;25:jEIhRU/e95OvOxyCv3dtYoNYBTUeqX/02xGzmWRqGkLfccusNxjgOO8syuqTCzSyTsSJE73s+I60KMO3O7uML4dLdYnrtCDK41OmVbPWhtsuhfW3YuwJAI8O67LvTceurjpwOdlzSz/8YepRRPfWMen5VPnEGOmBTJLh24CuZNtzgHUi/839oYmehFNSbfXyVgw+2HP+MGS3cgJXIgqcnH5QLLoHhJfWVCzFx78hC2aRy8AVmU07/liYI5mZHABxXlxtjkngx3C1PXvCHMCG90byspM/pWYjADkivVs3S4E5iezalJ/FX4GRqT8XSF8uA8TFHU5pLD0hzr3wWveuoQ==;31:yQZJyS5Ypcf2T0GCY6T3LHt3+LfPcSupIcjNoSZT5awGq3ZUtpKPOwWBvOA2DGyvjT5aHvXbasQuJmwPk5acF0YMWtAIy9M/xozM/ydnB3ftrsbPC0o1cBkiKhscVdOQxjm+2UMaxp8B8+HRGhAGOqIBLbGx55jwfI+RFv+mMZjXO+0kM+G1ehlsB1DlkeuXQmUlSkogdc0oGiDa+ZTKTgDz9QbEPR64wJKgbzu5cUs=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2725:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;20:Gf3ZYgynFMnGdYqLzOVkYck5Vuma9M9N56rQfxMOLP3HLi3BiRVS/h1ma1moPjRB0vJKvEW0dEvDx4ogVvds5UOzza1mu4/DkHmbDpw8zgnWmjS3VygCez4uTfbtshmhhq0IgTezj7qmcs/xyB0mFJY1ZI/uygxpk8Yzpk0KG6HmgJkNzqLhQgXiHvLaRYnmMdTCiCU6BN48mmregRfgJiHIowNSx+DQAGuLuSyx7clawvJVPCQO+NOT8Zyvq4MYWSumhixsfYcoTgz8Mz0WYyjI1EymQ3UF1aiA3aImetyC+KIdH76qvj6VGaL+OGivICN4mBL/HTO4II3m8eeIMNCFhqhvU0Dfa4FUiEKvu0bP+1W9fuJrVif88WQ//AlBpCV8OFQ//T6ONKSOW0T3+5J4Bg+BbSOqhRcEX+5icArlzccYhgoZam/cP7P8QZqhEHLGnkMi9ujqvSIP4Pao1Gfzeb1nZTONotmPyzO4+o7qz18VhWgySEwbhPWs53yj;4:6Z7in7v0pTYXux+lXodPU/e5XcTd7vNnvD+SJ7OIt/olv6zVVdTD0W/c4LvIEg6DBdOFsOLSjLCEtT7OT7rC955qudGoq3OFSgu29QsboyU6LgfBjEiauDzCyMgAqfpF9WFg7SDdi6WjhEM/B3n6DCw55KPa/Ke40izu1x/JYHesLqt7F6gCT761FWp9WHdOLpKeMY8CKnbFzeTJUWIZUse14z/J1bMrzZPxA79+F0GHj8A9oZNz7B2CTzXA7/1Hrw8bNovxCbtUSshSjwVtoJ/9GSIGCMzOP7yD7Tyz2+bkRG6eTfP2cpUfVPrFbNow
X-Microsoft-Antispam-PRVS: <BYAPR12MB2725845446C418BCB45D13B4E7190@BYAPR12MB2725.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231348)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR12MB2725;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2725;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(6116002)(11346002)(6666003)(3846002)(305945005)(14444005)(72206003)(52116002)(26005)(7696005)(316002)(16586007)(7736002)(54906003)(5660300001)(105586002)(486006)(446003)(53416004)(106356001)(476003)(2616005)(118296001)(956004)(6486002)(4326008)(50466002)(48376002)(47776003)(66066001)(81156014)(81166006)(76176011)(386003)(97736004)(186003)(2906002)(86362001)(575784001)(16526019)(25786009)(53936002)(51416003)(68736007)(8936002)(50226002)(478600001)(8676002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2725;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR12MB2725;23:p6pskwGgLKVedAsDiMyTleY+90QLP560WIm3im9eJ?=
 =?us-ascii?Q?ww2Y/OFFMgNvToowKjuszIE96CHMN1il12MqmTJIsHZffMOz6ow9nUm42MlZ?=
 =?us-ascii?Q?93gj3UA2VM0TxFl2HCg61duKF2RUpe4yOcFQ1s9zMDLyayxDva7MltPVKI9d?=
 =?us-ascii?Q?pRQt+Wb/EYWpvNUL6RqbxOZDmAQEqwulisuIFUUqwlh6aUOZ7c86Tinsr3KM?=
 =?us-ascii?Q?Bs6IMbNgNl2g29KF1W5qKt7OvOqxTT/HsBNAVcCKnNG9OKXi5WOdKhbawR2N?=
 =?us-ascii?Q?Aj4RKC/654Bl0N0S06yY9YYAtjDIiulzxqxOHTfzVNVMMPU66hQ+ocJceSsk?=
 =?us-ascii?Q?JD+/EIcbJSeRIrHbcQ5Eue3HMrAbecHzrkKW+jr6rEwTev3syfisZbliTUEJ?=
 =?us-ascii?Q?2lUlosHf+t3wwZA6j66UgqaH495ns0yP3L8Nf3cuK7w5BlnM8iKMJTwIMqtI?=
 =?us-ascii?Q?1gngAFNPDarJrR01TG/CSLRJr7sXEykJn1jLt2ZE94LJWX2HSwxssgXhM3WC?=
 =?us-ascii?Q?7XajfVSeYTykIyosKEhxGDT/ToetU+SEyHS8s8lAjFY2oUNI+bX5Kq51cXSG?=
 =?us-ascii?Q?QLYwQUE3RRGN5zf6JCDcDLdjrqT6X3HzuQQyH7irV9JV6RwJicIZU3aYIB0t?=
 =?us-ascii?Q?Q7myj1546cgHehaZM4ciqrkSPwkoj+bLzInfnuKR1Jqk01jLDmwgUoQT4ZCg?=
 =?us-ascii?Q?m0yvxPu77XuOYK15Bnk28mnK29wCjifFxHZXJORO7HPJ4JKY7bjEBAdyPTPv?=
 =?us-ascii?Q?A7pBTvm1dA4p9mBrd0lfogB+Z/a5S2qAatorG+Lc2fB001hB6OFRhzSF42bm?=
 =?us-ascii?Q?kUGsPV0KRlVVYa44aB+O2uLjTFQC7qp/GdunGwhWDX+Z/FQWyBsAMzTxqE4p?=
 =?us-ascii?Q?9hmPGoas89LmUPYW8Q/CLnWJZ7IB6XEK4+9l72meThI0IOANsTZg9s8y0aRv?=
 =?us-ascii?Q?3QhaRDAv15JluWqO8tZ2yVTyGzSstkDwV6474WxPxFMpxhZyM+NSdHxv+NRR?=
 =?us-ascii?Q?4bUKqs6K8TFfzJGdSO+wurlmyidFXtQelgLGgv8rQnSEDk11FoBseml3LklG?=
 =?us-ascii?Q?/37+N5/2LFWcNFusxbCC9yPoTfQimWpBz9MIW0crzdxo6D7adUwvQYsn4kXQ?=
 =?us-ascii?Q?xArDlsBRlMJAmoDhbn226AEfLBntwFeQ1cnkkzfaseiHj+IYvHON16CtGQ4z?=
 =?us-ascii?Q?Ub7OOfK26B8qpBT+ZvORqBs3VtnQr71u4u0wQryrRnVkCAh4a2+BU58M/ykF?=
 =?us-ascii?Q?ylcGXikARjxPhkjdnA=3D?=
X-Microsoft-Antispam-Message-Info: u4faN3c7nHI7Mtim8TMreVu6rsLWLszd5ShwEn5PQpF/ja7+OpKObRnb0db6yMV8XWoX0rp00JsNq6dV17xWBvyZBt+0gJpWddEnPqkdJpO1vNkCpgXVUTkbeB1LRcXkIYmHPwRLp+SaTan1OiJR9oZHTPb0HmWaJCQ9G18F/LfyeKic8rrIeHWVpYUC33us85OlQHhHw4K65RBRYvFA4dHGJIWrmAOVL5iAC7PF1zOf9T9av893wQAA4NoUhkOUIJsQpM2zhyIFbINCzccQHz9Xa6JpMeiOLAFG8Hai/Rt9siZ+6yWcLrUWuXcbGGdL43b0QNwamAlR4ttPcO4NPppNZwgeU6N8fYmd58BO7dw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;6:I1d0u0rrDFUghGlx6GITZuERVtBw/sM+VkeqSor5kUVzzReZJPc4452k1pL1U8lBJ9yK6zb8oPYcoF4RjIgilb0ES4KlhuzloLPNZsYRTdXb/d7pitc8zVNfyEn+fseBgJwUnbm/dqwJJv95INMXr5pvD0d41h0wcbV8To0Kv1Vy6sdQqaMkfTtodkBZfmnznf5gi05aJj2LaNyk349G73g+BGs6owDI1cINEE2NBfOKC9kQq1zvMBEKuXZPJ6sHjU+cYnCA6SG4jWlkija4CiReWQy+o0NAZDkcA/sYnH/JQR8+bytda2FObvB7d9FAfpGLbldEmRxdg2BV24He/211pja7PwsErgffMn7KRoTO1oRB3aBlDG+6ynVPJb2I5CpOFe7FItb/drnz+X5fJgAIdUtatA9iG0kDGTxcBpVC3putemv2MZ0soItbq8fjUPyWqAhClSA5qZcmP067KQ==;5:8KZjDNe66J0JrkgeZ1EPu76gePy40cjmrz+PbTOGSfmXfNnUw+/kw/1ny3/8WIOOxEs+XKuLWgGEgEAYpThPY+1JV/oclYQSBRh+g1YbxPJLSc4yLJl7K3q8lyEX7EHsfe012Hpf6WircGCNobKiSQEBWb4lZVnz2midu+CicrM=;7:TLUWjdGt/tZ3gbwLxFDFC1sBrssp9Mo4QhUJJGhaYjIIHyJMsigOMecgiqffSfUyY8Uw/W+2yZR8ms6fMMsCJMpAl2mhuKkXOscc0aVtrmqaM2O+r+QGpBmAL3N8Gq2KUFpk5V7uWM0I+vytFKvnRa4Cqz8Y9iS5fm731ReOd+FheNdT/3pFbcmJ/d+CBb0bQp20AC9FxFduB4uhvcDpaqzPg7t77+uOOvf4i9Rf93du74Oqrmqpw8ed+o9FovJU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2725;20:Bte9AMSipEiSQ7lA7/Bl3vsNgT3BJNzWJyriyZfEtpCf5jkjKxxakMY8tUKXsYccjGvy9ytejWwi6ZjRCi1agaZGgXOwER4D120/uEWOR3as2vigo63LQARj7xI6dqxMOJJRYCDfp9A/aBfqdhC3o/QIP5R2hlIAiulSthKWk43/2663GB8sNKUPx9zXrWrKpMYGNdzVHqq+6qQvDYKAlKP+H+wjGtNbI776R0/i5oyRLyqZzJFFnsnxeqa3h6FZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 22:32:32.5030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3545bd-1cc4-432b-6260-08d61a91f6c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PSP initialization, there is an attempt to update the SEV firmware
by looking in /lib/firmware/amd/. Currently, sev.fw is the expected name
of the firmware blob.

This patch will allow for firmware filenames based on the family and
model of the processor.

Model specific firmware files are given highest priority. Followed by
firmware for a subset of models. Lastly, failing the previous two options,
fallback to looking for sev.fw.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index f541e60..3b33863 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -31,8 +31,9 @@
 		((psp_master->api_major) >= _maj &&	\
 		 (psp_master->api_minor) >= _min)
 
-#define DEVICE_NAME	"sev"
-#define SEV_FW_FILE	"amd/sev.fw"
+#define DEVICE_NAME		"sev"
+#define SEV_FW_FILE		"amd/sev.fw"
+#define SEV_FW_NAME_SIZE	64
 
 static DEFINE_MUTEX(sev_cmd_mutex);
 static struct sev_misc_dev *misc_dev;
@@ -440,6 +441,40 @@ static int sev_get_api_version(void)
 	return 0;
 }
 
+int sev_get_firmware(struct device *dev, const struct firmware **firmware)
+{
+	char fw_name_specific[SEV_FW_NAME_SIZE];
+	char fw_name_subset[SEV_FW_NAME_SIZE];
+
+	snprintf(fw_name_specific, sizeof(fw_name_specific),
+		 "amd/amd_sev_fam%.2xh_model%.2xh.sbin",
+		 boot_cpu_data.x86, boot_cpu_data.x86_model);
+
+	snprintf(fw_name_subset, sizeof(fw_name_subset),
+		 "amd/amd_sev_fam%.2xh_model%.1xxh.sbin",
+		 boot_cpu_data.x86, (boot_cpu_data.x86_model & 0xf0) >> 4);
+
+	/* Check for SEV FW for a particular model.
+	 * Ex. amd_sev_fam17h_model00h.sbin for Family 17h Model 00h
+	 *
+	 * or
+	 *
+	 * Check for SEV FW common to a subset of models.
+	 * Ex. amd_sev_fam17h_model0xh.sbin for
+	 *     Family 17h Model 00h -- Family 17h Model 0Fh
+	 *
+	 * or
+	 *
+	 * Fall-back to using generic name: sev.fw
+	 */
+	if ((firmware_request_nowarn(firmware, fw_name_specific, dev) >= 0) ||
+	    (firmware_request_nowarn(firmware, fw_name_subset, dev) >= 0) ||
+	    (firmware_request_nowarn(firmware, SEV_FW_FILE, dev) >= 0))
+		return 0;
+
+	return -ENOENT;
+}
+
 /* Don't fail if SEV FW couldn't be updated. Continue with existing SEV FW */
 static int sev_update_firmware(struct device *dev)
 {
@@ -449,9 +484,10 @@ static int sev_update_firmware(struct device *dev)
 	struct page *p;
 	u64 data_size;
 
-	ret = request_firmware(&firmware, SEV_FW_FILE, dev);
-	if (ret < 0)
+	if (sev_get_firmware(dev, &firmware) == -ENOENT) {
+		dev_dbg(dev, "No SEV firmware file present\n");
 		return -1;
+	}
 
 	/*
 	 * SEV FW expects the physical address given to it to be 32
-- 
2.7.4

