Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF9ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8024221526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qg3ATQog";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XQtlv1at"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8024221526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeJQP2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:28:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJQP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:28:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4A33060B62; Wed, 17 Oct 2018 07:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539761651;
        bh=fr4Xzf6ysKak5a7qQ4fy5FBzV+DFj3YniUo+bTcF3Gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qg3ATQogn5fOdZ3YQey97EkXjpXEMLb2Xbs1NrHxm02YdOurWSeEWlEPfetTU/ztk
         kXMClxyX8JK+oicd2sc4pb1c/bHHiYolHjMzDLIbvTq0SYhMUQ2nIRx7VrSZK6OG5X
         2w+3Qe0tuzzsSIt4yFoIsGB/4mi8Trgm18UIW6WE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B5AB360769;
        Wed, 17 Oct 2018 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539761650;
        bh=fr4Xzf6ysKak5a7qQ4fy5FBzV+DFj3YniUo+bTcF3Gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XQtlv1atsjeN7XEbDSpIsrltB0fhZTKhBom55InceuJKSXH+IqNIoCVwNfm+j9OHn
         VpPm5vl3sv0ghxuOfngLBratrhFmv8hGDLxYv4evJjjCcSETmD16Ayc+v4kjdldnEb
         fXQSrH83EzdpmgmoeHyJQ2gUgA1KksMjvdl8dW0U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Oct 2018 13:04:10 +0530
From:   msavaliy@codeaurora.org
To:     Douglas Anderson <dianders@chromium.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        alokc@codeaurora.org, mka@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Don't slow all ports just
 for kgdb
In-Reply-To: <20181015204425.84537-1-dianders@chromium.org>
References: <20181015204425.84537-1-dianders@chromium.org>
Message-ID: <6a4b57b252c01d312be10ce586be7d7d@codeaurora.org>
X-Sender: msavaliy@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-16 02:14, Douglas Anderson wrote:
> If you turn on CONFIG_KGDB then you'll get CONFIG_CONSOLE_POLL
> selected.
> 
> If you have CONFIG_CONSOLE_POLL selected then the GENI serial driver
> was setting RX_BYTES_PW to 1 for _all_ UART ports.
> 
> This doesn't seem like such a good idea.  Let's only set RX_BYTES_PW
> to 1 for the console port.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/tty/serial/qcom_geni_serial.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
Good finding, Makes sense to keep changes this way for console only 
port.

Reviewed-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>

