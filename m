Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AG47ELu6BS9uqFpsT5/GpnG01UhlQFsHkxAP4/NT4WWIRoByoiYe0J2H3ssz4oaML0u4N2AcwG1e
ARC-Seal: i=1; a=rsa-sha256; t=1520369912; cv=none;
        d=google.com; s=arc-20160816;
        b=WmfbVMdRDNS/hhDsRllSZ669VfN6Ao56I0UZvfOXxN5maQp98GLrMzS2w5mxnSIbFo
         uJv2mjc8gvt31v7hxfsFGX4LV9PeTBxDTWXD4SoYHIa/XaBrBa4AtNxmCf5/2IZ+Is7U
         cBTETOCwkQzTN6ZTjJRc/NQDrXIDGGt9KK48jhlE/2FUb5hnfK2kDods42I0OWH+P3kh
         Nf42JO+PQ8n2OpCwKTH5/l7WhclAUwVxfTP3HFs5xwjx1z1E2mr6x+570yC5ya4ZHtuu
         0fLuca6+11cHNHo2+Sl+YQfDqqRHQID0HWb1B2upTbTt7U48Oa7ivNW+DGiclfOaHX+H
         3bMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=RJeMr33HJb/rBIkJmQe8cVf3rdKonCq36P0z1E3JeIQ=;
        b=vSowMrSTG9kd5WA/VFB5A4wPrRV/ULJZW72W5sAZoLlVkFhx3mWStuOMEXu+iHvi5E
         GLZJZRDNC8DhkjUIsQaUmvdbJeeVQPk8kBXMSXhuZfAuHUvka4txnDFYDxSdyHQfK9a5
         IsmT2AeXrtsaiqiqLmhzlN63N+K+BqzFA9gz7WnlFMiXg0yPF4c0NwViI1JOL38Jh+xA
         H+/c7pixKAN6kJSAHwVW6xm4MVIudjEr0Pmgp6YziFotH7D7F9N4rcsG3XZkruUhsWrm
         KHnrKSEWuivtaZ0woa8TvJY1ZDQlXT6tCln7IgcvSspX68xnp1IEPTgrOH61t5uOED8P
         BZgA==
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
 <6f8af831-e7f8-787b-b1f9-465062aa7e8c@osg.samsung.com>
 <6395451b-d31c-0196-1f7a-39286972ea3f@qindel.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <a939c16a-b503-2f5a-041b-0d6a34c44425@osg.samsung.com>
Date: Tue, 6 Mar 2018 13:58:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6395451b-d31c-0196-1f7a-39286972ea3f@qindel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591005843418915487?=
X-GMAIL-MSGID: =?utf-8?q?1594223401566054585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/06/2018 01:35 AM, Salvador Fandiño wrote:
> 
> 
> On 03/06/2018 01:03 AM, Shuah Khan wrote:
>> On 03/05/2018 02:00 AM, Salvador Fandiño wrote:
>>> On 02/21/2018 01:35 AM, Shuah Khan wrote:
>>>> Hi Salvador,
>>>>
>>>> On 01/30/2018 01:36 AM, Salvador Fandino wrote:
>>>>> Let me start by explaining the problem that have motivated me to write
>>>>> this patches:
>>>>>
>>>>> I work on the QVD, a virtual desktop platform for Linux. This software
>>>>> runs Linux desktops (i.e. XFCE, KDE) and their applications inside LXC
>>>>> containers, and makes then available through the network to remote
>>>>> users.
>>>>>
>>>>> Supporting USB devices is a common feature customers have been
>>>>> requesting us for a long time (in order to use, for instance, remote
>>>>> signature pads, bar-code scanners, fingerprint readers, etc.). So, we
>>>>> have been working on that feature using the USB/IP layer on the
>>>>> kernel.
>>>>>
>>>>> Connecting and disconnecting devices and transferring data works
>>>>> seamless for the devices listed above. But we also want to make the
>>>>> usbip operations private to the container where they are run.  For
>>>>> instance, it is unacceptable for our product, that one user could list
>>>>> the devices connected by other users or access them.
>>>>>
>>>>> We can control how can access every device using cgroups once those
>>>>> are attached, but the usbip layer is not providing any mechanism for
>>>>> controlling who can attach, detach or list the devices.
>> In this use-case:
>>
>> - does a container act as usbip client and attach devices from their
>>    host?
>> - do containers attach remote devices from other systems?
> In my particular case devices are imported from remote machines. But well, the thing is that I don't care where the connections come from, they could even be devices emulated in user space.
> 
>> Is the core of the problem really that any remote system can import without
>> a provision for being able to restrict export to a set of remote machines?
>> If so, this is a generic problem even without containers and I would like
>> to solve this with a generic solution that works in all cases, not just for
>> containers.
> No, that is a different issue. You are talking about controlling which devices can be connected, from which hosts, etc. That is an interesting problem but not the one I am trying to tackle here.
> 

Not entirely. These problems are linked if you use usbip driver and usbip
tools. USBIp driver is intended to be used in conjunction with the usbip
tools.

> I don't mind which every user does inside its container as far as it does not interfere which other users. In practice that means:
> 
> 1- Not being able to attach/detach devices in other container

How do container attach/detach in other containers in your setup?

> 2- Not being able to list devices attached in other containers

How do container list devices in other containers in your setup?

> 3- Not being able to access devices attached in other containers.
> 
> Point 3 is already enforceable using the devices hierarchy in cgroups. For points 1 and 2, my proposition is making every vhci_hcd device have its own fully independent sysfs directory (instead of all of them going through vhci_hcd.0) so that they can be selectively exposed with rw permissions inside the containers.
> 
> 
> 
>> The approach in this patch series appears to solve the problem just for
>> containers.
>>
>>>> Did you explore a solution to add a mechanism for access control to
>>>> usbip?
>>> Could you elaborate on that?
>>>
>>> For "usbip", do you mean the user space tools?
>>> If that is the case, I don't think it would be enough.
>>> My aim is to limit vhci usage from containers and I have no control about what runs inside the containers. So, a mangled usbip tool-set could > > be used by a malicious user to circumvent any access control set there.>
>> I mean the driver. There might be changes necessary in the user-space
>> as well depending on how the access controls are implemented. I am not
>> proposing implementing access controls in the user-space.
>>
>>
>>> IMO, there is no other choice but to control access to VHCI at the kernel level.
>>>
>> Probably. Please give as many details as possible on your environment
>> for me to make a call on if this problem can be solved in a different
>> way.
> 
> In our particular real life application, we are targeting the kernel interface directly, we don't use the usbip tools at all. It is that way because we have our own* transport layer, authentication and authorization mechanisms. And once all the handshaking is done we end with a socket we can directly pass to the kernel in order to get it attached to a vhci_hcd port. 

How do you do that? Can you elaborate on how do you pass the socket to the USBIP
host? The way you are using is unsupported and just not the way it is designed
to be used.


We don't like having an extra application listening on some TCP port which can be accessed by third parties on the client side either.
> 

USBIP is a server/client protocol is intended to work that way. You can specify
a port to use.

> The imported USB devices used are mostly devices which do not require kernel modules and that are accessed though libusb by the applications (i.e., id card readers, barcode scanners, signing pads, etc.).

This is just not they was USBIP driver in the kernel is intended to be used.
I am beginning to think that USBIP isn't the right solution for your application.
You are talking about not using the protocol the way it is designed and finding
custom ways to use it.

I am all for making the USBIP more secure for container environment by adding
features to restrict:

- Remote machines that can import (attach) - this can be per device.
- Make sure detach is done only by the remote that imported the device
- Restrict listing of imported devices to the remote that imported them
- Enhance current version match to a stricter version match and add checksum
  match between kernel and user-space.

Let me know if you would like to explore the above options that are generic as
opposed to custom solution based on a setup that doesn't use the USBIP driver
the way it is designed to work.

thanks,
-- Shuah
