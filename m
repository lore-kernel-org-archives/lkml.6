Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B01C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791CC21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCNxACSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791CC21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeI0X1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:27:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32870 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbeI0X1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:27:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so2375607pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Iqt+NKN0SDvEqqjdOjGm0nNyKWvshQ5cAgbQCCLjIk=;
        b=hCNxACSCniza2aqJS988Wgie+vCVVdX4lydLzPP0EOE5n+6xoyytVrsdG4cZ6lbfqz
         jNEBPQg3DTaNCOCBM4ZWzm7lB8TNDR5gioQUESooOjSJbsxn4iatihVLd1VNTNv/Lamo
         Zaas+h8a+T9LQeCYiAykVc2s8HX5Sv3+a4UPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Iqt+NKN0SDvEqqjdOjGm0nNyKWvshQ5cAgbQCCLjIk=;
        b=lKIE3N2UHS/DXbYpMuYDpxtroctiseFJRnRhphNZyNpw9I1wRGcJ+YGpklLnQFOruu
         rUp2JfBeXn1FwCOwH8Fhty5ymiO3YGXgl1czBzp+mdZdJZJP1sL5sRQ/dE9Npq7NeDzi
         HfFqYBlUKYPxBiDIou2pznX406Nlrr+IinbOJbuhFIEL5klKOdwMXzwO8GOS9cRUzecb
         QC/h/ahNdBZcJzj1M1l1tX3LyLwGClpx9hE+L8MA3TSESbWPadX2RMqnX8xqnygRQQhH
         BZSIPBsG3Sl31rY9rw9nDbRZmXH2+awaWYI7LuXbSiUplIUVodOtwvDbh5XBPO/n1XXg
         fsYA==
X-Gm-Message-State: ABuFfogEei/p9AJHAz/ZcfN4eOSsEo9JS15HobRm6rdB+cz7ToUVM5eH
        Mcj+1YBt/Xfj1lC5xmU/78BwIhK8maE=
X-Google-Smtp-Source: ACcGV61AzNRhxWyTgkAldF00u1koY1wq71y8QdO1kcGk9JI/7UIGr7kIrvXof9cmHEPxhhYmpXBw5g==
X-Received: by 2002:a62:a0e:: with SMTP id s14-v6mr10320050pfi.153.1538068071652;
        Thu, 27 Sep 2018 10:07:51 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 77-v6sm3905080pfw.159.2018.09.27.10.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:07:50 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:07:48 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUEUED v20180920 05/16] stm class: Add a helper for writing
 data packets
Message-ID: <20180927170748.GC7481@xps15>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
 <20180920124553.56978-6-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920124553.56978-6-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:45:42PM +0300, Alexander Shishkin wrote:
> Add a helper to write a sequence of bytes as STP data packets. This
> is used by protocol drivers to output their metadata, as well as the
> actual data payload.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/hwtracing/stm/core.c | 50 ++++++++++++++++++++++++++----------
>  drivers/hwtracing/stm/stm.h  |  3 +++
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index c869a30661ac..9ed2f06deb47 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -564,27 +564,51 @@ stm_assign_first_policy(struct stm_device *stm, struct stm_output *output,
>  	return err;
>  }
>  
> -static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
> -			  unsigned int channel, const char *buf, size_t count)
> +/**
> + * stm_data_write() - send the given payload as data packets
> + * @data:	stm driver's data
> + * @m:		STP master
> + * @c:		STP channel
> + * @ts_first:	timestamp the first packet
> + * @buf:	data payload buffer
> + * @count:	data payload size
> + */
> +ssize_t notrace stm_data_write(struct stm_data *data, unsigned int m,
> +			       unsigned int c, bool ts_first, const void *buf,
> +			       size_t count)
>  {
> -	unsigned int flags = STP_PACKET_TIMESTAMPED;
> -	const unsigned char *p = buf, nil = 0;
> -	size_t pos;
> +	unsigned int flags = ts_first ? STP_PACKET_TIMESTAMPED : 0;
>  	ssize_t sz;
> +	size_t pos;
>  
> -	for (pos = 0, p = buf; count > pos; pos += sz, p += sz) {
> +	for (pos = 0, sz = 0; pos < count; pos += sz) {
>  		sz = min_t(unsigned int, count - pos, 8);
> -		sz = data->packet(data, master, channel, STP_PACKET_DATA, flags,
> -				  sz, p);
> -		flags = 0;
> -
> -		if (sz < 0)
> +		sz = data->packet(data, m, c, STP_PACKET_DATA, flags, sz,
> +				  &((u8 *)buf)[pos]);
> +		if (sz <= 0)
>  			break;
> +
> +		if (ts_first) {
> +			flags = 0;
> +			ts_first = false;
> +		}
>  	}
>  
> -	data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0, &nil);
> +	return sz < 0 ? sz : pos;
> +}
> +EXPORT_SYMBOL_GPL(stm_data_write);
> +
> +static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
> +			  unsigned int channel, const char *buf, size_t count)
> +{
> +	ssize_t sz;
> +
> +	sz = stm_data_write(data, master, channel, true, buf, count);
> +	if (sz > 0)
> +		data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0,
> +			     buf);

The original code the payload of a flag packet was '0' while in this patch
changes it to be anything.  Some external tooling could be very confused.

>  
> -	return pos;
> +	return sz;
>  }
>  
>  static ssize_t stm_char_write(struct file *file, const char __user *buf,
> diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
> index 921ebd9fd3bd..753d83acb7ae 100644
> --- a/drivers/hwtracing/stm/stm.h
> +++ b/drivers/hwtracing/stm/stm.h
> @@ -111,5 +111,8 @@ int stm_lookup_protocol(const char *name,
>  			const struct stm_protocol_driver **pdrv,
>  			const struct config_item_type **type);
>  void stm_put_protocol(const struct stm_protocol_driver *pdrv);
> +ssize_t stm_data_write(struct stm_data *data, unsigned int m,
> +		       unsigned int c, bool ts_first, const void *buf,
> +		       size_t count);
>  
>  #endif /* _STM_STM_H_ */
> -- 
> 2.18.0
> 
