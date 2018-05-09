Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AB8JxZprqEdY2RlRR4vCUDAyPq8H/PPT2VckLEOhP1jcV2VKcc53p5rQmxgYcEevppeTiTnmSdR9
ARC-Seal: i=1; a=rsa-sha256; t=1525864660; cv=none;
        d=google.com; s=arc-20160816;
        b=pw1/2s1CClXStSF5zD1AGnskSpKd6y34OjmjS/OdV9lY7a22MPc+6jusG3ufHFT26x
         cp0KuCBCWTOuj+6vdn21EQFj4wD/s4udFe/vkiX3+nb6uOPumvUMDg8DckJH/ww7sqdU
         WSqn5p52mjdS0232XovUuriOi2c0n7c08tviraI/EVJgxO8MmWucWcb+bZ6w2kTVLrS1
         Vzxaia2g6luGeOXzm3J1cNxsBZ5XYKtPEs6g1/IHJucCdOnIHAPPh7ign+SfaU2bFzwz
         ZJp2AYlaZgL5Lsv/+ZOx14eLZk9gVlqJWmV0fJ8SsnZYu7EzG5lidYX5mk2x6RlaDrYk
         Ck9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=7XCmKjMzghphYDlZo5WoTtS7T8cP93in3G+71EsIOsQ=;
        b=CWecEVlj1WZ/TMYzxrLbkDYOlGWO9MEPkQpAfJydbD7uGZZGIGKVzGJeIj8h/bLtJO
         Pw+zxC6nAQvqSC4NXh2m49nXfUiyrbnJ7HeX2WeQmpNchV3aZWC11h9PTQHPZqPHEjJL
         dr8RB4LpynxpRxyzf+5sh5r9r+DMhvKWOlv3MpweDC862H4qhp3SJff5o1YO7nCN55VG
         Wz9U1xpfzbe5PrDMlIO0XYHPf7JRSiMfmJ6AzsgLGFHciV/rMkO9mHBuc62huAWOnXuh
         YWQGb79tGjYAZ04YXXGTh49fsCXWpi6QugB5cg5L4crHXmX/pWz9KAnsf9DhDRjEvw9U
         uUoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Kirill Tkhai
 <ktkhai@virtuozzo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Rik van Riel <riel@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9f67480f-ac5b-6c53-3463-06a9319ddfad@arm.com>
Date: Wed, 9 May 2018 12:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87d0y5toed.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1599985061966974378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

On 09/05/18 05:59, Eric W. Biederman wrote:
> Kim Phillips <kim.phillips@arm.com> writes:
> 
>> This patch is in the context of allowing the Coresight h/w
>> trace driver suite to be loaded as modules.  Coresight uses
>> find_task_by_vpid when running in direct capture mode (via sysfs)
>> when getting/setting the context ID comparator to trigger on
>> (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).
> 
> Aside from my objection about how bad an interface a pid in sysfs is.
> The implementation of coresight_vpid_to_pid is horrible.
> 
> The code should be just:
> 
> static inline pid_t coresight_vpid_to_pid(pid_t vpid)
> {
> 	rcu_read_lock();
>          pid = pid_nr(find_vpid(vpid));
> 	rcu_read_unlock();
> 
> 	return pid;
> }
> Which takes find_task_by_vpid out of the picture.
> 
> But reading further I am seeing code writing a pid to hardware.  That is
> broken.  That is a layering violation of the first order.  Giving
> implementation details like that to hardware.

Note that the value here is nothing more than a token - the CoreSight 
hardware doesn't actually *do* anything with it other than match it 
against the same value which we also stash in the CPU in much the same 
fashion - see CONFIG_PID_IN_CONTEXTIDR for, if you'll pardon the pun, 
context.

TL;DR: the CPU has a special register whose only purpose is to allow the 
OS help external debug tools identify the currently executing process, 
by writing some arbitrary identifier in there. The trace hardware can 
spit that identifier out into the trace stream whenever it changes, such 
that the user can see context switches easily. Newer trace hardware can 
also use it to actively filter what the capture at source, such that 
only the portions of interest are traced at all. We could in theory make 
up any old value, but as I understand it the PID is/was the most 
user-friendly and easily correlatable thing to hand, and it's now 
probably too well-established to reasonably change.

Robin.

> Any chance while you are working on this you can modify this code so
> that it does something sensible and defensible instead of every line of
> code I read be wrong in at least one detail?
> 
> Thank you,
> Eric
> 
