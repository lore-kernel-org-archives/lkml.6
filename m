Return-Path: <reinette.chatre@intel.com>
X-Google-Smtp-Source: AB8JxZqN/EVm2q0g7/cact30ONosfZdpksXej1g21d3fs+p/aNOusXVBcywaigg02Wxewg+pwmNG
ARC-Seal: i=1; a=rsa-sha256; t=1527095983; cv=none;
        d=google.com; s=arc-20160816;
        b=xy2zM9gidQRffxgwqFARPO8iKjRzxBe6i1hTozsRPEhinSOo/Jo3ySn7a9obTxUsrf
         jUoU2132RwarcPkqLRpLrX93kMfIwdRhBe41bkAm2Sf9zrTKAfkOsnScElGqWq5kUyba
         C04qi0r87vOMRIhs5imlBmYAHm/X6IAMVQbqZBJ4dcjrvyq1cHwUAXlX+oqnJRTTwt71
         86DfGx4ACnU3d9p4nfBMpGVFjeRVh42q0ZI0j8+0otFiLl3VGtw+4dDl9FTUGrbTMzfQ
         oODl5hYauFsdgD/uuXADB26ISp93+j2voCDpPGOLa9o4zu0U7qVjJDPpGIgQ07A4ZUBk
         +Z9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=nySeM1Iicn4KIdk39yZv0LDvueZzyHlm87QSaEOme7w=;
        b=E2WpZFAlDBSGMqFDNPg9oCPvCL5E5+Dd46ebCjCe7RnLLQVq4YJ+XmXERR33gNkFSH
         1HKSPmtl+fyDzlNgXt1DXUP5fcMKr/4N/g9sJLVynywqCZvs7Ef+LkFL8s8LteH1o1ds
         5xY6cPiaSAIe0wIFTie2odO272tQKlAwOnI188MwztOO1TYwTEJ8tOm0ySIJbLFjAOla
         ZkZtDwe1OsdrnQozn3w3rBqvaQxv0GNyyX8evJgiKmLPJsw6XrqaDpGfv4vsQB74dGF+
         wqMLJmEhJD77ZBrej6WResRlmH3Reo1ZChCWxd7fFntSq6nbOmVcFRgjvlFS+kUEGnUK
         YDHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of reinette.chatre@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=reinette.chatre@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of reinette.chatre@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=reinette.chatre@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="44182208"
Subject: Re: [PATCH V4 34/38] x86/intel_rdt: Create debugfs files for
 pseudo-locking testing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
 vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
 jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
 hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1526987654.git.reinette.chatre@intel.com>
 <2da8730575c589eb7303c7b18a2721da40c446e2.1526987654.git.reinette.chatre@intel.com>
 <20180522194300.GA9656@kroah.com>
 <b32a1e6a-1675-0c96-69d3-75bc97a672b4@intel.com>
 <20180523080501.GA6822@kroah.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <cf40175b-9068-650b-d1af-62762da8ad75@intel.com>
Date: Wed, 23 May 2018 10:19:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180523080501.GA6822@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1601199626751319595?=
X-GMAIL-MSGID: =?utf-8?q?1601276198178161461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 5/23/2018 1:05 AM, Greg KH wrote:
> On Tue, May 22, 2018 at 02:02:37PM -0700, Reinette Chatre wrote:
>> On 5/22/2018 12:43 PM, Greg KH wrote:
>>> On Tue, May 22, 2018 at 04:29:22AM -0700, Reinette Chatre wrote:
>>>> +	ret = strtobool(buf, &bv);
>>>> +	if (ret == 0 && bv) {
>>>> +		ret = debugfs_file_get(file->f_path.dentry);
>>>> +		if (unlikely(ret))
>>>> +			return ret;
>>>
>>> Only ever use unlikely/likely if you can measure the performance
>>> difference.  Hint, you can't do that here, it's not needed at all.
>>
>> Here my intention was to follow the current best practices and in the
>> kernel source I am working with eight of the ten usages of
>> debugfs_file_get() is followed by an unlikely(). My assumption was thus
>> that this is a best practice. Thanks for catching this - I'll change it.
> 
> Really?  That's some horrible examples, any pointers to them?  I think I
> need to do a massive sweep of the kernel tree and fix up all of this
> crud so that people don't keep cut/paste the same bad code everywhere.

As you know debugfs_file_get() is a recent addition to the kernel,
introduced in:
commit e9117a5a4bf65d8e99f060d356a04d27a60b436d
Author: Nicolai Stange <nicstange@gmail.com>
Date:   Tue Oct 31 00:15:48 2017 +0100

    debugfs: implement per-file removal protection

Following this introduction, the same author modified the now obsolete
calls of debugfs_use_file_start() to debugfs_file_get() in commits:

commit 7cda7b8f97da9382bb945d541a85cde58d5dac27
Author: Nicolai Stange <nicstange@gmail.com>
Date:   Tue Oct 31 00:15:51 2017 +0100

    IB/hfi1: convert to debugfs_file_get() and -put()


commit 69d29f9e6a53559895e6f785f6cf72daa738f132
Author: Nicolai Stange <nicstange@gmail.com>
Date:   Tue Oct 31 00:15:50 2017 +0100

    debugfs: convert to debugfs_file_get() and -put()


In the above two commits the usage of the new debugfs_file_get()
primarily follows the pattern of:
r = debugfs_file_get(d);
if (unlikely(r))

Since the author of the new interface used the pattern above in the
conversions I do not think it is unreasonable to find other developers
following suit believing that it is a best practice.

This pattern remains in the majority when looking at the output of (on
v4.17-rc5):
git grep -A 1 ' = debugfs_file_get'

>>>> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
>>>> +	plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
>>>> +					      debugfs_resctrl);
>>>> +	if (IS_ERR(plr->debugfs_dir)) {
>>>> +		ret = PTR_ERR(plr->debugfs_dir);
>>>> +		plr->debugfs_dir = NULL;
>>>> +		goto out_region;
>>>
>>> Ick no, you never need to care about the return value of a debugfs call.
>>> You code should never do something different if a debugfs call succeeds
>>> or fails.  And you are checking it wrong, even if you did want to do
>>> this :)
>>
>> Ah - I see I need to be using IS_ERR_OR_NULL() instead of IS_ERR()? If
>> this is the case then please note that there seems to be quite a few
>> debugfs_create_dir() calls within the kernel that have the same issue.
> 
> Again, they are all wrong :)
> 
> Just ignore the return value, unless it is a directory, and then just
> save it like you are here.  Don't check the value, you can always pass
> it into a future debugfs call with no problems.

Will do. Thank you very much for the advise.

>>>> +	}
>>>> +
>>>> +	entry = debugfs_create_file("pseudo_lock_measure", 0200,
>>>> +				    plr->debugfs_dir, rdtgrp,
>>>> +				    &pseudo_measure_fops);
>>>> +	if (IS_ERR(entry)) {
>>>> +		ret = PTR_ERR(entry);
>>>> +		goto out_debugfs;
>>>> +	}
>>>
>>> Again, you don't care, don't do this.
>>>
>>>> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
>>>> +	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
>>>> +#endif
>>>
>>> Don't put ifdefs in .c files, it's not the Linux way at all.  You can
>>> make this a lot simpler/easier to maintain over time if you do not.
>>
>> My mistake - I assumed this would be ok based on my interpretation of
>> how CONFIG_GENERIC_IRQ_DEBUGFS is used.
>>
>> I could rework the debugfs code to be contained in a new debugfs
>> specific .c file that is only compiled if the configuration is set. The
>> ifdefs will then be restricted to a .h file that contains the
>> declarations of these debugfs functions with empty variants when the
>> user did not select the debugfs config option.
>>
>> Would that be acceptable to you?
> 
> Yes, that is the correct way to do this.
> 
> But why would someone _not_ want this option?  Why not always just
> include the functionality, that way you don't have to ask someone to
> rebuild a kernel if you need that debug information.  And distros will
> always enable the option anyway, so it's not like you are keeping things
> "smaller", if you disable debugfs, all of that code should just compile
> away to almost nothing anyway.

Will do.

Thank you very much for taking the time to review and provide
constructive feedback.

Reinette
