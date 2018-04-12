Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx48PMO7oasBR2ustSB5LOOLj3GDFwEjLIGHZf+crPHnKvJBCWGuxrLIYu+vzpDRbXasOV8ue
ARC-Seal: i=1; a=rsa-sha256; t=1523554206; cv=none;
        d=google.com; s=arc-20160816;
        b=Y9C6ArtgSgivxzUy/Z/THi172T+vIeThFJueI8n4JX4etDCt8INBRXP6I/i/+RqkVy
         rlOombsfxMNX7NhguP+6WzTbl3oR+Sa1GhZsWlbEOIwDcLEe8XnCtPgqhCm58Qua8WK6
         BAtJ9MMdc8YAW+RNOlF9sAlKFtTUrESiN1Kch+1xa3dWaVyKUl3FrAU1kP3PbIJHgohB
         XJKe14FdNyQyZsE5SKv+FU8yJowiR1F75KVGqvrZzb6ZO3PVdgh+UfjYnspJP40K2g7o
         nhojz8Hm6ynHjVv72P6y0/dKJZPZPl2AO1LU8DmA24tgOAViH8xNIBG00mA24/6idRAb
         gU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=B9G2LpIvBTFcacZLqkUHahofM2DPmC4RSIB2dYkZUjI=;
        b=LqFTyyfTN6UY/wLdHxAmlBpXt+c9AtJq/db3CnHBi03xtIlQ1i+HiKrq45RucGozjI
         R3ySfDG1csCD0gUxg0qJ0atv42pyvkM4rY0sYnXWlVePK19UdcwoVVUoF171ZdjGyPEg
         VANuCaFYxPDK6J5V46c20pY1WP7yHdRkJycREoRb4c6HuQKM2g6OYw/4rEXp6pF0CsyW
         /cfvGkjbBf3HUI5Sz0sBnvfxDeBwNEDTZODUWJiCVCElWpD57PsnN1bamGHhPVOhTdyH
         q7BCutvAjF7EZQLfzoCeh07nTMNb8Iga26oEbfjf1YLAmkvNdrtJ057Grk/PCcHvjOec
         7ySg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=MHrWOVKK;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.89 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=MHrWOVKK;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.89 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,442,1517875200";
   d="scan'208";a="98006130"
Date: Thu, 12 Apr 2018 10:32:59 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: Re: [PATCH 01/10] staging: fnic2 add initialization
Message-ID: <20180412173258.GA6426@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
 <20180405211644.GB12584@osmithde-lnx.cisco.com>
 <20180406050752.GC27591@kroah.com>
 <20180406220010.GA23478@osmithde-lnx.cisco.com>
 <20180407060901.GA18744@kroah.com>
 <yq1r2no3xoz.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r2no3xoz.fsf@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942284542554315?=
X-GMAIL-MSGID: =?utf-8?q?1597562374318982897?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 04:57:16PM -0400, Martin K. Petersen wrote:
>
> My initial questions are: Why is a new driver necessary? Why can't the
> existing fnic driver be extended? And if it can't, what can be shared
> between the two drivers?
> 
> A good place to have that discussion would be on linux-scsi...

Hi Martin,

Thanks for taking some time to discuss fnic2. linux-scsi is CC'ed to this
thread, for their input.

The main focus of the fnic2 driver is FCoE target mode support, NVMe over FC
initiator & target drivers, and Multi-queue support. We think these changes
need a new framework that we have developed in fnic2.

However, we do believe that a significant number of files and interfaces can
be shared between the two drivers. Specifically, all interaction with the
Cisco VNIC hardware can be shared. Also, there are some driver-specific
queueing interfaces that can be shared between the drivers. This will allow us
to share a significant number of files between fnic and fnic2. We are currently
looking at how the common files can be shared, which was one of our TODOs for
when we were looking at including this driver in the staging area.

Thanks,
Oliver Smith-Denny
