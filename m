Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2912089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW848AQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2912089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933568AbeGIS6H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:58:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45947 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932738AbeGIS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:58:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so12297424oic.12;
        Mon, 09 Jul 2018 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RfK7/4CWsOBwZV2WLKFkALATW8hje5J5e1tNIbLB2+Q=;
        b=BW848AQym3EctUNol3HtKNdRLsXUe68HGlu0TQGpvRRS2Q5eAdt94uhiWtoQd0YdGv
         pvr9FNyLpzHdykENyV4ng0crTUW54DLaLdreySQq1Ea/Udp3bSvwv7SzbFRfHb7u2aDD
         slWGvYUribejoh7yBxB3+/x6gNah0UQRoZtYeyhdctIuZ2RTQKyNAgRszttPZK59/CE/
         7t7WV7hHYM1/TzWTIdYcZsU0PYy6IRkUXbk6KMmVh1FX8SMQx6o6ZotnZHfJc9GzEvgo
         LyKp1EQbIs7QI8JyAiAwUGOxt9XKqBAHU74RBOqbGZ1YS6EDlnI/ObWTzUqxBAC/j+tH
         C/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RfK7/4CWsOBwZV2WLKFkALATW8hje5J5e1tNIbLB2+Q=;
        b=EOvfXd/jwctD7LSCux/pO0DTOPLZqIus5jS851bRHn1O1fJWCO+2ktTjS73TqSvjP3
         YKM+oMTszTjab5Lvbz/JuZQWWFlBikUTPAa+KEcMZtRDveKLsT9E2BbB6gcTMDAFtMp4
         JpxoCHqeTW2plfjK/kOfddcLl8MurZJA3K/jnVH/tQnhtKp81oYEfL9yXsq391ZIc8wD
         eub2mN7/Lp0ck7kHSQwHQXf3Z+J4PCIeZAtCR/sTU63igVwVX4M4BY9lGzCvjFBOZOXI
         KewQroXmRfb/C6Xfcy+fAP4j8svtV0losE5bCD8styZDfvvXfKVumwcoNnrAiIVttnSQ
         kBIg==
X-Gm-Message-State: APt69E14sE7HhVHe4J80J15udMXIfn+KBsqrmkj+Y11Lu3vkzVMTKTi9
        Iha5ZA/FUuDnZk+WOx9kQVk=
X-Google-Smtp-Source: AAOMgpdySrbeX74DfVVYKdBasF2RjGRc+KWEmjx+g2msieWyxzkebdUeajfdeBXmRNF5r5Z8fwwnIQ==
X-Received: by 2002:aca:4dca:: with SMTP id a193-v6mr22864409oib.343.1531162684744;
        Mon, 09 Jul 2018 11:58:04 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n6-v6sm8601272oib.27.2018.07.09.11.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 11:58:03 -0700 (PDT)
Date:   Mon, 9 Jul 2018 11:58:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] usb: pd: include kernel.h
Message-ID: <20180709185802.GA1896@roeck-us.net>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
 <20180627151953.30942-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627151953.30942-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:19:46PM +0300, Heikki Krogerus wrote:
> This makes life a bit easier for the drivers that include
> pd.h. All pd_header_*_le() inline functions defined in pd.h
> call le16_to_cpu(), and all *_LE() macros in pd.h call
> cpu_to_le16().
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  include/linux/usb/pd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 09b570feb297..f2162e0fe531 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -15,6 +15,7 @@
>  #ifndef __LINUX_USB_PD_H
>  #define __LINUX_USB_PD_H
>  
> +#include <linux/kernel.h>

What is more appropriate ? This or asm/byteorder.h ?

Guenter

>  #include <linux/types.h>
>  #include <linux/usb/typec.h>
>  
> -- 
> 2.18.0
> 
