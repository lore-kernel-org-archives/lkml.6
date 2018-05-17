Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526577051; cv=none;
        d=google.com; s=arc-20160816;
        b=cS27OM10Kn7B6YBve7QM+yBG8zzEGDyM3Ou5HqW3GPC/9ak3MmSOJEoXNP3hH2FZnw
         Es4TjfWmEE/EOanInPCcblx+65mES4O1Bo1JBy1l0v4aTlv2lV+jLxIOXyhXMN9NAPgl
         bu92OdIAO482Dk7AYchFV92eKgG1gNis0Sz5eu3PpSz/i+cXSzeN0je3l9PalYYjxIXK
         09TLXjG5MU4MhudNWl+hfAx27OHlu/kIosNrVdLvNRh5w/y7yuLQQj7YMg26BVfSoGuP
         U8oBKWylmqAJ+2MGKjoEKmAiYWVafnLeAqM0eVgVC4xRbKB199B2KWKM31FG+6Wj7+Jb
         jPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=gvGXpNY9l6BhV7N/bSeE7mefgT7777YK9wsrHMGyLP8=;
        b=qiNAxmLgxyoOr01svNKxVdcXoGqOuJ02sAHWBsgfyasVBvzC9QRzm7HdbowJsopk0Q
         q8Xk499chPsvCq93NSmjLZJsOEi+zeOVS8hUrUVtLSg2bIzxFVtpWGXAyH/wmuAVE3XN
         CbajnzfDM0Y73zwvHbLO4RDMONxUoZG32JXw3gJJNakOiLvZaZ/pIByDUdEiVlAzxI65
         UdqE271EgBcvg9GMrmaT/MABQhjP4Z4PCoOq9ylnm4DdeYPnEaeMHyKrVifEdMlthhse
         6ngaz0/6Erv/g0ydXA4DSAjQZAJgDgk7+VmLfZwWMPyQDbPaWgJl9bos1xCeHa1uPB08
         A3zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TbN2fPok;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TbN2fPok;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqeubQ5Acz0r73HF6dmaIBJz148sXxtzggejJWFMOtuSt4s77HmCMto7ANvH+y/8qZE/LpBSw==
Subject: Re: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org,
 gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
 <20180517065544.GO20254@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <507b8b76-0846-a492-73e6-782b9953bc36@linaro.org>
Date: Thu, 17 May 2018 18:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180517065544.GO20254@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991553144563990?=
X-GMAIL-MSGID: =?utf-8?q?1600732058650695478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for the review.

On 17/05/18 07:55, Mark Brown wrote:
> On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:
> 
>> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
>> +{
>> +	struct q6afe_port *p = NULL;
>> +	struct q6afe_port *ret = NULL;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&afe->port_list_lock, flags);
>> +	list_for_each_entry(p, &afe->port_list, node)
>> +		if (p->token == token) {
>> +			ret = p;
>> +			break;
>> +		}
>> +
>> +	spin_unlock_irqrestore(&afe->port_list_lock, flags);
>> +	return ret;
> 
> This lock only protects the list, it does nothing to ensure that the
> port we look up is still valid by the time we return to the caller.
> That means we won't crash during list traversal but does nothing to
> ensure we won't crash immediately afterwards if the port is deallocated
> just after we look it up.  What stops that happening?

Each port is allocated and de-allocated in dai probe and remove calls 
respectively.

Lets say... So for this case to happen the dai has to be removed (unload 
module) at the same time when the interrupt callback happens due to 
delayed response from previous commands.

This case would be almost impossible because all the calls to afe 
service are synchronous with timeouts, if any of the previous calls 
times out the respective caller would get an error, this should prevent 
him from unloading the module in the first place.


thanks,
srini

> 
