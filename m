Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330BDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC7F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="FWeJctdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC7F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeH2MYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:24:51 -0400
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:13344
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbeH2MYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xARPM8KW+YYsM3+FkXpHcATpObHryFfJvFRN5A15nfg=;
 b=FWeJctdBjR1bgaroWpL/qGqa85l9n0OlKjbMq4fPXzdT3voK152BWDL0ehbfKFFHKe9AK+5MUyLvi8/awERlbZFj5DV1i1WXp1GQHcD01s6V0PIFSFM3im0DxHKoel4e0HQzSNtNJQ4GgIiDrpP1HBF1zJ4Xg2+i8SVCi5ohT3g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1581.namprd03.prod.outlook.com (2a01:111:e400:5232::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 08:29:00 +0000
Date:   Wed, 29 Aug 2018 16:25:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] net: mvneta: some bug fix and trivial improvement
Message-ID: <20180829162456.2bd69796@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:404:a::33) To SN1PR0301MB1581.namprd03.prod.outlook.com
 (2a01:111:e400:5232::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e4b8d3-ea8e-4ff9-81ff-08d60d897a14
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1581;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1581;3:KoNPy0/4ixXcWoaomqX3DLM6NZQhwyTxqF6mOd4sLFMxAl2vsAnY2hW8is2+4LLC9pwtWS0d6BXCRei4B35Sq4VLRGLGbmRgOO33gIaTZQOsGd17wHRZotf55SA8X5BgyMfzp8T35Z2DP2EjwQyaTyMkC4usOfSyL9X9id7GUlttpIHmz/+cXM35fqaSymFAel/IPAzPekwEE5hM5xVP92Jfz+h9+BldmwBgZ1rHV8pHTfY0Erb9Tc3YsH4mrl+6;25:9umRwUCk7Vy/SAnpZ64bmde88APMOgjm5GuX85pGWc7eYpGOQ+S1ycCR6qMIK57/2VTtg1H08uSJE5mRUS/g9X/4tVouNRvr16h6KvIHLKxCBxQARmCm8rtrnafqUcx/jglcxcRfXPuEyPLhusF+cltvWSWh1YgL34YsyY11e740XsLJsgRgMEeTaPfse+vl7s7dEmUquT6NsfAiSEzBa6xg0QMw1kXNBJCDNw34RZpbYdhu9nXy2C+Vh4f6zCX30fKUxvxXdsS8yT7gkprEEJuYcRKmlWG+ThxX5BoVr9Y9KvXAvW96oeSZohSOCsz8x7pi2pewnID0+xFw+D81Ag==;31:1Vjcya9bZk6X7eqn5aKQenRvtDHDNDd+6ZB2GB215Y3PS1Xic3zWygRtB74aR5OKWSJz82JIm/opDOX255ysmmRrkmtKckQ5ISyyi117TQ+WbH0JW4wHSpWrDWXUev6dgcC6iym9J9U87emkhaOX841XW5ZzeNsruHEBdH+cnHXKljsOm+KIXD8tmZH3S4JNvcog9qqJILsANkwdNdk8kGADljwZuUG/MwtxcuHUao8=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1581:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1581;20:PnRC5Tu1d6aNBcmWGcvQNCuT+Z3sZcNbSCKqwCBoRJOA92AeLenblkEs9kM11f63B5Kl4/2of10QGwi8GM5aLabm78jfc0+c7zkUAuRqy3F08fFNS9uMph8JZRCpWM0OX+UDsMj7RaUcU11WkSyjVE6uO0rOBLRkIdBSoboBQ7bHmbpbSpr1ennqMvqAoGhIFZqf38tDCMA5YMW88sXsAOp1v/6VC6KcUjEngLXRdiTURuoUQ4CwSqxhK0IrdV1hg9q+j1QcEEn9MQlMIqmIbYgtlL6lUnRc3PUkzm+nKF2BB/jdyymLaR0GUzUbl5wLg1LlSLEbcmYqCJNyZG3QHfW2cFxWQ2Er+d/vfFtpZT1HqpqKPasFDxmhSdeCmsQQKjlJGTbFA38RMFfj7MQT5fHV0cw0YwwJ+eXlAFl0Udkgms1IjZTL97uB2Mz7v5MYiE/hBLE5lEcJqbOSHlI7M0Md55IBYbXfjc0rm6K6p+uFJaVGEzMlPOrpxcWJLhOz;4:z96/rQVGxw4aOuZcloonBbcaof/+3aX21TqdZiOvLcVG//GDpiTM3hemfYqRtMdFdiaHujBOpqs1Gn3z8DuEKXXc7tvDbdypgIeCvn5VsXut7pnQjmA3NE7vR+gcUfcLOQdByg9vOWaQUOXnnWMTiBZBnw8VV+1hvzGI8yxyc8Gav733Sbv1BefTfFGUyKGHFbjZhGtprsizFKX44KWAw3DqRd+U6RF6+bA9eZ3ZKCZQJhrp5LvfApNUHhGrGXI18zowmRPVtUpv7RvOSotUGQ==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1581D37020D49201871AD7B5ED090@SN1PR0301MB1581.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:SN1PR0301MB1581;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1581;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(136003)(346002)(376002)(189003)(199004)(47776003)(1076002)(97736004)(72206003)(50466002)(81166006)(486006)(66066001)(110136005)(7736002)(16526019)(81156014)(6666003)(8676002)(2906002)(186003)(68736007)(33896004)(9686003)(25786009)(478600001)(52116002)(54906003)(55016002)(7696005)(5660300001)(305945005)(956004)(86362001)(106356001)(316002)(230700001)(476003)(105586002)(386003)(8936002)(6506007)(26005)(53936002)(6116002)(50226002)(3846002)(23726003)(4326008)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1581;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1581;23:/ba5OIQEuRYUHmAgciddCi9Hat4wj7RQnoyRBu6?=
 =?us-ascii?Q?E155dFY4reRfct5D8+Iklji13Wj5kGQpqX1BxuLdMxeUsY1h68QtbvOga9vO?=
 =?us-ascii?Q?KWWtwvMaIb3vjBG0tMmYyjEabHTz+GMgkfuLh5tf0J/LGooqjTlI1GWTOisl?=
 =?us-ascii?Q?tMOJFs6DyaHA/9jTtQfxIMg66ay8fuK5O3XLkNK/Hvi/QBl+/qB3XyM+xpTq?=
 =?us-ascii?Q?OjDy390haMb1zpD+6rLRv8D+VkSngTk1pp6iql7mDssHr2v2r1InQLBM6VtD?=
 =?us-ascii?Q?JMN3nDQwUzaIHljmuF0ZI0pReJ8sUcW+3syqhUGNVjYuzzSwm435h/o4bo/Y?=
 =?us-ascii?Q?CK+cpMWcgRGwLljJ0zFSSq50bEFLCims9/TbKA+l13JU2NXjx3i1YdCyQlyK?=
 =?us-ascii?Q?s64Ozy5imJVLI+YgTdBTif5MDexh5Y47DNiomNKO8/lMH3vk6Qp9lijYm0fB?=
 =?us-ascii?Q?xFh7ZJdFnUL1EDsi03idgLDdC1gK/HzW7mxd1YBbFjs6ADs9Y1U8Uj1M7eI1?=
 =?us-ascii?Q?NSt5O7LORSuZqEubRERRwQ/Oi4nqR2XWtV7EaBVGhO6E6buaa39A5glHnmk6?=
 =?us-ascii?Q?SphvXI9w+Fmo5GGG/G6VY5Cd0lfMqM6xndBXCR+RNs4H8p0FvX6dvsdaMeCH?=
 =?us-ascii?Q?FlSK4AHaMFqTtBgkUruuXfLwWl27DzwW9JHyxHroMxSCSqYd6KWaNAbYSRB8?=
 =?us-ascii?Q?w4/DK7dSZjOXRU3MmAOHNLPB4VgXz5ZsFldzGteMA9Tsw9/fcHAScPVGB7W5?=
 =?us-ascii?Q?UrR1lK5Cy7ElyvHUwFq4//b1UArIVWsgNQfOtc/c+WYbcRSAlNLx9tZNYRJ0?=
 =?us-ascii?Q?Fmrzn34jSIraij5pw0+tFQMP85TJ54Qh8I5PVGJnmg8ntLxL3M4Obe77pA44?=
 =?us-ascii?Q?h4Bq6V3KRAoKveUC0cgTiyEN7uDLn8EC6WOWs0EFKCvnjg2MbCHij7eifHBi?=
 =?us-ascii?Q?dIM6aQ9EQQuhUX3phvViiuprfKtd0WBvIFupbH2xx1bMpqfB65BO0qctsWuj?=
 =?us-ascii?Q?PLAAxZF/KPk65oTP/OCeFAsyREO97izMnOHTH4YbuuEXlkNZOhJfkqhd7IGJ?=
 =?us-ascii?Q?06YC/MPFoM91Ep/yxB9xFYveXZYOE28BTxuiKhoEvH69LXVYvF6FLfWyiQsD?=
 =?us-ascii?Q?T4a2KDUyXKkEEuntcmy6ZC2EOmKjunLR6ZM2ACSu6ZjztdO1UXH/kKaioZob?=
 =?us-ascii?Q?CbLUD6RHFt896rK0=3D?=
X-Microsoft-Antispam-Message-Info: Uz4hxMBhzATGmI7QNtCcbydcOmCgDfZxnFXcjby35+LYdjA3tudFDHrccCQAXuPcLJAIzLNWn/HApae/twgyTGJ/L2eSrbcKPwQp3wI7gvX4mTomeR3izQgar2pAUa2iDxE/GvhVyxZqDoKhPlXhXuL7AmQXBbhroa/XHF4wocvCKoOGvhD0yiu3wJySNemGfPCOUJvIwuL+CwaaNeTakKVwfdQoL2hSmE7jbQS683dav3TlV2qNZQIlPAQUK0zRkQFc+fvlNqwPVfmsDGDFO9DsN9Ssv4nkLs5i1uiGwtIF12wZI6/9Wz5FDgRWqiqL5XmzTz80tuOJQkQekjiPt7pnkoocIZcKWZpo08oaa5U=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1581;6:dAdUrBGB/lklEfgjlO56f9Yec/TYoMGClHjsJ/s3KrrwhlLOyS4oJv4qd/FvCRBukClmreLBmPGslYb3/iceGgAl/WQB8bp0tsRPb12wSi/STqIk00NTvpyM+XLA/4I/CZzX9ACA9wrNDBZEHWtAnP3HutvAa1JCHEGUuOpc2ov8pWMirM3tAJR3ZiGPT+CTE21Kslxa5WD+y2zjU4RYuaiDDTO/VW97bX1y8f3lT14hwI/I7jS3yxP+dDOjKtjq6gBi7bEjN+jiXwIss9uXV/YZB/nBjcmw2cy9C9mIZap2XKZmp5RhdU4Um8XMm9lLRUiDSlwXrIGTp0QUBb1Li6f7nQfymBUVFQ3MldRuHNEo54n6WJ+2anjXbkfnfedLS9QGNkemsSvYden+ejULEsy19kRZy34E+WSUuMSNKIQBuN1alJLaCig99IoRJFiNbMTFrzfawb+4zsHVR3+L/Q==;5:n1olc+79M6RqJ7GgQ3dp1q2j5HVq/j8s3MnVaZRirkpeh4rPzNMqvulQnUoZnWLeOLGAmIx3ocIoPmYBNxO4ZNKpJ7bPOZK4SE2i7E98c8mb2pAyfcuFjp791yNgnfnnnT6zSdeVfAmcd/t0u7PNMD5VlXdrnj0Uqzm5/JD3+R8=;7:jSqTv8yGSNGKRXsL8D4PuNcXqeULQ5qySZHt7WsdhBDjved5wm21l1dypQU3DBlC4tzMgKO/DBxzPCHIed/dcvUxFPJpfMwdy6jrp2xxrUremRgexspOCIpi0wZvP1qVk62/XBMVBevpvj+OQ9ad0pM+GVhj45Y0i1/1JDM45dSIYXiH7Hky7ipaxvMr6Dwl4X1zL2TOEGUw7ptIkHxpZnYXGdmuOHSA3jpCblTwDFqFYnONRnmC5iBSSdgT+/Ez
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:29:00.3367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e4b8d3-ea8e-4ff9-81ff-08d60d897a14
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch1 fixes rx_offset_correction set and usage. Because the
rx_offset_correction is RX packet offset correction for platforms,
it's not related with SW BM, instead, it's only related with the
platform's NET_SKB_PAD.

patch2 fixes the wrong function to unmap rx buf

patch3 removes the NETIF_F_GRO check ourself, because the net subsystem
will handle it for us.

patch4 enables NETIF_F_RXCSUM by default, since the driver and HW
supports the feature.

patch5 is a trivial optimization, to reduce smp_processor_id() calling
in mvneta_tx_done_gbe.

Jisheng Zhang (5):
  net: mvneta: fix rx_offset_correction set and usage
  net: mvneta: fix the wrong function to unmap rx buf
  net: mvneta: Don't check NETIF_F_GRO ourself
  net: mvneta: enable NETIF_F_RXCSUM by default
  net: mvneta: reduce smp_processor_id() calling in mvneta_tx_done_gbe

 drivers/net/ethernet/marvell/mvneta.c | 49 ++++++++++++---------------
 1 file changed, 22 insertions(+), 27 deletions(-)

-- 
2.18.0

