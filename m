Return-Path: <prvs=603a4b48a=Richard.Leitner@skidata.com>
X-Google-Smtp-Source: AG47ELsfxGo6qtTN6QCiXx5R+RkubDW9UmdbzyeWF6lm7cNn+V3JrN4++y91rdy2e3QOF9JidQfP
ARC-Seal: i=1; a=rsa-sha256; t=1520936454; cv=none;
        d=google.com; s=arc-20160816;
        b=dNoNTPnvozC6BL20JIQXV3U6ZUd24AmvO1eyNQk7Gvqi2QCLXLGSquF3jIe2sYZPl+
         43HaGYu7lvy/cu9TRqo0nHeELtJoVqVqIopgpAAd2CgTvG8bpeogobRs4T2j9PwY1SDA
         D5OX9kjn/4vUSqBbCUfy+uNGkNAgGN+oiylLsYuwgkVpiswnSs7E6KuQKnol9uTO//4S
         RUmPP9JgE3iN1uh08PNxlnEXMIIuzWLzcqmh7650wXK2uo1HbKxKYRNKOSM6nuu3NoUJ
         19uDuZbsw/WtLPbiAfCRiLfd6b0MThJO5cYZXonbxJDfUqJrm673KleEf/tNky2EySEM
         BFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Rmy0TjLKwxm0flBIes2wbs3+EXR1wFqGa+buCtV/Qpg=;
        b=de0rX+5zPtrarAJVLhT+c95Sc99vVe8tFVvoUoOyQFxKwF8CJtvc70uCi4H2lKwJZl
         mN9N3HrD4uNjAlpw6WNNQ3JRHPdjCHiXWdTMw99jOHqgbChPUMYdtFtZsuJtrJOfAGES
         RGiXaMMUoddSgR5tz98TD7MB4GtLpooL8I8f6oig1DMjCQCV/DipuGKEBjxxg7DWutB2
         oXp0p+bkUUccpQziDnGhipfCTXtdHClIX9FYdvtviRLoJhEylafIUJ2C8hyAMHC2rFP9
         k6EmCeCGT43ZcmPDbquWZFsW+BdJbmze6kHcxKrXVRaRBc40aQnY7Ii+l38tYfJ8IQoW
         EfAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=603a4b48a=richard.leitner@skidata.com designates 91.230.2.99 as permitted sender) smtp.mailfrom=prvs=603a4b48a=Richard.Leitner@skidata.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=603a4b48a=richard.leitner@skidata.com designates 91.230.2.99 as permitted sender) smtp.mailfrom=prvs=603a4b48a=Richard.Leitner@skidata.com
X-IronPort-AV: E=Sophos;i="5.47,464,1515452400";
   d="scan'208";a="9185470"
Subject: Re: [PATCH v2] usb: core: introduce per-port over-current counters
To: Greg KH <gregkh@linuxfoundation.org>, Richard Leitner <dev@g0hl1n.net>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stern@rowland.harvard.edu>, <linux@roeck-us.net>,
	<mathias.nyman@linux.intel.com>, <johan@kernel.org>,
	<felipe.balbi@linux.intel.com>, <ekorenevsky@gmail.com>,
	<peter.chen@nxp.com>, <drake@endlessm.com>, <joe@perches.com>
References: <20180220115033.29496-1-dev@g0hl1n.net>
 <20180309171921.GA30438@kroah.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <1485535c-ee0a-c25c-7f1f-5c0e8ede6b45@skidata.com>
Date: Tue, 13 Mar 2018 11:20:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309171921.GA30438@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592920589628798934?=
X-GMAIL-MSGID: =?utf-8?q?1594817463603297069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 03/09/2018 06:19 PM, Greg KH wrote:
>> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
>> index 0bd731cbb50c..27020293c85b 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-usb
>> +++ b/Documentation/ABI/testing/sysfs-bus-usb
>> @@ -189,6 +189,15 @@ Description:
>>  		The file will read "hotplug", "wired" and "not used" if the
>>  		information is available, and "unknown" otherwise.
>>  
>> +What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
>> +Date:		February 2018
>> +Contact:	Richard Leitner <richard.leitner@skidata.com>
>> +Description:
>> +		Most hubs are able to detect over-current situations on their
>> +		ports and report them to the kernel. This attribute is to expose
>> +		the number of over-current situation occurred on a specific port
>> +		to user space. This file will contain an unsigned int.
> "unsigned int" is very vague :)
> 
> How about "this is a 32bit value"?
> 
> And what happens when this wraps?  Is that allowed?

Thank you for your feedback. I'll improve the description for v3!

> 
> thanks,
> 
> greg k-h

regards;Richard.L
