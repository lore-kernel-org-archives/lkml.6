Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E404C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04A621916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549627108;
	bh=4KUf/8sCydqE2KQcagZtUgXUvPju1AiNjim+NCn8hIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ivrzuqpTx1CoA6z2fA6rh1hEx1kTFRjGjDia0poR9TiikndliVZcYo6O9bakiv6/F
	 6fYuML4gRxowFOy1IaEX7XVgSU9SPpMKetMDX4QnQDolizjPUNiXGUJqfvHOWFkIMD
	 5FUxEzswrMLn27gZJR0cfOF80cBpN0Z946Fla+YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfBHL60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfBHL6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:58:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F5CF218DA;
        Fri,  8 Feb 2019 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549627105;
        bh=4KUf/8sCydqE2KQcagZtUgXUvPju1AiNjim+NCn8hIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaNeCcGE+znqhbq59P+LKsyLb6lBgTc8Ce8pkfDXJmRKRvBM25FTwDKovQd+SwD0b
         7QY9WcFnWW21udKEwAfdMuORWutzAAXW9lw7KMuxrnsCXIFu0rDPB9pQ+7BldrqY85
         4laahEpClNOhxxVNGzdp4V2woE5AyyuUe4ohTTSM=
Date:   Fri, 8 Feb 2019 12:58:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     23pieces <23pieces@protonmail.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dm-crypt patch in Linux 4.20.6 Commit
 e4efd3184d9a63a7923e5c62fa236254f03c6bf8
Message-ID: <20190208115822.GA5313@kroah.com>
References: <1uWvFLIArHW8L5PlgMMbXz1fok_GsLiCTltivAZWDl9rHLjihpxmIzakchb_s1Ad_S267Ia3FqRj-fgsrm-ROZZuGVBOlHB1lplVZswHzNE=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1uWvFLIArHW8L5PlgMMbXz1fok_GsLiCTltivAZWDl9rHLjihpxmIzakchb_s1Ad_S267Ia3FqRj-fgsrm-ROZZuGVBOlHB1lplVZswHzNE=@protonmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 11:39:00AM +0000, 23pieces wrote:
> Hello everyone!
> 
> It seems since kernelversion 4.20.6 many people have problems mounting their encrypted rootfs while booting.
> 
> Trying to investigate i found this commit in 4.20.6:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/md/dm-crypt.c?id=e4efd3184d9a63a7923e5c62fa236254f03c6bf8
> 
> To clarify this issue also persists in 4.20.7 and isn't occuring in 4.20.5.
> 
> People having the problem often have something like the following config on their rootfs (including myself):
> cryptsetup -v --type luks --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5000 --use-random --verify-passphrase luksFormat device
> 
> I was trying to investigate the code in the commit and playing around with the dmsetup commands mentioned.
> 
> Now on a running system with kernel 4.20.6 i get:
> 
> dmsetup create test --table "0 8 crypt aes-cbc-essiv:sha3-256 9c1185a5c5e9fc54612808977ee8f5b9e 0 /dev/sdc 0"      Works
> 
> dmsetup create test --table "0 8 crypt aes-cbc-essiv:sha512 9c1185a5c5e9fc54612808977ee8f5b9e 0 /dev/sdc 0"
> device-mapper: reload ioctl on test  failed: Invalid argument
> Command failed.
> 
> dmsetup create test --table "0 8 crypt aes-xts-plain-64:sha3-256 9c1185a5c5e9fc54612808977ee8f5b9e 0 /dev/sdc 0"
> device-mapper: reload ioctl on test  failed: Invalid argument
> Command failed.
> 
> dmsetup create test --table "0 8 crypt aes-xts-plain-64:sha512 9c1185a5c5e9fc54612808977ee8f5b9e 0 /dev/sdc 0"
> device-mapper: reload ioctl on test  failed: Invalid argument
> Command failed.
> 
> 
> At boot people have the following error:
> device-mapper: reload ioctl on  failed: Invalid argument
> Failed to setup dm-crypt key mapping for device /dev/disk/by-uuid/UUID
> Check that kernel supports aes-xts-plain-64 cipher (check syslog for more info)
> 
> I don't have a patch for this yet, just wanted to inform you.

Are people also having problems with 5.0-rc5?

thanks,

greg k-h
