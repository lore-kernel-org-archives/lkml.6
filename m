Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523467862; cv=none;
        d=google.com; s=arc-20160816;
        b=ZKp67H0VSJa8+Z6CjCjpvC3A/dro9WHo1jrIVoqJk0kiboK2u8YjO1MMuPP0PtyWS2
         VKIJRpEwDoFug4Z5FqYO6ldRq1tiwNUmemEDdlIq3kmTCQ0smXBdAW9xwDqjR27Uc/NG
         VDW3cmr/62+nPnoPBxPl83KN837FwBLC7pUWt8fQn2XGVeX3jGwNVua4ypL9CM73e/OI
         mTrci5vP2Q3bzH2t/v/KHeuvljRmyTf/uFQJTgxyannmJsRaMMyy3hNPYg1vId8JQu0f
         xdZeNweG21ppfvgydhjs/78hgdH7maMQ98iV1I+r6uL9yuRhvneCUkXBu1G85uJDB8+s
         tuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=7fN/uZNvrBN6YzAi/VWIa7UP3DhVJYvDiFVptymhecw=;
        b=SOV8QyJD+IgcVxHtXilNCzYcCe8PJwDCSueqodMoX1S7Rf/UReEvosJl8tfLVPfIYV
         aHZKqOlkwoWJZouiSWqX1CauuC+yaVDnHwBiS1pw5LR0KBR0jQo6Kgr8Ze+vsN9mfmRF
         8YKDSdo8/EfT2KQfq59BZtVugRmN5SxIePi7BVWO/Tk2aJJeQ0EHts/g8JKsO0X1mkpK
         h1tnpDwj0PLTAPseUZf++HFLAdIQi5PESsp0P6XBURtKXyeSmF2yQDW84eyaKhCYY5pe
         9qtHoVYM3FrytMPUoBuINmJoFOhm2JFluhNWyNPIl3g66cJ1tR31HGVqcW7V7tn4Jx7S
         Cd7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MiLi0eLJ;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MiLi0eLJ;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx4+VqiJ026lxJL5YhlPH1WBtcaSr8O+qjEcXJkzvEYNkEzp8i3fWv+eRHDRXPTJPGGOlgqwPtQ==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 10:30:59 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411173059.GO793541@devbig577.frc2.facebook.com>
References: <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
 <20180411145632.GK793541@devbig577.frc2.facebook.com>
 <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
 <20180411170018.GL793541@devbig577.frc2.facebook.com>
 <398bad36e2f01e37645a36d052d62136766ee88d.camel@wdc.com>
 <20180411171538.GN793541@devbig577.frc2.facebook.com>
 <6cd1d285f726f81186dbab57c3308cc0b257ff99.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd1d285f726f81186dbab57c3308cc0b257ff99.camel@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597471836930775920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 05:26:12PM +0000, Bart Van Assche wrote:
> Please explain what you wrote further. It's not clear to me why you think
> that anything is broken nor what a "sever model" is.

So, sever (or revoke) model is where you actively disconnect an object
and ensuring that there'll be no further references from others.  In
contrast, what we usually do is refcnting, where we don't actively
sever the dying object from its users but let the users drain
themselves over time and destroy the object when we know all the users
are gone (recnt reaching zero).

> I think we really need the blkcg_exit_queue() call in blk_cleanup_queue()
> to avoid race conditions between request queue cleanup and the block cgroup
> controller. Additionally, since it is guaranteed that no new requests will
> be submitted to a queue after it has been marked dead I don't see why it
> would make sense to keep the association between a request queue and the
> blkcg controller until the last reference on a queue is dropped.

Sure, new requests aren't the only source tho.  e.g. there can be
derefs through sysfs / cgroupfs or writeback attempts on dead devices.
If you want to implement sever, you gotta hunt down all those and make
sure they can't make no further derefs.

Thanks.

-- 
tejun
