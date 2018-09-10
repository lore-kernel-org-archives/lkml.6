Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892CA206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwW2/7jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892CA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeIJMZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:25:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33775 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbeIJMZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:25:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id r1-v6so4650152wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogDjTx0Tfu9DKOoIXA+5Uu8n53a4yKyiIn47VB9Grig=;
        b=CwW2/7jSG3IRrDtJBtgEgciOHvuxBwmD39e3hsDnSPV5IyHKt2bJjElNg8sYw/qHHh
         H9/S2Pdmu2Re1OLOZK4aPr75N6jaPwyB2f2sLLN/y64ecLM4HT7q7muIUQhmEGvTySf5
         gIKTWPqFyNJvBGL1VJrDL0ZELsGeSaZVOGPqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogDjTx0Tfu9DKOoIXA+5Uu8n53a4yKyiIn47VB9Grig=;
        b=pkvJXKePqU3/cAhvlL0woaKNEmyUJzK2hgYwVlhTHP4BwXYN7LlqdDo4OnHnf5UJC3
         MwoVUslGQwg4LRnat0RduXFni60hVobqQQ2XJ17Zc8eXyCkcnzmXkttDuv4RtC+vz/+t
         uQEEXM60nVM+/dgOJOs/gQwuaOb1PHw5kZViFPYbWOkuIa84B/f/eOy/eVlpFpri8RBf
         zEdxExCcSSZXUA1QW56z+9DcAt/pcR39DU1Wz75SJ9BtPwIy4+lLCyoXoxhYB7uS17bt
         I69ygjm+HLN45YBvNO0Z5RFCi8ctq3t51GA2vLn6Ur7kdTADClZATQJOFRak9Zv69Hcf
         AkXA==
X-Gm-Message-State: APzg51CwinR6Oajb3UGowDbvF0L+X+HpKQcVl+NyxpfZQmGTZs6tNMV3
        qRK1OHFjiiZuzSZKpihnU7ggzg==
X-Google-Smtp-Source: ANB0VdZdQ9NdJq6/YrRBrkpodOwUgJ8XgoxAg8Mhk8jqNoi2mjythsBxydSqSwQe+jVVnvpPl9lnHw==
X-Received: by 2002:a1c:46c4:: with SMTP id t187-v6mr10864045wma.158.1536564751459;
        Mon, 10 Sep 2018 00:32:31 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id d22-v6sm35467255wra.80.2018.09.10.00.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:32:30 -0700 (PDT)
Subject: Re: [PATCH v2 13/16] nvmem: add support for cell lookups from machine
 code
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-14-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
Date:   Mon, 10 Sep 2018 08:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180907100750.14564-14-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/18 11:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a way for machine code users to associate devices with nvmem cells.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c          | 143 +++++++++++++++++++++++++++-------
>   include/linux/nvmem-machine.h |  16 ++++
>   2 files changed, 132 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index da7a9d5beb33..9e2f9c993a07 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
>   static DEFINE_MUTEX(nvmem_cell_mutex);
>   static LIST_HEAD(nvmem_cell_tables);
>   
> +static DEFINE_MUTEX(nvmem_lookup_mutex);
> +static LIST_HEAD(nvmem_lookup_list);
> +
>   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> @@ -285,6 +288,18 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
>   	return to_nvmem_device(d);
>   }
>   
> +static struct nvmem_device *nvmem_find(const char *name)
> +{
> +	struct device *d;
> +
> +	d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
> +
> +	if (!d)
> +		return NULL;
> +
> +	return to_nvmem_device(d);
> +}
> +
This is removed and added back in same patch, you should consider 
positioning the caller if possible to avoid any un-necessary changes.

>   static void nvmem_cell_drop(struct nvmem_cell *cell)
>   {
>   	mutex_lock(&nvmem_mutex);
> @@ -421,6 +436,21 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
>   	return cell;
>   }
>   
> +static struct nvmem_cell *
> +nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
> +{
> +	struct nvmem_cell *cell = ERR_PTR(-ENOENT);
> +	struct nvmem_cell_lookup *lookup;
> +	struct nvmem_device *nvmem;
> +	const char *dev_id;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	dev_id = dev_name(dev);
> +
> +	mutex_lock(&nvmem_lookup_mutex);
> +
> +	list_for_each_entry(lookup, &nvmem_lookup_list, node) {
> +		if ((strcmp(lookup->dev_id, dev_id) == 0) &&
> +		    (strcmp(lookup->con_id, con_id) == 0)) {
> +			/* This is the right entry. */
> +			nvmem = __nvmem_device_get(NULL, lookup->nvmem_name);
> +			if (!nvmem) {
> +				/* Provider may not be registered yet. */
> +				cell = ERR_PTR(-EPROBE_DEFER);
> +				goto out;
> +			}
> +
> +			cell = nvmem_find_cell_by_name(nvmem,
> +						       lookup->cell_name);
> +			if (!cell)
> +				goto out;
Here nvmem refcount has already increased, you should probably fix this!
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&nvmem_lookup_mutex);
> +	return cell;
> +}

...

> diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h

Should be part of nvmem-consumer.h.

> index 1e199dfaacab..7859c08934d5 100644
> --- a/include/linux/nvmem-machine.h
> +++ b/include/linux/nvmem-machine.h
> @@ -26,16 +26,32 @@ struct nvmem_cell_table {
>   	struct list_head	node;
>   };
>   
> +struct nvmem_cell_lookup {
> +	const char		*nvmem_name;
> +	const char		*cell_name;
> +	const char		*dev_id;
> +	const char		*con_id;
> +	struct list_head	node;
> +};

Consider adding kerneldoc to this structure.

> +
>   #if IS_ENABLED(CONFIG_NVMEM)
>   
>   void nvmem_add_cell_table(struct nvmem_cell_table *table);
>   void nvmem_del_cell_table(struct nvmem_cell_table *table);
>   
> +void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries);
> +void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries);
> +
>   #else /* CONFIG_NVMEM */
>   
>   static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
>   static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
>   
> +static inline void
> +nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
> +static inline void
> +nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
> +
>   #endif /* CONFIG_NVMEM */
>   
>   #endif  /* ifndef _LINUX_NVMEM_MACHINE_H */
> 
