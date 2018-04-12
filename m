Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeDLPGK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:06:10 -0400
Received: from mail-ve1eur01on0120.outbound.protection.outlook.com ([104.47.1.120]:62967
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752793AbeDLPGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:06:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioan.nicu.ext@nokia.com;
Date: Thu, 12 Apr 2018 17:06:05 +0200
From: Ioan Nicu <ioan.nicu.ext@nokia.com>
To: Alexandre Bounine <alex.bou9@gmail.com>,
        Barry Wood <barry.wood@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Frank Kunz <frank.kunz@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: fix rio_dma_transfer error handling
Message-ID: <20180412150605.GA31409@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [131.228.32.164]
X-ClientProxiedBy: AM5P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::29) To DB6PR07MB3288.eurprd07.prod.outlook.com
 (2603:10a6:6:22::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:DB6PR07MB3288;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3288;3:OogW6EdaHZN+i9aef7Occ9IQug4d0B8v9rmypqEr6x0BGrizxw6uvtbB/gvyat2ZC0k5iBcxAyLDf+ONE06LUFUXD0pgpK3SV9z8eZOn93OJyzZEs3PMyqdOn+SkAwO+o6AniBG8FwLXVFCyT2V/mwarpSA8kCohn72M9Qp3u586iCKvns6apEfJEP2t8OIWPD6NydMMN6AtTpi4gcJ01KDCc95H16Rs1NLoSdPd8NADzMSgQlwjtiiIbQm6AC6e;25:tKK8USJoWncqZ4pFLKWwWFbYTHqpwk9ScB6YIpQ81wc9pQsZRNu9l9+V+iIxedzl11pgBBbxmafaWFeGsgCOyhF0qVis4KEWoZJurEpkWcdLahB3X1v3upO//JLH8QH2YB37+9Gu3ZYSWbYOgY2msazBP+jgiRzmvEZYFc2D+r6qV/dlzz5rIRhLQnXzhUGCFbf8Cb/jXNKyd/QaYY7yBvDXOPKEr2EDmvZ9gKQ50G/0f6HUmY6huC13Pw/moqdRBxMSbiS3rG2Qt4BtTB/rIhILmyyahwXNQU7ItUV5AwADeQ5t73wMjPzrdcMI+SEYvNWbUbVDXStjjKIYatAEFQ==;31:mQQufj9OEPJWg6nqF8XgTG+FT8ISEBbqiu/FsogjzIyqbdIQjSnNS2Gx9MNotm5xKaBjkqouhgt8+A6hs5bFU3XaJnGFLoZgkqjz0ayfJEwmjCAsA1ayRCgaPtBJ36JfAiSOuAugAlqhYo+GbDP93bHOfpeEyKGbe5Ej7xVlZzyezC8HzuPbQ2klF2t2l+tJLD7RwBoMQYIo4OPqzuiOuuB5H7ZWz3d/V5KTMMMemTc=
X-MS-TrafficTypeDiagnostic: DB6PR07MB3288:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3288;20:7jRRM5E8ozXPEGamO+SIpGWWa0UYv01c9I6hsP5NgFOnK7apYK3K+b9+5GnHG/6mgfjD+yyvOt+Jc97e4bVZs2xXSNI3QTORvWyig0C8thMDxkiTdE8RJ3SUydXk2kRNt1NofKVAqZAuEEb6R7D+1gn/E25cpNulLQ7W52nZGz1+LDZ0JNLw0emm0jI6f+OM9G6qTnyoMUYhZdxXYiG16ZptPWof7fUWJzhwpCjAfy9N1qOFbBfavZtmRZLx60LAZgbK9KiCcW+iyh076GSJZ6WrxqwcJXs3Y84pExL7a5KHrd7Asrd5pKMXynM9aW0tdqyp4R0uhw2qt0sQvlDv7JelyytUxMR03HMMAnPBFL/AVTBD8th160aE9vSaduOeACE2svIks0E0L32lDBUyrFOo9cWBlz4BS9jbmEBl/+Yuu8ZXGRqirtN3dkJtpNioRU3WbGbyU8m9NeIOTG0MzDd+P62j+S/SeWB3AVJ4KjgXCkACIaXb9naVZTGmq3s0;4:ACvL82vwQeuWYMD4mHIWIeF+Dp2d+IbkQ8CoIyStkjRoIw0YCaUV0+WOYsa0bX4PHV79BGDpZYG6QsPlXIv7d4EH1w1PNbDp1q2xuPkdcz/6iPKFNewxzguXnXU9b8fsnUBRMRoNl9GF+0OKy0idNHX3qfQQVjVu0njNfsrKL7r8sDa45LcWcezQ8sBYp6OeLxApHUc44jAR2rv7BWMBfOsmp14/PbHpo4BiF/YW9gHPTWGSSPK3nyjZYL4L74PVTNT6MCpuG/YjkPTLkgpTeRy85JpOMy/aJc1ODoqYdbQlsf0I8apUIgLIcK/DczPW9h8Liz43Z4TMXSoj7HEzhQYe7HJHEAl1BEkkaSW81Bo=
X-Microsoft-Antispam-PRVS: <DB6PR07MB3288A40AF8BDF1FA717F44A7A6BC0@DB6PR07MB3288.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(11241501184)(806099)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR07MB3288;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3288;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39860400002)(396003)(366004)(189003)(199004)(97736004)(81166006)(25786009)(8936002)(68736007)(7736002)(7416002)(5660300001)(8676002)(69596002)(55016002)(305945005)(86362001)(81156014)(39060400002)(53936002)(58126008)(66066001)(2906002)(47776003)(3846002)(1076002)(23726003)(6116002)(16586007)(21086003)(316002)(110136005)(52116002)(7696005)(16526019)(186003)(26005)(50466002)(36756003)(59450400001)(33656002)(106356001)(476003)(105586002)(478600001)(956004)(486006)(2616005)(386003)(1857600001)(18370500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3288;H:nokia.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR07MB3288;23:+l/rQQAXh6GU92vvJix5rUYOKVnxSQIqrTXBVD7P2?=
 =?us-ascii?Q?I8LQ5ZHo7D2yKcSn20PJFJQkKlK4B4Sgbl4DSM+yBMSOn6e9a1h1eHiHw0i9?=
 =?us-ascii?Q?Bs0ceLZscT1AP5X1t+yl/JUDHNdiv8+dgQup5oRwwn0kqi4XWoryFwl/LXUQ?=
 =?us-ascii?Q?1DTyaNFgmyudp6eE3y8SZqJ/CHZ5DvOymO/9+fmg1VW45udeeICsaQDEWedA?=
 =?us-ascii?Q?u+bAFu4MD69VTUYABVCl4wr3kts+iAPH0IXlbeIZSiDCMrF5+478NJQmzXPT?=
 =?us-ascii?Q?/IWj4bdGmSpUM7zKlbUUppF/BhA36b3wukWv3MRVCCMU5TSB1OqfebZwqRMb?=
 =?us-ascii?Q?VYY3zgniH4cYwGTrljqFJP4hD8b/Z4zZaoZMNteFttMWS/QbV/EettZPE9Aa?=
 =?us-ascii?Q?YZT9zSQbnea54WMAE5sLL0v0CPDN1jEwqFBIQ7DwSfzvixFhwDoq0aIlNuNe?=
 =?us-ascii?Q?NzOJ1y97Od16MtvcJXgS156v4FETwC0dRo9Y7oB51qxFB5M3/4ddDnMrKoyl?=
 =?us-ascii?Q?MmcZM603XWBkg78jnIHZNSLFdkA1oeIWlqhcRN72vKyttjuI4dtajEIk/AfI?=
 =?us-ascii?Q?Sjibj0ET7VfpAbdtHo8qIZfwvUi1m9JsUuVHMW864jK2lH9BysvbembxqprK?=
 =?us-ascii?Q?JJWEe2exEKd/f3tJ0K2bA4ZMkOLtZi64FM3kvWEeJnWQtWw6fQvobUyxT1Dz?=
 =?us-ascii?Q?nsn2chskCIOZYCk9NP4K0P1nCbTKjGdSIXL0QdNL7KpjlDduQMOS7I9DG2sM?=
 =?us-ascii?Q?w6DeIaYbwF/xS2VnAaZGXq/ruT9g6fXAZxs/LzrHZ6woqtJTRJrmqTsreqGI?=
 =?us-ascii?Q?8ympyyJPl8/sR+nBCHMUn9pfYt8LsQSwILztc1pxBxd3uLglgVrWG51i03tM?=
 =?us-ascii?Q?CcvrhtrRhNq5oTMbU3BzfafuHVkVd2RZfixrkUyT1KgBjm6sMVIJogn2iqhF?=
 =?us-ascii?Q?Ti9l2hzbwlogiKHV766PeR2jkeiXk2KsOdNjr6hBJ8G2L4C1Fy7rocS/JTI2?=
 =?us-ascii?Q?qOxpo8FcpDSWYOb4U580a55PajSAL/zuNxap45D2NrRFlNBiorrqXElZdtqF?=
 =?us-ascii?Q?LLagHXPbssFIDfPexeV+8gFHDCYB0PlftAYtC1Oq5AWVxIioAb9xgXuBfFBk?=
 =?us-ascii?Q?TmMPxzG8zef5Ryv3vohk/r5A5zf+5DNEVjhMiW5wJvBcsZNoTXnoONbDcYEE?=
 =?us-ascii?Q?d0mD9KeTmjKdQHCubGSO/wPcnqjypgm6NhPvWtihMeqpY8xaYnsmLaSTxmLf?=
 =?us-ascii?Q?byYwCYiwGceCjTMLHeK7HRoHE9kiQj4zXmTK6yNvQcTnmTM6HMSN2ZQptfKK?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3288;6:8G+3cuM0HBuKKYm71KG4Wz8hNIinDPx7HF3VDiMMgpU6Pkybrh6TldgUF7zZnk4u6ok+s381BUIkaiTRbBWcYseBQwNWn7rvrz/SMb5zziD42btpF31FeLFb3+3fKZpdlZpLOgKaNK9JLePfcXUFjbkMSljTmiwueen1tuXuRla7vFXLxchg5bCfKbQXXIKr1pODlj8auCvb1qundHRKXkoiQuRMQVjgj3Lo0+Rjv4LfjKfhueAOWtgMO+HIjaUPf+LdBnvVtw/oLr45uCCkk4tyvYTJvhao+hL1whKF3jQkSgx3WMEwuA8GyNok7AOZ+WF0Ib6VBta7zv2f3+lIACVQEyrF09/eopSUmhFl8ijb/tDVtiN5u9ETnmPdgXHMIyGDRu4xEMuWi6n4tOEwDsTLN4k/zvmGfXariZghJ2CUTLvj7lafZ0IiRWL+kNr37QpPnoh8w+8RJ3iRDBVVQg==;5:/hRaRl2MvLP5qn/T1qI3A3mFI7xJ6MdjQ5aUbObFnuI4hqchNGF7fMh2vvgypcRiwvlCVOWFX3wYpsv+ct9xuVQMDhU4STxDzYBJgalB5ZSzo0GJzfyDu796j8Y+YSrxeDxjL4I43eFaeEdDfJlKr9ONlngfknHtfAWiJGkdqVY=;24:NEB901zFJJw24Nf+km5I1BMQj2DUeXmlIYElCeYS4He4H2HLk8Gii2S6UijuFhi+y7FBIB8h0qCrfBRGLfexml8zvwYcWC4zrjFZNx6bElw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3288;7:BB9fFnwqTTzA11FWZR9/7z9M8CTXIGvyutkaDg7L+d12K7V62mZ6u6hgq26jaWY7Bvdxhb2l81DnMgauUEeagcGHDeopsQ65b4rSc/DZgFRuqRF1YGOy5RROZSe9nFLHMFe/KRN9k/sicEqTfNV9NcZgadRETVqFCERla6sPBqPIImHVmPYvsHzXyYRkU5vSp6eKk4BSb8DEDp7rrjZYjgGdcQbKzgsx1fZy880v9Uht2X1F9XwIUqA0pBsawJyR
X-MS-Office365-Filtering-Correlation-Id: 4db72de6-2340-407a-f673-08d5a086ea4f
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 15:06:05.0147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db72de6-2340-407a-f673-08d5a086ea4f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3288
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the mport_dma_req structure members were initialized late
inside the do_dma_request() function, just before submitting the
request to the dma engine. But we have some error branches before
that. In case of such an error, the code would return on the error
path and trigger the calling of dma_req_free() with a req structure
which is not completely initialized. This causes a NULL pointer
dereference in dma_req_free().

This patch fixes these error branches by making sure that all
necessary mport_dma_req structure members are initialized in
rio_dma_transfer() immediately after the request structure gets
allocated.

Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 9d27016c899e..0434ab7b6497 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -740,10 +740,7 @@ static int do_dma_request(struct mport_dma_req *req,
 	tx->callback = dma_xfer_callback;
 	tx->callback_param = req;
 
-	req->dmach = chan;
-	req->sync = sync;
 	req->status = DMA_IN_PROGRESS;
-	init_completion(&req->req_comp);
 	kref_get(&req->refcount);
 
 	cookie = dmaengine_submit(tx);
@@ -831,13 +828,20 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 	if (!req)
 		return -ENOMEM;
 
-	kref_init(&req->refcount);
-
 	ret = get_dma_channel(priv);
 	if (ret) {
 		kfree(req);
 		return ret;
 	}
+	chan = priv->dmach;
+
+	kref_init(&req->refcount);
+	init_completion(&req->req_comp);
+	req->dir = dir;
+	req->filp = filp;
+	req->priv = priv;
+	req->dmach = chan;
+	req->sync = sync;
 
 	/*
 	 * If parameter loc_addr != NULL, we are transferring data from/to
@@ -925,11 +929,6 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 				xfer->offset, xfer->length);
 	}
 
-	req->dir = dir;
-	req->filp = filp;
-	req->priv = priv;
-	chan = priv->dmach;
-
 	nents = dma_map_sg(chan->device->dev,
 			   req->sgt.sgl, req->sgt.nents, dir);
 	if (nents == 0) {
-- 
2.16.3
