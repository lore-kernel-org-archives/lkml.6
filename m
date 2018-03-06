Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AG47ELvnJiA6wzoaJbuZIMbG68j9UeaWT+0WCxCLNVcD3bxB47TofcvoBv1FZFkHwTA15YScrq06
ARC-Seal: i=1; a=rsa-sha256; t=1520294596; cv=none;
        d=google.com; s=arc-20160816;
        b=MOKA0EXjRf1YDo9GpE4KmevA3gCdDiD16FHdRyxNVyDLUZh9LsZatiykGEgNf1YSVI
         xQUG7T/L92mh/+ykNWO9cGZYfSXATfOW/gYsrwwKU4qstL29G6Pf8Q78GTRDmJVMVcji
         jXa/9+QYSQCC7MBAdgr6JDqTvzccNrFu69oOfsOhJCt/UIzEfZf/iqzZ64q2V2RCLiju
         lc+28d/1sy/WFdVYzzXbn4PZTQtgx8Ub6zNC1hUbEljwuRlQOcA8TchBXn8XkVeziO+U
         U+Kf1crTqVVy/vi+ueBjEjwpgtC502hknsPC9gH+v+4t3PBKEoyMPorjtl5T5MwpUKAN
         XTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=RAVmzsuP01+rq9AULZR7X6GmxX1WKM60azbjtb+aKYg=;
        b=l44U6eOYf1UIT/yE80MuVnpYtiiNnRHqKK5o2/2Pvsk95Q9Mq8DAVuljm+OcbI/1Yt
         vNaJ1Dchg27faBl9i/dYCmOmh9Km2Q5z5beogDWQQJzLM/6EzDapFxX0H+J/YzCcQzmM
         kBy5WUqa+4Mt6uOTKpPJyjLYbdtHP3G4Q3SQpr56u2DERJ4IntjUVO+dclYTYYuqOVG+
         ajXkOoQmdsQucbV1lmYnpxg6oK9lF87TCDWLNDX0C2eEcGJ3o8gYDcPCH7AM/uvkyEVn
         NHWJiSYOolND3/QCYG3GfAVxVv+IApJa9Bg7Vl5y02nRLiDsWzz0dawyy2X/5F2xbn34
         B9Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATH 0/4] usbip: make vhci_hcd.* objects independent of
 vhci_hcd.0
To: =?UTF-8?Q?Salvador_Fandi=c3=b1o?= <salvador@qindel.com>,
 shuah@kernel.org, Salvador Fandino <salva@qindel.com>,
 linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, valentina.manea.m@gmail.com,
 linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180130083630.26501-1-salva@qindel.com>
 <391a54d5-73ac-3bd5-49ca-114639ea69fd@kernel.org>
 <60da1c91-d6bf-1922-44c5-3b8010129cc4@qindel.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <6f8af831-e7f8-787b-b1f9-465062aa7e8c@osg.samsung.com>
Date: Mon, 5 Mar 2018 17:03:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <60da1c91-d6bf-1922-44c5-3b8010129cc4@qindel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591005843418915487?=
X-GMAIL-MSGID: =?utf-8?q?1594144426944818571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 02:00 AM, Salvador Fandiño wrote:
> On 02/21/2018 01:35 AM, Shuah Khan wrote:
>> Hi Salvador,
>>
>> On 01/30/2018 01:36 AM, Salvador Fandino wrote:
>>> Let me start by explaining the problem that have motivated me to write
>>> this patches:
>>>
>>> I work on the QVD, a virtual desktop platform for Linux. This software
>>> runs Linux desktops (i.e. XFCE, KDE) and their applications inside LXC
>>> containers, and makes then available through the network to remote
>>> users.
>>>
>>> Supporting USB devices is a common feature customers have been
>>> requesting us for a long time (in order to use, for instance, remote
>>> signature pads, bar-code scanners, fingerprint readers, etc.). So, we
>>> have been working on that feature using the USB/IP layer on the
>>> kernel.
>>>
>>> Connecting and disconnecting devices and transferring data works
>>> seamless for the devices listed above. But we also want to make the
>>> usbip operations private to the container where they are run.  For
>>> instance, it is unacceptable for our product, that one user could list
>>> the devices connected by other users or access them.
>>>
>>> We can control how can access every device using cgroups once those
>>> are attached, but the usbip layer is not providing any mechanism for
>>> controlling who can attach, detach or list the devices.

In this use-case:

- does a container act as usbip client and attach devices from their
  host?
- do containers attach remote devices from other systems?

Is the core of the problem really that any remote system can import without
a provision for being able to restrict export to a set of remote machines?
If so, this is a generic problem even without containers and I would like
to solve this with a generic solution that works in all cases, not just for
containers.

The approach in this patch series appears to solve the problem just for
containers.

>>
>> Did you explore a solution to add a mechanism for access control to
>> usbip?
> 
> Could you elaborate on that?
> 
> For "usbip", do you mean the user space tools? 
> If that is the case, I don't think it would be enough.
> My aim is to limit vhci usage from containers and I have no control about what runs inside the containers. So, a mangled usbip tool-set could > > be used by a malicious user to circumvent any access control set there.> 

I mean the driver. There might be changes necessary in the user-space
as well depending on how the access controls are implemented. I am not
proposing implementing access controls in the user-space.


> IMO, there is no other choice but to control access to VHCI at the kernel level.
> 

Probably. Please give as many details as possible on your environment
for me to make a call on if this problem can be solved in a different
way.

thanks,
-- Shuah
