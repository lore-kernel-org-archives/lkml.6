Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C1C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638782086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfASTvK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:51:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49691 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfASTvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:51:08 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 53CADCF351;
        Sat, 19 Jan 2019 20:58:53 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4 3/5] Bluetooth: Reset Bluetooth chip after multiple
 command timeouts
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190118223407.64818-3-rajatja@google.com>
Date:   Sat, 19 Jan 2019 20:51:06 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <D1490A23-9076-4BAA-A932-CDE1C073475B@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190118223407.64818-1-rajatja@google.com>
 <20190118223407.64818-3-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> Add a quirk and a hook to allow the HCI core to reset the BT chip
> if needed (after a number of timed out commands). Use that new hook to
> initiate BT chip reset if the controller fails to respond to certain
> number of commands (currently 5) including the HCI reset commands.
> This is done based on a newly introduced quirk. This is done based
> on some initial work by Intel.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v4: same as v1
> v3: same as v1
> v2: same as v1
> 
> include/net/bluetooth/hci.h      |  8 ++++++++
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_core.c         | 15 +++++++++++++--
> 3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e20556..af02fa5ffe54 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -192,6 +192,14 @@ enum {
> 	 *
> 	 */
> 	HCI_QUIRK_NON_PERSISTENT_SETUP,
> +
> +	/* When this quirk is set, hw_reset() would be run to reset the
> +	 * hardware, after a certain number of commands (currently 5)
> +	 * time out because the device fails to respond.
> +	 *
> +	 * This quirk should be set before hci_register_dev is called.
> +	 */
> +	HCI_QUIRK_HW_RESET_ON_TIMEOUT,
> };
> 
> /* HCI device flags */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e5ea633ea368..b86218304b80 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -313,6 +313,7 @@ struct hci_dev {
> 	unsigned int	acl_cnt;
> 	unsigned int	sco_cnt;
> 	unsigned int	le_cnt;
> +	unsigned int	timeout_cnt;
> 
> 	unsigned int	acl_mtu;
> 	unsigned int	sco_mtu;
> @@ -437,6 +438,7 @@ struct hci_dev {
> 	int (*post_init)(struct hci_dev *hdev);
> 	int (*set_diag)(struct hci_dev *hdev, bool enable);
> 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> +	void (*hw_reset)(struct hci_dev *hdev);
> };
> 
> #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7352fe85674b..ab3a6a8b7ba6 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2569,13 +2569,24 @@ static void hci_cmd_timeout(struct work_struct *work)
> 	struct hci_dev *hdev = container_of(work, struct hci_dev,
> 					    cmd_timer.work);
> 
> +	hdev->timeout_cnt++;
> 	if (hdev->sent_cmd) {
> 		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
> 		u16 opcode = __le16_to_cpu(sent->opcode);
> 
> -		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
> +		bt_dev_err(hdev, "command 0x%4.4x tx timeout (cnt = %u)",
> +			   opcode, hdev->timeout_cnt);
> 	} else {
> -		bt_dev_err(hdev, "command tx timeout");
> +		bt_dev_err(hdev, "command tx timeout (cnt = %u)",
> +			   hdev->timeout_cnt);
> +	}
> +
> +	if (test_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks) &&
> +	    hdev->timeout_cnt >= 5) {
> +		hdev->timeout_cnt = 0;
> +		if (hdev->hw_reset)
> +			hdev->hw_reset(hdev);
> +		return;
> 	}

so I really do not see the need for the quirk here. Either hdev->hw_reset is provided, then execute it, if it is not provided then don’t. The quirk is just duplicate information.

I also don’t like hdev->hw_reset since that implies that the only way of handling a command timeout is a hardware reset. I prefer you call this hdev->cmd_timeout and also scrap the timeout_cnt. Let the driver decide what number of timeouts it wants to react on. The number 5 is just an arbitrary number you picked based on one hardware manufacturer.

Regards

Marcel

