Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeCOQUV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:20:21 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCOQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:20:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Lucas Stach <l.stach@pengutronix.de>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] gpu: ipu-v3: prg: avoid possible array underflow
Date: Thu, 15 Mar 2018 17:19:57 +0100
Message-Id: <20180315162011.807909-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:lbA6dTr3mwpT4NT80Zxn6D8aDnyLcSfwMFfQGKk6/a0pnCmFf5w
 TmalFCnjJgMDW/MyUnC2x8wa9yG1QC0LL21SLf9tisCkMuLjFnPYp1dv+d6hOeTW6PVNiWs
 bgAxPgilbqVi3KCZA6vO9lNTV7CaelsKSZO5GF+mn0Ndb7GxUJU63f/k6iDk038NmUL9Fta
 VM966JJheg+wFLYJAGDJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c8Ec0vxPw9k=:QqjXW71jkiJKnr2askDiqQ
 XBaeowtBL/I3O8FVP23PZvwtgtSh1g0BqSjKp30OeMAiNgEbDPFZYeSACDAvPAh7nxCiace2t
 JForuaW31Epfo4a21wNfjRSnRuhNGNwN8VYlsT8YVkC4gsfXytU2Aq2hRkvE3H9+U3LC+5Q8U
 zMzzkDr00DBgXzIQpsGJJbfJ9Zwbpod77va7NuVkIGK1iJ+WEmtbnzRx1yT9Z1h4ECpZQGM1v
 tEYGfkRquubxfcGvvPuTxwKm5KDjgteH5tLXXm/EZIXLXsHX4YluILjk1XhtdY8kzDHOWZF1E
 lRf9J1i4yCIMU+r9oADjhGwtDJSpaJotjLlRjs/fc44SF4P5YNW5uW82NyICcW5gacYRS/cRE
 muy+Y75O8T5B6ms+hfaHnUC4TA+NCOVq507/zcWlJA/onwmeMHaIyav7+PjQHu686atOW1JTk
 8KFnsqwor26UMBm+8bKVxFSQFhoO2BKUXByhirVvVzGy2BZ32ku4LHFUGdr8WLyR+DvKfV/QI
 XKTmeaX/iIP3hVFc/OrqHssiHOxgWLhlbcnIWqQYC4ot4TqsTqeu6XoX/y5xkZhxdYuSnpnrl
 QKwhADgNn6cuf7JxeWR3ZkVog1i/SEVmaUKq1QbacppRP1icfbeA6h4Mnek3LEU0k6UFS6/55
 fnqEWuNjuERY1nnxoNFoGRFZpIvEJdZf4a092Ww+K95cbi/jwFj6ZSEzcNphSRHQ3RMWoWPjz
 piwAxNWYp1lhRi1KV6tXPeJaTMBOx03JRLECoQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 reports that we access an array with a negative index
in an error case:

drivers/gpu/ipu-v3/ipu-prg.c: In function 'ipu_prg_channel_disable':
drivers/gpu/ipu-v3/ipu-prg.c:252:43: error: array subscript -22 is below array bounds of 'struct ipu_prg_channel[3]' [-Werror=array-bounds]

This moves the range check in front of the first time that
variable gets used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
v1: Originally sent on Dec 4, 2017.
v2: Sent again on Jan 16, after no reply, Phillipp said it was merged
v3: Ran into a related problem with CONFIG_UBSAN, sent again fixing both
---
 drivers/gpu/ipu-v3/ipu-prg.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 97b99500153d..83f9dd934a5d 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -250,10 +250,14 @@ void ipu_prg_channel_disable(struct ipuv3_channel *ipu_chan)
 {
 	int prg_chan = ipu_prg_ipu_to_prg_chan(ipu_chan->num);
 	struct ipu_prg *prg = ipu_chan->ipu->prg_priv;
-	struct ipu_prg_channel *chan = &prg->chan[prg_chan];
+	struct ipu_prg_channel *chan;
 	u32 val;
 
-	if (!chan->enabled || prg_chan < 0)
+	if (prg_chan < 0)
+		return;
+
+	chan = &prg->chan[prg_chan];
+	if (!chan->enabled)
 		return;
 
 	pm_runtime_get_sync(prg->dev);
@@ -280,13 +284,15 @@ int ipu_prg_channel_configure(struct ipuv3_channel *ipu_chan,
 {
 	int prg_chan = ipu_prg_ipu_to_prg_chan(ipu_chan->num);
 	struct ipu_prg *prg = ipu_chan->ipu->prg_priv;
-	struct ipu_prg_channel *chan = &prg->chan[prg_chan];
+	struct ipu_prg_channel *chan;
 	u32 val;
 	int ret;
 
 	if (prg_chan < 0)
 		return prg_chan;
 
+	chan = &prg->chan[prg_chan];
+
 	if (chan->enabled) {
 		ipu_pre_update(prg->pres[chan->used_pre], *eba);
 		return 0;
-- 
2.9.0
