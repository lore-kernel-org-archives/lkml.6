Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABEBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA24217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546535824;
	bh=W7Wiltv5gCLIUwsnevB3rRn0lr2jwTqaPd8I/6WmpVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dFsVIbzopQ5sOziODSXI6w1uupyzhhO08YSDyiezfthACXGT7Xhwo4WfTd92y4480
	 VXhjgy0ZJdu7qSJl8Vc3ctAcPowCXjIGrqwuJdvdrgQcXozbfhSUcgvtu8+cRl+lgZ
	 B0IDBFYTOoEkW48MxUmE/mYW/EWJh3p2uN+OCQJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfACRRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbfACRRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:17:03 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E7892073D;
        Thu,  3 Jan 2019 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546535822;
        bh=W7Wiltv5gCLIUwsnevB3rRn0lr2jwTqaPd8I/6WmpVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYVvmgopgiHQa6Y48PXGBAZOhaXzhx9G9qY9BlpzkQAmvFjTO0uBcTsvrVglf9hN+
         cAbkBO9Ajn1vcYtWU0AcV10yE2MbYGUPgbSUEc1cu9Mu5tFl+/MVt0uyN+KFr3lX5n
         M4l04VhcRHxYgrVFrN9KEjIDFmSyckVtPiwi9kdM=
Date:   Thu, 3 Jan 2019 09:17:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Howells <dhowells@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: Bug report: unaligned access with ext4 encryption
Message-ID: <20190103171659.GA208343@gmail.com>
References: <20181230162906.GI27785@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230162906.GI27785@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 06:29:06PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> When using ext4 encryption on SPARC, there's plenty of dmesg noise about
> unaligned access:
> 
> [  167.269526] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
> [  167.270152] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
> [  181.087451] log_unaligned: 5 callbacks suppressed
> [  181.087511] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
> [  181.092435] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
> [  181.095816] Kernel unaligned access at TPC[5497a0] find_and_lock_process_key+0x80/0x120
> 
> And also seen on an ARM machine:
> 
> $ cat /proc/cpu/alignment
> User:           0
> System:         1028193 (find_and_lock_process_key+0x84/0x10c)
> Skipped:        0
> Half:           0
> Word:           1028193
> DWord:          0
> Multi:          0
> User faults:    0 (ignored)
> 
> Looks like user_key_payload layout is not optimal when data address
> is used for fscrypt_key... I tried the below change and got rid of the
> messages. Not sure what the proper fix should be?
> 
> A.
> 
> diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> index e098cbe27db5..6495ffcfe510 100644
> --- a/include/keys/user-type.h
> +++ b/include/keys/user-type.h
> @@ -31,7 +31,7 @@
>  struct user_key_payload {
>  	struct rcu_head	rcu;		/* RCU destructor */
>  	unsigned short	datalen;	/* length of this data */
> -	char		data[0];	/* actual data */
> +	char data[0] __aligned(4);	/* actual data */
>  };
>  
>  extern struct key_type key_type_user;
> 

Hi Aaro, thanks for the bug report!  I think you're on the right track; it makes
much more sense to have the keyrings subsystem store the payload with better
alignment, than to work around the 2-byte alignment in fscrypt.

But how about '__aligned(__alignof__(u64))' instead?  4 bytes may not be enough.

David, what do you think?

- Eric
