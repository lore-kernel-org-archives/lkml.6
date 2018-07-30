Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F7DC46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E9220873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="JbhazQj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E9220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeG3ETg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:19:36 -0400
Received: from mail-dm3nam03on0088.outbound.protection.outlook.com ([104.47.41.88]:41024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbeG3ETf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBNdgngxV6F5slvk6l8KUn4Gw+nIUof/U1bct/+gEzA=;
 b=JbhazQj0nd4YnydvveFbfmGLeJfDTOrfCfwdlAKDwr79361dFwpbXj9/ua+N3B5+NK0kUe7zdMREjzW+GOd3Ql6Xu+Hn7XzUHF4SUfbNSkho6Y3fmWo/GDRcRXjR+KHoV74Fe7FEPKK8dRkagUbgkbXpapLRojZVoicWxe26XRs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1572.namprd03.prod.outlook.com (2a01:111:e400:52a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.16; Mon, 30 Jul
 2018 02:46:44 +0000
Date:   Mon, 30 Jul 2018 10:44:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next v3 1/3] mmc: sdhci: add adma_table_num member to
 struct sdhci_host
Message-ID: <20180730104424.44fa39a5@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:404:a::14) To BLUPR0301MB1572.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f242d97e-a87a-4ade-b273-08d5f5c6b09d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1572;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;3:WWzQ5dKtb7gT+6UR2m7hAaTl88NCGzOSNt2Uh8z3tLVlFBnpql5GW3JyUvELv7FI8ifZ5aE7crYapt3O/TuwvsUtp431Qh3xQ+Ih7gQbGAZ1j24odbq6ROBgrCeXl9hWBlaFsavq+re3pI5g465xZbzD/XSYexmB4gPDeoRPFCdNPPKVcTEcTneadz17d/vO1dQPW2oCjRuNgS8O9xHLx2lrGmgCEG+laZX7aYLEa/yX0UI9QN8rIZlZG/y67fFD;25:EEVsb2wH5yzTJq4EsAnWt5JEhDUnqDiSoos03RFPvRsNILkcwRKYDz1ZlJo069tAqD6i3q3+rcxddk4vR0L9rDzW9BEV8EduwWDQM54RIaxB3U8niiEvf97/pGbLO6HOS+7fG0sG8RvxH0v25t1cGCuGZrEDAS66qmKfMnrpsC8RJ1GWOrXy94tjHDcbsqoXnPniFsZI4UQi6th4qrZrId0Qzeq2H9fKBiZScOCNnc7IWTi4LMeWqCjM+cPxboBn6JZlSy6cprYkLUZNphpyQQuIGeUmB8U6qNbDQ4XE2QvXj4zcXAZ+AjkcvMQUhAWz1fbQ02JW8aTt5V27ATnGRA==;31:ax01me4l1q7vIR5zvKguY5ySvfWfnscCbDfjTKcJNjYUxQjmS3pK2m4aNiMOz8wgfdWMPI2RI6wN7dFrD1yOVx01zDkIV6PrsWLcI50Opsp/z9zd+j0NiDXuBz8Eku/cCBeL8ZY8CO0I1qI53zWnNjpZa1DJVVrC41TMIU64jrn/PUNITrT80FL+XQfCN3lXXXZT98nx8BuMoPJ8nHCzfdl/u5U+XRazSvQaBzQhJaw=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1572:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;20:Q3O6LGXRa9JAil1NBxW3UyVwZGCFM17DelC5enaGnjlXyz7RzIyFVEuMjundiFnvEmH+YxxC7Hn7oo6KHwRLGQLPWSNMzGOBZweHZEuJrvmwit3duaSweeVhNEXQpYxy1soz3strjyx1EBE8GpTA71D+yjX4mEHTOuEdHURE+rx70cjmyTPIJMzGvuzbQmr4r20bholBj1cHBHRerFQcqqxGOODWI5CjfK3P0/f+cFIdxb4iLgwSv/5bnLB8guadlMocE9IeseTV3GFP//C44vEN7J/Oyt/nqeXVYwRRyBLoxCHulzfuPWBi+uQeaPQTSH+mEk7Vijv/ey8Hxz7pzIpWDBIo8eFmDUxzvxlYqfuwDqvSSRWkU5xWfcKeqpOz0uAf219fREHn7QWswWfbNWmdzIjtKCidpZf+1kSMS8S1Ic6bw3dqwrNQ6W0CFJIQW/R02Hzv1emIeOphU6lOcaTB8tln/Q7Lg87e48D2MUD43lHzRYesxArpoJHpDvpg;4:iksj2jOk8dAcFigdx2APEcqrdcaF0fhNDmgho39T6m34dzfpwy8PjPuVhi8ZSYnOX7MyX0GuCsBHENinJNOjBS2D385MkluI09bP0F8XMncD/DS2x6y9HG/u5MIqbVwG4RWydQCGUIzfsqAzqV2DDyh3cMwJsURFrwoVD5LAHhcmqmU+N8dd8JTEdX8IbtGt7Z3LGnnKSENDsfosyW5q9Fu8zm13BSLOTj5QK/N2Mro101ZqtnHwYYV2rN5IKycN5PRzrBBmw4aGE8VIH7rUPg==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1572DCD20EB676C41FECCF1FED2F0@BLUPR0301MB1572.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1572;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1572;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(346002)(136003)(396003)(366004)(189003)(199004)(386003)(305945005)(6506007)(33896004)(7736002)(476003)(486006)(956004)(50466002)(16526019)(26005)(186003)(68736007)(6666003)(110136005)(55016002)(9686003)(52116002)(316002)(81166006)(2906002)(81156014)(8676002)(8936002)(7696005)(230700001)(106356001)(50226002)(5660300001)(1076002)(23726003)(6116002)(3846002)(53936002)(4326008)(25786009)(105586002)(97736004)(72206003)(47776003)(478600001)(66066001)(86362001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1572;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1572;23:UaL0yamRr6PduuYY/XDdcCFJ+t5noXxEh7ELCvM?=
 =?us-ascii?Q?UUGYsVorRD2YyTiuYjioZnC6Zfug+GRcWPfwwrQacQyn8QhK0W8zf1tosjv3?=
 =?us-ascii?Q?jo7msOf1nDIpFjm2G3QiMjkmACjx8fo1F5gIWYD4ZtjTX9X0hv5cdLoNJ5li?=
 =?us-ascii?Q?4p/2rJseyNAylU8TpzYNK4mbt+Y02rU2XJLAXa0PrkKPHz3dd3ubAip95h+B?=
 =?us-ascii?Q?QwbCDz5L7IFy4ZcP8JixdZBSLaEzF0mmGDzByASvaM1mZl5ru5PGyTKjXxyF?=
 =?us-ascii?Q?YFUkgp2ozZFkDiLCWVvpjJfJgtsjDyhoGlNrWCi+1UCxrkHHN/d5sKhB4oR1?=
 =?us-ascii?Q?o1+anLD/KxDglDk3bZYmvVQE8sL84PUq2kEjLNzcKoquXgg2FhYWbYZY3z4g?=
 =?us-ascii?Q?G2Qh0YoKr7ZGWXzfBFq0RSYXZ2/IUoLTk2uDcjtxH8XAUYhKCw9/FN6MfKiJ?=
 =?us-ascii?Q?kGDcB5k1wgqcdjYnbkm0xnGzW5oHE6WNgCsirW/9b45RqVMDuHkkdRypOtnY?=
 =?us-ascii?Q?/1n5PfLDEXoyCE6WgCG9zwQHWbLws6JUqGMGGeSPx2px4xRb/glDaneKdnkG?=
 =?us-ascii?Q?sNcoTGNII+VN8JosUOFCQkHcWkX184xU75S+51UkAahDeII8fEHGv0Mi9yfl?=
 =?us-ascii?Q?+s2PwvRr6ayw56siuJku6RRpnkpk2hGzpJAsoYACZjo1Va6MTtAA9V0aWf6R?=
 =?us-ascii?Q?NuUOmeD0BaNwsS6bADFvXQBZtXtKz9DGTZKjBOT96+IRT211Cym4h26OaQj8?=
 =?us-ascii?Q?U4WYR4SNs+W2Io/cbMYSNMh7Lfd5Syl0MuXOG0vfjIV/j7akXZtuaRY6Q60r?=
 =?us-ascii?Q?AqOL8/MoJPXBdeZTVWH8T36CS0Lb7DEb1ihbAd60Sw7CY88HgyWFP70ITl7f?=
 =?us-ascii?Q?asD3fFDZzR4heBbSSNbkoLlEipC4Iur2RzKa1XVGXegcXvzUEvpKqMUJTeOS?=
 =?us-ascii?Q?kkAwvM5D8lecM0+a1gZWpfieuRSTFeYgdLndk9BWQd65EAgDGFA9OOcIVCQk?=
 =?us-ascii?Q?5lQZRhtqA1ThsV5UEezWj1laSi7Vb/UnJRmpZY0B2JIom0JyI6qq5XDDU5Dm?=
 =?us-ascii?Q?OnC1SQkd13CkKryaNU71/ZI8Vge90bAFvbcbwIn9c5K/U48cQRdK2Kg+nOKa?=
 =?us-ascii?Q?drn7d1H4kw5RGBpw+8TKXv9VjhwWsMy6iOr8o781KwBBipX0kcgEAog=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 3NrEJ0aAmWeEFQ1u2KmMMEBQzqKKW6+GmRuiAqVyMlZLq4CuK7vz4oCauOD7wFzG4rM8ZNUjOG5RtI2DCPoXpU+PiJXtIn3rO37Vu17ZeQxvFFAz2zc6D8bS/rsBZOTloYK36228fdA8r75co1ldnzauRVqwLCOumsC2KyXHz6Fp5pvjIS77CslDDLtOIm9+Rgudy23ylssNqvEm78M+Mrw2rJ6hjCdp6K5e9lnbLRJJfyyMqC3LrFgp7VSe0mt9dz1lDe3VZu6grD12SZNHELQd19PZOxu8U3R4feo5pTlJ2KrX1yHit31DVUy+48KU21s+8vMzhEHz3NEU22CyScdOgS6oXr4I7JL/XYVl618=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;6:R6VTVAYh65kmKQ8dYwqnSH/hL0LXOzbXYhgmnzkcJZ6HT1g4yUEyVNp8k+5rXw+ItjZMu6sU9StrKXdeLnKy8qmq+Xkgr5WMZoR/mm3LN8A6eLnYeJCiw9NkMPOdNGc8FGGjKWc9ewdTH4/jVRnolIRQ1GDTcdeyf++Vgr6gbXmFdt87WGKI9O77xGz9gaQ1By6bS61daDn8WBQXIi0/pdEfKnSITE2vFGqkB2tlPrizx6hT9B0yaAB95Kc/V7eEM+6giUzEaIyuyk3en8lnWxjOdyCbj+X5PZPyTIW626qnXs0QB3J3OqfFZRhsINMDNFsOGlYdcoM80/H4Xwa2dz/JUlki7JpEUfc/29ZQL+FRCturBfvvXT0LQCQMCdjlHkrZCfFj2dPZQZko4EOLtpCdNP+s5DS+DJKyx85EqvBssBi4Iyjfs+CSIKZGbtzWJs3bUWDWUr2ibLy32foX/Q==;5:6izcKS3/6XIculOEbZKrgL2lgRQVvUfsTCTyisImUXv3NPsoz0Vd1xC/p3f4GAajpq6gfHt2xuh3fcqe1lTir+2XkUqByEXVsAVtDjos53lldF7U14uhTp1hXVsOOpuAyay+v0FvLEEn4uC22gzeZObzo2LnmqIE8VlD6hg4gfY=;7:wieIFn95WGoUG5g4dPnYO5GS5mLrul0rbEuXbs+nQ/bCVW9HC9Z+Gqn04ZTnyeY2ibNhSlewgIz1FQdoTqqfP3tDQoxsren+/NKvukGmkoEozX6WoABpUmrEWJJbaVvSbxexgrakrJrTS+2GKXXd0gJvuthwqZcPGPq+xvoC16cZkxLbih/7yO7Qva0j3xTiHTHRe6GUVm7k0AKTJwNoJqQEoMc+Lh39Qa7xOrH7MnNHHVAneS6icidV7Yorc2UJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 02:46:44.1983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f242d97e-a87a-4ade-b273-08d5f5c6b09d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1572
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds adma_table_num member to struct sdhci_host to give more
flexibility to drivers to control the ADMA table number.

Default value of adma_table_num is set to (SDHCI_MAX_SEGS * 2 + 1).

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++--------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a7b5602ef6f7..14dd4a49e03b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3316,6 +3316,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
 
+	/*
+	 * The DMA descriptor table number is calculated as the maximum
+	 * number of segments times 2, to allow for an alignment
+	 * descriptor for each segment, plus 1 for a nop end descriptor.
+	 */
+	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1;
+
 	return host;
 }
 
@@ -3561,18 +3568,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 		dma_addr_t dma;
 		void *buf;
 
-		/*
-		 * The DMA descriptor table size is calculated as the maximum
-		 * number of segments times 2, to allow for an alignment
-		 * descriptor for each segment, plus 1 for a nop end descriptor,
-		 * all multipled by the descriptor size.
-		 */
 		if (host->flags & SDHCI_USE_64_BIT_DMA) {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_num *
 					      SDHCI_ADMA2_64_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
 		} else {
-			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
+			host->adma_table_sz = host->adma_table_num *
 					      SDHCI_ADMA2_32_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
 		}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f887da6..d55fd7033e93 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -563,6 +563,8 @@ struct sdhci_host {
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
 
+	u32			adma_table_num;
+
 	u64			data_timeout;
 
 	unsigned long private[0] ____cacheline_aligned;
-- 
2.18.0

