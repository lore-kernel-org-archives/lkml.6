Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA8FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D58218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfAXJgY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:36:24 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56158 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfAXJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:36:24 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4CC34CF166;
        Thu, 24 Jan 2019 10:44:09 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v5 3/4] Bluetooth: Allow driver specific cmd timeout
 handling
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190123205725.239661-3-rajatja@google.com>
Date:   Thu, 24 Jan 2019 10:36:21 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        rajatxjain@gmail.com, dtor@google.com,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <D868735A-05A4-405A-9101-8D59F4208B9E@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190123205725.239661-1-rajatja@google.com>
 <20190123205725.239661-3-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> Add a hook to allow the BT driver to do device or command specific
> handling in case of timeouts. This is to be used by Intel driver to
> reset the device after certain number of timeouts.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v5: Drop the quirk, and rename the hook function to cmd_timeout()
> v4: same as v1
> v3: same as v1
> v2: same as v1
> 
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 10 ++++++++--
> 2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e5ea633ea368..624d5f2b1f36 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -437,6 +437,7 @@ struct hci_dev {
> 	int (*post_init)(struct hci_dev *hdev);
> 	int (*set_diag)(struct hci_dev *hdev, bool enable);
> 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> +	void (*cmd_timeout)(struct hci_dev *hdev, struct hci_command_hdr *cmd);
> };
> 
> #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7352fe85674b..c6917f57581a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2568,16 +2568,22 @@ static void hci_cmd_timeout(struct work_struct *work)
> {
> 	struct hci_dev *hdev = container_of(work, struct hci_dev,
> 					    cmd_timer.work);
> +	struct hci_command_hdr *sent = NULL;
> 
> 	if (hdev->sent_cmd) {
> -		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
> -		u16 opcode = __le16_to_cpu(sent->opcode);
> +		u16 opcode;
> +
> +		sent = (void *) hdev->sent_cmd->data;
> +		opcode = __le16_to_cpu(sent->opcode);
> 
> 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
> 	} else {
> 		bt_dev_err(hdev, "command tx timeout");
> 	}
> 
> +	if (hdev->cmd_timeout)
> +		hdev->cmd_timeout(hdev, sent);
> +

drop the sent parameter. You are not using it and if at some point in the future you might want to use it, then we add it and fix up all users.

And frankly, I would move the hdev->cmd_timeout call into the hdev->sent_cmd block since I do not even know if it makes sense to deal with the fallback case where hdev->sent_cmd is not available. Unless you have that kind of error case, but that is only possible if you have external injection of HCI commands.

Regards

Marcel

