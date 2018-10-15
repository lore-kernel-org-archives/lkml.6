Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D94C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34B9208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5hPACx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34B9208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJPCV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeJPCV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:21:26 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1612220881;
        Mon, 15 Oct 2018 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539628500;
        bh=7YDvBM1nUO7oaMDR1/tNE5L7X2ZWSgDKOXHQ0rMcsRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5hPACx4BQPCYLEaVfpUkcKGCer3KmAiORvA/aMAEv7NYDLTpYY9VRGLp1WTsJshj
         QpD9E+eskHPmtR44sw3dk23NG0k1k8WBqFRsslxzAsbp1w9R0VsfGbUPDVVmIVbxuB
         S0WF+7nYbtG8WkpwWkWqUe8svjhH7rFNFZSjc2b0=
Date:   Mon, 15 Oct 2018 20:34:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH v3 06/15] platform: goldfish: pipe: Move memory
 allocation from probe to init
Message-ID: <20181015183458.GA28454@kroah.com>
References: <20181003171720.169953-1-rkir@google.com>
 <20181003171720.169953-6-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003171720.169953-6-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 10:17:11AM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> There will be two separate init functions for v1 and v2
> (different driver versions) and they will allocate different
> state.

You should only allocate memory at probe time, not init time as what
happens if the hardware is not present yet your driver is loaded?

You should do almost nothing at init time except register with the
proper bus so that your probe function can be called if the hardware is
present.

So the patch here is going backwards from what it should be working
toward.

thanks,

greg k-h
