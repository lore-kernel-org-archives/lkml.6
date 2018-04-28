Return-Path: <bjorn.andersson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524891043; cv=none;
        d=google.com; s=arc-20160816;
        b=SrPGs9MhRhTJr1EQXDpSzyXUTaowLdteJEPYjf5ggYAF2aHt0X/WgTZuIFo9I2WZNQ
         G83Cil+YFedkuvdlZLs4LmTdQJeICitJbQ1XQ2PcITyo2JB9ZO34xjX08TMt3rRXHk9l
         SlAubQBSlYc0IKbcLOQrpw9Qvi1SyPYbLe5FiOwWgyo95Av0esDihA0lzwTQd2Cos0NH
         1/6VCSzr1j0VB5rtT2z9YEZJ9vZAD+orCCodJ5EfQ9yzAc5t9fbwbr4GnOgwwEQBHu1O
         F9bcOOFEJu835ZPjL8l9HW8Zz5VvEyqVoQZVaBaq7lJPOyDhjpOGBmXK1rgCY/gd3Xm1
         aS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=hxULewjASFlfCTo43/znMqiKZh3pqcxUCwLc0nO2qQA=;
        b=Ekm2lMVFYrofJLNcMSQP9lXSCQg1DXEB+6qa7aB5tdK4lJmWGY3JZQ3LuX6J03OjzM
         LxCG4SJVKd/Cv08s++gcZM3dsmhhRedBuKSTY8pOQpI/uho+TvQKG7/xKtJe6WwbkrSN
         w3MLCFnfJo6/GrhrNTppsr2o8cdMLIp/b1/gnp5sCHrdT8jR6DF1UIuUHLCvWCOh518L
         Z8vco/3x3VtUHsufxRq6x0pFZ5M+Exm90pzHE+zsImcaDYHLqFmIGfAAcWYAQAb5yCV7
         MCoVU18uBwk792uFNtrPQotXZFh2I86FkZn2Xs22ky4i8j3qf5ooF2rvrdfYcy94lddt
         DyMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XE0fYLtq;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XE0fYLtq;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrDWjm7PbUxRwCdLZLclI2f4KUZ1fkSrz6bomOMjs4ljuyKWt0DutCevIxXBgcjtLz9lrouxw==
Date: Fri, 27 Apr 2018 21:51:55 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, broonie@kernel.org,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	robh+dt@kernel.org, bgoswami@codeaurora.org,
	gregkh@linuxfoundation.org, david.brown@linaro.org,
	mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org,
	tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Message-ID: <20180428045155.GA491@tuxbook-pro>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801756443527719?=
X-GMAIL-MSGID: =?utf-8?q?1598964151184295088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 26 Apr 02:45 PDT 2018, Srinivas Kandagatla wrote:
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
[..]
> +int apr_send_pkt(struct apr_device *adev, void *buf)

Sorry, but I think we have discussed this before?

"buf" isn't some random buffer to be sent, it is a apr_hdr followed by
some data. As such I think you should make this type struct apr_hdr *,
or if you think that doesn't imply there's payload make a type apr_pkt
that has a payload[] at the end.

It will make it obvious for both future readers and the compiler what
kind of data we're passing here.


This comment also applies to functions calling functions that calls
apr_send_pkt() as they too lug around a void *.

> +{
> +	struct apr *apr = dev_get_drvdata(adev->dev.parent);
> +	struct apr_hdr *hdr;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&adev->lock, flags);
> +
> +	hdr = (struct apr_hdr *)buf;
> +	hdr->src_domain = APR_DOMAIN_APPS;
> +	hdr->src_svc = adev->svc_id;
> +	hdr->dest_domain = adev->domain_id;
> +	hdr->dest_svc = adev->svc_id;
> +
> +	ret = rpmsg_trysend(apr->ch, buf, hdr->pkt_size);
> +	if (ret) {
> +		dev_err(&adev->dev, "Unable to send APR pkt %d\n",
> +			hdr->pkt_size);

Afaict all callers of this function will print an error message,
sometimes on more than one level in the stack. And if some code path
does retry sending you will get a printout for each attempt, even though
the caller is fine with it.

I would recommend unlocking the spinlock and then do:

	return ret ? : hdr->pkt_size;

> +	} else {
> +		ret = hdr->pkt_size;
> +	}
> +
> +	spin_unlock_irqrestore(&adev->lock, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(apr_send_pkt);
> +
> +static void apr_dev_release(struct device *dev)
> +{
> +	struct apr_device *adev = to_apr_device(dev);
> +
> +	kfree(adev);
> +}
> +
> +static int apr_callback(struct rpmsg_device *rpdev, void *buf,
> +				  int len, void *priv, u32 addr)
> +{
> +	struct apr *apr = dev_get_drvdata(&rpdev->dev);
> +	struct apr_client_message data;
> +	struct apr_device *p, *c_svc = NULL;
> +	struct apr_driver *adrv = NULL;
> +	struct apr_hdr *hdr;
> +	unsigned long flags;
> +	uint16_t hdr_size;
> +	uint16_t msg_type;
> +	uint16_t ver;
> +	uint16_t svc;
> +
> +	if (len <= APR_HDR_SIZE) {
> +		dev_err(apr->dev, "APR: Improper apr pkt received:%p %d\n",
> +			buf, len);
> +		return -EINVAL;
> +	}
> +
> +	hdr = buf;
> +	ver = APR_HDR_FIELD_VER(hdr->hdr_field);
> +	if (ver > APR_PKT_VER + 1)
> +		return -EINVAL;
> +
> +	hdr_size = APR_HDR_FIELD_SIZE_BYTES(hdr->hdr_field);
> +	if (hdr_size < APR_HDR_SIZE) {
> +		dev_err(apr->dev, "APR: Wrong hdr size:%d\n", hdr_size);
> +		return -EINVAL;
> +	}
> +
> +	if (hdr->pkt_size < APR_HDR_SIZE) {

I think it would be nice to make sure that hdr->pkt_size is < len as
well, to reject messages that larger than the incoming buffer.

The pkt_size should be in the ballpark of len, could this check be
changed to hdr->pkt_size != len?

> +		dev_err(apr->dev, "APR: Wrong paket size\n");
> +		return -EINVAL;
> +	}
> +
> +	msg_type = APR_HDR_FIELD_MT(hdr->hdr_field);
> +	if (msg_type >= APR_MSG_TYPE_MAX && msg_type != APR_BASIC_RSP_RESULT) {
> +		dev_err(apr->dev, "APR: Wrong message type: %d\n", msg_type);
> +		return -EINVAL;
> +	}
> +
> +	if (hdr->src_domain >= APR_DOMAIN_MAX ||
> +			hdr->dest_domain >= APR_DOMAIN_MAX ||
> +			hdr->src_svc >= APR_SVC_MAX ||
> +			hdr->dest_svc >= APR_SVC_MAX) {
> +		dev_err(apr->dev, "APR: Wrong APR header\n");
> +		return -EINVAL;
> +	}
> +
> +	svc = hdr->dest_svc;
> +	spin_lock_irqsave(&apr->svcs_lock, flags);
> +	list_for_each_entry(p, &apr->svcs, node) {

Rather than doing a O(n) search for the svc with svc_id you could use a
idr or a radix_tree to keep the id -> svc mapping.

> +		if (svc == p->svc_id) {
> +			c_svc = p;
> +			if (c_svc->dev.driver)
> +				adrv = to_apr_driver(c_svc->dev.driver);
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&apr->svcs_lock, flags);
> +
> +	if (!adrv) {
> +		dev_err(apr->dev, "APR: service is not registered\n");
> +		return -EINVAL;
> +	}
> +
> +	data.payload_size = hdr->pkt_size - hdr_size;
> +	data.opcode = hdr->opcode;
> +	data.src_port = hdr->src_port;
> +	data.dest_port = hdr->dest_port;
> +	data.token = hdr->token;
> +	data.msg_type = msg_type;
> +
> +	if (data.payload_size > 0)
> +		data.payload = buf + hdr_size;
> +

Making a verbatim copy of parts of the hdr and then passing that to the
APR devices creates an asymmetry in the send/callback API, without a
whole lot of benefits. I would prefer that you introduce the apr_pkt, as
described above, and once you have validated the size et al and found
the service you just pass it along.

> +	adrv->callback(c_svc, &data);
> +
> +	return 0;
> +}
[..]
> +static int apr_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct apr_device *adev = to_apr_device(dev);
> +	int ret;
> +
> +	ret = of_device_uevent_modalias(dev, env);
> +	if (ret != -ENODEV)
> +		return ret;
> +
> +	return add_uevent_var(env, "MODALIAS= apr:%s", adev->name);

No space between '=' and "apr".

> +}
> +
> +struct bus_type aprbus = {
> +	.name		= "aprbus",

Most busses doesn't have "bus" in the name.

> +	.match		= apr_device_match,
> +	.probe		= apr_device_probe,
> +	.uevent		= apr_uevent,
> +	.remove		= apr_device_remove,
> +};
> +EXPORT_SYMBOL_GPL(aprbus);
> +
> +static int apr_add_device(struct device *dev, struct device_node *np,
> +			  const struct apr_device_id *id)
> +{
> +	struct apr *apr = dev_get_drvdata(dev);
> +	struct apr_device *adev = NULL;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&adev->lock);
> +
> +	adev->svc_id = id->svc_id;
> +	adev->domain_id = id->domain_id;
> +	adev->version = id->svc_version;
> +	if (np)
> +		strncpy(adev->name, np->name, APR_NAME_SIZE);
> +	else
> +		strncpy(adev->name, id->name, APR_NAME_SIZE);
> +
> +	dev_set_name(&adev->dev, "aprsvc:%s:%x:%x", adev->name,
> +		     id->domain_id, id->svc_id);
> +
> +	adev->dev.bus = &aprbus;
> +	adev->dev.parent = dev;
> +	adev->dev.of_node = np;
> +	adev->dev.release = apr_dev_release;
> +	adev->dev.driver = NULL;
> +
> +	spin_lock(&apr->svcs_lock);
> +	list_add_tail(&adev->node, &apr->svcs);
> +	spin_unlock(&apr->svcs_lock);
> +
> +	dev_info(dev, "Adding APR dev: %s\n", dev_name(&adev->dev));
> +
> +	return device_register(&adev->dev);

If this fails you must call put_device(&adev->dev);

> +}
> +
> +static void of_register_apr_devices(struct device *dev)
> +{
> +	struct apr *apr = dev_get_drvdata(dev);
> +	struct device_node *node;
> +
> +	for_each_child_of_node(dev->of_node, node) {
> +		struct apr_device_id id = { {0} };
> +
> +		if (of_property_read_u32(node, "reg", &id.svc_id))
> +			continue;
> +
> +		id.domain_id = apr->dest_domain_id;
> +
> +		if (apr_add_device(dev, node, &id))
> +			dev_err(dev, "Failed to add arp %d svc\n", id.svc_id);
> +	}
> +}
[..]
> +
> +static int __init apr_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&aprbus);
> +	if (!ret)
> +		ret = register_rpmsg_driver(&apr_driver);

bus_unregister() if ret here.

> +
> +	return ret;
> +}
> +

Regards,
Bjorn
