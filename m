Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AG47ELspcyOZiRig2dTDyMyqRR2moPzj8NdbDbeoOvnqmLuL4dD6aGeBysFO+mFRnHZ4yoJROKSk
ARC-Seal: i=1; a=rsa-sha256; t=1520259139; cv=none;
        d=google.com; s=arc-20160816;
        b=B4eoY7fOOpBW/7ZfJRUgkY5Wj75q+F1SCfWUVGLHdlCicvX64Qm1WHvtgFmw4XVCQ+
         RGYOm663iXoUX129o9zevlNS6uZOzGt3j09DQvcIOplyuEyfrTJQgkxOxbikbkTFnOhQ
         /4PjZNEMQHFnfEFhAtVzaNHPR9kUZpAqvkz9MjDxfbr0E6PxnmrNVfaI7lSjdUgLXtxe
         AT3yFelkPVMnibwFkrM6R4FZgFHzv8W1WhsmDntNep4SL/nEt8zwczCpu5+YGdTSay+O
         ul1w3E9KFxQVpA938HjFcxpWSoP7HduFzIWMCy2vNvF4B1uqKHMAVPZV4c6jR60RqeJR
         E/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=E//JgVDEdxGlNGFaI7c5S3ZF1By4UpMaa1X+EfqXHOI=;
        b=ivkuTzCR6oCkZstPNOaoYTefntDpcHQTjqR0e9P51MNM62A2gaZzLHcv2/fIuqCmj+
         +WjCOEXudAfnc2Kutu1CD6f3Pg3D94vqLL+mqnhmKtAE0zOKEcs8Vu2REsSL7by5dJo8
         9P+JoeQkFEagAE7kx/3aXRDs3beP5fR84Vg+G1ED1nTJxfb1cDyzK+P5t2F7waAv3LSQ
         BLhRWTanY3DiSA2/ePAU7jkyLihKN9EV5ddRuHAxYpfJeHk6FnSYONCZiKZ5je8uYBdJ
         lt728VY2Ll1k8zutTILRHsxoFhxRpvYPr0fad1u/vDd6GFxPLzCBcUZJBKvmONYQPdsu
         HEMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Mon, 5 Mar 2018 14:11:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: ALKML <linux-arm-kernel@lists.infradead.org>, LKML
	<linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "Alexey
 Klimov" <klimov.linux@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 04/20] firmware: arm_scmi: add common infrastructure
 and support for base protocol
Message-ID: <20180305151154.000051c2@huawei.com>
In-Reply-To: <1519403030-21189-5-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
	<1519403030-21189-5-git-send-email-sudeep.holla@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209578298526460?=
X-GMAIL-MSGID: =?utf-8?q?1594107247614189877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 16:23:34 +0000
Sudeep Holla <sudeep.holla@arm.com> wrote:

> The base protocol describes the properties of the implementation and
> provide generic error management. The base protocol provides commands
> to describe protocol version, discover implementation specific
> attributes and vendor/sub-vendor identification, list of protocols
> implemented and the various agents are in the system including OSPM
> and the platform. It also supports registering for notifications of
> platform errors.
> 
> This protocol is mandatory. This patch adds support for the same along
> with some basic infrastructure to add support for other protocols.
> 
<snip>

Minor comments inline.

> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index fa0e9cf31f4c..ba784b8ec170 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -105,21 +105,27 @@ struct scmi_desc {
>   * @dev: Device pointer
>   * @desc: SoC description for this instance
>   * @handle: Instance of SCMI handle to send to clients
> + * @version: SCMI revision information containing protocol version,
> + *	implementation version and (sub-)vendor identification.
>   * @cl: Mailbox Client
>   * @tx_chan: Transmit mailbox channel
>   * @tx_payload: Transmit mailbox channel payload area
>   * @minfo: Message info
> + * @protocols_imp: list of protocols implemented, currently maximum of
> + *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
If it is fixed size, is there a benefit in not just putting it in here
as a fixed size array and simplifying the allocation?

>   * @node: list head
>   * @users: Number of users of this instance
>   */
>  struct scmi_info {
>  	struct device *dev;
>  	const struct scmi_desc *desc;
> +	struct scmi_revision_info version;
>  	struct scmi_handle handle;
>  	struct mbox_client cl;
>  	struct mbox_chan *tx_chan;
>  	void __iomem *tx_payload;
>  	struct scmi_xfers_info minfo;
> +	u8 *protocols_imp;
>  	struct list_head node;
>  	int users;
>  };
> @@ -433,6 +439,45 @@ int scmi_one_xfer_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
>  }
>  
>  /**
> + * scmi_version_get() - command to get the revision of the SCMI entity
> + *
> + * @handle: Handle to SCMI entity information
> + *
> + * Updates the SCMI information in the internal data structure.
> + *
> + * Return: 0 if all went fine, else return appropriate error.
> + */
> +int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
> +		     u32 *version)
> +{
> +	int ret;
> +	__le32 *rev_info;
> +	struct scmi_xfer *t;
> +
> +	ret = scmi_one_xfer_init(handle, PROTOCOL_VERSION, protocol, 0,
> +				 sizeof(*version), &t);
> +	if (ret)
> +		return ret;
> +
> +	ret = scmi_do_xfer(handle, t);
> +	if (!ret) {
> +		rev_info = t->rx.buf;
> +		*version = le32_to_cpu(*rev_info);
> +	}
> +
> +	scmi_one_xfer_put(handle, t);
blank line before all simple returns is common kernel coding style
and does help for readability (a little bit)

> +	return ret;
> +}
> +
> +void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
> +				     u8 *prot_imp)
> +{
> +	struct scmi_info *info = handle_to_scmi_info(handle);
> +
> +	info->protocols_imp = prot_imp;
> +}
> +
> +/**
>   * scmi_handle_get() - Get the  SCMI handle for a device
>   *
>   * @dev: pointer to device for which we want SCMI handle
> @@ -660,11 +705,19 @@ static int scmi_probe(struct platform_device *pdev)
>  
>  	handle = &info->handle;
>  	handle->dev = info->dev;
> +	handle->version = &info->version;
>  
>  	ret = scmi_mbox_chan_setup(info);
>  	if (ret)
>  		return ret;
>  
> +	ret = scmi_base_protocol_init(handle);
> +	if (ret) {
> +		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
> +		scmi_mbox_free_channel(info);
> +		return ret;
> +	}
> +
>  	mutex_lock(&scmi_list_mutex);
>  	list_add_tail(&info->node, &scmi_list);
>  	mutex_unlock(&scmi_list_mutex);
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 854ed2479993..664da3d763f2 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -17,11 +17,48 @@
>   */
>  #include <linux/types.h>
>  
> +#define SCMI_MAX_STR_SIZE	16
> +
> +/**
> + * struct scmi_revision_info - version information structure
This isn't really just the version stuff. It's more about discovery
of what is present.
Perhaps the naming could make that clear if you want to keep this
as one structure?

> + *
> + * @major_ver: Major ABI version. Change here implies risk of backward
> + *	compatibility break.
> + * @minor_ver: Minor ABI version. Change here implies new feature addition,
> + *	or compatible change in ABI.
> + * @num_protocols: Number of protocols that are implemented, excluding the
> + *	base protocol.
> + * @num_agents: Number of agents in the system.
> + * @impl_ver: A vendor-specific implementation version.
> + * @vendor_id: A vendor identifier(Null terminated ASCII string)
> + * @sub_vendor_id: A sub-vendor identifier(Null terminated ASCII string)
> + */
> +struct scmi_revision_info {
> +	u16 major_ver;
> +	u16 minor_ver;
> +	u8 num_protocols;
> +	u8 num_agents;
> +	u32 impl_ver;
> +	char vendor_id[SCMI_MAX_STR_SIZE];
> +	char sub_vendor_id[SCMI_MAX_STR_SIZE];
> +};
> +
>  /**
>   * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
>   *
>   * @dev: pointer to the SCMI device
> + * @version: pointer to the structure containing SCMI version information
>   */
>  struct scmi_handle {
>  	struct device *dev;
> +	struct scmi_revision_info *version;
> +};
> +
> +enum scmi_std_protocol {
> +	SCMI_PROTOCOL_BASE = 0x10,
> +	SCMI_PROTOCOL_POWER = 0x11,
> +	SCMI_PROTOCOL_SYSTEM = 0x12,
> +	SCMI_PROTOCOL_PERF = 0x13,
> +	SCMI_PROTOCOL_CLOCK = 0x14,
> +	SCMI_PROTOCOL_SENSOR = 0x15,
>  };
