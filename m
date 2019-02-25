Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2CD217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="J/sN7r2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfBYX1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:27:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34632 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfBYX1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:27:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id a16so9177476edn.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DidyAyf0+6M+Qwqs+J7w8aaJ+Pko0V/VyXmx0zWiUw=;
        b=J/sN7r2Ysx+Va9vfSct3vlIRMv4hLW0ANe279gqt39NPl91Re1H9+KOVwgdTS7cOgD
         7mAR3aQzqELHU0SZSzEmIuXvWV30xZzw30sx214JE5hwNdCLDYOEV/BglCw0d+FBEIyp
         HvZagwlS/xTHEYlsWOeHxFnuyBM/VqkrsnxuxyFD0uHMlPf695cQaef+tIinOoPnyqw+
         dRqwaVGyhAB9eJppLeOJ0Q4QrVeAjBEaP5UYbE2gH7gXrOg7C5jAr42u4wSpEQ4UzDx9
         EYJjKauPGLAjY1sw1hg4hxUmBK8EK6EEOBxJpenmk5gG/jKMJJ5XBcLSqwlCYsQTTBVn
         psxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DidyAyf0+6M+Qwqs+J7w8aaJ+Pko0V/VyXmx0zWiUw=;
        b=lPadlboyO6lAnzMMDfaqcEZseAj9hJPYDxrq224j6McksqQyz8yF6yhaEq/rclB6rr
         Infx0ygK+qVYQMt9MYFlsDRH5e+Yzi/BSRGvKrVczhnd0WZtReJjhYW1pzLKHavXvNfo
         NjX64Z6TkRPmSBgKHK6yDQMwsw0D7FR6WZVz2+wGFM8O31O1GubQnADgUo/fzEIqFisi
         4oeFfWLJMWkMH/Y4luamXNAXEKaMlHHWYnKkl3HHbDjviZryDi7PPRQ/GnRVjbM1DOB7
         4lNmoZdMNej0xPswbO9wVeM7VCVtGQylQduzTd+t8uupMn7nbMK88y0SNTokU97YOmwO
         KbCw==
X-Gm-Message-State: AHQUAub+5M/rhP+69Z1k932IF1sS9MPNacYnd99glnKEZRUqWn0NK9a2
        q/3wliPZa/ZjrODpDGXQN4Fv+hx1FBY=
X-Google-Smtp-Source: AHgI3IZzY7LW23sfZoSQSJBO6noyZRiPLTkpmtVbQbezAqheHTPua6bfgXou7kX2ZH8YY6zwGaaz3A==
X-Received: by 2002:a50:b6e6:: with SMTP id f35mr16660920ede.94.1551137264530;
        Mon, 25 Feb 2019 15:27:44 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f48sm3040987edd.56.2019.02.25.15.27.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:27:43 -0800 (PST)
Subject: Re: [PATCH] rtnetlink: Synchronze net in rtnl_unregister()
From:   Dmitry Safonov <dima@arista.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>, linux-kernel@vger.kernel.org
Cc:     0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org
References: <20190225212721.2908-1-dima@arista.com>
 <eb7bca34-2b6a-1140-b230-71f333b42807@gmail.com>
 <d20c023b-33d5-4c48-a404-e2ba05f98a99@arista.com>
Message-ID: <8070c296-5767-6783-c34e-14112b2b412e@arista.com>
Date:   Mon, 25 Feb 2019 23:27:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d20c023b-33d5-4c48-a404-e2ba05f98a99@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/19 11:21 PM, Dmitry Safonov wrote:
> Hi Eric,
> 
> On 2/25/19 11:09 PM, Eric Dumazet wrote:
>> On 02/25/2019 01:27 PM, Dmitry Safonov wrote:
>>> While it's possible to document that rtnl_unregister() requires
>>> synchronize_net() afterwards - unlike rtnl_unregister_all(), I believe
>>> the module exit is very much slow-path.
>>
>> rtnl_unregister_all() needs the sychronize_rcu() at this moment
>> because of the kfree(tab), not because of the kfree_rcu(link, rcu);
> 
> I may be wrong here, but shouldn't we wait for grace period to elapse by
> the reason that rtnl_msg_handlers are protected by RCU, not only by rtnl?
> Like, without synchronize_net() in rtnl_unregister() - what prevents
> module exit race to say, rtnetlink_rcv_msg()=>rtnl_get_link()?

There is synchronize_rcu() in free_module() - but I believe it's a bit
too far in unloading. Maybe, I'm missing another call on the way.

Thanks,
          Dmitry
