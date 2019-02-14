Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DB8222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438769AbfBNNJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:09:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:45452 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438756AbfBNNJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:09:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 05:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="299716275"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2019 05:09:42 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1guGlo-0003Re-Gz; Thu, 14 Feb 2019 15:09:40 +0200
Date:   Thu, 14 Feb 2019 15:09:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     rdunlap@infradead.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guiding Li <liguiding@pinecone.net>
Subject: Re: [PATCH V2 2/2] rpmsg: add syslog redirection driver
Message-ID: <20190214130940.GV9224@smile.fi.intel.com>
References: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
 <1550124158-1111-2-git-send-email-xiaoxiang@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550124158-1111-2-git-send-email-xiaoxiang@xiaomi.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 02:02:38PM +0800, Xiang Xiao wrote:
> From: Guiding Li <liguiding@pinecone.net>
> 
> This driver allows the remote processor to redirect the output of
> syslog or printf into the kernel log, which is very useful to see
> what happen in the remote side.

> +struct rpmsg_syslog_header {
> +	u32				command;
> +	s32				result;
> +} __packed;

Isn't packed already?

> +struct rpmsg_syslog_transfer {
> +	struct rpmsg_syslog_header	header;
> +	u32				count;
> +	char				data[0];
> +} __packed;

Ditto.

> +static int rpmsg_syslog_callback(struct rpmsg_device *rpdev,
> +				 void *data, int len, void *priv_, u32 src)
> +{
> +	struct rpmsg_syslog *priv = dev_get_drvdata(&rpdev->dev);
> +	struct rpmsg_syslog_transfer *msg = data;
> +	struct rpmsg_syslog_transfer_done done;
> +	unsigned int copied = msg->count;
> +	unsigned int printed = 0;
> +	const char *nl;
> +
> +	if (msg->header.command != RPMSG_SYSLOG_TRANSFER)
> +		return -EINVAL;
> +
> +	/* output the message before '\n' to the kernel log */
> +	nl = memrchr(msg->data, '\n', msg->count);

Hmm... To me it sounds somehow fragile.

If your text contains binary data, how can you guarantee that it would be not
in the middle of two \n:s? OTOH, if it text data, why do you need to take all
strings at once? It might be worse from performance prospective (if you know
how and when printk() supplies buffer to the console).

> +	if (nl) {
> +		printed = nl + 1 - msg->data;
> +		copied = msg->count - printed;
> +
> +		if (priv->next) {
> +			pr_info("%.*s%.*s", priv->next,
> +				priv->buf, printed, msg->data);
> +			priv->next = 0;
> +		} else {
> +			pr_info("%.*s", printed, msg->data);
> +		}
> +	}
> +
> +	/* append the message after '\n' to the buffer */

> +	if (copied != 0) {



> +		unsigned int newsize = priv->next + copied;
> +
> +		if (newsize > priv->size) {
> +			char *newbuf;
> +
> +			newbuf = krealloc(priv->buf, newsize, GFP_KERNEL);
> +			if (newbuf) {
> +				priv->buf  = newbuf;
> +				priv->size = newsize;
> +			} else {
> +				copied = priv->size - priv->next;
> +			}
> +		}
> +

> +		strncpy(priv->buf + priv->next, msg->data + printed, copied);

Hmm... shouldn't be memcpy()?

> +		priv->next += copied;
> +	}
> +
> +	done.command = RPMSG_SYSLOG_TRANSFER_DONE;
> +	done.result  = printed + copied;
> +	return rpmsg_send(rpdev->ept, &done, sizeof(done));
> +}
> +
> +static int rpmsg_syslog_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_syslog *priv;
> +
> +	priv = devm_kzalloc(&rpdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&rpdev->dev, priv);
> +	return 0;
> +}
> +
> +static void rpmsg_syslog_remove(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_syslog *priv = dev_get_drvdata(&rpdev->dev);
> +

> +	/* flush the buffered log if need */
> +	if (priv->next)
> +		pr_info("%.*s\n", priv->next, priv->buf);
> +	kfree(priv->buf);

I don't see how it's serialized. Does rpmsg core take care of this?

> +}

> +#ifdef CONFIG_PM_SLEEP

You can consider to use __maybe_unused annotation to the below function.

> +static int rpmsg_syslog_dev_suspend(struct device *dev)
> +{

> +}
> +
> +static int rpmsg_syslog_dev_resume(struct device *dev)
> +{

> +}
> +#endif

> +static const struct rpmsg_device_id rpmsg_syslog_id_table[] = {
> +	{ .name = "rpmsg-syslog" },
> +	{ },

Terminator better without comma.

> +};

-- 
With Best Regards,
Andy Shevchenko


