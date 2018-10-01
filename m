Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B275AC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0E72146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZqFu3kI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0E72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeJBC1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:27:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36138 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJBC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:27:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so10007252pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KQiwFfFiTpP1y68h5qOaJ4wqr+K5SUcpeffpP71St+w=;
        b=ZqFu3kI3dzrrrTxQN/u1lXxyOG0J5wlmWFWY2eC3/k3YRybsURKys3W7BaGL7k8Fsh
         GcayGmjXw+8ZnCVYr+nFU8FsEXcsvKWfL6U4eudh5u9QgMR7NU/bX4TgVOj7zxoI27O/
         kdeMzEwTfTAQHvSLusKSBSeBT0M8Yi5linxYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQiwFfFiTpP1y68h5qOaJ4wqr+K5SUcpeffpP71St+w=;
        b=jFMKZQWKk6pp5VtGh4c5GkxRcqIczKaWvP87OFWbERK1CnT7F613bHUefBm5hz3cVH
         rIkVnbvDaBbLfB0j7VogjSHyE1f2x65GJ1cZqJTJHd5keiBtqfMtUwc0EkxUiAtjtuMj
         +FGz5vC+c0pHr+7BBgxZcwRh8BppqNz2+58HOF54m4LVCuC6F59FuMfxyaxdAvuUSFE6
         9KWWuNZnl6rbxpNS9sSpnvtxmzfP0UxW4pDY4W5/IAYCOjlYGWzUu3kUBnInn+bVO1Nm
         gdHhsT9y5iL3beWR7v6Enr+/2X1/bV/D+KT1f2bwDNbFvLbk611EjJQq8FYX2m50k6di
         52Mg==
X-Gm-Message-State: ABuFfoibE8IYEWIZEYeDplRFWKPJ9MEnRkH3p1O63whwK+SJa1tR4I62
        3iTwIn9YBkHYL6eNQk6h0pQPCg==
X-Google-Smtp-Source: ACcGV63n1t0AlYDYs5Q6W/PEJdPWWvd6cEhctAIxPJbtVeLgp0VWXLivRwIka+IsDXPCpRz3oNxj3A==
X-Received: by 2002:a17:902:5590:: with SMTP id g16-v6mr13224532pli.46.1538423304059;
        Mon, 01 Oct 2018 12:48:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id o2-v6sm19081990pgi.62.2018.10.01.12.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 12:48:22 -0700 (PDT)
Date:   Mon, 1 Oct 2018 12:48:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Add support for controller debug
 logs.
Message-ID: <20181001194821.GH22824@google.com>
References: <20181001135102.17453-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181001135102.17453-1-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

On Mon, Oct 01, 2018 at 07:21:02PM +0530, Balakrishna Godavarthi wrote:
> This patch will prevent error messages splashing on console.
> 
> [   78.426697] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
> [   78.436682] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
> [   78.446639] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
> [   78.456596] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
> 
> QCA wcn3990 will send the debug logs in the form of ACL packets.
> While decoding packet in qca_recv(), marking the received debug log
> packet as diagnostic packet.
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index d98ed0442201..a00910aaed54 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -63,6 +63,10 @@
>  /* susclk rate */
>  #define SUSCLK_RATE_32KHZ	32768
>  
> +/* Controller debug log header */
> +#define QCA_DEBUG_HDR_MSB	0xDC
> +#define QCA_DEBUG_HDR_LSB	0x2E
> +
>  /* HCI_IBS transmit side sleep protocol states */
>  enum tx_ibs_states {
>  	HCI_IBS_TX_ASLEEP,
> @@ -849,6 +853,20 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
>  	return 0;
>  }
>  
> +static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	/* We receive debug logs from chip as an ACL packets.
> +	 * Instead of sending the data to ACL to decode the
> +	 * received data, we are pushing them to the above layers
> +	 * as a diagnostic packet.
> +	 */
> +	if ((skb->len > 2) && (skb->data[0] == QCA_DEBUG_HDR_MSB) &&
> +	    (skb->data[1] == QCA_DEBUG_HDR_LSB))
> +		return hci_recv_diag(hdev, skb);
> +	else
> +		return hci_recv_frame(hdev, skb);

nit: you could just do hci_recv_frame() after the if branch, instead
of doing it in 'else'. That would make it clearer at first sight that
the QCA debug packets are a special case and other packets normal
operation.

> +}
> +
>  #define QCA_IBS_SLEEP_IND_EVENT \
>  	.type = HCI_IBS_SLEEP_IND, \
>  	.hlen = 0, \
> @@ -870,13 +888,20 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
>  	.lsize = 0, \
>  	.maxlen = HCI_MAX_IBS_SIZE
>  
> +#define QCA_RECV_ACL_DATA \
> +	.type = HCI_ACLDATA_PKT, \
> +	.hlen = HCI_ACL_HDR_SIZE, \
> +	.loff = 2, \
> +	.lsize = 2, \
> +	.maxlen = HCI_MAX_FRAME_SIZE

Is there any actual advantage of adding this 'macro' instead of just
using H4_RECV_ACL, which is exactly the same?

>  static const struct h4_recv_pkt qca_recv_pkts[] = {
> -	{ H4_RECV_ACL,             .recv = hci_recv_frame    },
>  	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
>  	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
>  	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
>  	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
>  	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
> +	{ QCA_RECV_ACL_DATA,       .recv = qca_recv_acl_data },
>  };
>  
>  static int qca_recv(struct hci_uart *hu, const void *data, int count)
