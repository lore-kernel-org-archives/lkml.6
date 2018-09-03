Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC1DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6590C2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6590C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeICOAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:00:46 -0400
Received: from mail-eopbgr720056.outbound.protection.outlook.com ([40.107.72.56]:60854
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbeICOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:00:46 -0400
Received: from MWHPR02CA0023.namprd02.prod.outlook.com (2603:10b6:300:4b::33)
 by SN6PR02MB5181.namprd02.prod.outlook.com (2603:10b6:805:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Mon, 3 Sep
 2018 09:41:22 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MWHPR02CA0023.outlook.office365.com
 (2603:10b6:300:4b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.17 via Frontend
 Transport; Mon, 3 Sep 2018 09:41:22 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.100 as permitted sender)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Mon, 3 Sep 2018 09:41:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39690 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fwlMH-0003pf-Q1; Mon, 03 Sep 2018 02:41:21 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fwlMC-0007hz-LO; Mon, 03 Sep 2018 02:41:16 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w839fFV8013924;
        Mon, 3 Sep 2018 02:41:15 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fwlMB-0007hY-7Q; Mon, 03 Sep 2018 02:41:15 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-i2c@vger.kernel.org>
CC:     <shubhrajyoti.datta@gmail.com>, <wsa@the-dreams.de>,
        <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] i2c: xiic: Make the start and the byte count write atomic
Date:   Mon, 3 Sep 2018 15:11:11 +0530
Message-ID: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No-2.420-7.0-31-1
X-imss-scan-details: No-2.420-7.0-31-1;No-2.420-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131804412824826495;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(50226002)(86152003)(87572001)(105596002)(36756003)(50466002)(9786002)(2351001)(106466001)(498600001)(83322999)(73972006)(63266004)(48376002)(2876002)(316002)(16586007)(55446002)(2906002)(4326008)(54906003)(8936002)(450100002)(107886003)(551934003)(81156014)(51416003)(6916009)(126002)(476003)(486006)(81166006)(2616005)(82202002)(73392003)(336012)(8676002)(6666003)(426003)(1857600001)(14444005)(26005)(77096007)(356003)(305945005)(86362001)(61266001)(47776003)(76482006)(5660300001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5181;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT028;1:0+6/cYQQwLv8YPCCawu5LPAycOFPNo1EBNOmN3YA39X4YIJqG4FGoho27wm/J/5JzVfuQzk0+cKe8Y08c3yiHV7iXnQm0vH7UCfGuX7mn7+4Vh0+U8xGmL6VMNZo+hXl
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30f46db-3c0f-4bb7-2906-08d6118168ae
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:SN6PR02MB5181;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5181;3:+TkMvIx5fpTok9SU466rONZnLKlGsu6RCaJp165sAjC9UPeK3oVAXGFl4NgfFpwNGlG5y1YVSUCkOxGl1f/nkDd4KFtZHjy9dJG+twIrfnrHN99Vc3dQe/oltzI0zkF6uW14kqkLl/dPwGjJETiytPts9VwmkskaDlR0d4YxUkFWcCbdicW5uYy+Um50phTl4PP4BfmlrONF+xYVFqv2/sRhXF4w2ndcUW3qwoU6GhobjD6x9psdYqYeXv04eL+CdUjHNeuUieyoPFJ0dgSrWuWgmfuujhEmhHtDUlQ5y5ZaTJkCgbV3qWdlig8NSlFkCDuKeLsOLb6mokoth3a/uRW8lX5GQCrBtjue8BOWe9M=;25:0MB3g/aCrBeH3qxMqmD1oP4YGjO2gkR6dJQT/sMJuyquUOcUhytir369uI9wPY1rU58L7Ll95cx5kjomDSe3hPp+Uk2w8QMAreOfCt/vDznxY8gPNaQiRgxkWSN5XCQFSZ6uttT87HwtbEOsiwtn6flzZa5/GXTEA03JEorNLP04juth90WDfFF4J6aTLF1bS9yczLn+sVyfuZ1Ch4l38UZGeHndPL0hEID012vMBraXq1Fdr1sq6eN6zx2TIET3ro4BFYsgqOy1dOpwPxziTpLHA8UWEmesak8bhYDLduEYG5LXKJLXk1aO9vnkiLIosBqR+ZaNTjabBx78oYAkBA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5181:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5181;31:b9LAoNzDplscqij0NkRtSM5NWZZhjUteO6fVGdmi9kAjNzcVWKRWxBASYIq4+XAixKc01qpJcFSbbTsxPo+7wlss/O56HRgm8XZJr9Ome+OHCO2jHPTNvZh1szF972O+MHfJ16gGfqmYNJ5HZwZXZCWEtGkDv8P7k8At2yQl2spgX/2I1kUpPeCp3XWm6DOqx9xPnjIhuQcu0UuL0lNO5C5CNCK9XrxvG7oJf3sJRwk=;4:ORoAEepSfxuJLa8H+h3cB+4cZT+Y/7Vxp/7GQHc/Tci9YvcN2bDa/Jp0VYBAoKIggVT88Wc9QtR03k52AEGdhJvXzbIOW/LXAWWTgd92MaFE+cibJkuOJ5rZODXjVjrOS1/Y5KRaytOpsX6vIwe2zXOkH+vo1kJ2O598/5W6VeDGGsZoupCWex5dTSkqnMN+y+/Mu7DFGuBf0c0Mdm2nSuPvSCa1lBAPRtokPWGb3vkPzYKaCjjzyMKxS0Wce7j47hJ48tD1si4jjJJuGZVdkXYAfWL/4BfLbCVbrY9tv4Un0+Ik46tijurlT4fZUNDB
X-Microsoft-Antispam-PRVS: <SN6PR02MB5181AE5780CC84FC5780B4CB870C0@SN6PR02MB5181.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6096035)(20161123556025)(20161123563025)(20161123561025)(20161123559100)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011)(7699016);SRVR:SN6PR02MB5181;BCL:0;PCL:0;RULEID:(400006);SRVR:SN6PR02MB5181;
X-Forefront-PRVS: 0784C803FD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5181;23:MgzdUVqabDQwrQAafuYNnU+9/ka+Jy8pk9g062j84?=
 =?us-ascii?Q?fNfMb2gIFEl28fpv9+bUwmLbtVy4rMW33a0S20K8MQcS38Kqv5ejNtn+xVF4?=
 =?us-ascii?Q?KE+RFzVeJ4UmKv05rthpT4pEmkPmYFBq1Zns19TGf8d9triAPt+et6jybUL3?=
 =?us-ascii?Q?yZoHra7iDqyxNapIGaiLstBGzj7fPJdmdRId6epD2USfutbQX5nevp34Dkq1?=
 =?us-ascii?Q?UJ+cumr6lIvZV4DAOrQaoWch+/tGNS2LE1ALKgxlQ/CpdNxuB5pI/PuJdoYp?=
 =?us-ascii?Q?Qc9xqHR7cUhn2kizT6dfp/8bz/A6q6/qT61KWb6ozKAbG7j3NtvJp+PmClVx?=
 =?us-ascii?Q?MU0RHj+3rm4E5/llC84hyok/TXg7PB0vEdTlx0DpuYLFHWOpjCo2yzA7btUg?=
 =?us-ascii?Q?6pr4nyZbDenwiHFR1sg+zfsY0+UZm3j06WJoLRWU32ciSy5/0yj1pMrLGzy/?=
 =?us-ascii?Q?+wiReQWki28/fFWhxP8+tBs0ucRFb5ju64GmVqUUsa3evL8ETO24LOEMcc9D?=
 =?us-ascii?Q?A6fcJc+np/wkQ6knmSgWBQeI7iv9Et4QEz5QI6O22kU4aGyukFlpr46QIB+f?=
 =?us-ascii?Q?yX2JWPuF+MfuS9NYYOu32V1opfviRKxlW6sSNaV9rCwPL3MwRuTmfUn6YmQ/?=
 =?us-ascii?Q?td4G40/emgWIWk41TTb6RpfFWQuEtLqHAVj0G0NOC5/Q6DzIrGhbNPgY4hqc?=
 =?us-ascii?Q?q9cN+zwZmdbgvdbxgrpWDv1lYtUe8zGNp4qpU4pQanIL24RAoiXh9V9jF9Qq?=
 =?us-ascii?Q?6j+SwYjpU6fraDEtA1+MANkb9wJIo/BW91ZBEus3s4BhrIWROarYQIETMKM5?=
 =?us-ascii?Q?EYf6G+msiXYPsspWOgAAtUt/JUC6GN2Y7jux0tzkZg47KQX48i36s1Jpy0rh?=
 =?us-ascii?Q?0mpWZ/6C1r2GRkF/ShaAkNj/9RejSSIjjhBRtNo6isihm5RWbMrM7WNizKY0?=
 =?us-ascii?Q?rZGi5X1lzyAsYihwqsaXNocZCX9O1ppJdmrIVAQvrcS8AWGWIQqXOzxYS49B?=
 =?us-ascii?Q?qi0zkRhgBPR8NHVgvbL05uXBwuKiOcqfqjauWioPwar7/Xj/7GJbHz8CXDBh?=
 =?us-ascii?Q?XzO5r5PlkwHgco/46Oc2BoqpHYVwjPrUtkqYWqPcAWKlTelfv+rk5iNSiJpu?=
 =?us-ascii?Q?4ksLcGG80yGSsWivghnwrSGRoiVL+P0H4IpWUfndHpiDSWX4PFzxNv8zFY4g?=
 =?us-ascii?Q?yJymASs4g+RQ6k+C0gaslRRs9HQWPFV/lvk+MuAQ6iN4SCmNHXqNLlKt7DsD?=
 =?us-ascii?Q?psvHr0iEC4B6Mg48H0c7oe4CL2V9ipvIcE0J0XPXkJ35b6J3lYsl8RxZZJAS?=
 =?us-ascii?Q?pG1H0t+q2dNAnXNOki5pWv2hf899ryZtyAp/NtptCi+gbft/e57GRsEBTZnG?=
 =?us-ascii?Q?x13sA=3D=3D?=
X-Microsoft-Antispam-Message-Info: di37jb9TC9QKdti3FFnn21MzTpAKQY6Sci7sXgs8zyPzH9j50YTLAIl3nrrG1ACKmyibihx5Ok6xRZwgB88NzVOT2slwWQ/bX79/HJ2F+UQCBN9GzwrQXnTAT9U/YWEVKFHzNXpVgQWLuUEAXqs0f23mXUuS3wQhqIPEwNzjbRnVJQ6Wrdt+Sm5bsI+9T542yVK416T9yTHUs6XpO7c7Fwxr4L5rcvno+rB/podc6UWGBu/ZbD2xj8GZshmfl6h7xa2iPv8FHm23a26HZJwtjO/XtTvAOjy+HYbjw4Ba+v/3xb21c5uKKvnerF96iR98bJ0fHQMhA51yqSAiH0hNHlJNkReeePzHkk3enE/f8SM=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5181;6:Ht5WevN5l4tPxWBGtJ34ADl2O/gvsf90a14Y0eTcYVrAaeeqw7Ei+uiLl9GKPxzIM5UxvNwHhy9/ZyeaywvrILsRlAt0+mN7OIlMmQs/tl1F0QygHYwLba1sEnZz/B9LhUvE4HhlywgD0Wv542otVkaPkoFiQOgg8amG/iQtki6FF0jiG8FRBUsMKP4BKbjsh9PadvlHkMvDTbEQ/Ho7fZWVCXVyBXH0XBvC8DSSfRy/T6tQeoGVNPeh+PTibtjt49yYfpoDzI9KCX13Gpv9aVuM35S6++9ROrO6/ncLmltKPa4xvs2I4Bey9IXbEqY+CGa+R53X/JbEXTJ96Txv+l76gszCO0kBXmmVAwgR3gJlrqYet9K8TVAmhCZhJDgVdmK2o9MG1uw9Y2Wt48vUeDChq5sP1E1xZoW5gTIkQUs677Yis0Ony56w0L9EJ/25VRgDpnAksiCWb5mJ7AUwdg==;5:KeUBHlwAg1LodXK1siorO19LO1+k7Uck/jXid+AvppT7nDxByia2zqGSI7ChRtH0sGVXxf8i6+XZ1MQv49eWMBo1obescf7EBrNt+9wLghsQ+a0dzGk0LUIq3TRFyhL6kLCTUB+wQKykKpAZqv6c70Na9HpdgP0w3MyKRlhqSBM=;7:RlVwPkhMo1746yhdfgf5cgCvo1CStJZlGlrsyUNMd7DgXuSkOC0MeLRSUgNYbA0F0ERZSsrxkjhtgzDcMg61sC0pXaTloEo66GZp3dUlPtRLvvOals0EuNxtSxRtKVSXSSnHU+WWGPMcOhGZw9NgZtJtJBpbblzaLPRJYEBGM8611MDCjGBJeCLm8lVA87CXczBLBLSfiqgp40LX5ZWXRDGTlU5FjX9lLx+KGh2qDv8gtbVRiDyemuqbT7oKrPTa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 09:41:22.2326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30f46db-3c0f-4bb7-2906-08d6118168ae
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Disable interrupts while configuring the transfer and enable them back.

We have below as the programming sequence
1. start and slave address
2. byte count and stop

In some customer platform there was a lot of interrupts between 1 and 2
and after slave address (around 7 clock cyles) if 2 is not executed
then the transaction is nacked.

To fix this case make the 2 writes atomic.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/i2c/busses/i2c-xiic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 9a71e50..4e3b2a4 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -532,6 +532,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 {
 	u8 rx_watermark;
 	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
+	unsigned long flags;
 
 	/* Clear and enable Rx full interrupt. */
 	xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK | XIIC_INTR_TX_ERROR_MASK);
@@ -547,6 +548,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 		rx_watermark = IIC_RX_FIFO_DEPTH;
 	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rx_watermark - 1);
 
+	local_irq_save(flags);
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
@@ -556,6 +558,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 
 	xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
 		msg->len | ((i2c->nmsgs == 1) ? XIIC_TX_DYN_STOP_MASK : 0));
+	local_irq_restore(flags);
 	if (i2c->nmsgs == 1)
 		/* very last, enable bus not busy as well */
 		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
-- 
2.1.1

