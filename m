Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71055C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ED8217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfAVR3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:29:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:49432 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfAVR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:29:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 09:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,507,1539673200"; 
   d="scan'208";a="313854281"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jan 2019 09:29:19 -0800
Message-ID: <cbba45c70233bf72e90e9f13b203616f166f0a7d.camel@linux.intel.com>
Subject: Re: [PATCH v1] HID: intel-ish-hid: Switch to use new generic UUID
 API
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Tue, 22 Jan 2019 09:29:19 -0800
In-Reply-To: <20190110154804.89298-1-andriy.shevchenko@linux.intel.com>
References: <20190110154804.89298-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 17:48 +0200, Andy Shevchenko wrote:
> There are new types and helpers that are supposed to be used in new
> code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c |  3 +--
>  drivers/hid/intel-ish-hid/ishtp-hid.h        |  6 +++---
>  drivers/hid/intel-ish-hid/ishtp/bus.c        | 19 ++++++++--------
> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.h        |  4 ++--
>  drivers/hid/intel-ish-hid/ishtp/client.h     |  2 +-
>  drivers/hid/intel-ish-hid/ishtp/hbm.h        |  2 +-
>  6 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index e64243bc9c96..2246697ada1d 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -788,8 +788,7 @@ static int hid_ishtp_cl_probe(struct
> ishtp_cl_device *cl_device)
>  	if (!cl_device)
>  		return	-ENODEV;
>  
> -	if (uuid_le_cmp(hid_ishtp_guid,
> -			cl_device->fw_client->props.protocol_name) !=
> 0)
> +	if (!guid_equal(&hid_ishtp_guid, &cl_device->fw_client-
> >props.protocol_name))
>  		return	-ENODEV;
>  
>  	client_data = devm_kzalloc(&cl_device->dev,
> sizeof(*client_data),
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h
> b/drivers/hid/intel-ish-hid/ishtp-hid.h
> index f5c7eb79b7b5..1cd07a441cd4 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.h
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
> @@ -29,9 +29,9 @@
>  		client->cl_device->ishtp_dev, __VA_ARGS__)
>  
>  /* ISH Transport protocol (ISHTP in short) GUID */
> -static const uuid_le hid_ishtp_guid = UUID_LE(0x33AECD58, 0xB679,
> 0x4E54,
> -					      0x9B, 0xD9, 0xA0, 0x4D,
> 0x34,
> -					      0xF0, 0xC2, 0x26);
> +static const guid_t hid_ishtp_guid =
> +	GUID_INIT(0x33AECD58, 0xB679, 0x4E54,
> +		  0x9B, 0xD9, 0xA0, 0x4D, 0x34, 0xF0, 0xC2, 0x26);
>  
>  /* ISH HID message structure */
>  struct hostif_msg_hdr {
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 728dc6d4561a..1b6092b300fe 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -133,18 +133,15 @@ int ishtp_write_message(struct ishtp_device
> *dev, struct ishtp_msg_hdr *hdr,
>   *
>   * Return: fw client index or -ENOENT if not found
>   */
> -int ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const uuid_le
> *uuid)
> +int ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const guid_t
> *uuid)
>  {
> -	int i, res = -ENOENT;
> +	unsigned int i;
>  
>  	for (i = 0; i < dev->fw_clients_num; ++i) {
> -		if (uuid_le_cmp(*uuid, dev-
> >fw_clients[i].props.protocol_name)
> -				== 0) {
> -			res = i;
> -			break;
> -		}
> +		if (guid_equal(uuid, &dev-
> >fw_clients[i].props.protocol_name))
> +			return i;
>  	}
> -	return res;
> +	return -ENOENT;
>  }
>  EXPORT_SYMBOL(ishtp_fw_cl_by_uuid);
>  
> @@ -158,7 +155,7 @@ EXPORT_SYMBOL(ishtp_fw_cl_by_uuid);
>   * Return: pointer of client information on success, NULL on
> failure.
>   */
>  struct ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device
> *dev,
> -						const uuid_le *uuid)
> +					       const guid_t *uuid)
>  {
>  	int i;
>  	unsigned long flags;
> @@ -401,7 +398,7 @@ static const struct device_type
> ishtp_cl_device_type = {
>   * Return: ishtp_cl_device pointer or NULL on failure
>   */
>  static struct ishtp_cl_device *ishtp_bus_add_device(struct
> ishtp_device *dev,
> -						    uuid_le uuid, char
> *name)
> +						    guid_t uuid, char
> *name)
>  {
>  	struct ishtp_cl_device *device;
>  	int status;
> @@ -629,7 +626,7 @@ int ishtp_bus_new_client(struct ishtp_device
> *dev)
>  	int	i;
>  	char	*dev_name;
>  	struct ishtp_cl_device	*cl_device;
> -	uuid_le	device_uuid;
> +	guid_t	device_uuid;
>  
>  	/*
>  	 * For all reported clients, create an unconnected client and
> add its
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.h
> b/drivers/hid/intel-ish-hid/ishtp/bus.h
> index b8a5bcc82536..babf19ba3ff6 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.h
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.h
> @@ -112,8 +112,8 @@ void	ishtp_cl_driver_unregister(struct
> ishtp_cl_driver *driver);
>  
>  int	ishtp_register_event_cb(struct ishtp_cl_device *device,
>  				void (*read_cb)(struct ishtp_cl_device
> *));
> -int	ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const uuid_le
> *cuuid);
> +int	ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const guid_t
> *cuuid);
>  struct	ishtp_fw_client *ishtp_fw_cl_get_client(struct
> ishtp_device *dev,
> -						const uuid_le *uuid);
> +						const guid_t *uuid);
>  
>  #endif /* _LINUX_ISHTP_CL_BUS_H */
> diff --git a/drivers/hid/intel-ish-hid/ishtp/client.h
> b/drivers/hid/intel-ish-hid/ishtp/client.h
> index 042f4c4853b1..e0df3eb611e6 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/client.h
> +++ b/drivers/hid/intel-ish-hid/ishtp/client.h
> @@ -126,7 +126,7 @@ struct ishtp_cl {
>  };
>  
>  /* Client connection managenment internal functions */
> -int ishtp_can_client_connect(struct ishtp_device *ishtp_dev, uuid_le
> *uuid);
> +int ishtp_can_client_connect(struct ishtp_device *ishtp_dev, guid_t
> *uuid);
>  int ishtp_fw_cl_by_id(struct ishtp_device *dev, uint8_t client_id);
>  void ishtp_cl_send_msg(struct ishtp_device *dev, struct ishtp_cl
> *cl);
>  void recv_ishtp_cl_msg(struct ishtp_device *dev,
> diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.h
> b/drivers/hid/intel-ish-hid/ishtp/hbm.h
> index d96111cef7f8..7286e3600140 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/hbm.h
> +++ b/drivers/hid/intel-ish-hid/ishtp/hbm.h
> @@ -149,7 +149,7 @@ struct hbm_host_enum_response {
>  } __packed;
>  
>  struct ishtp_client_properties {
> -	uuid_le protocol_name;
> +	guid_t protocol_name;
>  	uint8_t protocol_version;
>  	uint8_t max_number_of_connections;
>  	uint8_t fixed_address;

