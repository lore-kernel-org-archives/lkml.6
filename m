Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20273C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB2020873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB2020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbeGKTru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:47:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37076 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732848AbeGKTru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:47:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so3716414wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgBDlhKEN3Qp0PntAjaHv5cuharSsTUZJ6jV6/ge3cE=;
        b=nzCTyzY8WQqaRI7RJ28Z17mZ8nyT18+a7jmAvXNFtKP9bJ0oYCdgZ+21b7+uGY3P/F
         Mc4bN4MhJImcXT1CQFIyRCnMYXTvRLoS1cxfjCfUz/wvQUPXapb9TEuCpPdN73uItLTy
         k4zOJZ8WErwEOz8hGeK5ePy7eoo4ILJ7vfgfqxn+h6F+OZznXu7pPm++CQlmnVnh4Nc7
         XrbM3BNjExbogn60BRl15mWTk6mixliJRv05GCMpfREEh/NfB92hbijtYHU1yueWKHFJ
         b1+I0S+klWkThn0ovreTl1ahRIXJv5vOFEdRPc2XbPA18Blmo5alj/mI9aA+jueWxhg2
         AHCg==
X-Gm-Message-State: APt69E2WkJJlv2s6yYTDYUcsJnTjoH+I5h7h12SHeeD2TQ5gYryEsESJ
        msuZW9zsRxqZsMe/q1xHoTRXUA==
X-Google-Smtp-Source: AAOMgpeT3FLaQIFU2WNcDf8jX4/jf1W/M1HJoBwYlYTuLSbKJjgXq6XNnynWYYCEtda8Zv7aX5MjpQ==
X-Received: by 2002:a1c:cbc2:: with SMTP id b185-v6mr19257157wmg.117.1531338119022;
        Wed, 11 Jul 2018 12:41:59 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t1-v6sm3491086wmt.40.2018.07.11.12.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:41:58 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
 <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
 <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
 <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
 <20180711151911.2ea40200@gandalf.local.home>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ec818015-9fc9-f389-dd06-952953f84068@redhat.com>
Date:   Wed, 11 Jul 2018 21:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711151911.2ea40200@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-07-18 21:19, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 19:56:02 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
>>> Have you seen Steven's suggestion which he send about the same time
>>> as your mail I'm replying to here ? I personally think that doing
>>> something like that makes sense (for as long as we have the need
>>> for the lockless_fb_register debug hack).
>>>
>>> Note I've 2 patches ready to go to only fix this in fbcon.c, but I
>>> think a more thorough fix makes sense.
>>
>> Yeah Steven's suggestion looks reasonable to fix this all for good.
>> The #if 1 predates git history, so no idea why it was added or by whom
>> :-)
> 
> I just sent the patch. If the printk maintainers take it, then you can
> update the fb driver to set the ignore_console_lock_warning when
> lockless_fb_register is set.

Thanks for doing this. I will wait with sending a fbcon / fbdev patch
till the fate of your patch is clear then.

Regards,

Hans
