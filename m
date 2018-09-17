Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A098ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04B42147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xaTOeWBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04B42147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeIQTLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:11:10 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:14673
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728476AbeIQTLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OuoQ6ME5x9zl8DUCFOnuDh9S4MBGNhyUDs21Ggg0Og=;
 b=xaTOeWBujVNGy7qwk6/p/l/FyNikZUtuXknRAcrwqdLyOO8EKF6Q0edIkbrZPO7Lo+5pFxtinvDnYNC7nf4GzMZ/oqupaF9U6yYR9IzGzn1sqD8FYdvbkHnH8Z/wuzaxQ1XlAe/HDcUMkWh6dSMBdB1FK7St/Noo/+aBYcJS4Qs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 13:43:05 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [RESEND 5/5] drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm
Date:   Mon, 17 Sep 2018 16:42:15 +0300
Message-Id: <c19c0c00ed42e8e8f7965aa4821ac295abc5cd05.1537191359.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537191359.git.leonard.crestez@nxp.com>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9fa18ec-5485-45b4-0c0e-08d61ca37ffb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:xuiDAKE4I9QOwN2MtNJCv5H3BncUb5EejHoFN6wbUkj5USRd/DOI9vdmH9U8wF3O+3FBZQrdN+bxRo5oMj+5TLk4YiNKQ3QAlNVGqObDGJit+QKWu4CP9zlWUFfEeMegsfI/f55rEHitJwVv6+1p7HPjR5pvlWsq4LQX7ZZCLF4Fq0EeTP1YDMKEwevErh1e6PYrh28Us+vuXDI5lGUMWSXHyv/dQN52ISvizQG99t8q0bBLrxITaF1B6p2Av1C/;25:OEtnTiF6Z+svmQYu56Qst3KuzSSWErJxSwUnARererBuSZ7ppO3kDNen04Zamp4M7GutdH+IAB+IN7s3cGne0Be98D96M5arURtGckh8H08S82V/HO1ydrCIBuIFX8XFTYjqyJtIpWPwwGf4J8+IZRSO7FP02KDXyhJoBsHFJ6jvefx4hlvf2PfECE2R4maskqbM6a26TZ39G1wMFmyDVL7U3PIhAIMSdAt9Y/JQ9eS9ZCevfeU1suwApEnps3qnvdRvPCD7o6Yjld6qDMKXpiy0hwzK0wnKvEARA7tk0+VvPoXDtUQrC+22LGJ9Zgla6RgHd6wV4EOIiZpwIbO9xQ==;31:Q6zyOfnUcd+wVkMzba8CdiBR7+yOdSKfBNQQnKll4PmRdLOWESss1cW3BBQXwC1Ohit1u+iKHvJOucIuaflTk0BIk+mqHovMaBS30Yo4vaqkUsPtg5qRTq821i5lf1UEf6IWeQQFrqexA6z3BJQsuGKPGgR1f5vxZoGDzCz9p6Cfum4UKi9nwk6dYNeH4g7/FzupZ31U77WhScL2WJIIadLyhPMHbBWwRsSWtvoAipE=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:KCiiSi/WVtQ74Zf/fdJr1kxKiA/ueHZK//IZkdOzeW3zVys/CkY4HQu0rhguZ4FKZTqMxmqihBT0Nr0Or940EDG45D9FBE30hCEJviaL+xiIHTqFabincbAvtTxB1bfQfW4S1h7M7gROPkacJuOk7hTiFjQC/y3FAGxZfujEqq/VK8xHfFVEb69ow1U/6R8xGK8aKMEIuZtMM1DooglUSuu+F2UzXFthLOwb8R65WazybTFcCGmeIGuECT1ETAjdPTgDebSKVjiB0SRZpwObahYnaDMGgMBe7ZrZAZlpi1/+jxz9ImDZXYfZF89jelJzEllu3/n4Sq5UTWnAtpy7gudOHc28Z5gW2xi7bjCUbjnSlspGmw2Zh9yqAB6zNz8wdmw5rWGXR5V0tEDWr25JGE+cjbyLQnR/9f4rk64jGPnxvsLwDMvt271/+l1w1XdkcndGf2gdtiYM+QLQbGIsie+B4ViVceJInLdSD7o8lO5L8s1OH6VwVKMWrephcgIc;4:Y2EcEMKzX8fvvRA6+/HCKeYM+er7cQrOemDxgEu/nQr5zhRXj4KZQaDrlxaNqMXVjT3s4YsRcCJM8tKQKe2HR+WQ+zslfMTM88Z/0jcJ2IpP/TQqwTU0C60jLMv0knjSkG4NuXZm9KqhTrHV09gDvycl1/cU+6cnsG6Dwii6x2ze0Awmx2WQ9lCoQvEskxFabfcDDz3GsQVHu+ksX/jEz61tMzCUkGtQaP+QcOAi++R1TgU7614aT+7jTbHAhj1AbMils9hhG+KOvycdI5GoGptRuPpCJjlPxdVaj+MS3SCsBJ+BaX+UMx6tQi5UgkmqdLj+vgp1YY6P/cjYY0RE+l7aLGbTpa+rHpC4zkkUWeo=
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290F7CBD158873213919BA2EE1E0@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(6506007)(81166006)(81156014)(8936002)(14444005)(50226002)(478600001)(16526019)(186003)(106356001)(3846002)(6116002)(105586002)(97736004)(47776003)(26005)(68736007)(50466002)(48376002)(66066001)(6512007)(2906002)(5660300001)(118296001)(11346002)(446003)(386003)(110136005)(4326008)(7736002)(6666003)(476003)(956004)(2616005)(54906003)(51416003)(16586007)(86362001)(305945005)(6486002)(44832011)(25786009)(53936002)(36756003)(8676002)(52116002)(486006)(69590400006)(76176011)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:ogmAz2qaDWkcrlps68CYx+jnaZ9UkgLPgkjYK+VUy?=
 =?us-ascii?Q?T8asyGogPOh9gciwQrAI0HMfPZPUsUW7SLNFG+x/xItTfrtB2fA80866FXDs?=
 =?us-ascii?Q?p/H/7FigpJUS+yiRe2t1fTn8WZM6NeFNcezbSpC8/yWWC9U/CJhGMSlgSLsp?=
 =?us-ascii?Q?EeyZKJd8l60KY+KazlBCnWtWW29q+ebxPMN0gqdxZj8WJcbqZIVnRM+K79EP?=
 =?us-ascii?Q?0Zpjvs8kKX2kpLkVqbF+CPA4iAMEV9bJozaoxspdaUkT+xhIRJbuBd46dYw4?=
 =?us-ascii?Q?dJDNpZBEjrURO6cJomkfpLaCu6BdyNHCvxMB4aXyF7N3h6Dvi7H5/P9y51sN?=
 =?us-ascii?Q?xX7h+8REU5468yFi1jAb5r0JlyLsHRQMztye1DkeWXl0k2lUHlhUtbDZowNE?=
 =?us-ascii?Q?kJKlh2r8Rs1Xn5Rz546eKzQ1AkulFJmvieiXFzHlr1bn0CfiMl0Xmrt5q2YT?=
 =?us-ascii?Q?8pdW3PFQc7Pbmkm5VLmwxVDVlzbl675ICq6/ZYjtngmwocuaG5HvX8fM91p9?=
 =?us-ascii?Q?VAUvk4aCpZC+HrAy55ZLYElOiu7YgWQ6XWuvl06TtT17xrUWAOWqEi4SdXpx?=
 =?us-ascii?Q?Xrx2HZQxLRG+i74dSmpoBtZGSdX59zu3NUCAtsF7p1P5fVOF1PVsVM5quZHs?=
 =?us-ascii?Q?CTNj7UboHWSey4JOQbw7AcgE8c1kNRVooOZn0DKVu7s6/VRI2Grk8VAu4dgQ?=
 =?us-ascii?Q?S8Z670mkT/nSsrHdJ/xczhfDCuKSgVXWQpoOy7QFaOSRtt303YlPgvdIZyxk?=
 =?us-ascii?Q?0hIzIH0Vscx0jhVF2OR4cA+Cw7TWzVi+i74gVJtI7d3qIMZQ1EV7V1B5HU9X?=
 =?us-ascii?Q?uLaRJlzJl6z6uOGHQkruhcbk+QZtQdTuvrayJwhn5/1X4lgNFqdCrr98W+pc?=
 =?us-ascii?Q?1D79BaYIFxw5yZYKjt8JH3//GYJKfvH2Lr8bkPidhJX2QaZkk4NDs6Fj5dRN?=
 =?us-ascii?Q?Rxotw42T1WrwvMUJCf1T00FK6dtyFjm3gwwt4swRGjnqy7SOH/mdQ5GVnnCe?=
 =?us-ascii?Q?ndC0eTE5YXplbrsYd2jVj4IKHHWUE1Xc6W2JDAG+BtOXENmaWdpz8/BpaXQk?=
 =?us-ascii?Q?Vz4nc/jPuYEJEE0AsPrOJgO37n29fkqA8kURZUGnozJEg/3FoN5x7xVGIRDr?=
 =?us-ascii?Q?bCcCnrB6sL0qiGziPwzbH5m1shceLG3/2FmvVmdFsnmdbbq1kZtNpOW41/cc?=
 =?us-ascii?Q?FAHsbBIXSuaSZVm9mVuNMLCRFdjzDoF3lCUWJLLJhZT+MHIdJOl37l87LzhT?=
 =?us-ascii?Q?ulbl5eE6+zu5TwnkL/tXCj3zVO5QgqN/AhUMpt4zVVWLeYPduGXmTb2ANIvU?=
 =?us-ascii?Q?jkp91TBAypa8Qh0PSJgj1k=3D?=
X-Microsoft-Antispam-Message-Info: d4xwERiAf5Sx/ywIVGyq9/7NYDC0IU4fEfJOtPhvYOkaFrF3h5ozwlcBZBKdr0jQ75JCIeai0rx1/52AruH/SgU4A7tEtQoFRJSgwiM9RV5TOcwfD9UXAA1jIkZQQP2XmCmD0kU72lkZz6DPvWqMFtE25P1gY1BwBTWNWUX+s74OLeWqqaXXB11hPD/11jaYpr8sViiHRIgGnpZin9VzAFYfxbq9h7G3M95ZHyY/IbXBGD5udJXo9+FC7gv0OLa7uU0GsscwWluJ4LeohxUEIvoDqfQ50z0PSYVQWzGaVbFXVfY2P+X1wHN1ggmiw+BWwv3bqSoffouV6gh40/f7Mn4zvZTM7W9Fwp7pWgyUSjQ=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:lPJYBBBzGdOe5Vx+Z6sC3txZMsHDq0PI5r+wUNvs7+/JedUHxGiUdNyiPjCBK3f0in6pYJ6xkkDX8KCRcbFGj+WBXu7uzAbAXW0HgSfz7K9ZanQwdvkScnebTIpi+uDZM9DXuy53i/MNALo2KNcOlt2fEABJFu7Aqg1Gsb4cedPhLZQdu0F5hEg0oKcYSPnu3kr2sF/SM/UEBdz/juM4OVc88Mj1x0mq3czXz326jSUPOfLMf5MR3TWgbzP6BbxooFe8/DWZ8PPLw8bQCdxNmHGf1IsMy8GqueQLp1ytwaN5eho2/AENB3ygwFNrHpVjyr9Z4TXgRtMpizsqRUIMoOBMSWFixrQ9ppXwaq0HfbDgSKGT/fOnqpf/bHkIisgbSwN7wOBC4xZZaLddnJexrpJb9FaTxzyQcJb66e/kw7iPCYIOchWoO17UJaydGyEEyk42VGO8yfNXjIdxbgkItw==;5:8q46Toc47YefRJt3fUyYcUvRj3pX5qWqCidf8Sen0gqQ8QWc+HWBdCWF8ytZKB/d2Cio6+v3QtSVkrd1viPBhCi10SdtimNmgaW4bwsbRJmjC8iOV1EOSChSMZpHJX0c11l4BtfaSk6JzFOBFj29PIY35afERbOWha3H7MqBhDk=;7:/pxE3gsz7ivhr+rmZWIfCpDIzs+g5JMdbfQwQBqlHnh12yd78hnXGDAb6zzh/fspxRrZmHwVbB9EqEUbPgdAZ6SpgLbg2dj1u/O9He2IqRJzx5YM6dlYwJhv8k7lEC3Iq69xqsYDXEohpkiAn7hNzzbCXonViWeXCzNIi83hlRdOplmLmUNt76iSaYwIk3jgf7nfA8kOhSW+BzPumBWX/+DB3yhO7u7bbzbnBQI5I7soGzUT1tf2qf/eYaZORCke
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:43:05.7840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fa18ec-5485-45b4-0c0e-08d61ca37ffb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lcdif block is only powered on when display is active so plane
updates when not enabled are not valid. Writing to an unpowered IP block
is mostly ignored but can trigger bus errors on some chips.

Prevent this situation by switching to drm_atomic_helper_commit_tail_rpm
and having the drm core ensure atomic_plane_update is only called while
the crtc is active. This avoids having to keep track of "enabled" bits
inside the mxsfb driver.

This also requires handling the vblank event for disable from
mxsfb_pipe_disable.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Suggested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index d797dfd40d98..5777e730085b 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -96,10 +96,14 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 	.fb_create		= drm_gem_fb_create,
 	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 };
 
+static const struct drm_mode_config_helper_funcs mxsfb_mode_config_helpers = {
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+};
+
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
@@ -113,15 +117,25 @@ static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
 	struct drm_device *drm = pipe->plane.dev;
+	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_pending_vblank_event *event;
 
 	drm_panel_disable(mxsfb->panel);
 	mxsfb_crtc_disable(mxsfb);
 	drm_panel_unprepare(mxsfb->panel);
 	pm_runtime_put_sync(drm->dev);
+
+	spin_lock_irq(&drm->event_lock);
+	event = crtc->state->event;
+	if (event) {
+		crtc->state->event = NULL;
+		drm_crtc_send_vblank_event(crtc, event);
+	}
+	spin_unlock_irq(&drm->event_lock);
 }
 
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state)
 {
@@ -232,10 +246,11 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 	drm->mode_config.min_width	= MXSFB_MIN_XRES;
 	drm->mode_config.min_height	= MXSFB_MIN_YRES;
 	drm->mode_config.max_width	= MXSFB_MAX_XRES;
 	drm->mode_config.max_height	= MXSFB_MAX_YRES;
 	drm->mode_config.funcs		= &mxsfb_mode_config_funcs;
+	drm->mode_config.helper_private	= &mxsfb_mode_config_helpers;
 
 	drm_mode_config_reset(drm);
 
 	pm_runtime_get_sync(drm->dev);
 	ret = drm_irq_install(drm, platform_get_irq(pdev, 0));
-- 
2.17.1

