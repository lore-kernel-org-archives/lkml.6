Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD082C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8370F22535
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="BXmkXzAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8370F22535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cumulusnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbeFUXfg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:35:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35230 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeFUXfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:35:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so419864wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GzXTZN2s6naNL26BfTVBl1E41kNnvnYHrab5sokz8+M=;
        b=BXmkXzAzNPcXJbRd957IIlm3XIl8OpDPx6dDCjyj7OXo21lKhTOhVWVl5mN4aA/UaN
         fgCvqt0L1OQ0FyRNNLmOhXxsEUKu7c1MjSpNIhGI1Mzf63SSnVumuHW6XDIR8t2BSoNo
         DRj7qwmYaT7PVXk1jPDkNkZAAe/k8xnUcQUko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GzXTZN2s6naNL26BfTVBl1E41kNnvnYHrab5sokz8+M=;
        b=XALP4EG8LwZ753gztoRbPnE1cddOdELmWsQjlHuKXYiiKKvPi4GNb7ikS5+Zka8tTV
         KRyG/1pU87tYXfBUATPEXGrCN5Q3ChxywhhcH76a2c8D26vPhpfI8ogwNByiMv/TJdN+
         F3oPGCnLGPyN8DNNcYfu5JBfdhSFuBv1bvuBVaCgMCy9TadBcWFop1q1dyRRPqA0V0xN
         W0NsvPessyesxW56oNMAsYLCI46xVhrz0D2P2UztEckbg9SEPzDej4z0sZaJuLAObQ7G
         jHkHVA7gSRTPYhaztbfAnOpg4C42V6qO5goxFNQNsXbDjsBn2Ja4qbo+KQKpa5XV+1kg
         V86Q==
X-Gm-Message-State: APt69E2DzObfZY0WiZTJOgLobYf2UXxzviFaiKsisj1YAFP5pGp/QyBW
        /d/OWcMXUDmIBatLqFT+HAVQbTSW
X-Google-Smtp-Source: ADUXVKL99DGbcfOItYLKtnk5ZsLV63zU2NWmSFe2uZzec5h9H5pa9agjRQ6BL0Bg7io4ouAM1XbVhw==
X-Received: by 2002:a1c:a8a:: with SMTP id 132-v6mr6979163wmk.44.1529624133096;
        Thu, 21 Jun 2018 16:35:33 -0700 (PDT)
Received: from [192.168.0.108] (46-10-48-153.ip.btc-net.bg. [46.10.48.153])
        by smtp.googlemail.com with ESMTPSA id w13-v6sm963480wrl.20.2018.06.21.16.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 16:35:32 -0700 (PDT)
Subject: Re: [PATCH] net: bridge: fix potential null pointer dereference on
 return from br_port_get_rtnl()
To:     David Miller <davem@davemloft.net>, garrmcnu@gmail.com
Cc:     netdev@vger.kernel.org, stephen@networkplumber.org,
        jiri@resnulli.us, bridge@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180621201427.4961-1-garrmcnu@gmail.com>
 <20180622.072056.1223319763674661318.davem@davemloft.net>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e4fb2883-1643-a921-a138-d1255831a9bd@cumulusnetworks.com>
Date:   Fri, 22 Jun 2018 02:35:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180622.072056.1223319763674661318.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 01:20 AM, David Miller wrote:
> From: Garry McNulty <garrmcnu@gmail.com>
> Date: Thu, 21 Jun 2018 21:14:27 +0100
> 
>> br_port_get_rtnl() can return NULL if the network device is not a bridge
>> port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
>> br_port_fill_slave_info() callbacks dereference this pointer without
>> checking. Currently this is not a problem because slave devices always
>> set this flag. Add null check in case these conditions ever changye.
>>
>> Detected by CoverityScan, CID 1339613 ("Dereference null return value")
>>
>> Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
> 
> I don't think this is reasonable.
> 
> The bridge code will never, ever, install a slave that doesn't have
> that bit set.  It's the most fundamental aspect of how these objects
> are managed.
> 
+1

This keeps coming up, here's the previous one:
https://patchwork.ozlabs.org/patch/896046/

Please do a more thorough check if these conditions can actually occur.
In this case, as Dave said, they cannot.

To be explicit as with the patch I mentioned above:
Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

You can find more info in my reply to the patch above.

Thanks,
 Nik
