Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeB1S4q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:56:46 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56283 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752902AbeB1S4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:56:43 -0500
X-ME-Sender: <xms:avuWWgaKkSEMO2_vAPyLb9NZw5FUZdVAt18HuZfOu-9kYECsOl4M8w>
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ", linux-arm-kernel"@lists.infradead.org,
        ", linux-arm-kernel"@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
 <d9e14058-6ffb-e54a-1565-f228342ee1f0@sholland.org>
 <CABb+yY3nfVxoA9wy1ym4mtCTKCZtJjepUTr7OP1uUPmzOEzniA@mail.gmail.com>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <e52b48cb-ce06-f4c4-ce20-9b893139e54d@sholland.org>
Date: Wed, 28 Feb 2018 12:56:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CABb+yY3nfVxoA9wy1ym4mtCTKCZtJjepUTr7OP1uUPmzOEzniA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/18 12:14, Jassi Brar wrote:
> On Wed, Feb 28, 2018 at 11:21 PM, Samuel Holland <samuel@sholland.org> wrote:
>> Hi,
>>
>> On 02/28/18 03:16, Jassi Brar wrote:
>>> On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
>>> ....
>>>
>>>> +/*
>>>> + * The message box hardware provides 8 unidirectional channels. As the mailbox
>>>> + * framework expects them to be bidirectional
>>>>
>>> That is incorrect. Mailbox framework does not require a channel to be
>>> TX and RX capable.
>>
>> Sorry, it would be more accurate to say that the intended mailbox _client_
>> expects the channels to be bidirectional.
>>
> Mailbox clients are very mailbox provider specific. Your client driver
> is unlikely to be reuseable over another controller+remote combo.
> Your client has to know already what a physical channel can do (RX, TX
> or RXTX). There is no api to provide that info.

There's a public specification for SCPI available[1]. I'm writing the remote
endpoint to follow that protocol specification. (There's even an explicitly
platform-agnostic update to the protocol called SCMI[2]). Ideally, I should be
able to reuse the existing Linux client drivers for that protocol. Are you
suggesting that I need to write a copy of the arm_scpi driver, completely
identical except that it requests two mailbox channels per client (sending on
one and receiving on the other) instead of one? In the >1000 line file, this is
all that I would need to change:

--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -257,7 +257,8 @@ struct scpi_xfer {

 struct scpi_chan {
 	struct mbox_client cl;
-	struct mbox_chan *chan;
+	struct mbox_chan *tx_chan;
+	struct mbox_chan *rx_chan;
 	void __iomem *tx_payload;
 	void __iomem *rx_payload;
 	struct list_head rx_pending;
@@ -541,7 +542,7 @@
 	msg->rx_len = rx_len;
 	reinit_completion(&msg->done);

-	ret = mbox_send_message(scpi_chan->chan, msg);
+	ret = mbox_send_message(scpi_chan->tx_chan, msg);
 	if (ret < 0 || !rx_buf)
 		goto out;

@@ -894,8 +895,10 @@
 {
 	int i;

-	for (i = 0; i < count && pchan->chan; i++, pchan++) {
-		mbox_free_channel(pchan->chan);
+	for (i = 0; i < count && pchan->tx_chan; i++, pchan++) {
+		if (pchan->rx_chan && pchan->rx_chan != pchan->tx_chan)
+			mbox_free_channel(pchan->rx_chan);
+		mbox_free_channel(pchan->tx_chan);
 		devm_kfree(dev, pchan->xfers);
 		devm_iounmap(dev, pchan->rx_payload);
 	}
@@ -968,6 +971,7 @@
 		dev_err(dev, "no mboxes property in '%pOF'\n", np);
 		return -ENODEV;
 	}
+	count /= 2;

 	scpi_chan = devm_kcalloc(dev, count, sizeof(*scpi_chan), GFP_KERNEL);
 	if (!scpi_chan)
@@ -1009,13 +1013,19 @@

 		ret = scpi_alloc_xfer_list(dev, pchan);
 		if (!ret) {
-			pchan->chan = mbox_request_channel(cl, idx);
-			if (!IS_ERR(pchan->chan))
+			pchan->tx_chan = mbox_request_channel(cl, idx * 2);
+			pchan->rx_chan = mbox_request_channel(cl, idx * 2 + 1);
+			/* This isn't quite right, but the idea stands. */
+			if (!IS_ERR(pchan->tx_chan) && !IS_ERR(pchan->rx_chan))
 				continue;
-			ret = PTR_ERR(pchan->chan);
+			ret = PTR_ERR(pchan->tx_chan);
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "failed to get channel%d err %d\n",
-					idx, ret);
+					idx * 2, ret);
+			ret = PTR_ERR(pchan->rx_chan);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to get channel%d err %d\n",
+					idx * 2 + 1, ret);
 		}
 err:
 		scpi_free_channels(dev, scpi_chan, idx);


But then there are two copies of almost exactly the same driver! If there was an
API for determining if a channel was unidirectional or bidirectional, than it
would be trivial to support both models in one driver:


--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -953,7 +955,7 @@

 static int scpi_probe(struct platform_device *pdev)
 {
-	int count, idx, ret;
+	int count, idx, mbox_idx, ret;
 	struct resource res;
 	struct scpi_chan *scpi_chan;
 	struct device *dev = &pdev->dev;
@@ -971,13 +973,12 @@
 		dev_err(dev, "no mboxes property in '%pOF'\n", np);
 		return -ENODEV;
 	}
-	count /= 2;

 	scpi_chan = devm_kcalloc(dev, count, sizeof(*scpi_chan), GFP_KERNEL);
 	if (!scpi_chan)
 		return -ENOMEM;

-	for (idx = 0; idx < count; idx++) {
+	for (idx = 0, mbox_idx = 0; mbox_idx < count; idx++) {
 		resource_size_t size;
 		struct scpi_chan *pchan = scpi_chan + idx;
 		struct mbox_client *cl = &pchan->cl;
@@ -1014,7 +1015,13 @@
 		ret = scpi_alloc_xfer_list(dev, pchan);
 		if (!ret) {
 			pchan->tx_chan = mbox_request_channel(cl, idx * 2);
-			pchan->rx_chan = mbox_request_channel(cl, idx * 2 + 1);
+			if (mbox_chan_is_bidirectional(pchan->tx_chan)) {
+				pchan->rx_chan = pchan->tx_chan;
+				mbox_idx += 1;
+			} else {
+				pchan->rx_chan = mbox_request_channel(cl, idx * 2 + 1);
+				mbox_idx += 2;
+			}
 			/* This isn't quite right, but the idea stands. */
 			if (!IS_ERR(pchan->tx_chan) && !IS_ERR(pchan->rx_chan))
 				continue;
@@ -1034,7 +1041,7 @@
 	}

 	scpi_info->channels = scpi_chan;
-	scpi_info->num_chans = count;
+	scpi_info->num_chans = idx;
 	scpi_info->commands = scpi_std_commands;

 	platform_set_drvdata(pdev, scpi_info);


Obviously this is just proof-of-concept code and would need to be cleaned up a bit.

The are platform-agnostic protocols using mailbox hardware. There's no reason
that the drivers for them need to be platform-specific. I'd really like to avoid
duplicating large amounts of code unnecessarily. I'm willing to prepare a patch
series adding this functionality to the mailbox API, if it would be accepted.

Something like:
bool mbox_chan_is_bidirectional(struct mbox_chan *chan);

Implemented in drivers like:
struct mbox_controller {
	...
	bool bidirectional_chans;
};

or:
struct mbox_chan_ops {
	...
	bool (*is_bidirectional)(struct mbox_chan *chan);
};

> thanks

Regards,
Samuel

[1]:
http://infocenter.arm.com/help/topic/com.arm.doc.dui0922g/scp_message_interface_v1_2_DUI0922G_en.pdf
[2]:
http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/DEN0056A_System_Control_and_Management_Interface.pdf
