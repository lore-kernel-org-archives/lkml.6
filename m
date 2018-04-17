Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx48RCBwUZGcyH6iqJ1rC/RlGp43gdAPyP6VIt6nsfSW3IvcmeVjV4A008UA4UY+u1vaWFeLL
ARC-Seal: i=1; a=rsa-sha256; t=1523974413; cv=none;
        d=google.com; s=arc-20160816;
        b=j1SpBC9XNFy2Gg+9TKW+TGse0/y/znAqJd8mRW1AM2kbirOww0W3c0nzLnWqL/v9It
         SKgWXP1vkbDNdjFbRegmi8y+G0wsuuVyzBs+t1Cijv0gXXdGWj6JQyPaiYizF67Eseks
         dhbeOD7+YFcZfIvX68tVl3J5cXb/ta7btodJKdgSzGbjqqOb35kS1KJ/ISGnNFMrnqcA
         mqklzgno+0zzxgTWye/l0Fln76+Rnm1G8nmt5R1LXrSKO6ohPwBtcAkCxIJ3l8SllraF
         W/JNMqlxC6rsHufnkpBliVErm0XAm4mTYzLy68oIMzq7yKmyT7wCzIQBWcaBA931JH7Q
         7SbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9MX6o8ylcXA1YFOfejF6HYU8mPVTGRQXYpSrOn5cYLo=;
        b=ipwHFhcJIfENUfKylQ6G8C7zsJ2oeXUD++oiQC5P0ceRpB8VZZ5f/QM14QzG86qrQ6
         HmhjTGrvLUSz/2VqOcrxQSUNJcWAesnf17cJEKGVyzDV3j7vGDGc3lS7kFT6lwBTqoNC
         0GTMUekWIVeCYP62BiYbaJ/024vvX5CztgLTCb7tK7cRPyrl93l/HhfolrfNmxY5wgcD
         wDEd8WxNmrribn6bvLweet+e7GzEUjrj6b9iITyPWQBAm8ayUhU5DZ5pgbu/bE+2ljer
         2OO7I1HG8HLH48QyMa5vba3n9fGnVJ4pNIVyZk6M44CUfG/1HuirT/JjB+KGWGmeHdpl
         WkhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SFzaliwh;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HI0yn72g;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SFzaliwh;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HI0yn72g;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23C7D60C64
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org, arnd@arndb.de, timur@codeaurora.org,
 sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Helge Deller <deller@gmx.de>, Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
 <1523957852.3250.9.camel@HansenPartnership.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
Date: Tue, 17 Apr 2018 10:13:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523957852.3250.9.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597964966697704374?=
X-GMAIL-MSGID: =?utf-8?q?1598002994114205632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi James,

> 
> Perhaps if you gave an example of the actual problem you're trying to
> fix we could assess if it affects parisc.

Let me clarify myself here. Maybe, there is a better solution.

		/* assign ownership */
		desc->status = DEVICE_OWN;

		/* notify device of new descriptors */
		writel(DESC_NOTIFY, doorbell);

The difference between writel() and writel_relax() is writel() guarantees
memory transactions to be flushed to the device before the register write.
writel_relaxed() does not provide any guarantees about the memory and IO
operations.

Similarly, readl() provides following code to observe the DMA result while
readl_relaxed() does not provide this guarantee.

Ideally, you want to embed rmb() and wmb() into the writel() and readl()
to provide this guarantee.

PA-RISC doesn't seem to support neither one of the barrier types. If you are
familiar with the architecture, maybe you could guide us here.

Is __raw_writeX() enough to provide this guarantee for this architecture?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
