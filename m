Return-Path: <dsterba@suse.cz>
X-Google-Smtp-Source: AIpwx4/FFvZMWtd8aV96mJqoTxnzF7jmad5DlZgJKCUQCI0OL2CIIyQ3hwC/+NCN8JJgmH2NvEFG
ARC-Seal: i=1; a=rsa-sha256; t=1523445136; cv=none;
        d=google.com; s=arc-20160816;
        b=Ai/ZXQeyJkFlOSUMYvmdyqHaWs6L/raGO9eM/GohIn3Q3y1P4LqZDTKRK2MBmTPmHb
         bWcNrl10TI56pDzdrb3yvPEmuu3VwkJCDcBNgPycF1FCjZ+PDmv7hdNOGjswsQ7mpnHE
         pCPFa8Ro2p72sR0C235GoxkckZop4MDy2e6vkJraquOt18msO8BZ/6kMFnCn7ry/pqeX
         NxvCS8YwLFpOyC/sI1K/bmGewF7Z6Mn9MCM29BeSZzpp+RKwEr/FDVRQVdlwjq/9WLRL
         yTKnsFB8/2xc6d7V0eyfDK8A+AswsetG50QcDfWNER1ALXjkDptUXMyNihsfObh8GxJt
         9JAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=icIenROs0wInk5toLXQcyUScMJj6oDTrpJ2Bblsm5Vs=;
        b=PVSyWdr+vRB/X71ymPfAG7HRyinVYD3whGMhZFLbX7Ys5ViXliXBrRQeuirdPK0ZJR
         7o54ZIUtE2kv4BWBBylbIP8QW/IuZVCOhJLT/NFMdj9Wd/2ojr5l8NjDx3DZ5yeFJNW9
         6UFW0Wp24pDdcKrHFGNFsr4vlLrKCBY+PdOuLweu+3CljECPSuYAPHC5g1WuWkV8zIag
         r/wXKBR1Gp0iMUeMoUr/KvKN8dGns4m0fZlt7Y9dtoeEttKMRXQ66GFMJMBMsAtO8JkK
         8svlWOaMfFrkZZNJyFXE87EzIspYswoIpsxmuTSuNL6sY5wWxiHNgFzEwjrvCZDDuUr4
         Vciw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dsterba@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=dsterba@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dsterba@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=dsterba@suse.cz
Date: Wed, 11 Apr 2018 13:09:45 +0200
From: David Sterba <dsterba@suse.cz>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: davem@davemloft.net, johannes.berg@intel.com, jikos@kernel.org,
	gregkh@linuxfoundation.org, stephen@networkplumber.org,
	Jiri Slaby <JSlaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: ipwireless: Replace GFP_ATOMIC with GFP_KERNEL in
 ipwireless_network_create
Message-ID: <20180411110945.GA21272@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>,
	davem@davemloft.net, johannes.berg@intel.com, jikos@kernel.org,
	gregkh@linuxfoundation.org, stephen@networkplumber.org,
	Jiri Slaby <JSlaby@suse.com>, linux-kernel@vger.kernel.org
References: <1523349106-29584-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523349106-29584-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597347322364831105?=
X-GMAIL-MSGID: =?utf-8?q?1597448006839738033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 04:31:46PM +0800, Jia-Ju Bai wrote:
> ipwireless_network_create() is never called in atomic context.
> 
> The call chain ending up at ipwireless_network_create() is:
> [1] ipwireless_network_create() <- config_ipwireless() <- 
> 	ipwireless_attach()
> ipwireless_attach() is only set as ".probe" in struct pcmcia_driver.
> 
> Despite never getting called from atomic context,
> ipwireless_network_create() calls kzalloc() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: David Sterba <dsterba@suse.com>

We don't have any other patches queued for this driver so it would be
best if this patch goes via net or Greg's tree.
