Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeDEUdx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:33:53 -0400
Received: from mail-ve1eur01on0136.outbound.protection.outlook.com ([104.47.1.136]:30680
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751274AbeDEUdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:33:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioan.nicu.ext@nokia.com;
Date: Thu, 5 Apr 2018 22:33:43 +0200
From: Ioan Nicu <ioan.nicu.ext@nokia.com>
To: Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Barry Wood <barry.wood@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Frank Kunz <frank.kunz@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: use a reference count for struct mport_dma_req
Message-ID: <20180405203342.GA16191@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [131.228.32.171]
X-ClientProxiedBy: HE1PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::24) To VI1PR07MB3293.eurprd07.prod.outlook.com
 (2603:10a6:802:22::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85e5f63e-8799-4e26-6cfa-08d59b348792
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:VI1PR07MB3293;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3293;3:/Y9UXriq171UIofqrc/ZHi1V0aSFQZoRQDCOX9dVA1v5cTSsHNFt6fSV6NrE7DH77TVKr7NVTqwre950Az0YNNOg960VRBacrRrJ8i1ze0UG28PWVCn/4AUkhLKtyyCoMhEUd5CxAHR4MBrSaYSmDeL+GjpVqdSbfp1thXUOYuYlptmxMDBRT0a6m5biOX4oH8MtXY9XDXJUetun6SqzFcuEy8dF/Z2yct4gh3QcntImrRS6uAnGAhCn3Vw7NXy7;25:wmZ9rrdF+DJrlpDhaKdxSrcwN5rQvLmdI1cJAML1Ynvd2ZBmJmeLzYKX8WTisqODFAyKgn1lTqI3yRaxoQZMVUpjXAdRWbRvJMDWFgKtn5v1Py13tATiMBVYNP/kbUEUUXW4UMIILHpbdjICQ7OpN1QGUhlfPSm5t7DCMncxrRBS75P/d669w2YXhj/giJPijm3X3T/BcgA0/d6gZK2tOICCw8NpmH85Fzf9bFHLNVGhi/inCW7Y8AU3eAeQLLAbJEQB/dteBM6S+rRTU+flaK897BLebpHcGa2jH6c4PMJUKbtj/thUkgMxgx/Cqmdaic9EjQ2goHxRe6jkLo3NCw==;31:vyFwot2hwAA7B1uo1vK7pIKTbQzKoclh7PH5RzPmU5ShUzTuSSk32/dykPlTxgCV/PLeJMW5VRek+fc0/ZvKsOsrYmO/ZhB+OZYULa8nr9gfWY2ZPItfXZY95ES7hOzStLWukxOPbzMY1xYlB0Fu541WjjVMBfbwz3711ugyGuSoYzljccsuqpJ61CKaX8zCdGFHty9uA+SOQbbqYRENrowQPO/xp1CRC6agjsEsqfA=
X-MS-TrafficTypeDiagnostic: VI1PR07MB3293:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3293;20:E/lsK8fLUBAr8E7nHzybhLKsm/V9m+Fm/bfreIgLLv/d2jdieIhE0J+6bX0bXuvJio/Tzz2MdsBLd3ZgQRo22HsuLC4HYghK9aEz3kxs5s9/A38Zyr7YRjM/Eju8TgK0MZV86SzYtyQwEf3DamXnfFvusR/qCSfeufnyRmsVV/51vk8oEeNdmZJXVVPcWDnNnBOxO0C6FvnAKPU1l9UPOJ/956SDMz3+e4EovOZxUf77ev+FsmKUxzoXDOVnO/jGph/QSnKHifcTApekrEr6NMaXxnfovRrjEMkhGHU5ZqIPr01Qnig3HKO7dyU2uflkoLdR3I+iIn15G5U1gTS4qzzkkoeHjeHjis4zfmNpEZHNZlauCLnFB35WS34TpzCNkksJw4SFjUh9hGa2s6IOrS8MA5QKZ2WSh+K2KcTtaD+nBAQ4l6s1tkO/ZnrYKNJGS/wkbt0DU/kZUlF+a0fH/jgma/8EUErizZu7yU+mNIkpf4SRCqEHMVZaIV3lOtW2;4:4bp795b14dATQt63Nz8m+8rjMZy5xozZo5jopbEw3N7zmKR17llzbCwceGrtew1vAcw4fVN1A+vVHnlTUgwhqW29w6kFQym8FFITOiwPj5xwWRfmBnCthoDBM3/Fb6K9AMAQHkVXIOBgP9wNRwsyfq+TriMj40ir/J9YWus5GqLgHt86tIl3Oyibs8Xsm19Is/SL3yztVnUF+yFhxi08wHCzOZ3ChHMcix5Qp37wQlfFJ19tUJLMe3edIhX2grWOXoD4hl3QmTgeRsMzuRzet6gYRaw+YkB6/TUowJdTheIS4EdcI1+cE9RQZ4hF9Xz/
X-Microsoft-Antispam-PRVS: <VI1PR07MB3293CCCA74A246754885D26BA6BB0@VI1PR07MB3293.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(11241501184)(806099)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB3293;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3293;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(346002)(366004)(376002)(57704003)(199004)(189003)(476003)(956004)(386003)(7696005)(305945005)(2616005)(97736004)(1076002)(110136005)(486006)(55016002)(25786009)(66066001)(59450400001)(52116002)(47776003)(86362001)(16586007)(58126008)(36756003)(7416002)(33656002)(5660300001)(8676002)(81156014)(2906002)(81166006)(8936002)(6116002)(21086003)(316002)(478600001)(68736007)(105586002)(23726003)(16526019)(50466002)(1857600001)(186003)(53936002)(7736002)(106356001)(69596002)(3846002)(26005)(39060400002)(18370500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB3293;H:nokia.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB3293;23:japUVorD/Wa3YLUvHt3rPZXe1o7XNB7toosF7nC7P?=
 =?us-ascii?Q?soJKua+i396KULcmSn5IvssruIZ0jtPQEm2N5XlWk8pSRSeSK0LVjhKZBeed?=
 =?us-ascii?Q?cs336jfXNtjVD9dchnE8bLXck6k6jWq88mGZOmOXrQquCtFGRKYdV1j9/gXi?=
 =?us-ascii?Q?Y2OoYYzGv1CadfgKnbcyD9Pf4yxybNb0yFDf9bnUd4htZPnTumurqQvVmOG6?=
 =?us-ascii?Q?UPvKdjjC1K0qQvs57IW6XQ0XtqUYym1L8KblRD0pHOHyPTq6fI1mUH1h+87F?=
 =?us-ascii?Q?tS3BYo0uqdWTUyQt36LbKSjZHHpBQzMJ60Lg2mZEi+rvBiFJsuK1+v1DVvyV?=
 =?us-ascii?Q?efdZPbnZGg+TqM6UGhELrqS+LJC4Fe1SyTuWpDrbioz50OfuYvxhsU+9JoJl?=
 =?us-ascii?Q?fmZu71RIaO5tSmjLgcmYvJbzGs8M8dx2zuip4dGBRWXFIQ7nR3ebUygPMQqT?=
 =?us-ascii?Q?Kz5fmUJYypn/HEUWaW9EqSIEK3HgutFATXwzvrCw4wI5tQytz71LhUzT9FNS?=
 =?us-ascii?Q?rF/t2G5mVcOUCy3V+9JrM+/ERMTlbmJ3C6ysuuX9jW75RVxCJindq+PvXg3L?=
 =?us-ascii?Q?V2/gldFT0Fiu2h4uyciAEJFhP/uxKEXesOO5fcuvXpLT5HTAjqtSQObtvCYC?=
 =?us-ascii?Q?3L1lkRBLkxn8GEqUOZ1m4GD5NA965jw1QBlnF3OzewVfJwxZLyT5GiqdOhyy?=
 =?us-ascii?Q?I7GuhLJVCxNFThxua7ESGjFkJ+CckGhhQPf0EMo3l2s2TdMtcfPq9Xx08yLY?=
 =?us-ascii?Q?PZXeW2+mRQUH/xvmMZrlgDxDFzlMEfvIRwyU46ybazYszqMYOPO663Qvd+10?=
 =?us-ascii?Q?RnDaXWKmZxAfGsUsgyxH6mIo1jGIvXSEJRv/U1PCzYGPkBrzgsqRnnE99gEL?=
 =?us-ascii?Q?8hawVZ6Az4wm1yT3O1e+mojRoCwN24PwTQf41qKJYRrm+msAP5DerGxeWQd0?=
 =?us-ascii?Q?Nl5nJz+XU5G8Yfaq6/yi5RZZNRfjCRf4VyjgTILstctMDGvoqi325bNLo3zN?=
 =?us-ascii?Q?hb5K9nan9YAIt3F9Orh1sGtmEBM4gR97KQv7a2OrIg5CRlfXbS1SeLqtDtj5?=
 =?us-ascii?Q?LoRGSWc/+/tGCIa1y8gtU7Xjbn7eASnbNiBQ599fhM424z2S/rc6YPHl/z6/?=
 =?us-ascii?Q?pg2AkP3r850M2NifBrism1NjxvWWkxGlkH3br6cpIod5WhGBleaxRbr1NxIQ?=
 =?us-ascii?Q?Z1q36oGfT8weEUsiuP0bngT7OVVFhwUvy7SQXubLtZl9BA7S5RdLDsecWKwh?=
 =?us-ascii?Q?wfkKIgzLiw+7IzVA6MjinfGP5UfxL5hC0FliC3YsRiS7Mx0pBK9XQDdne6WO?=
 =?us-ascii?Q?PmsmDFqUbkKJKH94EN4mqg=3D?=
X-Microsoft-Antispam-Message-Info: Hzllx9P10PAOLi+34gXxP7msqucyvh9cKxNRv0hF1or8yVSwW0o39t0EcPseAfdTev7AwnvG5MI9MeppEtWSrVftQ++LQbNupD2KLIxz53rSbvp+lA6TEehh/lyyQky+n/5Xf4i3ajUHvyO+XfDcu2JFiDAY9oI7etUXqTAVH6dvD9oDDlOPd5xmeQy381YPM6mzxGj3nekjuHLdJs4OMiqf1Vj8VvAZXV+p7j9XJJQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3293;6:0n5RXZfIxQty7c2aGRaeRBur70cw6QKM2+hMAspvOJU9A/SWVAxLY+eihv11UUrSKSCCfsg84wsb7epb5ZYhqwIwK14K1KmmH/1YS/2O5hwvhvheJrZnN92OntrX7o7uMrnZ++IfvfETe8u5wFWA54nD5mdEHh1x954adXxikr46VUUU+mCXlHI0kxwx4aEMGdozEMOv3ol1UenwgPx5FMiFAOJPr51J/ckV9dNBZbnRTFEuYjNOYV2OFEubjAkb0mpqzLrSz0xJZys5NA3alkhj6vRNtyh36+Rzw0/O1zcM1AznNOawnIWx5ZaAZlxzkZtl5nrTy5IndVXaqfItFXDQ31I0p00XU/2hfTYNSDFmgYMOCpyNBay/fOuqB2ZKSzqCBEbMbBwYyCPLZldrlKFOzA/43r8T0x7D8yDZMan8MIrUiQtmMzGN7AtCZ05HJy4vovYWA80f4biG33jWaw==;5:vmPS3q0tB61KBoZ7en/0KSVIOiJIUkBBs9jxOisu9r6DhrHKUEC5r56Aoj571WmWo0qAUrwdmuSv60LpQYTYbsGA5SGqr+jH5H1nWlXeT7OJWFE9+9QiS3L7cjjXXEArLayHsHz5DWRIdlEd7BU9O/JXswDQByP7FkgBK6aXaoE=;24:I/aCWmseBeA1IpFqhc1vWOjMslui+Tg8ThKb3IU99XxNwO6yULB265JfTTnUY18NzrX/3MED2s7lQtClZ+BY6ey/3LcMXG94ymb2nb4M+tg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3293;7:q+WWIZsRaO+cAYBCIzkJz5p4MwaqpDXpFhVaSkb/2lt9uX1RBpjXVOEb/p34dXL0grRy4xZ+UuzqHBuDftJVFxz/Reymbbew17yzzxIa9yUF7dLQz8DVC7heMnr0BrEKDbiWZC2SCM3rl34hSK74wG+OtPqc6yGY3VJLVB9ZzTX6/DAXoxd2EhBS11S40uvrwNiZY4gRUJ9CCRTVUoevmpazJ9BCxm7Vn9LwfTPdmL1dPkMubPerX1usP13nAEe2
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 20:33:44.5339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e5f63e-8799-4e26-6cfa-08d59b348792
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3293
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
