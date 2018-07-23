Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816F4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3C220846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="XyTeMMMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3C220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeGWGSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:18:53 -0400
Received: from mail-cys01nam02on0043.outbound.protection.outlook.com ([104.47.37.43]:11314
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbeGWGSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF1PetsNYUzJZI3954E0dYMA5lq87p9rm0FdGOPosI8=;
 b=XyTeMMMXcNZbJmGtkni1x2EuRFcvo1hMOrCbPfvCVBFFKqT54QK3ZEu/Ih0qe0F8U+B6c6gLB274ugdryZcmYbi2bpwdj8JjUaJgiGTHO8/gf8zgFvwMPNG766+UJnuBcPjnAGn5jrqsJsmXXiOwIfsVxSKWIvKFmDHGi2urGI4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from localhost.localdomain.caveonetworks.com (50.233.148.155) by
 BYAPR07MB4918.namprd07.prod.outlook.com (2603:10b6:a03:55::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 05:18:46 +0000
From:   George Cherian <george.cherian@cavium.com>
To:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jglauber@cavium.com, george.cherian@cavium.com, wsa@the-dreams.de
Subject: [PATCH] i2c: xlp9xx: Fix case where SSIF read transaction completes early
Date:   Sun, 22 Jul 2018 22:18:39 -0700
Message-Id: <1532323119-11085-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: MWHPR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:300:103::26) To BYAPR07MB4918.namprd07.prod.outlook.com
 (2603:10b6:a03:55::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb5a2541-cc97-41b9-2fe6-08d5f05bc48f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4918;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4918;3:po8mS4A9xJ0RH6Rs3oZ+6m7X78ku/wAxJA4w2s7oCpCo93Nses58RGHfF/VSbQEbnIJcliCT2cni1y+prwtL1hwNohs0nua4NzwSiOBQ8Ydv9RZogRSbEuS9bQ1YgXDXjwskszAtuUT8jYOQT5GSoOTQdxZOguuIDUmW9fBOY4CO7jFE+wIdtQiGOcz9Q0Abk6onIpn6HCRpolr3kOnBLxUR4CPWrjjcR8CMiTajINQ9G1T3fx6uSiwqo8WCE+wQ;25:yr0MG24KGLtETPOilQp+3eJtyanz+Z8HLQxnd/lS4pyD49HUJgIfpeB/9Ag4p69DkSvhEbdgJ6TIeobi7v9IK0USuo6dHYJg2jXRkpLCbva0xevB2G0QF4AM3eJa+16R8SwqF9Vr6J7NBEQUXMh8afipi7YRuBqdPITfPlzhxA6Ii6DsErn6g5VY8/bmxUEeu+HOeXfVRFYibNHpaURGArXNC50N4HrWHbggZ489oHzM3Uejk16IHsqwwCmPgagxcJMokrW2SfZvG6Ok7xDOUWpIXMFXTO5mS8oBr0BOaFIQnN5KyymGdG04tVDrDONQp/yoQI4dYGGLPE1D5FUJQA==;31:fZWJ9VzFEabB45EWph7Ggq0MD1CPclUWgHOqVUyBq7VACUeR4xP0PK1owigdGJDyeRNsp25E1qjzT0hQt+WkCxRAQ8JXBzRheuNT6FftR3sX+v+MYftm6vMQuYYR2uEsCFQcmfpZJdHjvcDQCtz/ay6d87KM5BCAdHtcQed1gOtz+z7udvOxsa4fsm7BQgmDVCjB5jagjlsZeMpiCUbCBjHqhUtqYbI51dnk5nzKIVY=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4918:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4918;20:bveJbw1fQkeMG0b9ns2sDV112RHLC1RxzMavP1AK0vUxgWgqOoEckPROfcH+j3ZAMkssPGjgJWF3mJdpoUyJygjYGyv++udqFNCZWGyxN+OlumiD0RO4UDa++SQrzIO8otXlWdxRpye24KeOpwQy4Wh0mGGtO5ie++B5EsKyGqKGhHsufjdHXcAinu9R5BMsCedZHCnjJ9mo+3LQoF0WFWDOI50s16In2SdXAblnB7bWF3JUyHwWCP4XUvqPNWTzzzxVdbiuGcUMBgq9yzW/EZwqCkGtoI2Y3z9s7TvIasW8sUnmB+W83ic8y61AkjdpX8+QqssFgpLWQn8UsqEq+vCYHqwN2/16zsc9vwz7x3Vvmw+Lb7tXijp/URYl2KpuWH2m4Di1lpviTyaqbVKuQbf9lcvDuO4c01z0O8fOnUbwp2Irep0sLWe2BhQY2wTCabZpROr14KcNVwvpIySDTEx9ae/FCDVhslLRY+av/5lN7eo8vMA49GaAqC/9a7El;4:adVbSCotdodoMnvQweXsCsDC7H4q8pfiNX0LrspJeH3LVjuvU5A2T2axv9SU64KHGHcmytK/at8rSF6VFyqcUsjLgk7uLUsySCwdDXL2EG/72j7ijgnGGLdjEv1kxCbOjeMD80Qs4E3T1sLCPnTxOtRs2kI9zHFJYrmOrIR6PTzei+2o/5QvgMFI4I72CTQcEHEBczh4il2gFo1ZD656PD2pag3CBI6cP3tOv4gxmJULZyhr0Kmsij/I1vgzIqbn0x7kgjzuliDdKwqJR++7Jg==
X-Microsoft-Antispam-PRVS: <BYAPR07MB49181F6E05DF7C3D14C3FFD4F9560@BYAPR07MB4918.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4918;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4918;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(7736002)(386003)(6506007)(68736007)(53936002)(72206003)(26005)(3846002)(6116002)(105586002)(6486002)(478600001)(48376002)(4720700003)(6666003)(51416003)(6512007)(52116002)(551934003)(106356001)(5660300001)(50466002)(8676002)(97736004)(47776003)(50226002)(14444005)(316002)(16586007)(44832011)(86362001)(2906002)(8936002)(81166006)(81156014)(66066001)(25786009)(305945005)(1857600001)(2616005)(36756003)(476003)(956004)(186003)(4326008)(486006)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4918;H:localhost.localdomain.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4918;23:KRmj156qf41VJwNF+ehaZPsojgE42zWPOYtUCC0dR?=
 =?us-ascii?Q?PHpuaY3OoX9iq/WVeUU5LdZFoCsfFjSNzh2mUgGeZZ6OnX83uQgA6CP7c9pp?=
 =?us-ascii?Q?uVLUVPwWPa71isT2l09KzmG0lz9tijtrnBwtKvYjgmN+ub4U6tCedmkDNkD4?=
 =?us-ascii?Q?zzbXWO3MD91u4oMEcheE8wP/ysp9WB5/ujnXT8k42EKWLwIlJ6TRxMwOeGyy?=
 =?us-ascii?Q?Sc6w3PQ+rC+M8KHvo1jM2W/rWbI1xdmdeSM/ijNx33qbSgdqFy/qLDPn+IHB?=
 =?us-ascii?Q?7B8Kg3XGNQafS1jCPwhoxkicRkz+cmmVoUZdjXXumvgFCvadvaM1hzmMAq3J?=
 =?us-ascii?Q?BTAPjgzP7bDxTr7uuN5d4PCyd7y5fBRuornziSNwAYtdC/du6mEbKrAW/Hbj?=
 =?us-ascii?Q?zurCQjFrcWhtsdpLLOisbLCgjq7VTVeOpIo5HtXMFURsioe5TJ3gvu3tCM8E?=
 =?us-ascii?Q?0Ix9ug9qfY0snj/4FmZDkzGtHE2wI1oDcZyCmBKL1CEzbFCHSI61mKsi6vba?=
 =?us-ascii?Q?rtf80Z0B0RuqWgAvIWIvMjIIT9U8xnm6AN1f+idLely9pfcmE7QaEzriDdZ4?=
 =?us-ascii?Q?M4uZxkFej8S7kc0aYkpIvewg3A3SSHBOhbvhcyBu5l8LH/87RJWbclrq+bBA?=
 =?us-ascii?Q?FAY1VMyBBthN9ql4mmQpMD0BHIVtPJNYbAOcXztoY6MoHxAkGS/VNaqbP/ck?=
 =?us-ascii?Q?+qjsOfANvmMHiHR7WJgc2WuHzCLymWREgLarNiqLeHnBSL9frj9XW1P979fs?=
 =?us-ascii?Q?iLCvP4LNAEXBggsPFP7z6wjst7JoAoRr8t9jtS4Vr6t1OlD2wwZ2ulmulwoh?=
 =?us-ascii?Q?N9jm0yf0KbOHGbxCggYBXJVr7F74B+0lAktF/NjabTKrzixQzqEs6CAieT5x?=
 =?us-ascii?Q?7W4bJx0GhUXm0Zu4FvODCRnhoSdTLw5Qh5MBSmo30x9n7dr90qTpijIM6grO?=
 =?us-ascii?Q?ORFhD0EMFbITZ475iKx3lGruZ8MgZkD6Hmr/ZsDN5/bVX/tn/5khkb76iFXg?=
 =?us-ascii?Q?0dmJjGCg3krvV4CgnI6Ykolbb8qRKor7BWrrl9rQ5rwgFHu1L4WeEqlt7l9S?=
 =?us-ascii?Q?0BTn7gLfsMrBpjSVbPVAjoa4KyGo/FzLRXsVYzaqLDRXrQs4lVDALJyXAMGI?=
 =?us-ascii?Q?md/v/49NOy7QMT60sFng46qQsLy20rNP2ky1p7qF1CtUi01DapV2qDsW9e0q?=
 =?us-ascii?Q?AGYLgIec8Fl4Z/d/7my2k/UMioEAu1cUwJqxDOfRh1/Si/Uy7/DK1wTZVieX?=
 =?us-ascii?Q?2aLKhESSi7jzBXbcxA=3D?=
X-Microsoft-Antispam-Message-Info: 7Dx9+SkPN+SeCF19kYdqEiEerED6Q6fjnDupLsFJa38SpCiZFDcKFV+6xyrYdz4mEQgVyi1NDa5wfZvdlAFbO/3c/+eRra//AjK3EvkvTe65yDjgib7SBbdF2xH9Vps8gZsJHL8uwJ9IixMTRCzv+LXOC4e2AqDSGOpsH/aemRe+oznuMbknZ/0pWkTVaGrtC5V3Wf2uvBD0NczWWbqhS781tfLyvwXxGesXtQKJVZYfYon6ufPAw082qSXXHIMmeH2M4TZJaoNhu34T9kKt3oHPreHG7//kqPrAPlOuLtPhJ2Y3S8ppvYTS1GuOK5c/By79Jg+X3PDUezgrWxIC5LBgeI99UcIxzH0Qd8yb8k4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4918;6:5ZJvzOSWMaXEKhF1dCh/iZE/gmIdJhQPQ71kOeIxpJot6ZSp3oqQQyVQIYWerhHT4nhlzto41fjMG62Hfqg5IlXpzaXdbuH1lfuuB7zOYDhUe/bu5ryHxSpGEc9hcCG/lCKQempQv+g8tvSe85birJ1aMNOzZQ3RRDnIRxhvK7e/SH6tT+MHyKpohfKSETwVQT6W9FaYLKNhUdUQdxHkEPRF5FWKRz6M1Vg8VLnOvZAGTx7PH3qboGtjHJhYCPdAacxlip/dl50IZxDWyfyqZXDxJbJ7AlZkL8LyUXGMnG1YD9D7WPdkymmRwmy2KqnUAb1ksSb5496Kqv6WxOY0y14piIJAJa4iSuTvv0Ekso0NsBzB/T0yr/+8v07yq9p200YbwxZtr3ULReDtH39h5KPUZc6rB+FmW/MSg9BFMN5Za7Tb+WHG7HcZykzhqWhFvISYsIP/rScNsXcKzZb6HQ==;5:Q3DvBfuNPb4xoIcSgiZhNRYDtEeeNdgVq/+2i/iLyRvtzSA79MfnkJK5RZ7RuEyqEA8vvkPOnZ+RGLUZ2/ljCHlvJjbJexpxddNpZFEfaMXF9KsFlE2iPYTcY5j/jfL8I+LWFrdA2rlYZrUvhXvkPbEVIywCB/2+lzLYLyiOdcU=;7:Hndq3+8FnrHSsxnHYLkmbhrP4CnWL5MZsuL6I0SVpJ89+OS+8aIth9uXEg3lQt4HUcp3n7j0043+GBDpPZeLLYg/NN40hySWlXjHRURB0nYiWqTlzF/EbQp2SUstrIKm9X0yLo7knx+EgObkNoBdgEhcGtw27AqDMGsVqZy+cPDfsajc7XnQiF9euR12lMTbMlqKexSsgR08VVsw4oFVcXD/xItyZjTUkU9Ec/yCLg6gLMgGXE4YobW+V5KMPKhW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 05:18:46.9764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5a2541-cc97-41b9-2fe6-08d5f05bc48f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During ipmi stress tests we see occasional failure of transactions
at the boot time. This happens in the case of a I2C_M_RECV_LEN
transactions, when the read transfer completes (with the initial
read length of 34) before the driver gets a chance to handle interrupts.

The current driver code expects at least 2 interrupts for I2C_M_RECV_LEN
transactions. The length is updated during the first interrupt, and  the
buffer contents are only copied during subsequent interrupts. In case of
just one interrupt, we will complete the transaction without copying
out the bytes from RX fifo.

Update the code to drain the RX fifo after the length update,
so that the transaction completes correctly in all cases.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 1f41a4f..01fa04d 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -191,28 +191,30 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 	if (priv->len_recv) {
 		/* read length byte */
 		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+		len--;
 		if (rlen > I2C_SMBUS_BLOCK_MAX || rlen == 0) {
 			rlen = 0;	/*abort transfer */
 			priv->msg_buf_remaining = 0;
 			priv->msg_len = 0;
-		} else {
-			*buf++ = rlen;
-			if (priv->client_pec)
-				++rlen; /* account for error check byte */
-			/* update remaining bytes and message length */
-			priv->msg_buf_remaining = rlen;
-			priv->msg_len = rlen + 1;
+			xlp9xx_i2c_update_rlen(priv);
+			return;
 		}
+
+		*buf++ = rlen;
+		if (priv->client_pec)
+			++rlen; /* account for error check byte */
+		/* update remaining bytes and message length */
+		priv->msg_buf_remaining = rlen;
+		priv->msg_len = rlen + 1;
 		xlp9xx_i2c_update_rlen(priv);
 		priv->len_recv = false;
-	} else {
-		len = min(priv->msg_buf_remaining, len);
-		for (i = 0; i < len; i++, buf++)
-			*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
-
-		priv->msg_buf_remaining -= len;
 	}
 
+	len = min(priv->msg_buf_remaining, len);
+	for (i = 0; i < len; i++, buf++)
+		*buf = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
+
+	priv->msg_buf_remaining -= len;
 	priv->msg_buf = buf;
 
 	if (priv->msg_buf_remaining)
-- 
1.8.3.1

