Return-Path: <ghammer@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521097026; cv=none;
        d=google.com; s=arc-20160816;
        b=XEQtstXDEmzTszwWRkkmyWdnQPCs+tN3E86TubEk6Gd0RkSeEvaPDTO8SK/Lucyfdi
         KlUW07isSUx2/00IQbue0v+P/uIJ8aM/rdYLW9/HYLnj/HwhZRjR3PM+K32QexNkXL5c
         NdOE+hB8XnfOD9cECpmxeNymfsIEiHd8az2k9xswBM7p0p4TcVFey4ZqWPVAt9bfLWFH
         80qFDuCs8Y9umb6Jr4IVzx3OP7EfDzLwJRw7WPqGy47rs8Qneid0qJI8DalwjF+VM9hm
         ueXL9NeFD4aFRUhEt4YnFZKOn2wxm0/AEKl+Lg24drjEPAWIkDW0J+P13IiM4b7SeULd
         cXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=SO4L1LA3bQCXuVm07OqInALQlw7XEkrpWb4Bp0/+OWo=;
        b=e7fgjEQcoaFQ0cM4DxWUIO6rFMWtK+VwmnFY1K3dyhQ8Vl1oP8X4s5aPlRw/7C6vAT
         m3xJa5UjAWrCE4b0zRvm1Xz5KPBNQCgn4x2E85EWbZdU0al5Zcyz1WLYjyC1XFIJYIIN
         i6jS4qkzt7/3n1gqdbusoo8aYjtfNT45keYBrDvjHj7matP8K3eWEu9wQ6Ti3Yer8VxD
         N0MFRAvVdMDIFdg5qWFcI6Wb53X3nL0Eas67DErX5RHAhQgvQq13VJM2OqIeUl5fsFKi
         /6/8o0BGkuXHys3eq9aO577wba0aqYnDquT3CZHWZOMx/sL2i9kSkP3T00w6lNzzAp1g
         5qCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ghammer@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ghammer@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ghammer@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ghammer@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELvaJGuKJjPRRDjZv/zrwWEvu8k8Qip+6MjUVNCpjUssB1pl0h58RgTlX4m/psgkR1BZZD00l6e2nDJFyD9pGfc=
MIME-Version: 1.0
In-Reply-To: <20180314211704-mutt-send-email-mst@kernel.org>
References: <20180301142215.11812-1-idgar@virtualoco.com> <20180313190617-mutt-send-email-mst@kernel.org>
 <20180314182536.GA14504@kroah.com> <20180314211704-mutt-send-email-mst@kernel.org>
From: Gal Hammer <ghammer@redhat.com>
Date: Thu, 15 Mar 2018 08:57:05 +0200
Message-ID: <CAA2ifQy4nP3-KdHGpho3ayQb_kfCX2GJx0kPmMotoTr3X+b1Bw@mail.gmail.com>
Subject: Re: [PATCH v5] drivers/misc: vm_gen_counter: initial driver implementation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Or Idgar <idgar@virtualoco.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Or Idgar <oidgar@redhat.com>,
	Or Idgar <oridgar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593745507285614890?=
X-GMAIL-MSGID: =?utf-8?q?1594985835489559817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 9:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Mar 14, 2018 at 07:25:36PM +0100, Greg KH wrote:
>> On Tue, Mar 13, 2018 at 07:40:51PM +0200, Michael S. Tsirkin wrote:
>> > I think it's a good idea to use sysfs for this. However,
>> > there are a couple of missing interfaces here:
>> >
>> > 1. Userspace needs a way to know when this value changes.
>> >    I see no change notifications here and that does not seem right.
>>
>> How can these change?
>
> It's a hardware register. It changes when hardware feels like it :)
> In particular, it changes whenever VM is migrated or snapshotted.

This value doesn't change when a VM is migrated. It is unlikely that
this value will be changed so frequently that a direct access to the
memory is required. Even in QEMU, the current implementation was
merged without an option to change the generation id on-the-fly. One
must run a new instance in order to set a new value, which means that
no application will be running during that time.

>> > 2. Userspace needs to be able to read these without
>> >    system calls.
>>
>> Ick, what?  Why not?
>>
>> > Pls add mmap support to the raw format.
>>
>> For a single integer?  Why do you need mmap for this?  What is so
>> "performant" that needs to touch a sysfs file?
>> >    (Phys address is not guaranteed to be page-aligned so you will
>> >     probably want an offset attribute for that as well).
>>
>> Ick ick ick, that's why it's good to just stick with a sysfs file.

I agree with Greg here. The user is able to read the value, and then
wait for a notification if she cares about changes.

>> Have you tested just how long this takes to see if the open/read/close
>> is really the bottleneck, or if the io on reading the value is the
>> bottleneck?
>>
>> thanks,
>>
>> greg k-h
>
> Well an application needs to check this value basically after
> every database transaction. So I'm pretty sure it's a performance
> sensitive path. But yes, I didn't profile any apps since they
> are yet to be written to use this interface.
> I'm fine deferring point 2 for now.
>
> --
> MST

Thanks,

    Gal.
