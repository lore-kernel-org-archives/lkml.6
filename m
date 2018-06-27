Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1374C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8D25CB4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSUuw26p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF8D25CB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966443AbeF0WGR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:06:17 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37631 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966278AbeF0WGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:06:15 -0400
Received: by mail-pg0-f53.google.com with SMTP id o11-v6so1508897pgv.4;
        Wed, 27 Jun 2018 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZKtIQnwuQ1zy2t43p8H/SxmseobXJjKavg+G2kNQV4c=;
        b=VSUuw26pwXdmnoPyoWi3f2xEIto5+Knz/sltLji9hrT526ALZpdIEBB6qqdC978zFH
         P8I/Tn71faarrDHtVA8ScqS2kFWF55U6d627wHmHlyq9zc/0BJ1RiA5fBCGQhpPmLki8
         GrOeAQYLRQPn8i7SsShMh2JkjBxXOv7Tn+eBRJNO+fVpjxpMEqs8JiV/kPp3atnhOPVO
         hO2iyAp5si1NHfZyUBPV6lBYiIvKqUnLrRyR9+RyuJaDNqnJQasv4abEk6+d1URqGZxn
         n6Wuu2IzeeWXmUccZQC3WmFdOyoJr9IHpcbuichn8ZNIaxW+ii8Juvb0RM1MUpYJzbV6
         k35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKtIQnwuQ1zy2t43p8H/SxmseobXJjKavg+G2kNQV4c=;
        b=VD6RGuwwBztGybavsC9NAE/HjpIrLYpqdGarpz7QtXGebEN+EOnefzMEwTc3iZhlFw
         E/2z8ki6VyI99vErM1QebkmpGzh7WpS5gDbLlpj5Yrlwp20l8jQQ6+MytUqOLF6GMnxi
         u8U4eBqhIAzeoy3w+evngCk2mpdt28RSKobrcdyPmqlYnHk5tj1lbAbToaeMkyIBbddW
         U2DEBWqd4ni4RsDFmF40EtyNixws5SEY87iaHBeReIx0U4RR7Hyy6S3vs8iqQVKdou1a
         7yWqmu06PqfCAxsJSkFrmghuCMGX7u1NfS6rLpQX+kMo/2tdjpSR6sPjm52rDRu746tw
         lYdQ==
X-Gm-Message-State: APt69E045DPbzGFt6DdiRirWfmT2Y3jIi3bTCXDByisSlmYo2Eme9sRI
        3o6KMpllsxWsPaIfJRYP2yCZ+MyB
X-Google-Smtp-Source: AAOMgpeDh/umi7OCRjrheafPkmYK0DTRQgDbmRoTJIvVnhVzWlvvowjlaajvrpBK3u57DL8FjEs/tQ==
X-Received: by 2002:a62:4695:: with SMTP id o21-v6mr1900744pfi.176.1530137175330;
        Wed, 27 Jun 2018 15:06:15 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id b4-v6sm6777151pgq.51.2018.06.27.15.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 15:06:14 -0700 (PDT)
Subject: Re: [RFC PATCH] net, mm: account sock objects to kmemcg
To:     Shakeel Butt <shakeelb@google.com>, eric.dumazet@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
References: <20180627204139.225988-1-shakeelb@google.com>
 <f08b2e2c-d4c6-7a80-10d9-104c0aab593b@gmail.com>
 <CALvZod4JTY8T19L-q+E1LLFVGFso6ea1MACKdFsed8dM-3AvYQ@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a48b2c73-b3b2-8291-202b-e5a2a5ee1f2a@gmail.com>
Date:   Wed, 27 Jun 2018 15:06:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALvZod4JTY8T19L-q+E1LLFVGFso6ea1MACKdFsed8dM-3AvYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 03:03 PM, Shakeel Butt wrote:

> 
> This will opt-in all the sock kmem_caches which I think is better and
> much smaller change. Should I resend this or do you want to send the
> patch?
>

Please send a V2, with maybe some updated changelog ;)

Thanks !

