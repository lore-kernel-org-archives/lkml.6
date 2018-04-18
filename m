Return-Path: <ashok.raj@intel.com>
X-Google-Smtp-Source: AIpwx48wIS9bW+vtFH9W690IbOcv8zqLgPmO47sgddoQizrAgMzet+X5UkUnamtg7wHRn5dUo8Cg
ARC-Seal: i=1; a=rsa-sha256; t=1524059612; cv=none;
        d=google.com; s=arc-20160816;
        b=znKHppO1IjsrD6QPh4NDWc4T3W0eLv11wBVJcty9MkpDeDcbO47q5wYhJ5+2dH7Cjc
         zqa3QOU04tHFHjdWY8Km+zBuLjtoLPag+2YHn5ijYzhDn36IL7vwj9NyVNPm4F+R+q7+
         NMuMbtwDL3ZIvu0GA6qxAUJ7TD8sOJQCD73Gp7LHI64TZCxhJHsT09aWftWJQU7a/ihG
         E9nFxppJt0qjzf20GSfdEbXWoM7j3UoOGxcISW1UXieZ82bHiZ0oRDWUl2oFNXq9GJKf
         KYE1WxSCcTajff4sb704Qg8C9xVn16Hv2/UsSWhs81sd9W7rBCtDP4c2LBb0yKjApB2Z
         9S7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=g25rPSv8JgF9NCkWA3pDlDYQaX316sZzOl4jlmOSfLg=;
        b=UWnzpVfsd0tZumm5WMCRrcMjdenjLFSy9NTHQxA+Nr0YcpSLrGlFdgXcWRXrcsdWoT
         SRMWeqRJgEUifXzcj7PzlFxaxt8doX9Gt0rBsKNd6YhC/jnFbG+wWEzyy+K6i6nuY6Ol
         YejREo+PxbIPA1tf7LoFp+yEPuMje4NE0kIZXCcq3kdKMJh79KXjiWHlbRjhl19FWjFr
         2hAZIqsdlUwOCZDXbyBvVkziKjAX/UzVXqnbDWYpDVqAJes8V7xSRaM7fl/kOXq4Qpgu
         8A1WdhOZ5kNPEOboHv4UqXr1xxLwpkMQigDXYIeX2nzEUMQk2FKCP6wqFEfZEH7skqmB
         lf0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,465,1517904000";
   d="scan'208";a="221415504"
Date: Wed, 18 Apr 2018 06:53:30 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Vitezslav Samel <vitezslav@samel.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180418135330.GA23580@araj-mobl1.jf.intel.com>
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418122212.GA4290@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598092332139566444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 02:22:12PM +0200, Borislav Petkov wrote:
> On Wed, Apr 18, 2018 at 02:08:40PM +0200, Vitezslav Samel wrote:
> > I switched to firmware-in-kernel early loading and that works OK.

firmware-in-kernel means you compile your microcode image in linux?

Can you tell me which distro you are using? The ones we used 
doesn't do late-loading (i.e echo 1 > /sys/devices/system/cpu/microcode/reload)

I suspect that might be the problem. 

- Can you remove your builtin microcode, 
- rename the /lib/firmware/intel-ucode so we don't find it during late
loading. 
- let the system boot completely
- then rename the intel-ucode back for this test.
- write 1 to reload and see if that update succeeds or fails?


> 
> Ok, and keep using that from now on.
> 
> People should all move away from that late loading dance. I'm saying
> that in case someone else reads this on lkml.
> 
> > But still, the reported issue is regression in 4.15.17 and 4.16+.
> 
> Oh, I know it is a regression.
> 
> @Ashok: anything particular about his microcode revision not being able
> to stomach late loading?

nothing about the microcode itself comes to mind. I'm wondering if this 
similar to the Arch linux that used late-load during booting might be an issue.
