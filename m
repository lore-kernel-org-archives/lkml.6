Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KtYwHDN7GVuvPgAAmS7hNA
	; Thu, 07 Jun 2018 18:36:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 602366074D; Thu,  7 Jun 2018 18:36:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB64960590;
	Thu,  7 Jun 2018 18:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB64960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbeFGSgb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:36:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52496 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753716AbeFGSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:36:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fQzlk-00039U-BS; Thu, 07 Jun 2018 18:36:20 +0000
Date: Thu, 7 Jun 2018 19:36:20 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "'tj@kernel.org'" <tj@kernel.org>,
        "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: Re: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
Message-ID: <20180607183620.GU30522@ZenIV.linux.org.uk>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
 <87wovhqex2.fsf@xmission.com>
 <87po17r9ek.fsf_-_@xmission.com>
 <33710E6CAA200E4583255F4FB666C4E21B65E04E@G01JPEXMBYT03>
 <87sh62k3vk.fsf@xmission.com>
 <33710E6CAA200E4583255F4FB666C4E21B66BAC8@G01JPEXMBYT03>
 <87h8mhgsh3.fsf@xmission.com>
 <20180605154210.GD1351649@devbig577.frc2.facebook.com>
 <8736y1dt1m.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736y1dt1m.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:47:33PM -0500, Eric W. Biederman wrote:

> Sigh,  I have found another issue with kernfs_fop_readdir.
> 
> We are not currently protecting file->private_data with the kernfs_mutex
> or any other kind of serialization.  Which means if two processes are
> calling readdir on the same file descriptor we might get unpredictable
> behavior.
> 
> It doesn't look too bad and easy enough to fix, but definitely something
> to be watchful of.

As discussed off-list - this is not a problem; getdents() et.al. are
serialized on per-struct-file basis by fdget_pos() in relevant syscalls,
since all directories automatically get FMODE_ATOMIC_POS in ->f_mode.
