Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeEUTjz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:39:55 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:21706 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751077AbeEUTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:39:54 -0400
X-Authority-Reason: nr=8
Date: Mon, 21 May 2018 14:39:51 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [media] duplicate code in media drivers
Message-ID: <20180521193951.GA16659@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fKqev-001ysX-Jt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.46.223]:57532
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

I found some duplicate code with the help of Coccinelle and Coverity. Notice that these are not code patches, they only point out the duplicate code in some media drivers:

diff -u -p drivers/media/pci/bt8xx/dvb-bt8xx.c /tmp/nothing/media/pci/bt8xx/dvb-bt8xx.c
--- drivers/media/pci/bt8xx/dvb-bt8xx.c
+++ /tmp/nothing/media/pci/bt8xx/dvb-bt8xx.c
@@ -389,9 +389,7 @@ static int advbt771_samsung_tdtc9251dh0_
        else if (c->frequency < 600000000)
                bs = 0x08;
        else if (c->frequency < 730000000)
-               bs = 0x08;
        else
-               bs = 0x08;

        pllbuf[0] = 0x61;
        pllbuf[1] = div >> 8;
diff -u -p drivers/media/usb/dvb-usb/dib0700_devices.c /tmp/nothing/media/usb/dvb-usb/dib0700_devices.c
--- drivers/media/usb/dvb-usb/dib0700_devices.c
+++ /tmp/nothing/media/usb/dvb-usb/dib0700_devices.c
@@ -1741,13 +1741,6 @@ static int dib809x_tuner_attach(struct d
        struct dib0700_adapter_state *st = adap->priv;
        struct i2c_adapter *tun_i2c = st->dib8000_ops.get_i2c_master(adap->fe_adap[0].fe, DIBX000_I2C_INTERFACE_TUNER, 1);

-       if (adap->id == 0) {
-               if (dvb_attach(dib0090_register, adap->fe_adap[0].fe, tun_i2c, &dib809x_dib0090_config) == NULL)
-                       return -ENODEV;
-       } else {
-               if (dvb_attach(dib0090_register, adap->fe_adap[0].fe, tun_i2c, &dib809x_dib0090_config) == NULL)
-                       return -ENODEV;
-       }

        st->set_param_save = adap->fe_adap[0].fe->ops.tuner_ops.set_params;
        adap->fe_adap[0].fe->ops.tuner_ops.set_params = dib8096_set_param_override;
diff -u -p drivers/media/dvb-frontends/mb86a16.c /tmp/nothing/media/dvb-frontends/mb86a16.c
--- drivers/media/dvb-frontends/mb86a16.c
+++ /tmp/nothing/media/dvb-frontends/mb86a16.c
@@ -1466,9 +1466,7 @@ static int mb86a16_set_fe(struct mb86a16
                                                        wait_t = (1572864 + state->srate / 2) / state->srate;
                                                if (state->srate < 5000)
                                                        /* FIXME ! , should be a long wait ! */
-                                                       msleep_interruptible(wait_t);
                                                else
-                                                       msleep_interruptible(wait_t);

                                                if (sync_chk(state, &junk) == 0) {
                                                        iq_vt_set(state, 1);
diff -u -p drivers/media/dvb-frontends/au8522_decoder.c /tmp/nothing/media/dvb-frontends/au8522_decoder.c
--- drivers/media/dvb-frontends/au8522_decoder.c
+++ /tmp/nothing/media/dvb-frontends/au8522_decoder.c
@@ -280,14 +280,9 @@ static void setup_decoder_defaults(struc
                        AU8522_TOREGAAGC_REG0E5H_CVBS);
        au8522_writereg(state, AU8522_REG016H, AU8522_REG016H_CVBS);

-       if (is_svideo) {
                /* Despite what the table says, for the HVR-950q we still need
                   to be in CVBS mode for the S-Video input (reason unknown). */
                /* filter_coef_type = 3; */
-               filter_coef_type = 5;
-       } else {
-               filter_coef_type = 5;
-       }

        /* Load the Video Decoder Filter Coefficients */
        for (i = 0; i < NUM_FILTER_COEF; i++) {


I wonder if some of the cases above were intentionally coded that way or some code needs to be removed.

Thanks
--
Gustavo
