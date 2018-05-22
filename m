Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeEVHV2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:21:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56344 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeEVHV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:21:26 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v2 4/7] Bluetooth: Add new quirk for non-persistent setup
 settings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
Date: Tue, 22 May 2018 09:21:23 +0200
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
References: <cover.1526374087.git.sean.wang@mediatek.com>
 <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
To: sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
> runs setup() after every open() and not just after the first open().
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> include/net/bluetooth/hci.h | 9 +++++++++
> net/bluetooth/hci_core.c    | 3 ++-
> 2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1668211..b37d973 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -183,6 +183,15 @@ enum {
> 	 * during the hdev->setup vendor callback.
> 	 */
> 	HCI_QUIRK_NON_PERSISTENT_DIAG,
> +
> +	/* When this quirk is set, setup() would be run after every
> +	 * open() and not just after the first open().
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 *
> +	 */
> +	HCI_QUIRK_NON_PERSISTENT_SETUP,
> };
> 
> /* HCI device flags */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 40d260f..7de712e2 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1377,7 +1377,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> 	atomic_set(&hdev->cmd_cnt, 1);
> 	set_bit(HCI_INIT, &hdev->flags);
> 
> -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);

I am not 100% sure that we want to send the HCI_DEV_SETUP event also multiple times. That is a userspace change that I would need to think about. We need to check create_monitor_event() and see what the btmon trace for this looks like. Can you send me a btmon -w trace.log when this change is active.

Regards

Marcel
