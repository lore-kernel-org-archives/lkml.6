Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EDBC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40450213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40450213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeJFG26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:28:58 -0400
Received: from smtp.infotech.no ([82.134.31.41]:38841 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeJFG26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:28:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 8216C204190;
        Sat,  6 Oct 2018 01:27:58 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4x0EDcRxv1eX; Sat,  6 Oct 2018 01:27:52 +0200 (CEST)
Received: from [192.168.48.23] (host-45-78-192-203.dyn.295.ca [45.78.192.203])
        by smtp.infotech.no (Postfix) with ESMTPA id 45954204147;
        Sat,  6 Oct 2018 01:27:49 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: Recent removal of bsg read/write support
To:     Greg KH <gregkh@linuxfoundation.org>,
        Dror Levin <drorl@infinidat.com>
Cc:     torvalds@linux-foundation.org,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@infradead.org, axboe@kernel.dk
References: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
 <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com>
 <CA+55aFyLC8PhjZ+iV7MucSZ1aGKMT=S9=EkEAQ6T1=ZRqD-xLA@mail.gmail.com>
 <CAOuWhkbNuesaVYar6ML-qFw7RAfkPsaOYUXT4Ypfiu5=Nt1kWw@mail.gmail.com>
 <CAOuWhkYRtTqrnp1uyDWFqXFcTLhPbcqv8XzdV_jurJHstGQmuA@mail.gmail.com>
 <20181005223526.GF13613@kroah.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <c443315d-eef2-31c9-754a-f24f0fcbb129@interlog.com>
Date:   Fri, 5 Oct 2018 19:27:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005223526.GF13613@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-05 06:35 PM, Greg KH wrote:
> On Thu, Oct 04, 2018 at 09:58:37AM +0300, Dror Levin wrote:
>> CC'ing Greg.
>>
>> On Mon, Sep 3, 2018 at 11:34 AM Dror Levin <drorl@infinidat.com> wrote:
>>>
>>> On Sun, Sep 2, 2018 at 8:55 PM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> On Sun, Sep 2, 2018 at 4:44 AM Richard Weinberger
>>>> <richard.weinberger@gmail.com> wrote:
>>>>>
>>>>> CC'ing relevant people. Otherwise your mail might get lost.
>>>>
>>>> Indeed.
>>>
>>> Sorry for that.
>>>
>>>>> On Sun, Sep 2, 2018 at 1:37 PM Dror Levin <drorl@infinidat.com> wrote:
>>>>>>
>>>>>> We have an internal tool that uses the bsg read/write interface to
>>>>>> issue SCSI commands as part of a test suite for a storage device.
>>>>>>
>>>>>> After recently reading on LWN that this interface is to be removed we
>>>>>> tried porting our code to use sg instead. However, that raises new
>>>>>> issues - mainly getting ENOMEM over iSCSI for unknown reasons.
>>>>
>>>> Is there any chance that you can make more data available?
>>>
>>> Sure, I can try.
>>>
>>> We use writev() to send up to SG_MAX_QUEUE tasks at a time. Occasionally not
>>> all tasks are written at which point we wait for tasks to return before
>>> sending more, but then writev() fails with ENOMEM and we see this in the syslog:
>>>
>>> Sep  1 20:58:14 gdc-qa-io-017 kernel: sd 441:0:0:5: [sg73]
>>> sg_common_write: start_req err=-12
>>>
>>> Failing tasks are reads of 128KiB.
>>>
>>>> I'd rather fix the sg interface (which while also broken garbage, we
>>>> can't get rid of) than re-surrect the bsg interface.
>>
>> Discussion seems to have died down but release of 4.19 is drawing near.
>>
>> Is there still any chance removal of bsg can be reconsidered? Maybe
>> postponed to the
>> next version to allow more time to adjust?
>>
>> I'm especially concerned about the possibility of this being
>> backported to stable kernels
>> which might leave us very little time to fix our code.
> 
> What is being backported to what stable kernels and why?

What has been removed from the bsg driver is the ability to use write()
to issue a SCSI command (and return before that command's response has
arrived) and to use read() to wait for the issued command to complete
and return that command's status and optionally its sense buffer.
Basically async SCSI command capability has been removed from the bsg
driver. The ioctl(SG_IO) for bsg device stays in place.

The reason is that the bsg driver has no active maintainer and its
rather serious design flaw: when a async SCSI command is issued (by
a write()) any process using any file descriptor (opened on that
device) may receive its response. Actually if you tried hard with bsg,
the synchronous SG_IO ioctl will also exhibit this behaviour.

> Is there sg patches?

Well I'm working on a patch set but it won't be ready for lk 4.19 .
Amongst other things it will remove the SG_MAX_QUEUE (16) request
limitation per file descriptor that Dror Levin is noting as a
hardship when re-porting their application from the bsg to sg driver.

Also Linus Torvalds doesn't like the write()/read() async interface used
by the sg driver and mimicked by the bsg driver. It has been in place in
the sg driver since 1992 (see lk 1.0) when it was the only user space
interface to the sg driver. Linus proposed replacing them by two new
ioctls: SG_IOSUBMIT and SG_IORECEIVE ***. I will work on a second patch
set for the sg driver to do exactly that (plus SG_IOABORT to abort a
request inflight).

> totally confused,

Hope this helps.

Doug Gilbert

*** See Linux Torvalds' post to this thread on 20180902
