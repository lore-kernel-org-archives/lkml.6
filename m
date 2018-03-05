Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AG47ELtIpsjcdqz2J+oVweWXNcYjrM6LuGGA0BjyK/ZPRLclzChyAS2PwZTftEuUm5DeE/KaA7Fe
ARC-Seal: i=1; a=rsa-sha256; t=1520260584; cv=none;
        d=google.com; s=arc-20160816;
        b=XDuDI4i2wW0g4KYmUBrjpfZsrVTDfrv8fuqocinDoqH9Obxkd9XtSPQ+Z1vyikJY7I
         tSW7qHeZwnjed15FpVFItFdGGI/Gd5Whb9ZaXoVuZl3LxoItwUcWe+zfSEY/f52py7WW
         uz7ip4vz5SlJqzPLqmm8rp5kFKe8sa69h79IXFL1NAopkSOPnsU7v6ke6ta/2+/S6V6G
         Ho8fHNG7Ruij1NFYl9NWx8cIxbo3P0DHPDs6jr/V3QSbv82r7WM+sfe78hco6pquovM7
         mgGvriZDy4j1m+ceHBg+e2IXgIx9hSSSS7lFKsl4IGnsk7IvE1rsa4Ecl3LhY0Ubx/VC
         a8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=8mXzSlo5f46m7Op1IClAgQjxyoq/ORANxmbdJ7fDERg=;
        b=fSFSbYCboPSB9obZnCckjAcOUBFboffsMcA0KHZiDEOCQwrCTwqmr8cS7OkqDCpYz5
         ClPeSydUqFC0CoZnJXv+mDjPfp8q/nVAEq+zMTDgSyfVrZibV6svLSu7xhml/UeXSG5w
         ezWIU9z7kgQHBHBhfnYbg+28a3sciqNhD2mi7PnNnEfxxI7LxCpbCmLv4WAsL4jSEVJ8
         DBjiMDqTTnUBim9+3ZQXOH2qzNmbsmE0m2kCaL4sSCbhTDHtSJDVn5GubclrLFxzb1jK
         ScBwM7XoDn6nJruHM3N56lMqBOJvj1h7uG3nZc9nonteOqfhCB2I2zgR6RO4kceJlaTG
         WDfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Mon, 5 Mar 2018 14:35:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: ALKML <linux-arm-kernel@lists.infradead.org>, LKML
	<linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "Alexey
 Klimov" <klimov.linux@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 13/20] firmware: arm_scmi: refactor in preparation to
 support per-protocol channels
Message-ID: <20180305153549.00000f39@huawei.com>
In-Reply-To: <1519403030-21189-14-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
	<1519403030-21189-14-git-send-email-sudeep.holla@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209592530957527?=
X-GMAIL-MSGID: =?utf-8?q?1594108762825120639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 16:23:43 +0000
Sudeep Holla <sudeep.holla@arm.com> wrote:

> In order to support per-protocol channels if available, we need to
> factor out all the mailbox channel information(Tx/Rx payload and
> channel handle) out of the main SCMI instance information structure.
> 
> This patch refactors the existing channel information into a separate
> chan_info structure.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
A little odd to present a series to mainline that does a fairly important
refactor mid way through.  Why not push this down to the start and always support
the separate chan_info structure?

> ---
>  drivers/firmware/arm_scmi/driver.c | 90 ++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index e6698629e15a..a9e3f4c46b78 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -102,6 +102,22 @@ struct scmi_desc {
>  };
>  
>  /**
> + * struct scmi_chan_info - Structure representing a SCMI channel informfation
> + *
> + * @cl: Mailbox Client
> + * @chan: Transmit/Receive mailbox channel
> + * @payload: Transmit/Receive mailbox channel payload area
> + * @dev: Reference to device in the SCMI hierarchy corresponding to this
> + *	 channel
> + */
> +struct scmi_chan_info {
> +	struct mbox_client cl;
> +	struct mbox_chan *chan;
> +	void __iomem *payload;
> +	struct device *dev;
> +};
> +
> +/**
>   * struct scmi_info - Structure representing a  SCMI instance
>   *
>   * @dev: Device pointer
> @@ -109,10 +125,8 @@ struct scmi_desc {
>   * @handle: Instance of SCMI handle to send to clients
>   * @version: SCMI revision information containing protocol version,
>   *	implementation version and (sub-)vendor identification.
> - * @cl: Mailbox Client
> - * @tx_chan: Transmit mailbox channel
> - * @tx_payload: Transmit mailbox channel payload area
>   * @minfo: Message info
> + * @tx_cinfo: Reference to SCMI channel information
>   * @protocols_imp: list of protocols implemented, currently maximum of
>   *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
>   * @node: list head
> @@ -123,16 +137,14 @@ struct scmi_info {
>  	const struct scmi_desc *desc;
>  	struct scmi_revision_info version;
>  	struct scmi_handle handle;
> -	struct mbox_client cl;
> -	struct mbox_chan *tx_chan;
> -	void __iomem *tx_payload;
>  	struct scmi_xfers_info minfo;
> +	struct scmi_chan_info *tx_cinfo;
>  	u8 *protocols_imp;
>  	struct list_head node;
>  	int users;
>  };
>  
> -#define client_to_scmi_info(c)	container_of(c, struct scmi_info, cl)
> +#define client_to_scmi_chan_info(c) container_of(c, struct scmi_chan_info, cl)
>  #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
>  
>  /*
> @@ -215,10 +227,11 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
>  {
>  	u16 xfer_id;
>  	struct scmi_xfer *xfer;
> -	struct scmi_info *info = client_to_scmi_info(cl);
> +	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
> +	struct device *dev = cinfo->dev;
> +	struct scmi_info *info = dev_get_drvdata(dev);
>  	struct scmi_xfers_info *minfo = &info->minfo;
> -	struct device *dev = info->dev;
> -	struct scmi_shared_mem __iomem *mem = info->tx_payload;
> +	struct scmi_shared_mem __iomem *mem = cinfo->payload;
>  
>  	xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
>  
> @@ -269,8 +282,8 @@ static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
>  static void scmi_tx_prepare(struct mbox_client *cl, void *m)
>  {
>  	struct scmi_xfer *t = m;
> -	struct scmi_info *info = client_to_scmi_info(cl);
> -	struct scmi_shared_mem __iomem *mem = info->tx_payload;
> +	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
> +	struct scmi_shared_mem __iomem *mem = cinfo->payload;
>  
>  	/* Mark channel busy + clear error */
>  	iowrite32(0x0, &mem->channel_status);
> @@ -349,27 +362,27 @@ void scmi_one_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  }
>  
>  static bool
> -scmi_xfer_poll_done(const struct scmi_info *info, struct scmi_xfer *xfer)
> +scmi_xfer_poll_done(const struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
>  {
> -	struct scmi_shared_mem *mem = info->tx_payload;
> -	u16 xfer_id = MSG_XTRACT_TOKEN(le32_to_cpu(mem->msg_header));
> +	struct scmi_shared_mem __iomem *mem = cinfo->payload;
> +	u16 xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
>  
>  	if (xfer->hdr.seq != xfer_id)
>  		return false;
>  
> -	return le32_to_cpu(mem->channel_status) &
> +	return ioread32(&mem->channel_status) &
>  		(SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
>  		SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
>  }
>  
>  #define SCMI_MAX_POLL_TO_NS	(100 * NSEC_PER_USEC)
>  
> -static bool scmi_xfer_done_no_timeout(const struct scmi_info *info,
> +static bool scmi_xfer_done_no_timeout(const struct scmi_chan_info *cinfo,
>  				      struct scmi_xfer *xfer, ktime_t stop)
>  {
>  	ktime_t __cur = ktime_get();
>  
> -	return scmi_xfer_poll_done(info, xfer) || ktime_after(__cur, stop);
> +	return scmi_xfer_poll_done(cinfo, xfer) || ktime_after(__cur, stop);
>  }
>  
>  /**
> @@ -388,8 +401,9 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  	int timeout;
>  	struct scmi_info *info = handle_to_scmi_info(handle);
>  	struct device *dev = info->dev;
> +	struct scmi_chan_info *cinfo = info->tx_cinfo;
>  
> -	ret = mbox_send_message(info->tx_chan, xfer);
> +	ret = mbox_send_message(cinfo->chan, xfer);
>  	if (ret < 0) {
>  		dev_dbg(dev, "mbox send fail %d\n", ret);
>  		return ret;
> @@ -401,10 +415,10 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  	if (xfer->hdr.poll_completion) {
>  		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
>  
> -		spin_until_cond(scmi_xfer_done_no_timeout(info, xfer, stop));
> +		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
>  
>  		if (ktime_before(ktime_get(), stop))
> -			scmi_fetch_response(xfer, info->tx_payload);
> +			scmi_fetch_response(xfer, cinfo->payload);
>  		else
>  			ret = -ETIMEDOUT;
>  	} else {
> @@ -426,7 +440,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  	 * Unfortunately, we have to kick the mailbox framework after we have
>  	 * received our message.
>  	 */
> -	mbox_client_txdone(info->tx_chan, ret);
> +	mbox_client_txdone(cinfo->chan, ret);
>  
>  	return ret;
>  }
> @@ -654,11 +668,11 @@ static int scmi_mailbox_check(struct device_node *np)
>  	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
>  }
>  
> -static int scmi_mbox_free_channel(struct scmi_info *info)
> +static int scmi_mbox_free_channel(struct scmi_chan_info *cinfo)
>  {
> -	if (!IS_ERR_OR_NULL(info->tx_chan)) {
> -		mbox_free_channel(info->tx_chan);
> -		info->tx_chan = NULL;
> +	if (!IS_ERR_OR_NULL(cinfo->chan)) {
> +		mbox_free_channel(cinfo->chan);
> +		cinfo->chan = NULL;
>  	}
>  
>  	return 0;
> @@ -678,7 +692,7 @@ static int scmi_remove(struct platform_device *pdev)
>  
>  	if (!ret)
>  		/* Safe to free channels since no more users */
> -		return scmi_mbox_free_channel(info);
> +		return scmi_mbox_free_channel(info->tx_cinfo);
>  
>  	return ret;
>  }
> @@ -690,9 +704,17 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
>  	resource_size_t size;
>  	struct device *dev = info->dev;
>  	struct device_node *shmem, *np = dev->of_node;
> +	struct scmi_chan_info *cinfo;
>  	struct mbox_client *cl;
>  
> -	cl = &info->cl;
> +	cinfo = devm_kzalloc(info->dev, sizeof(*cinfo), GFP_KERNEL);
> +	if (!cinfo)
> +		return -ENOMEM;
> +
> +	info->tx_cinfo = cinfo;
> +	cinfo->dev = dev;
> +
> +	cl = &cinfo->cl;
>  	cl->dev = dev;
>  	cl->rx_callback = scmi_rx_callback;
>  	cl->tx_prepare = scmi_tx_prepare;
> @@ -708,16 +730,16 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
>  	}
>  
>  	size = resource_size(&res);
> -	info->tx_payload = devm_ioremap(dev, res.start, size);
> -	if (!info->tx_payload) {
> +	cinfo->payload = devm_ioremap(info->dev, res.start, size);
> +	if (!cinfo->payload) {
>  		dev_err(dev, "failed to ioremap SCMI Tx payload\n");
>  		return -EADDRNOTAVAIL;
>  	}
>  
>  	/* Transmit channel is first entry i.e. index 0 */
> -	info->tx_chan = mbox_request_channel(cl, 0);
> -	if (IS_ERR(info->tx_chan)) {
> -		ret = PTR_ERR(info->tx_chan);
> +	cinfo->chan = mbox_request_channel(cl, 0);
> +	if (IS_ERR(cinfo->chan)) {
> +		ret = PTR_ERR(cinfo->chan);
>  		if (ret != -EPROBE_DEFER)
>  			dev_err(dev, "failed to request SCMI Tx mailbox\n");
>  		return ret;
> @@ -785,7 +807,7 @@ static int scmi_probe(struct platform_device *pdev)
>  	ret = scmi_base_protocol_init(handle);
>  	if (ret) {
>  		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> -		scmi_mbox_free_channel(info);
> +		scmi_mbox_free_channel(info->tx_cinfo);
>  		return ret;
>  	}
>  
