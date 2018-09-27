Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8458216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MOfnJN3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8458216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeI0WCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:02:34 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39292 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0WCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:02:34 -0400
Received: by mail-yb1-f193.google.com with SMTP id c4-v6so1287957ybl.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PJV1AjsrZAZRaCVk5huvM+FwDdZnx6bFPDX0hzRINzc=;
        b=MOfnJN3wT6pb94Egjcfs+XjCgax7WFcjJO+Y4SxNe/56Diumo1EqHDzAuCqHU2LqCm
         1nc3Q8Fznp+MIPKu1ED77s8k5z1G0715feXscA7ivPci2Rlxd9f94g+oUc6wPUD5z59R
         pVlH/bPj5qW5VDZ1HzSYf/m8XwZd40YzytCxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PJV1AjsrZAZRaCVk5huvM+FwDdZnx6bFPDX0hzRINzc=;
        b=UkTNvRTJZm8MrAHFnXsTT9V8bDp1JakYP41w0zmSYN9MtrIQ7RbZUQULoTRYyBtALX
         He7tqRAVWKVOsCDyl5EptjS3xPl4msfuwXNAUD/AHNCDJCA2lrR5IXGGQGTUCczLZDVx
         VUAop28VAlt2stoZWBHC3YHnNlmQhYwqhh0pd+iqoZFe8AtxHbScgle/ZrhUXdkbUuf9
         nTM3skRj8p53rPfLRaL4nxIFt0y0S7noRKNtIk0KazQM7Lzjgc+UZh4PCWwA2JvFBP03
         YqdrLMOASQtu21eogXqA28JNqiUIWIchMCEDGJCIhN2Ht7Z6ogUu43Fwz5H7hQQE1Dh/
         jBTQ==
X-Gm-Message-State: ABuFfogtPVhqj/pIzz8TJTeep+bmtekwnKGGfB4fLpmmnMD4Sf4JDsjm
        oi1N8KTGznC2tan1Geux4/SXr8zjuZI=
X-Google-Smtp-Source: ACcGV61QAzhWxSYq1qPfTNAlWG0eM0IETUcA3kco1JzIewAwpKMb+YZlwStAZndpMuicJUl2vvZMYA==
X-Received: by 2002:a25:18d6:: with SMTP id 205-v6mr6030543yby.430.1538063022198;
        Thu, 27 Sep 2018 08:43:42 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id f82-v6sm1060178ywf.58.2018.09.27.08.43.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:43:41 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id d9-v6so1268132ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:43:40 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr1212790ybk.209.1538063019847;
 Thu, 27 Sep 2018 08:43:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 08:43:39
 -0700 (PDT)
In-Reply-To: <20180927142403.z27x6wvq54ealwwt@mwanda>
References: <13450.1537984337@turing-police.cc.vt.edu> <20180927142403.z27x6wvq54ealwwt@mwanda>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 08:43:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+YLN=skzm1C3AEz3GEFnaP6ng2HBbkBzfkv0k3_REjBw@mail.gmail.com>
Message-ID: <CAGXu5j+YLN=skzm1C3AEz3GEFnaP6ng2HBbkBzfkv0k3_REjBw@mail.gmail.com>
Subject: Re: [PATCH] fix error handling in drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Whitmore <arigead@gmail.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 7:24 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, Sep 26, 2018 at 01:52:17PM -0400, valdis.kletnieks@vt.edu wrote:
>> John notes that if the kzalloc of ieee->pHTInfo fails, we fail to call
>> ieee80211_networks_free().  In addition, that function has an un-needed check
>> before kfree().
>>
>> Reported-by: John Whitmore <arigead@gmail.com>
>> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>> ---
>> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
>> index 90a097f2cd4e..97ff0371b5bb 100644
>> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
>> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
>> @@ -78,8 +78,6 @@ static inline int ieee80211_networks_allocate(struct ieee80211_device *ieee)
>>
>>  static inline void ieee80211_networks_free(struct ieee80211_device *ieee)
>>  {
>> -     if (!ieee->networks)
>> -             return;
>>       kfree(ieee->networks);
>>       ieee->networks = NULL;
>>  }
>> @@ -180,6 +178,7 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
>>       return dev;
>>
>>   failed:
>> +     ieee80211_networks_free(ieee);
>>       if (dev)
>>               free_netdev(dev);
>
> When there is a "goto failed;" then it's called "one err style" error
> handling and we're just asking for bugs...  In this case the bug is that
> we're not allowd to call ieee80211_networks_free() with a NULL
> "ieee" parameter.  The right thing to do is to only call
> ieee80211_networks_free() if we know that ieee80211_networks_allocate()
> succeeded.

Ah yeah, thanks for the extra eyes. Looks like it would need something
more like this:

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 90a097f2cd4e..8d6a28af96dc 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -78,7 +78,7 @@ static inline int ieee80211_networks_allocate(struct
ieee80211_device *ieee)

 static inline void ieee80211_networks_free(struct ieee80211_device *ieee)
 {
-       if (!ieee->networks)
+       if (!ieee)
                return;
        kfree(ieee->networks);
        ieee->networks = NULL;
@@ -97,7 +97,7 @@ static inline void
ieee80211_networks_initialize(struct ieee80211_device *ieee)

 struct net_device *alloc_ieee80211(int sizeof_priv)
 {
-       struct ieee80211_device *ieee;
+       struct ieee80211_device *ieee = NULL;
        struct net_device *dev;
        int i, err;

@@ -180,6 +180,7 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
        return dev;

  failed:
+       ieee80211_networks_free(ieee);
        if (dev)
                free_netdev(dev);


Valdis, can you respin the patch?

-Kees

-- 
Kees Cook
Pixel Security
