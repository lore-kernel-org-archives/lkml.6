Return-Path: <salvador@qindel.com>
X-Google-Smtp-Source: AG47ELuImyxKFGTuqsrhx8iyM79gcrGqrupdkk/9kXtM1PUPyACThCFse4uNhQoX5Ad57ioqQLef
ARC-Seal: i=1; a=rsa-sha256; t=1520240426; cv=none;
        d=google.com; s=arc-20160816;
        b=LwrqvDIgIXCCdDxyWKf2iVjyZPLIB4XDkq1qboQVuxlKjV1/CYWOpAIODZRea66BcW
         aKjkZXs0mvl47o09hzogcoHAq/C+gdxK6VieRx/4Pw8rB3hPewHNROdbJYWS818vbf7P
         eFie+hpj76lj6a36GrqV+q5KzM6gY8jqZFEP+KmUC87Z5TyAvfrJb1fOXt75sgzmg5t0
         tIPreEaC/X/TadcGIkXYRb5zdU4uiqoRZc6n+zCaL20jr7V3pXIwl0K7JXSkr1wAF68G
         Mjsdj0i11AwR3VqTi4l437dly8llKupE3tbD49A1W651hSzjkCTUqmdYcFLiFSJ3gTWY
         JzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :arc-authentication-results;
        bh=UgrdHNdk+bkSohG7md/fiMaRW2/Xt+JG86qjge64qLk=;
        b=AdkfS6kkW6TeGAj4iNSdFJIpq3TtYIvlDD/ZAiLat74Zy+6JYBw1xCqJcCsO001dmf
         V1cDDE3TqsHFC/++kuuZUAfHxNl/8ENqz4rXE8sUlTX/lwBG6uwixKFyvu4jCukVqMJs
         gyA4En69Ds5G3Bwl+hZOgCxIeWnOJIXtQeb/HRp/ugC44HmZyXwDs9xSdo+4SkhGFzrn
         ydO0JGzhy3R/n6kdvTNcjotkaXp8BbQu4Cw3jJpWVKLrxEaJZ25Hc4xg9q+csUgznyc5
         hZQI+Hvn2H+agzfYOqo5s56/UXivNdIsCKFu/qft2hmWKqHZDClneuZJ0uMdYUJ1WGQO
         YkhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of salvador@qindel.com designates 89.140.90.34 as permitted sender) smtp.mailfrom=salvador@qindel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of salvador@qindel.com designates 89.140.90.34 as permitted sender) smtp.mailfrom=salvador@qindel.com
From: =?UTF-8?Q?Salvador_Fandi=c3=b1o?= <salvador@qindel.com>
Subject: Re: [PATH 0/4] usbip: make vhci_hcd.* objects independent of
 vhci_hcd.0
To: shuah@kernel.org, Salvador Fandino <salva@qindel.com>,
 linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, valentina.manea.m@gmail.com,
 linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180130083630.26501-1-salva@qindel.com>
 <391a54d5-73ac-3bd5-49ca-114639ea69fd@kernel.org>
Message-ID: <60da1c91-d6bf-1922-44c5-3b8010129cc4@qindel.com>
Date: Mon, 5 Mar 2018 10:00:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <391a54d5-73ac-3bd5-49ca-114639ea69fd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591005843418915487?=
X-GMAIL-MSGID: =?utf-8?q?1594087624921496505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 01:35 AM, Shuah Khan wrote:
> Hi Salvador,
> 
> On 01/30/2018 01:36 AM, Salvador Fandino wrote:
>> Let me start by explaining the problem that have motivated me to write
>> this patches:
>>
>> I work on the QVD, a virtual desktop platform for Linux. This software
>> runs Linux desktops (i.e. XFCE, KDE) and their applications inside LXC
>> containers, and makes then available through the network to remote
>> users.
>>
>> Supporting USB devices is a common feature customers have been
>> requesting us for a long time (in order to use, for instance, remote
>> signature pads, bar-code scanners, fingerprint readers, etc.). So, we
>> have been working on that feature using the USB/IP layer on the
>> kernel.
>>
>> Connecting and disconnecting devices and transferring data works
>> seamless for the devices listed above. But we also want to make the
>> usbip operations private to the container where they are run.  For
>> instance, it is unacceptable for our product, that one user could list
>> the devices connected by other users or access them.
>>
>> We can control how can access every device using cgroups once those
>> are attached, but the usbip layer is not providing any mechanism for
>> controlling who can attach, detach or list the devices.
> 
> Did you explore a solution to add a mechanism for access control to
> usbip?

Could you elaborate on that?

For "usbip", do you mean the user space tools? If that is the case, I 
don't think it would be enough. My aim is to limit vhci usage from 
containers and I have no control about what runs inside the containers. 
So, a mangled usbip tool-set could be used by a malicious user to 
circumvent any access control set there.

IMO, there is no other choice but to control access to VHCI at the 
kernel level.


> 
>>
>> So, we got the idea that in order to enforce that remote usbip devices
>> are only visible inside the container where they were imported, we
>> could conveniently mount-bind inside every container just one of the
>> vhci_hcd directories below /sys/devices/platform. So that it is as if
>> every container had a vhci_hcd just for itself (and also, we restrict
>> access to the matching USB ports in cgroups).
>>
>> Unfortunately, all the vhci_hcd.* devices are controlled through
>> attributes in vhci_hcd.0 making our approach fail and so... well, that
>> is what this patch series changes. It makes every vhci_hcd device
>> controllable through attributes inside its own sysfs directory.>
>> The first patch, does that in the kernel, and the second and third
>> patches change user space, adapting the libusbip and the usbip tools
>> code respectively.
>>
>> Then there is a fourth patch, that allows to create much more USB
>> hubs per machine. It was limited to 64 and we are running thousands of
>> containers (every one requiring a hub) per host.
>>
>> These changes are not completely backward compatible. In the sysfs
>> side, besides moving around the attribute files, now the port numbers
>> go from 0 to CONFIG_USBIP_VHCI_HC_PORTS * 2 - 1 and are reused for
>> every vhci_hcd device. I could have maintained the absolute numeration
>> but I think reusing the numbers is a better and simpler approach.
> 
> Not being able to maintain backwards compatibility is an issue. This is
> a considerable change to the user interface.

Well, it is true that it is a considerable change to the user interface 
breaking backward compatibility, but as I had already stated, that 
interface was broken until a couple of months ago, when my coworker, 
Juan Zea, reported it and nobody had noticed it before. So, I don't 
think we are going to affect too many people.

Note also that the user interface does not change when only vhci_hcd.0 
is used.


Regards
