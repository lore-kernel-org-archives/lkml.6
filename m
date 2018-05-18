Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZoqL8m5xkLJUIj68nDOV4sIX/9/yKoNo9gmSzzPN2bp3jVAX1ORn9ZUV8M4MXavEMHzgZH4
ARC-Seal: i=1; a=rsa-sha256; t=1526682443; cv=none;
        d=google.com; s=arc-20160816;
        b=MealF7TG7mXp3QvSrJLUz5xe8vhYNTacIb9oKP3Rur+NUQ4vRNWc3zqrSPQPZiq+Qf
         XP/J1CDUwFZZrLYiZ2AXjw/pgL5nWI+FTSdD279mKZp82jMRWDQnnVy0NjtGe9JoVs9X
         89MLDIbzcJgaxr8dhNnD7aykOE4nwTfTrc78wRWcOGrJ02CeUJVX9wgBbCMWRhKFDD/T
         DWXZ4fpsdLwpCRyiIbujZtDr0hY6FsIHFvOntwFsyAh8onrUr/GwkQcAnUwavyWlrcfP
         DV7q5B1wG32yxZ7P6FvtJY+C6LsdRfQISwyjecE1QWxWCRg4tdab9nM27V1uzNgazpmK
         u73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=MJGfmVum2FbracbdvIwT7IJ35aBupqBqZz0M7CVSIjo=;
        b=FRKQe9ZNBa5f5C93dJK6sLm2nTME6A2XqtLgOgYjPuucQ5o1HCk1h303GEfVUCq1wr
         BH4GhV4FOdw2QSfzPCAH6HklsZoqFpD7mfcMjkCtXeuOFmimnkWXLdOYVNmeZOsN6AEs
         GG6DyJCR2c/+paxGF+SFnItcvXlzjYu6YOaqHTuA1Rk/1fQ68Or1Gz2Uhms+GGe3S+PJ
         mMSaJOZju1AGIcHANyIXRmBmsPf+vczZMVEMNsi9ztGOF1q4UNPu41azKWP6hatYweJE
         amx+Fao4GP3rTDAaJfobQi7xyHfgmbBm+65lBEjzYvclNy5Gx+adpgfPzU19bGRPd7h0
         tZSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.143.4 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.143.4 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Subject: Re: [PATCH v2] usbip: vhci_sysfs: fix potential Spectre v1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
 Valentina Manea <valentina.manea.m@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180517201628.GA6090@embeddedor.com>
 <20180518134701.GA15598@kroah.com>
 <a6e9c635-5749-6fa0-7d1d-c1390d7f61ff@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <3a169862-d723-88fb-05d6-f1ec80c8f7ab@embeddedor.com>
Date: Fri, 18 May 2018 17:27:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a6e9c635-5749-6fa0-7d1d-c1390d7f61ff@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.252.93
X-Source-L: No
X-Exim-ID: 1fJnqN-002ads-1h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-93.static.axtel.net ([192.168.15.106]) [187.162.252.93]:51324
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600661041859915107?=
X-GMAIL-MSGID: =?utf-8?q?1600842570280129763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/18/2018 11:06 AM, Shuah Khan wrote:
> On 05/18/2018 07:47 AM, Greg Kroah-Hartman wrote:
>> On Thu, May 17, 2018 at 03:16:28PM -0500, Gustavo A. R. Silva wrote:
>>> pdev_nr and rhport can be controlled by user-space, hence leading to
>>> a potential exploitation of the Spectre variant 1 vulnerability.
>>>
>>> This issue was detected with the help of Smatch:
>>> drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
>>> drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
>>> drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_ss->vdev'
>>> drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_hs->vdev'
>>>
>>> Fix this by sanitizing pdev_nr and rhport before using them to index
>>> vhcis and vhci->vhci_hcd_ss->vdev respectively.
>>>
>>> Notice that given that speculation windows are large, the policy is
>>> to kill the speculation on the first load and not worry if it can be
>>> completed with a dependent load/store [1].
>>>
>>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>> Changes in v2:
>>>   - Place the barriers into valid_port.
>  
> attach_store() doesn't call valid_port() - can you make the change to
> have attach_store() call valid_port() to protect that code path.
> 
>>
>> Thanks for the change.  I'll wait for Shuah's ack/review before queueing
>> this up just as she knows that codebase much better than anyone else.
>>>
> 

Greg,

I've been talking with Dan Williams (intel) about this kind of issues 
[1] and it seems my original assumptions are correct. Hence, this patch 
is not useful and, in order to actually prevent speculation here we 
would need to pass the address of pdev_nr and rhport into valid_port, 
otherwise there may be speculation at drivers/usb/usbip/vhci_sysfs.c:235:

         if (!valid_port(pdev_nr, rhport))
                 return -EINVAL;

         hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);


[1] https://marc.info/?l=linux-kernel&m=152668152509103&w=2

Thanks
--
Gustavo
