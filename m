Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CC3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936A320863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549874299;
	bh=6MP/TrHG9ZTAzKHRXxed+wFH9mNc3Ykl1L68d7LQsuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XJoPt9m/OzuqPaPUoT7Y/rjAs2BQiXo81BUdRpqroKNXI5gZ4ORRkKBGtymt+yzxB
	 VP+OHTUF5HD7fHApZxJhTNdxnng4/6KxuylJSxotvGXjNGpyP3A8/wkB8WaSSMPWq7
	 3pNoC6H8yUfR+bgc6B7Q4IGKzFXs0fZD5x2E2ZE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBKIiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfBKIiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:38:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A3420863;
        Mon, 11 Feb 2019 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549874297;
        bh=6MP/TrHG9ZTAzKHRXxed+wFH9mNc3Ykl1L68d7LQsuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtMNdT9zrH5iaY5lJ1xWESVAiw5x1IdLqpLvAXfDpjO8n4C6LuWFDPBPuEfmlcYHz
         h128KtjL+sn3PwjZCR0UFicFSfxyqwvGXVFGiATHMKcyZHQWP+nKWRR9QY4903U2nO
         R+husRZbTHHCpwuCv6EnrD7aIAmX33pEFW/mjiQ0=
Date:   Mon, 11 Feb 2019 09:38:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] parport: daisy: use new parport device model
Message-ID: <20190211083815.GB5207@kroah.com>
References: <20190209205907.3770-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209205907.3770-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 08:59:06PM +0000, Sudip Mukherjee wrote:
> -	return bus_register(&parport_bus_type);
> +	int retval;
> +
> +	retval = bus_register(&parport_bus_type);
> +	if (retval)
> +		return retval;
> +#ifdef CONFIG_PARPORT_1284
> +	daisy_drv_init();
> +#endif

Shouldn't you hide these #ifdef lines in the .h file instead of putting
them in the .c file?

thanks,

greg k-h
