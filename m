Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7368ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4AC208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4AC208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeGNQyJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:54:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47340 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeGNQyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:54:09 -0400
Received: from [192.168.0.117] (188.146.224.185.nat.umts.dynamic.t-mobile.pl [188.146.224.185])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9386ACF163;
        Sat, 14 Jul 2018 18:41:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v5 4/7] Bluetooth: Add new quirk for non-persistent setup
 settings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4b188c8a508340598dda233f6d49a16c9ac8784e.1531150733.git.sean.wang@mediatek.com>
Date:   Sat, 14 Jul 2018 18:34:29 +0200
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2825B722-E75C-4A3C-8110-879205E46C0E@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <4b188c8a508340598dda233f6d49a16c9ac8784e.1531150733.git.sean.wang@mediatek.com>
To:     sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
> index 73e48be..d3ec5b2a8 100644
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
> index f5c21004..0111280 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1396,7 +1396,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> 	atomic_set(&hdev->cmd_cnt, 1);
> 	set_bit(HCI_INIT, &hdev->flags);
> 
> -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);

can you include the extract of btmon on how the HCI_DEV_SETUP event shows up in the traces? I remember that I asked about something like that.

Regards

Marcel

