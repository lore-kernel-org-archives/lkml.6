Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C824C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F27B2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxD8y4xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F27B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeLEGEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:04:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37098 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:04:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so17202951lja.4;
        Tue, 04 Dec 2018 22:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CS4vtvQelp5gpMEkctN0BYyuL98AEddXz23ekuUXwrA=;
        b=oxD8y4xprxMKRX7SoDG5hwKscSvm4QLPJdo4G3MSFfYSKjm3YMJacfyuTwTry2P34D
         qxhezBjnyX4HrfAyl5VnLRsC5Bz4AM6+GFcviMgHdBvt/lQBV+r9j/o55O/T6s0GKH8V
         junNqKQnspjTwAh6NjUWI6Dn8/H+lSbvATE/qrjBWyyJhspo/Eno5lrgff4l/ndK2yM/
         odVJApnhXFxd8z5ZIdMpE5Kldv4QNE3jnRP49O0+H20kku+NW7qcptPVWnhubjEsip+l
         iuUnpokyp1cA1k5piSYzynYN5yWqjCPANF6DNMN53TwVg471zF4LPK3RGfeVnUTvYpFL
         dqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CS4vtvQelp5gpMEkctN0BYyuL98AEddXz23ekuUXwrA=;
        b=qiCD05HFd9sd5UP2oepqJ/AgSZ+lUCn+wihlG9w9w1IKDolEvvfE/MSqM89/rpdg8J
         r3u7VtmDZaGIUni2iFzBGdyKaMsaQb72EpzdEJ63wZ87nVSMwe1JuiS7UuH57ICJo94X
         yjBf/q8TlcBwZWSHbZ7lhQfX3Iks2GrsEadC/dRTuecZ14xPj/5uziMaNPMeveNqd4dG
         0FdNGp2+qiyCPbzTQW2h3MKUtKpxwpxdgAEseGCJFFbFj7puHqSz+CwcAFhiObbyhBo/
         OL94bntJMTC5jJeiY29gzbI9D49H0hsX2lQK9AiiUERtMA2N24Xr2XPK9ZLjbx3Nw63p
         0ngA==
X-Gm-Message-State: AA+aEWbM2C8qgCFhHkRfCRJtWYuPUvplG7W4UcTgPeCmIzBFKDSQkz9d
        xuR9+9gUEApG/1pZyLMPUUs=
X-Google-Smtp-Source: AFSGD/V7l6qy+y3m75xA4nCxxyr+7Z5813HdlE9Lvrdeu+til/aZGVAu+t0q9h/QteIqvYki5CwTxQ==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr5091381lji.112.1543989838484;
        Tue, 04 Dec 2018 22:03:58 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x24-v6sm3909551ljc.54.2018.12.04.22.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 22:03:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUQHv-00010z-DK; Wed, 05 Dec 2018 07:03:59 +0100
Date:   Wed, 5 Dec 2018 07:03:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jackychou <jackychou@asix.com.tw>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        louis@asix.com.tw
Subject: Re: [PATCH 1/2 v4] USB: serial: mos7840: Adjust port settings for
 read and write registers
Message-ID: <20181205060359.GE18087@localhost>
References: <20181130063122.24217-1-jackychou@asix.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130063122.24217-1-jackychou@asix.com.tw>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:31:21PM +0800, Jackychou wrote:
> From: JackyChou <jackychou@asix.com.tw>
> 
> In the read/write function, set port 2 independently in the 2-port case.
> 
> When setting the offset of port registers, the offset between port 1 and
> other ports is different, so port 1 is set independently.
> Then in the rest of ports, the port 2 between 2-ports case and 4-ports case
> is different, so port 2 in 2-ports case is set independently.
> 
> Signed-off-by: JackyChou <jackychou@asix.com.tw>
> ---

Thanks for the update.

> +	} else {
> +		u8 port_offset;
> +
> +		if ((mos7840_port->port_num == 2) && (serial->num_ports == 2))
> +			port_offset = 1;
> +		else
> +			port_offset = mos7840_port->port_num - 2;
> +		mos7840_port->SpRegOffset = 0x8 + (2 * port_offset);
> +		mos7840_port->ControlRegOffset = 0x9 + (2 * port_offset);
> +		mos7840_port->DcrRegOffset = 0x16 + (3 * port_offset);

I simplified this further as:

	} else {
		u8 phy_num = mos7840_port->port_num;

		/* Port 2 in the 2-port case uses registers of port 3 */
		if (serial->num_ports == 2)
			phy_num = 3;

		mos7840_port->SpRegOffset = 0x8 + 2 * (phy_num - 2);
		mos7840_port->ControlRegOffset = 0x9 + 2 * (phy_num - 2);
		mos7840_port->DcrRegOffset = 0x16 + 3 * (phy_num - 2);

before applying.

Johan
