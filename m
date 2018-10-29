Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C062C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E4B2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E4B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeJ2Uqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:46:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:42563 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbeJ2Uqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:46:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 04:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="103423121"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 29 Oct 2018 04:58:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Oct 2018 13:58:13 +0200
Date:   Mon, 29 Oct 2018 13:58:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Tsai <lucas_tsai@richtek.com>,
        shufan_lee <shufan_lee@richtek.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH 08/10] usb: typec: Add support for usb role switch in
 rt1711h driver
Message-ID: <20181029115813.GA14534@kuha.fi.intel.com>
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-9-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027095820.40056-9-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 05:58:18PM +0800, Yu Chen wrote:
> This patch add struct device_connection to rt1711h driver to support
> find "usb-role-switch" in tcpm_register_port.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Lucas Tsai <lucas_tsai@richtek.com>
> Cc: shufan_lee <shufan_lee@richtek.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 017389021b96..5f8b952612fe 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -39,6 +39,7 @@ struct rt1711h_chip {
>  	struct tcpci_data data;
>  	struct tcpci *tcpci;
>  	struct device *dev;
> +	struct device_connection dev_conn;
>  };
>  
>  static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> @@ -237,6 +238,7 @@ static int rt1711h_probe(struct i2c_client *client,
>  {
>  	int ret;
>  	struct rt1711h_chip *chip;
> +	const char *dev_conn_end;
>  
>  	ret = rt1711h_check_revision(client);
>  	if (ret < 0) {
> @@ -254,6 +256,7 @@ static int rt1711h_probe(struct i2c_client *client,
>  		return PTR_ERR(chip->data.regmap);
>  
>  	chip->dev = &client->dev;
> +	dev_set_name(chip->dev, "rt1711h");
>  	i2c_set_clientdata(client, chip);
>  
>  	ret = rt1711h_sw_reset(chip);
> @@ -264,6 +267,15 @@ static int rt1711h_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = device_property_read_string(chip->dev, "dev-conn-end",
> +			&dev_conn_end);
> +	if (!ret) {
> +		chip->dev_conn.endpoint[0] = "rt1711h";
> +		chip->dev_conn.endpoint[1] = dev_conn_end;
> +		chip->dev_conn.id = "usb-role-switch";
> +		device_connection_add(&chip->dev_conn);
> +	}

That is wrong. You should not read name of a device from a property.

Regardless of that, I don't think this patch is needed at all. You
need to describe this kind connection with OF device graph
(Documentation/devicetree/bindings/graph.txt).

I've prepared a proposal how we should be able handle graphs in the
device connection API:
https://lkml.org/lkml/2018/10/24/613


thanks,

-- 
heikki
