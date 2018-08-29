Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B3F205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cc8ITsgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B3F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeH2U0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:26:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43779 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbeH2U0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:26:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id z27-v6so4372122edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqWU86kkPRp0GLzPz1pwkADPIESL7shygY3zKW2USoY=;
        b=cc8ITsgzgqhNZH6/XiRzYKz+IrIHaqofQpiKzxCb/d5ogE1YM8I+GP37QX7p4nOXwt
         COd58CjE4YlSGbIhhReq0rJAS1morHSov4MdoYA/IpctrVeIwA2zrj9p8L2E6OK7Zvtw
         XYg9Y2JJ9dnw+8HX4J9gOqWa4zZpx228DYrE7rKQJ2qWp/cy1ZPz1Nl2geHaSSFZCohZ
         U0B2EB9XYynv2MHEPsGNiRezZvCZhLTIphk7fme4ZBawr1kM4QzPVpPtq4WfY+PdFTVa
         A3SnjUMbyM08eOS+kEyeB6PUXscaZLZBUFrBsSAuZgGXSPgnlmjEFT1zNYiTpqm1eUPm
         HIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqWU86kkPRp0GLzPz1pwkADPIESL7shygY3zKW2USoY=;
        b=rrJQmKwOAp33bq7cVUwti+E8KJ6rbhJETNyT8ip6fmNqNyYXH9Jn44oRqPEvdlW6Z6
         NNY3KqfyvQ+Y5GrwczUPUFOaAlo0eMsYGeyxbn+T439syrQulUayVSLpw4L7OxSofLUx
         esG2TkefK5bSH7cRCgnUon3GVm3u8fNCP1Cx9PFD9tqj7a7mSwUp9KAjq5V2pJx7VARg
         bhJQptb7ZGl+NSlnHYlRaSkH0Ta/QD2dyyS9COsmzDyKSLPcXGXr0TsWPvb/fbhQbNrg
         Dmn2yo0y6wDa+YPSev78/iUkf3o8BCdJeXcqhcubzNOWnnkJ6R+NNwebwy9+JRAsLarP
         hw6g==
X-Gm-Message-State: APzg51Br39IYq+kbBLQy6c5LXt3x8gqnhdZnxm7mX1z7a21FlTAUy5ZS
        CLW48Yc6V6//kV//Z6i9xyOhOw==
X-Google-Smtp-Source: ANB0VdYzQjN2hab/Z2doeemWSQGRgL9aGOKoYN0bZu0MhXYAStkRjGwtV3Kx3uorkOwc18kopTcqfg==
X-Received: by 2002:a50:f743:: with SMTP id j3-v6mr8461970edn.203.1535560114165;
        Wed, 29 Aug 2018 09:28:34 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b20-v6sm2279953edc.30.2018.08.29.09.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 09:28:33 -0700 (PDT)
Message-ID: <1535560111.23560.61.camel@arista.com>
Subject: Re: [PATCH 3/4] tty: Lock tty pair in tty_init_dev()
From:   Dmitry Safonov <dima@arista.com>
To:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
Cc:     Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Date:   Wed, 29 Aug 2018 17:28:31 +0100
In-Reply-To: <22935dc9-a9fe-5fc8-4c97-3f5c7b07b8c3@suse.cz>
References: <20180829022353.23568-1-dima@arista.com>
         <20180829022353.23568-4-dima@arista.com>
         <22935dc9-a9fe-5fc8-4c97-3f5c7b07b8c3@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 16:46 +0200, Jiri Slaby wrote:
> On 08/29/2018, 04:23 AM, Dmitry Safonov wrote:
> > It's safe to not lock both here - done to silence attempt lockdep
> > assert in
> > tty_ldisc_open(), which will be added with following patch.
> 
> SOrry, could you elaborate here? I don't follow...

Sure, 4/4 patch adds lockdep_assert_held() into tty_ldisc_open().
Currently ldisc in tty->link isn't locked, which according to code
shouldn't be an issue, as far as I can see.

So, this patch silences lockdep warining by holding the semaphore,
which is slowpath anyway and doesn't case any new contention.

(actually, not holding the semaphore for slave might be an issue if one
opens slave before it's fully initialized, but I'm not sure if it's
possible).

-- 
Thanks,
             Dmitry
