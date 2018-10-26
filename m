Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A920AECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287122085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXT/0O+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287122085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJ0Db0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:31:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39059 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeJ0Db0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:31:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so978912pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQmOOJ/rN1/JPprUB1D77Z8TtrDa67iiG6AT33srIeg=;
        b=SXT/0O+jlxYauE+2Mnh1ke5s7xV9ZKtVTE9P7F2MKKWJJtnxBtt6Cu3b6kzMXHa0C+
         EtJLHabKJY4Mi+nq6cOZ35S59we5QdT/7ikZ36o6BaiuEnA1H3UXVxVK2pNVw+/FeMFO
         0Vw18mzUCxh6R/EY9SxtRpr2UDscIgH5HYLXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQmOOJ/rN1/JPprUB1D77Z8TtrDa67iiG6AT33srIeg=;
        b=h8pUl/WVJxci1rfg5DuYK+YdNrx14L1Q4yy/Gjrf3IJjkk66Jekr1YoGTQROE1053p
         OMaJvc9uiATK+Kh7OtH97WBDH4y69mgcohCXb+MqlH3F/pEn5c6rtnKlyVKSwgXz71hX
         s/bxdWMmIs8MK/tlOJeE3/KE3CUCnxLL5befciGTpbpbtxFeqwmSJwn0TlBMKq6/c+5a
         tEez0usoKQm74x+CDI7wYxUHEjOb8axiuuINljfFRr5WD/ixel4kIreyZCa1S6I9qKhD
         9LFPs2KUr/rnN2cF3Z5WZ8TfCMP57pgdLK0AIrL1T3GWSQ1gId32eUpirERGSDGKFY/v
         i1UQ==
X-Gm-Message-State: AGRZ1gIOFbtwxTDSJ75l00pBDHYUIvUNcru6Sj9DqOl7whnEeNim0g6m
        qT4WV6Fqa+BTfVtcPZMRWxihog==
X-Google-Smtp-Source: AJdET5c+AfeQMduHXJyy0OY05zwR0t7Hs5iA74giJaPi5YklZ1ZN6UMpZ3OF+88e9RUSllFNsKlQPw==
X-Received: by 2002:a63:561b:: with SMTP id k27mr4590475pgb.271.1540579995569;
        Fri, 26 Oct 2018 11:53:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p7-v6sm15940835pfb.101.2018.10.26.11.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 11:53:15 -0700 (PDT)
Date:   Fri, 26 Oct 2018 11:53:14 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Add helper to set device address.
Message-ID: <20181026185314.GD22824@google.com>
References: <20181026140450.13172-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181026140450.13172-1-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 07:34:50PM +0530, Balakrishna Godavarthi wrote:
> This patch add qca_set_device_bdaddr() to set the device
> address for latest Qualcomm Bluetooth chipset wcn3990 and above.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c   | 21 +++++++++++++++++++++
>  drivers/bluetooth/btqca.h   |  9 ++++++++-
>  drivers/bluetooth/hci_qca.c |  5 ++++-
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index ec9e03a6b778..132dc6ceb174 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -391,6 +391,27 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  }
>  EXPORT_SYMBOL_GPL(qca_uart_setup);
>  
> +int qca_set_device_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)

nit: just qca_set_bdaddr() ? That would be consistent with
qca_set_bdaddr_rome() and ->set_bdaddr().

> +{
> +	struct sk_buff *skb;
> +	u8 cmd[6];

nit: this doesn't really contain the command (which is
EDL_WRITE_BD_ADDR_OPCODE). Name it 'buf', 'ba' or similar?

re-nit: in the memcpy below 'sizeof(bdaddr_t)' is used, do the same in
the declaration?

> +	int err;
> +
> +	memcpy(cmd, bdaddr, sizeof(bdaddr_t));
> +	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, sizeof(cmd),
> +				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
> +		return err;
> +	}
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qca_set_device_bdaddr);
> +
>  MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
>  MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
>  MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 0c01f375fe83..8771fc2b193d 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -20,6 +20,7 @@
>  
>  #define EDL_PATCH_CMD_OPCODE		(0xFC00)
>  #define EDL_NVM_ACCESS_OPCODE		(0xFC0B)
> +#define EDL_WRITE_BD_ADDR_OPCODE	(0xFC14)
>  #define EDL_PATCH_CMD_LEN		(1)
>  #define EDL_PATCH_VER_REQ_CMD		(0x19)
>  #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
> @@ -140,7 +141,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, u32 soc_ver);
>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
> -
> +int qca_set_device_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
>  #else
>  
>  static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> @@ -159,4 +160,10 @@ static inline int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int qca_set_device_bdaddr(struct hci_dev *hdev,
> +					const bdaddr_t *bdaddr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..f18d9f5a7782 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1241,7 +1241,10 @@ static int qca_setup(struct hci_uart *hu)
>  	}
>  
>  	/* Setup bdaddr */
> -	hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
> +	if (qcadev->btsoc_type == QCA_WCN3990)
> +		hu->hdev->set_bdaddr = qca_set_device_bdaddr;
> +	else
> +		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
>  
>  	return ret;
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
