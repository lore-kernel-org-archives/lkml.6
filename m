Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AH8x226hP3qua6hneUazOEjzhDjE7A6+X+IW4NGKX+bxHL8iHL7L6wu9Z7qt2YfrhG/alSqH4Nzp
ARC-Seal: i=1; a=rsa-sha256; t=1519259856; cv=none;
        d=google.com; s=arc-20160816;
        b=j3JpezCFklfEPqW+A0manFJwQVgxYz61rjSfIJWEbejivdhxA2uPL0PBgcEqqmnwrP
         IzYhftUKsiP11WVfxEip6jdg6Fy1Ai29zlPIZ7Fxd/JHI1mT8PGCx/6N0YTcfwPS1Als
         zG6Gs2r88MXpA2BVxeAo1QslUdzEZV/s3UJayw0tilCfwGi8JWLt7OmBkGkBNjF014QR
         hqRYnwbcVxcguMCZM6YxkrM+moNrOM0qGohjEnF2R3vP16vzOgUL2y2khCkGuPQqDBHV
         ut6Oa1hcnagWv4Efd8RwiUBepj4K56Jngj7qTUIDiqRWuctNg0Svd3X31+Tr9VLWYTif
         vEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=kiMGOIPGWWr68BNAvR7Mq34VCt2OkZo3EsFWRY27ocs=;
        b=KULLC/sthemGWhfo5qvsBi0zq4tXYdE1YOHpuJFzQ3Gn1rNPvUjbgLHsWY8DVaEgDv
         BYMv2m49k5BENPIJgFUl9KETeK2BSrP+IjKZdTEJK5XYvdHGpLF8ZsSjhjlyNW+G6oiG
         k3SsLFpBxvECf9Hn170u0K80FONXTUw7DMUVmIxXeM6wQ5rXWqQzrORWfm3Dznjt9KWE
         0FPcKgW7TzUF+6xOiaQWy6TYKQ+chx/hF1KFRhoNFGtS7QcX97hxiUbQqPtivOklm/2f
         o8LEP9w95bUC20XIKelJwFxFo1wp2YE6ifHmoZ7kSsgDt6W+cVj0gU+FoHR62mR1mMug
         dDpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=zLjSbd+e;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=zLjSbd+e;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Thu, 22 Feb 2018 01:37:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, joel@jms.id.au, andrew@aj.id.au,
	arnd@arndb.de, gregkh@linuxfoundation.org, jdelvare@suse.com,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 7/8] [PATCH 7/8] drivers/hwmon: Add a generic PECI
 hwmon client driver
Message-ID: <20180222003720.GA25250@lunn.ch>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-8-jae.hyun.yoo@linux.intel.com>
 <20180221182608.GA11635@roeck-us.net>
 <618f34cd-ee43-d8e4-4fb0-3c23bf03835f@linux.intel.com>
 <20180221214859.GA30263@roeck-us.net>
 <576a50c6-c302-654c-ceb3-aaf820b7738a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <576a50c6-c302-654c-ceb3-aaf820b7738a@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027891482896135?=
X-GMAIL-MSGID: =?utf-8?q?1593059423289949942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> But even with this change, it still needs to use delayed creation
> because BMC side kernel doesn't know how many DIMMs are populated on
> a remote server before the remote server completes its memory
> training and testing in BIOS, but it needs to check the remote
> server's CPU temperature as immediate as possible to make
> appropriate thermal control based on the remote CPU's temperature to
> avoid any critical thermal issue. What would be a better solution in
> this case?

You could change this driver so that it supports one DIMM.  Move the
'hotplug' part into another driver which creates and destroys
instances of the hwmon DIMM device as the DIMMS come and go.

Also, do you need to handle CPU hotplug? You could split the CPU
temperature part into a separate hwmon driver? And again create and
destroy devices as CPUs come and go?

	Andrew
