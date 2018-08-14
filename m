Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11022C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BDC21772
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BDC21772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbeHNMIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:08:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:08:00 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84DFAC19;
        Tue, 14 Aug 2018 09:21:39 +0000 (UTC)
Date:   Tue, 14 Aug 2018 11:21:35 +0200
From:   Greg KH <greg@kroah.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     security@kernel.org, kdeus@google.com,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
Message-ID: <20180814092135.GA10316@kroah.com>
References: <20180813223910.26276-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813223910.26276-1-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 03:39:08PM -0700, Suren Baghdasaryan wrote:
> When handling SHDLC I-Frame commands "pipe" field used for indexing
> into an array should be checked before usage. If left unchecked it
> might access memory outside of the array of size NFC_HCI_MAX_PIPES(127).
> 
> Malformed NFC HCI frames could be injected by a malicious NFC device
> communicating with the device being attacked (remote attack vector),
> or even by an attacker with physical access to the I2C bus such that
> they could influence the data transfers on that bus (local attack vector).
> skb->data is controlled by the attacker and has only been sanitized in
> the most trivial ways (CRC check), therefore we can consider the
> create_info struct and all of its members to tainted. 'create_info->pipe'
> with max value of 255 (uint8) is used to take an offset of the
> hdev->pipes array of 127 elements which can lead to OOB write.
> 
> Suggested-by: Kevin Deus <kdeus@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
