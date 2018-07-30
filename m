Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E1AC46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524EF20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="vV0ZaRvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524EF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeG3EUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:20:45 -0400
Received: from mail-eopbgr720042.outbound.protection.outlook.com ([40.107.72.42]:45824
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbeG3EUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4u5uB4pyMz2QMMCboV1G5cEG2ARP2isXycosXVGyGw=;
 b=vV0ZaRvbHgOc+E9iBu2TRDBFO74dkH+zWJmhC3aqZERNabASl0iAmCFRbTOtBOVFZ26/XKWg1hDgT6hijk+GePpr4R9Srbzn55MaSlmgvcl6gyT8R8iJvhkivhb6P9lQO7K3U/+sVDEYfmH9ecAP1VhG3mpxr5P7+HJnqy4MPdg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1584.namprd03.prod.outlook.com (2a01:111:e400:5232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Mon, 30 Jul
 2018 02:47:53 +0000
Date:   Mon, 30 Jul 2018 10:45:31 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next v3 2/3] mmc: sdhci: introduce adma_write_desc()
 hook to struct sdhci_ops
Message-ID: <20180730104531.388b4f39@xhacker.debian>
In-Reply-To: <20180730104228.28b58bd0@xhacker.debian>
References: <20180730104228.28b58bd0@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0160.jpnprd01.prod.outlook.com (2603:1096:402::12)
 To SN1PR0301MB1584.namprd03.prod.outlook.com (2a01:111:e400:5232::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da222d22-5b65-4da5-e54c-08d5f5c6d9c4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1584;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;3:9+hB5XNZX/exSi6Hf88QDLdSPrJqYG5+cdNf7od1G9rqjdAfGeECsUiNJyfejD1c2Qzn9BzlGvpyz0D5CPwDvzRusOy8OnH4ktGPV7hNqTx48my3rnPnGdQmT/gL+QFTAaMBJNYGOFAW2yd0zdMvQUzu/fMR8pKous69NyAItdJet1ts2XMafQ9KQiA+RNozaJ9ZlCcEtuZ0D0qCo/l5jjI4sXhvo0hCONF2wsuSjh+CZd0pgQDP2WjFK8LgZ4H4;25:q5fg8FQcUkpTTNpeZGPxxsjPsV0uNAW2GL4GaLsx2TLPimib7C6/62J/NjRtmRZXU28kepvsgay2VsrSaAB/ZceGmuTXb++3+jQCTt8OpnqK4K3rm9EQQSDBBw1anZQsZt5kAuM+LgW3+SnHLOoL3t092G8fkFFuhUi7xUD2ilfk/YupJGLkVxpoZJtogFaQNzBCq+OKLScEqhXoKuhYR9/Y9ZPubNcMToZvTKZ2hLKPFdLOdcvB3MZ6VUgXXbuIEoBtZBqSjPWCXdtiyTPzghO9rZxHY34m7s3RUNzGfa36Vab3YL7dYJv2QMX9+j7AlUEAKPaIYJO5Qs10/uuL8g==;31:saqklJdpvo+8PyBT0rB0T7IdeVd0cDwXw/v/8w7u9bSNW0j8m4yxfPfX0fF9ihrLULqgLMVfWqTH+qqFCb/uEzDQHfyyjrZ3dfOrdCCFAsSaCF7zUiUNwjzWepY+8bfd3rpFMm3ehB4ojZtTSAv7KYl5/S2ZWkf5n9CkRwA/NCiRRvgDr/RuRFFpUhjw5QEjovmWn1SDmE9ttjI0PnG/YcpmbqDLDiqhSzQL9hj3hkM=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1584:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;20:5R6+3uvDcYeUgwLbFh6ik7sXMQEHBB673Q/34yr350SdqinZ789jJFv/QRb2/pddV7ejtjkzNVosvVP7ZgvyyZpglM2ev2mjQOn74LLEcCLFu6dtdWYAnb/TuXym93IAwjSfXD2vXnAnYKQVPAJ1TW/dm8cjSioIbt1FXRxeaWnKaIYNgzKxRXdEHpcHK0NkbGZI+wS0f7vgQKdmPH7maICtxOdAWH3D+Wu8xO3bMojYYZWnWycqcVXhQpEiKPfc0lnKwVGOHq9LO3Ivp1K47/1J9P5iFSGh38WDVx4+Z0E6uC8znZEHBerV2y4gizu5kd89xxypAKn4f4uXNXUmA9ffVDQFdU3VZxZkhbyLewGtq8qvGgJ5/c925gisf9Fku3tBLu8AdFZ8P/QhsMX05I0j2RUY/QKlJC+PmUaQufsc+x6X7kewh4u9plvxXy1+660sVX9T5J/LCe48V3MsK0ySKlXNHdGKYTzupLhTSpnMyyjvEDjJhVQ+0XHHxCuz;4:Cb37dJfPEJPJBMX049HhmW+c4CRs+S0O19nPAEq9cKCF0dBVxO7Q/0hJ3vhisAFkySQnozAEIMGJD8N7V7kx+Hc5CBXwlYKSi4QZY3BU5ArhkKsTzRw/Ht1GCXCKaYkrjG7lQsKVUNdOPjwHROajfPsV59c1pCHWg0RChU6R1OWwQFBhF5ZYO/4V2cRpcB1/ixTBOZnckm8NK4RlNb71Gfg2/S+4L7OW3wt1sNG1R9W8eByqnfrzDMlLADepl1+2q1BVcYYTNHNBU4w9txed0w==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB15844ED2F9A5732DB0038987ED2F0@SN1PR0301MB1584.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR0301MB1584;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1584;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(366004)(396003)(39850400004)(376002)(189003)(199004)(105586002)(6116002)(3846002)(106356001)(23726003)(8936002)(230700001)(6666003)(50226002)(7736002)(6506007)(386003)(68736007)(186003)(16526019)(7696005)(2906002)(26005)(8676002)(81156014)(81166006)(52116002)(53936002)(76176011)(478600001)(4326008)(72206003)(1076002)(47776003)(25786009)(33896004)(97736004)(476003)(5660300001)(110136005)(316002)(305945005)(956004)(50466002)(486006)(575784001)(66066001)(446003)(11346002)(86362001)(55016002)(14444005)(9686003)(39210200001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1584;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1584;23:l9m0jEctKXTQezuVPtFSSE/1chWEhPLnq3bCYGt?=
 =?us-ascii?Q?TuiThNUIrs4utTpoCaafYrv7ck4bq8fQQnOXVfTy31B69R6TDsprsxvv/4zF?=
 =?us-ascii?Q?l1ApIFWEm0iVGfceMUgH+r5ykI++oMKHV6mGsg1XC9fAscg0BRJTk2DjroQ6?=
 =?us-ascii?Q?GPN6ur5vXGS+3i9tkc2d9KS5gnZPQylDm7MeXaRPOWUHLHGoyxwGWcDEk0zD?=
 =?us-ascii?Q?n0zg81z1Hd8o4UT0Le1p5V++7HjLO6FES9cHlpHaSFdyh50JgDKw8BFf20iH?=
 =?us-ascii?Q?eTi4SZePQKEPk0Ou/qZASItOq/VLKS4LHIaMXFRWOoeDV7V+aqj8MoKK3bdt?=
 =?us-ascii?Q?7d1eBXb/SdPii4lPAZLtTqBBfL4KIqvex3/neVihoutVxrgkPtX4Q4bRCI1l?=
 =?us-ascii?Q?KXcKPZWdbmMVy02WCCXsLIZ4Nd83ClPP58EVBSBA0JwNLx6w9ma2TxYMz//K?=
 =?us-ascii?Q?LNoh5SCaSzoi6djcNOA6iYLrYcq4/rIv1mMwjpUwNQAc3FwQPDlIx5NNDtzX?=
 =?us-ascii?Q?YkH7ucVXOAsQSZ7Yl1Ayg6purlBKzcEfXmpEFiF1ZrTp/z0bZr5+FcVQQkxe?=
 =?us-ascii?Q?8A6NOj1+amg/BK+Lygo+SwvcmJmM+hJNv5t/EG3eyKwIZiXI5Zd7I8Fqewmy?=
 =?us-ascii?Q?uOc8vYKSs2XYSB/tR8WAOTCvU7Dp9t42n1IrvNhUzYsvwCrdaNuj2Nbk/M0O?=
 =?us-ascii?Q?Ps0I6kNNcULqp2x68phXbSANQm7qO564aAtB3VLGQ87Sx+U1l1/PxVCm6NKD?=
 =?us-ascii?Q?1whL/Y80Wn6f+fqKwn71luB5kZcmrfOZlc9jjWhZPYNiU10V3zLPiwj9sCEQ?=
 =?us-ascii?Q?2svk2ltQjgYnDtjfOREJ4Hs4/9ya9mU5NrWYSl+qcFhp/L59DRSdaNcnNGsk?=
 =?us-ascii?Q?S5hmbfi2NHWGqBl8v06Eor/jPXLOBNNpba0S+5uxqhzJ/medp4rGZF0RRjvU?=
 =?us-ascii?Q?OH1gkJow7pqGUURNnbodyUsEVQ5f62KbG2z/53rKBm5UD9081qhAFPg/WREg?=
 =?us-ascii?Q?mK/vGD8wa0TbCtyp9/B90YQ/AS7qcLsOid7HJjx4eGmYate/IMsvXiTODufR?=
 =?us-ascii?Q?NH3ikE8KDtlU72e0Bb4XYoVrHjjVCkL/Kz7Wz9H2iuNVh4BA0kYkY/oZReVf?=
 =?us-ascii?Q?D/rm5gS5lRMBPfORz9kezPk+FUgkml5+fwZUKdxgckTDL2lSBclIQ5W7aSOc?=
 =?us-ascii?Q?xvhLkLfbRQtQgU9lhStKg/kd4ZYObggq6Usk75tMNYSQI2pgRMuxnhd4i3N4?=
 =?us-ascii?Q?PaadhwzA2pynxZJqtgCmo4DD7kRNpwtx0QgRhX06UYrLj/d0mwTq8Asa3mee?=
 =?us-ascii?Q?eL148uSq8GJGTrt2dwIW4ku69oW1LJZ/qcfs+WqQXglN+NzbXwr7MzD/LnvR?=
 =?us-ascii?Q?qQvpQUQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Pd4XC6dJAoJr7WfFYhxvAcntIKPpwJ9yXfffRtMQowVtAqx6GK4vmSmrRgez7al19WtxALyx9z1/3rZzjuY34nZZtG7aHwieThiF2kZWs59E+3SkYmbz4Dw2MDvwfp5mKpp4IkLZGEneRNPOo2xdYCxnqLBU7QQrCT8hj30/HhEoEAh69B5PqrAM9L67Urr4eb2X9k5C8UM838rJYcEybuQWyyCUnbnS9bRlMOO/H/TQ4Gb06Tk56Yn4uBJJibvSUwmEJSL9wE2FOSMK12lFP1M9FZ/hDO76xbPY6mc3DEEWa84r/QjzFjp4/RxZ3zBBsm04iP6CNrwHHfShZngoXCAuTeu+/BQfC0PxvGfEe70=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;6:dJ+k4pCw+tkMNzalnFTGweeVy5/wgX0lqDtq7mZgG+QkQGnPntKEU1pjVHuZOEGLDZAi2uAf/L7WkZaTZYRRXqic5VD0QyW3qmJHXm2OEiAmjkG7MWdKM3/Z74QtXd9a/LRBKbl+AAXPX3pbF9JogcwmwNA3BkJzDA/I5pycU44uppVMMmY/Wz9JsVSWm5FvZyDxpDlTBBQVPCV47HENjWUv+OMGKIJ1qpufnUDuvNEvDN1j3GiBuUBvJeiH8PyV/Yk1sDhEOPOnGVNnjDbRwiiyUNnG8etlY10m+o7IpXIL39b2c6iIAs0iwMB+IorZbFFTPkN9as/PmeCzEEN83g3Kv8xWJNw3ylPtwx1y4gEEVvc3qj4rDNMxzNg7RUCvkSSgZP0BMSJO9gdjnfPNq3yqaLSs/zrL+grbwwuRmvJlk4bOZixoN6vFmAY99S8x2+gkXSiyOoKjhlUwg04oMg==;5:dB8iLLo+7hG7vtQm8pDLQbvWXRxXQQhVjZWRzRy0tLfzPoL1i9IMrCK7NFaGCwZ9eFENbmCsbAxcji8UrWn+zKXV8xl2QHa7RL7jVjiwS1UaPmca0XKfI9QrW2Prl/wcBLWO6UqmP6Y11Nvvta3h9E4nxIPkONL9BFWy3nQETuM=;7:3SDQ16PZPIaXuwapRydO+UakRCjcPYV42f1/zTlPtti+zDf3PyqDJElgBDSMixkZGBZT4b1NdbwDizDp9ffCODhNf+/1FW1HqceijLKf4VRdDzG6u7aq2pMnRCZHyrRJHw6rf7dQvc+OySquUgoU22npnbR4wvFfIjYebp5koMs+RV/Vdfxu0fSsMbQ6tbq4IHm73qlZompTvSV1C4+CJ0O+QKWMdn61MyjFE5g+HRiufhROL9Pm4liTIr0NS/ZY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 02:47:53.4380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da222d22-5b65-4da5-e54c-08d5f5c6d9c4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this hook so that it can be overridden with driver specific
implementations. We also rename the original sdhci_adma_write_desc()
to _sdhci_adma_write_desc() and export it, so that it could be reused
by driver's specific implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  6 ++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 14dd4a49e03b..50c846d99182 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -554,8 +554,8 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
-				  dma_addr_t addr, int len, unsigned cmd)
+unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				    dma_addr_t addr, int len, unsigned int cmd)
 {
 	struct sdhci_adma2_64_desc *dma_desc = desc;
 
@@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
 		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+
+	return host->desc_sz;
+}
+EXPORT_SYMBOL_GPL(_sdhci_adma_write_desc);
+
+static unsigned int sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+					  dma_addr_t addr, int len,
+					  unsigned int cmd)
+{
+	if (host->ops->adma_write_desc)
+		return host->ops->adma_write_desc(host, desc, addr, len, cmd);
+
+	return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
@@ -585,6 +598,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	void *desc, *align;
 	char *buffer;
 	int len, offset, i;
+	unsigned int desc_sz;
 
 	/*
 	 * The spec does not specify endianness of descriptor table.
@@ -618,15 +632,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, align_addr, offset,
-					      ADMA2_TRAN_VALID);
+			desc_sz = sdhci_adma_write_desc(host, desc,
+							align_addr, offset,
+							ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
 
 			align += SDHCI_ADMA2_ALIGN;
 			align_addr += SDHCI_ADMA2_ALIGN;
 
-			desc += host->desc_sz;
+			desc += desc_sz;
 
 			addr += offset;
 			len -= offset;
@@ -636,9 +651,9 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 
 		if (len) {
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, addr, len,
-					      ADMA2_TRAN_VALID);
-			desc += host->desc_sz;
+			desc_sz = sdhci_adma_write_desc(host, desc, addr, len,
+							ADMA2_TRAN_VALID);
+			desc += desc_sz;
 		}
 
 		/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d55fd7033e93..0aad0ee8f63b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -605,6 +605,9 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	unsigned int	(*adma_write_desc)(struct sdhci_host *host, void *desc,
+					   dma_addr_t addr, int len,
+					   unsigned int cmd);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -735,6 +738,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				    dma_addr_t addr, int len,
+				    unsigned int cmd);
 
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
-- 
2.18.0

