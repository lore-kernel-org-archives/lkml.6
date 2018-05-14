Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZoSpwgCAsPM41XNUYKW6jfVo3iLKIxpOueTrgmqsTJwcWb2x/i0Lf6FN3acmWxU6xvsAxsu
ARC-Seal: i=1; a=rsa-sha256; t=1526288067; cv=none;
        d=google.com; s=arc-20160816;
        b=ZrVh58Kj+D56y1Tj7+i4hcK8rD711qzL7gdvXePhuttQbFDAgs5NcswwCZzI9dFMAA
         Zl6eFOIllGAzbaOSKSVDRVVcIzj/P+Ar527pqilNmMmhPOCUK54zQMd02eDF00VY1icD
         MRzv6/aFfnECFylgNDBnyofUh9CP9cwshS5qjoIjNP0y5RKRuvzprivYX6TiX/xBstWh
         NwASbdx9r/WYi3dM1qoHVIl8zajQnVjg8/p0Jj06ss0KZHCZ0DhVY9cPTjbNKBZH8yzN
         b7Xgka4gh3BgXodpWNi7MUCWVyFR6g018Vw+kJtm9cZ58vZfa2fAxr6j9Du8/LcPMtpJ
         wbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=ql4i3IQ3SBskgtErOqU9s9UDZGphpQIqIpLI2/18nVo=;
        b=koL/wWVa+mB7Xnb3ggYwQgCogGSlRt5L9G+NgCkT8YuyMfyArYBqcOncSej1XFIW9V
         6OdpSOrnM3yAqf33UIxj96iYQkMVsGAzKFLhx6IB1aJ9/knpi4BMb92fBqT7127YoZJQ
         0goW3n6SgOeNiYsUvcnms7i+g/BQZFEoRWv5BjByVJ6W+sBn4Rvz0uYwpCFFl7zBML8J
         WOxU5vk4yQrkOu/txPrLmAjRHx7afBh5/C8iiZsE5es91KvtHWe83nyQF9FY0RQkH9LL
         Vbq99ILTE9X4azt8U4xMndikF1l5ZCGSNvlZU1bz2fAgDyrtvXQ2nptx0UayLtx3qEAy
         bW/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Subject: Re: [PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse Input Terminal number
 of channels.
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ruslan.bilovol@gmail.com
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
From: Jorge <jorge.sanjuan@codethink.co.uk>
Message-ID: <e2088eb5-381f-3ad4-8e59-381a729346d0@codethink.co.uk>
Date: Mon, 14 May 2018 09:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600181868703215105?=
X-GMAIL-MSGID: =?utf-8?q?1600429037017442654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 11/05/18 16:25, Jorge Sanjuan wrote:
> Obtain the number of channels for the Input Terminal from the
> Logical Cluster Descriptor. This achieves a useful minimal parsing
> of this unit so it can be used in other units in the topology.
> 
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>   sound/usb/mixer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 431f3c319839..19b25fbc7437 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -903,9 +903,9 @@ static int check_input_term(struct mixer_build *state, int id,
>   				 * recursion calls */
>   				term->id = id;
>   				term->type = le16_to_cpu(d->wTerminalType);
> +				term->channels = get_cluster_channels_v3(state, d->wClusterDescrID);


Sorry about this. I just spotted that I should have used the helper 
function I added to access d->wClusterDescrID 
`uac3_mixer_unit_wClusterDescrID`.

I got the sparse warning for the endianess and realized that. I'll 
resend this one patch.

>   
> -				/* REVISIT: UAC3 IT doesn't have channels/cfg */
> -				term->channels = 0;
> +				/* REVISIT: UAC3 IT doesn't have channels cfg */
>   				term->chconfig = 0;
>   
>   				term->name = le16_to_cpu(d->wTerminalDescrStr);
> 
