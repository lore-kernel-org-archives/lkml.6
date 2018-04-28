Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524927568; cv=none;
        d=google.com; s=arc-20160816;
        b=Om6D1mjxHNyrFv7fkrVEHXRCCJpCWC+EgmEv+VuxrMpWy8NRyMW/OqIqw1FD5+iuIk
         xg3rQeR38wK8gOyTIvjnufLuJPfu+PdrtulLyjNH732ckDf4dfZBUhYubK7DK3bQIIIc
         0kDKTwEqnjri9c8yCusrEPrvFp8x8aLqRZ85XYmmniEzsf0a75KzcIvzGRWnhstwnbhu
         Tm6Pxa9w7bw9rfJphpE71exNcIPv2/9CvbSjWCighQdkNFGV7Ornfbr6Nxa5+qVdsMzh
         bqdp27w//bpxsZstNDir946MnbzKr1WXu7pnglgF046ORwOi8duZ011DkidcxXPf0UlA
         +S3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=5Usux9xMqUtGKuOHXL45zwgDumhlLgqyqfAWGJbiWSg=;
        b=ZaPaimViYoKqZ5H1B/8Btul0w8amaajPrJOYk7opOF+FxsazJ/fbzqOjlpjLVquPGD
         KZo2Cxr6N01YLJZPGcaOgm7h6dng8k/bBVQmHZYxRb5Q9P6LUev1ljiTMvln0lMNDcmC
         oV9Wp7Cju6crsSyrwb8IUJgdCq0L3Rupg6hS6dOYKDMk9CgdPpVHbHU0jRAkYf8X8to0
         w00jZhO0I9f78AJb3fp6ONJOr5Bj6eTtq4izlzfVx5aenLeI+17ydlMzGUAVm1pG2mIw
         /83Tjq8Xcp2hMX/qdF7FBQ295O6vbdz88QYt/GmB5FbP0F9T+NO4HdzgJX3/qZXjxKmB
         EMaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=D2lZseIg;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=D2lZseIg;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqkTCLclsXqc7RmEfMIdE/FLa/2DhiTgQzHM+I+d/qvCPTEISgdforplCwiCNdr8IycN56P+w==
Date: Sat, 28 Apr 2018 09:59:25 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, Theodore Tso <tytso@mit.edu>,
	Thierry Escande <thierry.escande@linaro.org>,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH 4.16 163/196] random: fix crng_ready() test
Message-ID: <20180428145925.jsjnx4rgljbcxi3e@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, Theodore Tso <tytso@mit.edu>,
	Thierry Escande <thierry.escande@linaro.org>,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180422135112.655853962@linuxfoundation.org>
 <20180427163443.fdsixdsrwwkycuhh@xps>
 <20180428060003.GB18371@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428060003.GB18371@kroah.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598455333623900338?=
X-GMAIL-MSGID: =?utf-8?q?1599002449592121561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 08:00:03AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 27, 2018 at 11:34:43AM -0500, Dan Rue wrote:
> > On Sun, Apr 22, 2018 at 03:53:03PM +0200, Greg Kroah-Hartman wrote:
> > > 4.16-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Theodore Ts'o <tytso@mit.edu>
> > > 
> > > commit 43838a23a05fbd13e47d750d3dfd77001536dd33 upstream.
> > > 
> > > The crng_init variable has three states:
> > > 
> > > 0: The CRNG is not initialized at all
> > > 1: The CRNG has a small amount of entropy, hopefully good enough for
> > >    early-boot, non-cryptographical use cases
> > > 2: The CRNG is fully initialized and we are sure it is safe for
> > >    cryptographic use cases.
> > > 
> > > The crng_ready() function should only return true once we are in the
> > > last state.  This addresses CVE-2018-1108.
> > > 
> > > Reported-by: Jann Horn <jannh@google.com>
> > > Fixes: e192be9d9a30 ("random: replace non-blocking pool...")
> > > Cc: stable@kernel.org # 4.8+
> > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > > Reviewed-by: Jann Horn <jannh@google.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > This patch has caused a regression on 4.16 using kselftest lib/printf.sh
> > - specifically, when it runs "/sbin/modprobe test_printf". This
> > regression has been detected on arm64 dragonboard 410c (not seen on
> > other arm64 or x86_64 devices).
> > 
> >     /sbin/modprobe test_printf
> >     [   22.725551] test_printf: hashing plain 'p' has unexpected format
> >     [   22.726031] test_printf: failed 1 out of 236 tests
> >     modprobe: ERROR: could not insert 'test_printf': Invalid argument
> > 
> > This problem has not been seen on 4.9 or 4.14 under the same
> > conditions.
> 
> Does 4.17-rc2 also fail like this?

No, but I did see it in v4.17-rc2-102-g3442097b765c, and it was fixed in
the subsequent build:

good: v4.17-rc2-64-g26ed24e429d8
bad: v4.17-rc2-102-g3442097b765c
good: v4.17-rc2-104-g69bfd470f462

I haven't investigated deeper though, and I do not see any changes to
random in those above revisions. This test passes on all the other
mainline builds, including v4.17-rc2.

> 
> You all are testing the -rc releases, right?  :)

We test every push to mainline and we test -next daily.

> 
> I think the random changes that will be in 4.17-rc3 should fix this, and
> if so, I'll suck them in here too.  But testing that would be good to
> see happen...

Waiting is fine with me.

Thanks,
Dan
