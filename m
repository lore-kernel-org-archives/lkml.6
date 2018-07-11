Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75228C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F81F20C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F81F20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbeGKPGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:06:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55242 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbeGKPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:06:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so2724364wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F3IS1Y5XYpAVJxHY9N/iOuwMdpZQEMql+GOJqRZ+Yqw=;
        b=GG6LTF5uf7/a0Gkgvjvr5fqRpk2xARaXkyhJtDlV9HQGWxEfY0X6tC4fw85UTdouke
         gUypM0y2DXdNIE/FcvlimWn2B3A9A0mctzpmXZoTx2+j9Tuo4UcdrDYoIJlvQKLGCEgj
         P4BUdfEuvds/UOJOzhMNB2GUs6Z30uS2hBvYU0cvaE5TAVNldVWfbvrLjNiLXJ5LtQdF
         SLkoUmktH3j4cg8Z7CXd7wt/d/QnmQL7eqjtQZtwBMw3j+DOcblg6ykZucN2m+NXXdD/
         /52WPmfaBkwfrkCrts02NLiv2VzAyuPipVwCXasJlXLB2E726xIOo3OV4GkkiW9xeQgG
         HGuw==
X-Gm-Message-State: APt69E0u/ibROLq/1w7STkyHFbMsu6p+PcQsFPYlfh7n/3cHO8pXeK2R
        QLlTg4Hau/T4Lepdq/WbEvDXxZRHIo0=
X-Google-Smtp-Source: AAOMgpd8DQCIHFsa0SdydTXZI7mTq/UeAgIFpD6bz84q2Iyku75huwdfSdJYOzxKml2WyG/pVWdfJQ==
X-Received: by 2002:a1c:9546:: with SMTP id x67-v6mr16930834wmd.25.1531321304884;
        Wed, 11 Jul 2018 08:01:44 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 65-v6sm3186646wmk.46.2018.07.11.08.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 08:01:44 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <386d987c-899a-2e98-66ba-6e672dd532ef@redhat.com>
Date:   Wed, 11 Jul 2018 17:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711105255.32803a3c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-07-18 16:52, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 16:46:11 +0200
> Thomas Zimmermann <tzimmermann@suse.de> wrote:
> 
>> Hi
>>
>> Am 28.06.2018 um 11:03 schrieb Hans de Goede:
>>> Replace comments about places where the console lock should be held with
>>> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
>>
>> Debugging fbcon sometimes requires to not take the console lock. This
>> patch breaks the debugging workaround provided by
>> 'fb.lockless_register_fb'. The dmesg is now filled with warnings about
>> the missing lock.
>>
> 
> What if you make lockless_register_fb visible to fbcon, and then we can
> have a macro:
> 
> #define WARN_FB_CONSOLE_UNLOCKED() 			\
> 	do {						\
> 		if (unlikely(!lockless_register_fb))	\
> 			WARN_CONSOLE_UNLOCKED();	\
> 	} while (0)
> 
> And use that instead?

Yes I'm already preparing a patch like that :)

Without the unlikely though, this is not used in hot paths.

Regards,

Hans



> 
> -- Steve
> 
> 
>> Best regards
>> Thomas
>>
>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v3:
>>> -New patch in v3 of this patchset
>>>
>>> Changes in v4:
>>> -Keep the comments about which fbcon functions need locks in place
>>> ---
>>>   drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>>> index c910e74d46ff..cd8d52a967aa 100644
>>> --- a/drivers/video/fbdev/core/fbcon.c
>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
>>>   	struct fb_info *oldinfo = NULL;
>>>    	int found, err = 0;
>>>   
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>   	if (oldidx == newidx)
>>>   		return 0;
>>>   
>>> @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>>>   {
>>>   	int i, new_idx = -1, ret = 0;
>>>   
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>   	if (!fbcon_has_console_bind)
>>>   		return 0;
>>>   
>>> @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>>>   {
>>>   	int i, idx;
>>>   
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>   	idx = info->node;
>>>   	for (i = first_fb_vc; i <= last_fb_vc; i++) {
>>>   		if (con2fb_map[i] == idx)
>>> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>>>   static void fbcon_remap_all(int idx)
>>>   {
>>>   	int i;
>>> +
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>   	for (i = first_fb_vc; i <= last_fb_vc; i++)
>>>   		set_con2fb_map(i, idx, 0);
>>>   
>>> @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *info)
>>>   {
>>>   	int ret = 0, i, idx;
>>>   
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>   	idx = info->node;
>>>   	fbcon_select_primary(info);
>>>     
>>
> 
