Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BAEFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB7E206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFJfKOGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB7E206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeINTBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:01:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38665 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeINTBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:01:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id d7-v6so2517016lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nlEahoLBt27+S4Emdzo1dXS88bPfeNFOvsp+5deKzI=;
        b=LFJfKOGYHWgdYFBpVjScd1TapXB924RFdF4GIaeiEr1Os7sh6KL2Tk5hv2eIBoJz1T
         yvzXz/DZEptXFITU00r+KePqc3MT41Uv3ynytHexs5zpEi93ybLrzyyhAHxZkvyVcICL
         9V1M6Q2kClwyATrJrzleSpDA/44/1ye60kSJaB6av1L+z9PQHGi16aOBXHJfdGGtWSok
         1WQKJwbSZ1XBh7fS7dXF6JNIqa4P/R5kPjmSr/4lNlPRYi/hJV66BXHHC90Pk0U0Sbab
         ksYIAHhKnyxPX/PT0v+3trvDfpCOMueYFqKC2ezh6JAu0lSnJm/508XguHcSLOrSsenY
         B0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nlEahoLBt27+S4Emdzo1dXS88bPfeNFOvsp+5deKzI=;
        b=bGF7UXPCiVzJi/PoaG3mGIkhdw3E+4ZSJCMEZc7oeqGjwURQiDL60LQT6EpdHJnsw9
         SP8PxYq1WyQSaTCIy9eWpXvDj49Bus2mFRGbVke2M7wbtL8beM5lZmTrqSxbQ6fhRdOR
         rpqC4q/wghfFHaMJQJ914TsM/Kh84Q/R3SeY6sPzZHBM+Bet9keiW39bs57bd+t3PCXn
         /OL3AhKkmokugqHW+JhKmTt7D1wxuM7kGwUbzlc9V8WZOqaZWfNQ207OG7I/33R2mC6p
         9wLEo+vc+RVdfuic23mlC+Mle/v+3R7+A/9Af+d53TB9rN5UdMGHIoKd97StONnVmvj7
         KD/w==
X-Gm-Message-State: APzg51AIaUmV2km1V7UPraQcQdEQU5O/h9dn/gzeYlcNuL0xueWo0OPA
        dvtgCRdN13SOoadmRTGhSptuVG8B
X-Google-Smtp-Source: ANB0Vdb9CxBM7ErwWYkWS41vTVF6e0fYyH0OqkvghlolbwLQOtvE/ITqvj5IkZftjZ7ZyOPqWr18qQ==
X-Received: by 2002:a19:1586:: with SMTP id 6-v6mr2851699lfv.72.1536932836183;
        Fri, 14 Sep 2018 06:47:16 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r23-v6sm1186605ljc.15.2018.09.14.06.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:47:15 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oRJ-0002iO-NT; Fri, 14 Sep 2018 15:47:17 +0200
Date:   Fri, 14 Sep 2018 15:47:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/50] fdti_sio: switch to ->[sg]et_serial()
Message-ID: <20180914134717.GJ1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-22-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-22-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:21AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
