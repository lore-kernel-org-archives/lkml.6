Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4+UlXGCzJB7A+oXCsAw11KEqYuu5ZGYpNsyDh4vpjPTw9sV2q4I3EH5YSBlIcIJXqz9imUg
ARC-Seal: i=1; a=rsa-sha256; t=1524499616; cv=none;
        d=google.com; s=arc-20160816;
        b=X58PM1BXtlMCmD3xEbr/812JpRVfQoXh/Q3MoQWwAziTnsmelAxtrGD56ifJdG1F6r
         QQSiQt0hiESmvQ1pnY7WP7pQuVDgSFx3OJ3HLJ+Jf72Sh4BKOWVt06+P/ZgNM+NUzlz5
         dJ5bCx6+EwEG540pp1U8y7B15NgacutCltS8mO2HPojL1QlIS/iBlGwboMK3yaEkN2yE
         OTiGec5anSxZC1uTrYiHM9cj/KI+fTm94H2nFIXjDSA9nM4Fw0qgLBKp+GbIM+9Dw5Da
         3Pu4Kr6iKRGEV8U7Fpywo8dc0Lhb0t+4GnU25FM6hCH6NyJ0pqyjDOdaUeig2FM/11aF
         dohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=FMTSdoLH3b39M3B3bvR957Bzbbh3orlpjv8sci7kSEA=;
        b=DYoVQPouVnSNajSxbHKGFO7BQ+Ul1etC/dTwrDo7rtVG6zX127C1bDUjf6sRwOQOsd
         8avWyjt7RmFISg6gFB5t1jB0ba2QvVPE4Z6dJytl1DfUHoZh/SHgUMX1rENPiMdHAa/9
         33ZN2UXcGVWE1DdyMTxJYoW75JajeU7qyXsxg4g94FedIsJceWYf3iSOQx0tuSwJYxJW
         1Lql5YwNGw0UxgJzHl2x4LJ8aXozERYFDc6mtmwj5fC7bHEz0eFt+TKYM4z334KTIWcW
         U7SGF7SqSGzKvJZ/Ji5+aNc8EHhe8E0G52jiJAM2Qwe1nclywG8vuP+QL9YQ1Nx6mxWp
         sltg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Subject: Re: [PATCH 4/4] ALSA: usb-audio: UAC3 Add support for connector
 insertion.
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180420170327.31569-5-jorge.sanjuan@codethink.co.uk>
 <s5hr2n6ru79.wl-tiwai@suse.de>
From: Jorge <jorge.sanjuan@codethink.co.uk>
Message-ID: <61a5d852-f4b7-70fa-ae0e-2b5559e3b1f6@codethink.co.uk>
Date: Mon, 23 Apr 2018 17:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5hr2n6ru79.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285490123572261?=
X-GMAIL-MSGID: =?utf-8?q?1598553710444625423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Takashi,

Thank you very much for the reviews. I'll put a v2 patchset with the 
suggested changes for this patch and the other ones you reviewed.

Some comments below

On 23/04/18 13:19, Takashi Iwai wrote:
> On Fri, 20 Apr 2018 19:03:27 +0200,
> Jorge Sanjuan wrote:
>>
>> diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
>> index a8959aaba0ae..6cedb6d499ba 100644
>> --- a/include/linux/usb/audio-v3.h
>> +++ b/include/linux/usb/audio-v3.h
>> @@ -221,6 +221,12 @@ struct uac3_iso_endpoint_descriptor {
>>   	__le16 wLockDelay;
>>   } __attribute__((packed));
>>   
>> +/* 5.2.1.6.1 INSERTION CONTROL PARAMETER BLOCK */
>> +struct uac3_insertion_ctl_blk {
>> +	__u8 bSize;
>> +	__u8 bmConInserted[1];
> 
> Do we need to declare this as an array?

The size of bmConInserted will be determined by bSize. We could check 
how many connectors are in the device by checking the high capability 
Connectors Descriptor. If the number of connectors was greater than 8 
this block would need to get some more bytes in the request (or we could 
just request the following bytes if bSize was greater than one).

I'll remove the array and leave it as two byte block. That should be 
enough for up to 8 connectors.

> 
>>   static struct snd_kcontrol_new usb_feature_unit_ctl = {
>>   	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>>   	.name = "", /* will be filled later manually */
>> @@ -1322,6 +1367,15 @@ static struct snd_kcontrol_new usb_bool_master_control_ctl_ro = {
>>   	.put = NULL,
>>   };
>>   
>> +static struct snd_kcontrol_new usb_connector_ctl_ro = {
> 
> Put const.

+1	

> 
> 
>> @@ -1904,16 +1966,29 @@ static int parse_audio_input_terminal(struct mixer_build *state, int unitid,
>>   				      void *raw_desc)
>>   {
>>   	struct usb_audio_term iterm;
>> -	struct uac2_input_terminal_descriptor *d = raw_desc;
>> +	unsigned int control, bmctls, term_id;
>>   
>> -	check_input_term(state, d->bTerminalID, &iterm);
>>   	if (state->mixer->protocol == UAC_VERSION_2) {
>> -		/* Check for jack detection. */
>> -		if (uac_v2v3_control_is_readable(d->bmControls,
>> -						 UAC2_TE_CONNECTOR)) {
>> -			build_connector_control(state, &iterm, true);
>> -		}
>> -	}
>> +		struct uac2_input_terminal_descriptor *d_v2 = raw_desc;
>> +		control = UAC2_TE_CONNECTOR;
>> +		term_id = d_v2->bTerminalID;
>> +		bmctls = d_v2->bmControls;
>> +	}
>> +	else if (state->mixer->protocol == UAC_VERSION_3) {
> 
> Put "else if" and the closing brace in the same line.

Thanks. My bad.

> 
> 
>> +		struct uac3_input_terminal_descriptor *d_v3 = raw_desc;
>> +		control = UAC3_TE_INSERTION;
>> +		term_id = d_v3->bTerminalID;
>> +		bmctls = d_v3->bmControls;
> 
> Doesn't it need le32_to_cpu()?

Agreed.

> 
>> +	}
>> +	else /* UAC1. No Insertion control */
> 
> Ditto, put "else" and the closing brace in the same line.
> Also, use braces for the rest block, otherwise it'll look
> inconsistent.  Or rewrite with switch().
> 
>> @@ -2645,6 +2720,12 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
>>   			err = parse_audio_unit(&state, desc->bCSourceID);
>>   			if (err < 0 && err != -EINVAL)
>>   				return err;
>> +
>> +			if (uac_v2v3_control_is_readable(desc->bmControls,
> 
> Missing le32_to_cpu()?

Agreed.


Thanks,

Jorge

>  >
> thanks,
> 
> Takashi
> 
