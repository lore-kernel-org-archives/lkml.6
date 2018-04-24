Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AIpwx48y7bxqCmpdtJcAGk7QMMrL2dr1uWwvwi5uMJPw95QmFAeMDssRn/o/it3kWtY01LAbl81+
ARC-Seal: i=1; a=rsa-sha256; t=1524579234; cv=none;
        d=google.com; s=arc-20160816;
        b=qAQ8zfQAYiFtHyrSxgJ2/PjGog+9lDfWn12TyvERIGJGXJOTzk1hKelrsXLwlgC7ou
         q7rDycn+JcREEzjn53gcbbrtpaK1VEqoDif9VppvdzEuncl+ONZLS4z/jropE2JmihXn
         c8tSdSv77wrDcFRR6KU5XsXkZVekdDSrszqOLQmgpXxyOf0ousbEdaiQ9Ab+DdDx40jg
         aW/qDXspE9CwqA7JJ7LoGWNTsI1Fo/cAvZ0CmZrzAiFLWBglJLGeWxGNB5y4ilTWmqdx
         IeI/7k3Hje6V+4NakIfR0LuhzjlotJFPliJNktC6xNX7n+p6KGobmiVmC0p1CAHKZlo4
         f38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1KLTBQvFa298pA4tC0Q/wm12bprxR2qQx/nYPoiOnA4=;
        b=Wd3YxDsNO38b/WLNnR4ZRY6pmz852ZeDgCkAS5B+RYTR1W/NSmME4XhPfiurg4fwKa
         +ZIkoAZUqQ7lekJSuY6m1Uw4Z4lmXTydbFTlSS2GZwoGFQfzuVyOzg8OfP34OmS1FJkL
         zfxSiPr0M0qGgzsTEP/cmXOOqeKLOwN73o5ilNUllCeSJa8UqljhjOifg8B+DYV63gmG
         UVd778B1s8ovhBTUTBTM8pcZNdpRnHSafR/6nehO5l5kC7yx2qg3ev5coGU4TvsUVnEo
         X6qbcZFBcBjK0uRMNY/hJ1I+FHl4PM2r2yuw0xgu01RB6FF2P65W4u7CxxwZaBFjp4hR
         NNgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Tue, 24 Apr 2018 16:15:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Corey Minyard <minyard@acm.org>,
	Alessandro Zummo <a.zummo@towertech.it>, linux-acpi@vger.kernel.org,
	drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-afs@lists.infradead.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/39] rtc/proc: switch to proc_create_single_data
Message-ID: <20180424141524.GB26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419124140.9309-27-hch@lst.de> <20180419131027.GC7369@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419131027.GC7369@piout.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178505716638463?=
X-GMAIL-MSGID: =?utf-8?q?1598637194937052338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 03:10:27PM +0200, Alexandre Belloni wrote:
> On 19/04/2018 14:41:27+0200, Christoph Hellwig wrote:
> > And stop trying to get a reference on the submodule, procfs code deals
> > with release after and unloaded module and thus removed proc entry.
> > 
> 
> Are you sure about that? The rtc module is not the one adding the procfs
> file so I'm not sure how the procfs code can handle it.

The proc file is removed from this call chain:

  <driver>_exit (module_exit handler)
    -> rtc_device_unregister
      -> rtc_proc_del_device
        -> remove_proc_entry

remove_proc_entry takes care of waiting for currently active file
operation instances and makes sure every new operation never calls
into the actual proc file ops.  Same behavior as in RTC exists all
over the kernel.
