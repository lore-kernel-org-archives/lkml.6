Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeDCPpa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:45:30 -0400
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:58352
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752478AbeDCPp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:45:26 -0400
Date: Tue, 3 Apr 2018 17:45:19 +0200
From: Ioan Nicu <ioan.nicu.ext@nokia.com>
To: Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alexandre.bounine@idt.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Frank Kunz <frank.kunz@nokia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: use a reference count for struct mport_dma_req
Message-ID: <20180403154519.GB25203@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [131.228.2.30]
X-ClientProxiedBy: VI1PR08CA0222.eurprd08.prod.outlook.com
 (2603:10a6:802:15::31) To AM4PR07MB3282.eurprd07.prod.outlook.com
 (2603:10a6:205:9::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff103a8-a7a3-41fa-a961-08d59979e9d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:AM4PR07MB3282;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3282;3:+LNFO1IZ9tjvOr6B3elVHZWBFtddiaHJ3vUKV9t6wKk69JfG7je1dxzV6ecexFt1PmlOUv05ZK0zM8XsPIUgvxP5wM++Fug2o1Sy+66CUKyq4Mfrg3REVN3lsziCt6CTSsrtnhzkugTgeScNa5bBcfQjIXy9Cb/XUUhxP64bY3OEDjiUPC9Q6dyOoMPiV8jbs02M7MYH5MsPqv5ATwQzjnVsz2hpQZwdmCnkwWjAzE02s+RX6IHmt/TMNLHmlRqd;25:FZKkqB4W6WLPWGEZIM5RTTWtTOahsaQ6DJR3qHNYmS36qbI9J3oJMN9E3fdN8kqHRy+vJIRJjL/y5IWTLbrZBqFwnafM/7Nj2bFNrgbgUqQcQpVSY1aMuj65cG1Wa3KwOMZMMVhHKK5mHiwyYPDSMV4mIWlKYhPbXSWKavHs/pjiU+TePW31ntV1CE+wlwTJgd7dUzIxjkFN7AF2btQcIJO67vf97enY5MBDJbrKqtbN0NoZgrgM9w5ZR1VyXleXV03gs/kgTSjoNOA7a/dF9yC9zIPMwQcN87rSp7WDbWC0Gapo5l4zpdGFuifWJNL+a4f+hDBN5v6XJ2/nA7huxA==;31:br7ABBwgnI/Avtgrl6biu6jz5Yk5RbS3cnhEKI2LuP5iZUqZQJkUdUqA5iJ1aOLypu+e7XVUrJhbkcgOivBwjP3YnE8FInqAI41NJEhJaaNPasIK3zydnBun6XRmMZQXfS8/joUjrjAe7/OFoc0+vh9qYSdpjhPRWlfi+ciSrt7fxaWKxHrpycxO9RSq/+42o2Fr4+1qdNUkRjZrPsLE63wuC7EAABgqEgrovF/3RpA=
X-MS-TrafficTypeDiagnostic: AM4PR07MB3282:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioan.nicu.ext@nokia.com;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3282;20:TC9UzOrQEWrQfyFPdwbswTL0hTrhUi0TLFFOUwX2zsQaXMHpa96yT94p8IfxyZtMOGT5OcKMn17YlSp5UdPx1HcOLqnSBweLxREy7unEIiVIk8bDGCMW5HfotaIxU/r5byW0rUWIJX0fXjY7EFutjGXhq6zYUSepJjrDsoLTtYUhRS+e3+ISr6Mvx/PC6FQZgLCqG6WsHXCr/NfGTeuoi+3NzL0bBY+tcnEFFAhI3yzDGfznDdwhOf/U89HvrAtA73rEGtE9xwg1EUy5WJg5jCoRncLytiOVgVVTpkVm02ZM7/GVHp51fMAoqjODbyxErZhf+c8Q0xc12BeaxBDDjRttnRAH+iyiCz0DsXE651mO5xWjl8TVptfWs8fEQoiFEmoTjh9G8EGgET5HPRx/6voVfsi2fEWzZTwPmB+XwxcjsZfoCUcPyvWT81RT6uCQzpoQiDAc3tTMr+5xSYWbiZgTC8XoS4VWb2ACoexwBF70TiUEnm4kS2cY5HfGvx7AJbbEr3LuasNUjJ1hClURNmjmeAQI8oSWaMIm5TWKG6CArrtg3wsRT7qPz7PxLAX1fBVFTddLl62UL0qDivos30IwgHIJAkY/pGf7nKKIDWo=;4:yAQv67Q2JsxyCtxtcwGW68sUxR6f5bNH2j6i4YRQJx1HT9PDteG7x51eKMZN+U1wiG1CfkzE+4OZIWKY37i3ERdxK3EzzbxCH7dU2O4LKmLRCQfbioHLyV74ScIkwfI6valKM/jmaPtwmfGmrm2Cl7ePMf/ELJ81RtLH6ojOgdhXOMU2UyhKpdrIITAVibrVXsAB4fxr3L1VyiuZvaRUgUxK8MOV+Gc4g5AQyYYbZM1dbK+G/YT9RS+eLpX1Oxag8F0/hdqfR0LlHuH+nhL3IkDCxcIdYPZOBYcVEq5kZZkyhzqGth/UwPsNWT0ArK6r
X-Microsoft-Antispam-PRVS: <AM4PR07MB32821DAEBC25AC9182D8F274A6A50@AM4PR07MB3282.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(11241501184)(806099)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR07MB3282;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB3282;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(39380400002)(57704003)(199004)(189003)(1076002)(69596002)(81156014)(81166006)(956004)(2616005)(23726003)(97736004)(105586002)(21086003)(6666003)(16526019)(50466002)(6116002)(36756003)(25786009)(486005)(86362001)(5660300001)(486005)(186003)(7736002)(8676002)(3846002)(305945005)(8936002)(476003)(55016002)(53936002)(106356001)(68736007)(478600001)(26005)(7696005)(52116002)(59450400001)(386003)(33656002)(47776003)(1857600001)(58126008)(2906002)(16586007)(110136005)(316002)(66066001)(18370500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB3282;H:nokia.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR07MB3282;23:xyaHVJZx0CxjA/f0U2I0IXPi+4o0wwJLbr5KjPH9N?=
 =?us-ascii?Q?IH9x0o6MYCSxpTdHvK5gmmMUfjngYs5gFG4CBU5nbINVGPnbSuM0Z55z5K9B?=
 =?us-ascii?Q?Wll8TWFGozgqlVtg34MSwfbZE1QqF8Au8jjpsRjiQ2ogFYRCGDl9Gq6I0AgM?=
 =?us-ascii?Q?MUiW9PMQ8q5oXMTbtv19P2FAzgyexW10PMol2IInjwp8o94jZnIs/4W+2Y+m?=
 =?us-ascii?Q?VvR91AAPkBr35OqSJRCJo9WHuBXrH4PqbTNVstRYo9Ex6oENDuvTg/xdTwSX?=
 =?us-ascii?Q?wOUlzBEzOWFphDi4z+/sTYwuAJIzE7loMI8uhhuK5c0lyR9uI5aeqjtoPrx+?=
 =?us-ascii?Q?Hfr0bBGTtot9oI8/6MWlrkUk7s5sRuLAz3rWz3ak1jQleWumOLoNRXhZYdDL?=
 =?us-ascii?Q?LZ6qWQ1dI30a7+7KJoLUhK8Hai/KU63Z7CFTV3SnZ7X0kxADytoG86nfxhre?=
 =?us-ascii?Q?fjPG7cvdvcbTzSEgt14HSVz4+wRVlpT+cTYNooW7W10/xw8dQwsHeoY2jYGu?=
 =?us-ascii?Q?+QgRHlGxNhsBzXVMNlyMmGLNg14iy/56oP5MIpZGOnvclGdLfCj/DfPGPEQb?=
 =?us-ascii?Q?YfLwVaFy8ob4zxEQes2YeD+NUUOdN0MRwr5KYsQ0C6LjrooziW0Ni5LsAEG5?=
 =?us-ascii?Q?JWbgMc2aagu0dJEEZDxES/Q9/R4phjfuKEzYTraNtZ8FYoe1JMD6S44tMUC/?=
 =?us-ascii?Q?+dEfGyPYyKeN7aebpjuF3LPR0ZtlSWY7uxp0cKJuwtiPWBG3UROZ0AgF+Gqf?=
 =?us-ascii?Q?V95q1Tzxn9UyHGE39y7NbTPaj03KNq1LdQJ5DxeR8+pS0m1ffM9liSqwzFiK?=
 =?us-ascii?Q?d5XQO+43O19OM4TMow2MqKZPq9JP1pnRr4ly/QMoVr27F3VqcaHl/rXvjDf6?=
 =?us-ascii?Q?PQah6k1qbS7arS5620MSaRVjUmQS/qgSBPWyA7pc5cjNl+7ImW4+ABbEpFS2?=
 =?us-ascii?Q?iTj2S38MS8is5jwUQ8r57tGxtLHCFaXXiTfz51dxOz3G2Kb5eTRsgUVdSCqb?=
 =?us-ascii?Q?UQwDeLuopilgxy59Gt44Y12D0/3Xu6oHAC8EiS3tu6AiW2lfir0WJDbTVk2L?=
 =?us-ascii?Q?+WdqeZRug97+mw7M9joSYjN4FRlYFzWOiOlT0d7g6wqlauwnS0CCwnMr+Jn1?=
 =?us-ascii?Q?BsDJ80k+HGHhTJ4EQxS1EKGio1XcXsTG/oVIX4P55TKvcrjevahPfOQA+nQ6?=
 =?us-ascii?Q?POrif3xzGL/8MI+XjgZuo5oclxZ7ODU04hHT2rX21EIFKyoJL/jd0B8jdO+O?=
 =?us-ascii?Q?sOLnav8nb3wtWx+wYVcQiBv9PsboekMG2J8CZtUTuZ8Meo0gw7VBV4OjM7s9?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: rwlLsvV5Et5XKqREEa/SI4UBwjefjbQaGmg7mJuERcz0YsDw7cs06/cdLoATYAhyca5KaK1sNCRjssPMfIIltXKTmOhexFQ5Ln3P7IeRGgTm0z1V26hRVXRgc/yG8PrfojFbhV+rsE1aPsH7CR3KzdgbLEfvsCIwsDc+umdsKLs6aMKvsFs7Dx+fY/W0jnwH8DgjYq81QvQhqV3bJwI3dAIEqz8dp1nI6mJPcOLB3Yk=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3282;6:EoxV9RY3qEfpMhFi4WGOY+FEZL5iM8z1k3jAhAfapFRnzxNBk+u7Itw5XXG/BG6H1MGBawqIiZkoqOyl2wrGqEaxyGaQm331nxXyRWlTeThXCvfS4K1UBJBQMOmiO3QGU4GNHzFsjQwVnKJOYR0EQp+maYHTamBlVGX+SxbjALlLDhK4suFhxGd1XDKiBAALVTSKr3WCjldUhmXo2V0WvcQtLf8R25aqrFQbQ3VOQ2BDpXR1zLHZN7l2xlZpfyWnHxOVy6ObY/9omoJJ+7Zi3a6ivJ48vOc7U9/EliAUVgGNXs0hFeu266xNs7jAzyNYhTxqLg7qZl1HtnWKQ+4muxbadAc45NO0EfTbSQ3CpDWsZNLv2kgz7SDCdN3ABP5zJC2iadr5UpDWee9e1Z96dCaL9Kn3qLihO4WEPO4zpbQ771oyr3Ds5XJfeBpX2nC9vE58e5TrOMfanJPk0osUog==;5:Y5+RtocLHKDAF+vK/ldcAET8zE/Mai7x96SV1LRkO/hYyVsG0cDcMKmIsm3yf8V2fznYk0d7cV87uFmGw4NEo4oTEizyT16xfOCsWC9bHtFp+KnOf3mvYFMvCkTgAavLyQ+bciO/nFqSVQZsX5F2joBXPfaEqyRC1zjWmTa3nhY=;24:fhNZyNvcm3EY3RQGXEb08ftekYqW9DoEhTgLetMti9/1X6K/Mn+zg6Fs2foXlXq55vD3QkZRoVvwQIvqfPtMG3Psl5TfyXdKeqOszrxj01w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3282;7:wF82O5HwCDq3Ocfw97cSX7HE6RfB8VMSUQ+3shDTG2OkecUIfyUZGbX3pOKj7IT0p4kBnTKOznLdupVx0n+FaRmfMSDLaTiFTtHRZqkcwhXpS8jTcuX+0MRpoKhn9JUU1nXcgwm1wzvIXaRk1N76nxNoA9ANGdGdKOPcZd0GVlTDXsoCJAu6yVjqW9eiiuDH7656CyvADNcv6+tlPZ3k4Kpl8Qr4ya4yRurSqOOTqf7ueBfTqEEJi7PZFar6bHuR
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 15:45:22.2529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff103a8-a7a3-41fa-a961-08d59979e9d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3282
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the dma request is passed to the DMA engine, the DMA
subsystem would hold a pointer to this structure and could
call the completion callback after do_dma_request() has
timed out.

The current code deals with this by putting timed out SYNC
requests to a pending list and freeing them later, when the
mport cdev device is released. But this still does not
guarantee that the DMA subsystem is really done with those
transfers, so in theory dma_xfer_callback/dma_req_free
could be called after mport_cdev_release_dma and could
potentially access already freed memory.

This patch simplifies the current handling by using a kref
in the mport dma request structure, so that it gets freed
only when nobody uses it anymore.

This also simplifies the code a bit, as FAF transfers are
now handled in the same way as SYNC and ASYNC transfers.
There is no need anymore for the pending list and for the
dma workqueue which was used in case of FAF transfers, so
we remove them both.

Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 122 +++++--------------------------
 1 file changed, 18 insertions(+), 104 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index cfb54e01d758..9d27016c899e 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -212,7 +212,6 @@ struct mport_cdev_priv {
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 	struct dma_chan		*dmach;
 	struct list_head	async_list;
-	struct list_head	pend_list;
 	spinlock_t              req_lock;
 	struct mutex		dma_lock;
 	struct kref		dma_ref;
@@ -258,8 +257,6 @@ static DECLARE_WAIT_QUEUE_HEAD(mport_cdev_wait);
 static struct class *dev_class;
 static dev_t dev_number;
 
-static struct workqueue_struct *dma_wq;
-
 static void mport_release_mapping(struct kref *ref);
 
 static int rio_mport_maint_rd(struct mport_cdev_priv *priv, void __user *arg,
@@ -539,6 +536,7 @@ static int maint_comptag_set(struct mport_cdev_priv *priv, void __user *arg)
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 
 struct mport_dma_req {
+	struct kref refcount;
 	struct list_head node;
 	struct file *filp;
 	struct mport_cdev_priv *priv;
@@ -554,11 +552,6 @@ struct mport_dma_req {
 	struct completion req_comp;
 };
 
-struct mport_faf_work {
-	struct work_struct work;
-	struct mport_dma_req *req;
-};
-
 static void mport_release_def_dma(struct kref *dma_ref)
 {
 	struct mport_dev *md =
@@ -578,8 +571,10 @@ static void mport_release_dma(struct kref *dma_ref)
 	complete(&priv->comp);
 }
 
-static void dma_req_free(struct mport_dma_req *req)
+static void dma_req_free(struct kref *ref)
 {
+	struct mport_dma_req *req = container_of(ref, struct mport_dma_req,
+			refcount);
 	struct mport_cdev_priv *priv = req->priv;
 	unsigned int i;
 
@@ -611,30 +606,7 @@ static void dma_xfer_callback(void *param)
 	req->status = dma_async_is_tx_complete(priv->dmach, req->cookie,
 					       NULL, NULL);
 	complete(&req->req_comp);
-}
-
-static void dma_faf_cleanup(struct work_struct *_work)
-{
-	struct mport_faf_work *work = container_of(_work,
-						struct mport_faf_work, work);
-	struct mport_dma_req *req = work->req;
-
-	dma_req_free(req);
-	kfree(work);
-}
-
-static void dma_faf_callback(void *param)
-{
-	struct mport_dma_req *req = (struct mport_dma_req *)param;
-	struct mport_faf_work *work;
-
-	work = kmalloc(sizeof(*work), GFP_ATOMIC);
-	if (!work)
-		return;
-
-	INIT_WORK(&work->work, dma_faf_cleanup);
-	work->req = req;
-	queue_work(dma_wq, &work->work);
+	kref_put(&req->refcount, dma_req_free);
 }
 
 /*
@@ -765,16 +737,14 @@ static int do_dma_request(struct mport_dma_req *req,
 		goto err_out;
 	}
 
-	if (sync == RIO_TRANSFER_FAF)
-		tx->callback = dma_faf_callback;
-	else
-		tx->callback = dma_xfer_callback;
+	tx->callback = dma_xfer_callback;
 	tx->callback_param = req;
 
 	req->dmach = chan;
 	req->sync = sync;
 	req->status = DMA_IN_PROGRESS;
 	init_completion(&req->req_comp);
+	kref_get(&req->refcount);
 
 	cookie = dmaengine_submit(tx);
 	req->cookie = cookie;
@@ -785,6 +755,7 @@ static int do_dma_request(struct mport_dma_req *req,
 	if (dma_submit_error(cookie)) {
 		rmcd_error("submit err=%d (addr:0x%llx len:0x%llx)",
 			   cookie, xfer->rio_addr, xfer->length);
+		kref_put(&req->refcount, dma_req_free);
 		ret = -EIO;
 		goto err_out;
 	}
@@ -860,6 +831,8 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 	if (!req)
 		return -ENOMEM;
 
+	kref_init(&req->refcount);
+
 	ret = get_dma_channel(priv);
 	if (ret) {
 		kfree(req);
@@ -968,42 +941,20 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 	ret = do_dma_request(req, xfer, sync, nents);
 
 	if (ret >= 0) {
-		if (sync == RIO_TRANSFER_SYNC)
-			goto sync_out;
-		return ret; /* return ASYNC cookie */
-	}
-
-	if (ret == -ETIMEDOUT || ret == -EINTR) {
-		/*
-		 * This can happen only in case of SYNC transfer.
-		 * Do not free unfinished request structure immediately.
-		 * Place it into pending list and deal with it later
-		 */
-		spin_lock(&priv->req_lock);
-		list_add_tail(&req->node, &priv->pend_list);
-		spin_unlock(&priv->req_lock);
-		return ret;
+		if (sync == RIO_TRANSFER_ASYNC)
+			return ret; /* return ASYNC cookie */
+	} else {
+		rmcd_debug(DMA, "do_dma_request failed with err=%d", ret);
 	}
 
-
-	rmcd_debug(DMA, "do_dma_request failed with err=%d", ret);
-sync_out:
-	dma_unmap_sg(chan->device->dev, req->sgt.sgl, req->sgt.nents, dir);
-	sg_free_table(&req->sgt);
 err_pg:
-	if (page_list) {
+	if (!req->page_list) {
 		for (i = 0; i < nr_pages; i++)
 			put_page(page_list[i]);
 		kfree(page_list);
 	}
 err_req:
-	if (req->map) {
-		mutex_lock(&md->buf_mutex);
-		kref_put(&req->map->ref, mport_release_mapping);
-		mutex_unlock(&md->buf_mutex);
-	}
-	put_dma_channel(priv);
-	kfree(req);
+	kref_put(&req->refcount, dma_req_free);
 	return ret;
 }
 
@@ -1121,7 +1072,7 @@ static int rio_mport_wait_for_async_dma(struct file *filp, void __user *arg)
 		ret = 0;
 
 	if (req->status != DMA_IN_PROGRESS && req->status != DMA_PAUSED)
-		dma_req_free(req);
+		kref_put(&req->refcount, dma_req_free);
 
 	return ret;
 
@@ -1966,7 +1917,6 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
 
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 	INIT_LIST_HEAD(&priv->async_list);
-	INIT_LIST_HEAD(&priv->pend_list);
 	spin_lock_init(&priv->req_lock);
 	mutex_init(&priv->dma_lock);
 #endif
@@ -2006,8 +1956,6 @@ static void mport_cdev_release_dma(struct file *filp)
 
 	md = priv->md;
 
-	flush_workqueue(dma_wq);
-
 	spin_lock(&priv->req_lock);
 	if (!list_empty(&priv->async_list)) {
 		rmcd_debug(EXIT, "async list not empty filp=%p %s(%d)",
@@ -2023,20 +1971,7 @@ static void mport_cdev_release_dma(struct file *filp)
 				   req->filp, req->cookie,
 				   completion_done(&req->req_comp)?"yes":"no");
 			list_del(&req->node);
-			dma_req_free(req);
-		}
-	}
-
-	if (!list_empty(&priv->pend_list)) {
-		rmcd_debug(EXIT, "Free pending DMA requests for filp=%p %s(%d)",
-			   filp, current->comm, task_pid_nr(current));
-		list_for_each_entry_safe(req,
-					 req_next, &priv->pend_list, node) {
-			rmcd_debug(EXIT, "free req->filp=%p cookie=%d compl=%s",
-				   req->filp, req->cookie,
-				   completion_done(&req->req_comp)?"yes":"no");
-			list_del(&req->node);
-			dma_req_free(req);
+			kref_put(&req->refcount, dma_req_free);
 		}
 	}
 
@@ -2048,15 +1983,6 @@ static void mport_cdev_release_dma(struct file *filp)
 			current->comm, task_pid_nr(current), wret);
 	}
 
-	spin_lock(&priv->req_lock);
-
-	if (!list_empty(&priv->pend_list)) {
-		rmcd_debug(EXIT, "ATTN: pending DMA requests, filp=%p %s(%d)",
-			   filp, current->comm, task_pid_nr(current));
-	}
-
-	spin_unlock(&priv->req_lock);
-
 	if (priv->dmach != priv->md->dma_chan) {
 		rmcd_debug(EXIT, "Release DMA channel for filp=%p %s(%d)",
 			   filp, current->comm, task_pid_nr(current));
@@ -2573,8 +2499,6 @@ static void mport_cdev_remove(struct mport_dev *md)
 	cdev_device_del(&md->cdev, &md->dev);
 	mport_cdev_kill_fasync(md);
 
-	flush_workqueue(dma_wq);
-
 	/* TODO: do we need to give clients some time to close file
 	 * descriptors? Simple wait for XX, or kref?
 	 */
@@ -2691,17 +2615,8 @@ static int __init mport_init(void)
 		goto err_cli;
 	}
 
-	dma_wq = create_singlethread_workqueue("dma_wq");
-	if (!dma_wq) {
-		rmcd_error("failed to create DMA work queue");
-		ret = -ENOMEM;
-		goto err_wq;
-	}
-
 	return 0;
 
-err_wq:
-	class_interface_unregister(&rio_mport_interface);
 err_cli:
 	unregister_chrdev_region(dev_number, RIO_MAX_MPORTS);
 err_chr:
@@ -2717,7 +2632,6 @@ static void __exit mport_exit(void)
 	class_interface_unregister(&rio_mport_interface);
 	class_destroy(dev_class);
 	unregister_chrdev_region(dev_number, RIO_MAX_MPORTS);
-	destroy_workqueue(dma_wq);
 }
 
 module_init(mport_init);
-- 
2.16.3
