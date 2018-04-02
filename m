Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeDBQ0J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:26:09 -0400
Received: from ch3vs04.rockwellcollins.com ([205.175.226.52]:62038 "EHLO
        ch3vs04.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752853AbeDBQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:25:57 -0400
X-RC-All-From: , 205.175.226.20, No hostname, ronak.desai@rockwellcollins.com,
 Ronak Desai <ronak.desai@rockwellcollins.com>, ,
X-RC-Attachments: , ,
X-RC-RemoteIP: 205.175.226.20
X-RC-RemoteHost: No hostname
X-RC-IP-Hostname: ch3ip04.rockwellcollins.com
X-RC-IP-MID: 4923241
X-RC-IP-Group: GOOGLE_RELAYED
X-RC-IP-Policy: $GOOGLE_RELAYED
X-RC-IP-SBRS: None
X-Google-Smtp-Source: AIpwx4+w6gl9JAtuZYS9k+CcvU1UFbMQ/GZZmlhOD2lylyECcFfcbjPyYnq9HxkO5WuuBCzoSW+pcx1L5M1thFq/XmA=
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzvLNs7ONc+N7YHziULyK-FEz+rE8ASv=F4nnHaSH1DfQ@mail.gmail.com>
References: <CADFuHZ4L4+-V2XYzTbpuMDL5BycfDU7QaVZo6z+PTTQA4cXFoA@mail.gmail.com>
 <CADFuHZ6c5p7opDgAoPc6oq8O6udSsFzW2VS721PNjoTh6v9D8g@mail.gmail.com> <CAFLxGvzvLNs7ONc+N7YHziULyK-FEz+rE8ASv=F4nnHaSH1DfQ@mail.gmail.com>
From: Ronak Desai <ronak.desai@rockwellcollins.com>
Date: Mon, 2 Apr 2018 11:16:24 -0500
Message-ID: <CADFuHZ7y_QXsr3-hZYR3mbgnaDEGS_itk_q2mSi_nsbwUFaGbA@mail.gmail.com>
Subject: Re: Question regarding container affecting the host system mounts
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 10:56 AM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> Ronak Desai,
>
> On Mon, Apr 2, 2018 at 5:40 PM, Ronak Desai
> <ronak.desai@rockwellcollins.com> wrote:
>> I am able to workaround this issue by marking the mount as unbinadable
>> and clearing the flag (CL_COPY_UNBINDABLE) in "copy_tree" function in
>> fs/namespace.c. This skips the unbindable mounts to get cloned inside
>> the new namespace. For my use-case this is acceptable.
>>
>> On Thu, Mar 29, 2018 at 3:50 PM, Ronak Desai
>> <ronak.desai@rockwellcollins.com> wrote:
>>> I came across a problem where if the containers are running then it
>>> affects the unmount process of the system's mount points. I am not
>>> using these mount points as shared mounts with container.
>>>
>>> For example, I am using SD card and NAND as external storage device
>>> and mounting it to a mount point in the ramfs. Then I am launching
>>> containers and then when I try to unmount the NAND partition then my
>>> "unmount" call succeeds but I don't see the UBIFS hooks being called
>>> and because of that my UBI detach process fails. When I stopped the
>>> container then I see that kernel is calling the unmount as I see my
>>> debug prints inside the UBIFS for unmounting that partition.
>>>
>>> If I tried to mount my NAND partition once the container is up and try
>>> to unmount then it does unmount and detach without issue. It seems
>>> like there is an issue with namespace.
>>>
>>> I am using 4.1.8 kernel .  I traced the kernel code and I see that
>>> copy_mnt_ns is calling copy_tree and which basically increasing the
>>> active counts of the super block of my host mount points (NAND, SD cards).
>>> I am using container but I do not wish to share any of my host storage
>>> media with
>>> container so in my container configuration I am only mounting the
>>> tmpfs as the rootfs of container is in in tmpfs of host. But, still I
>>> can't umount completely my host storage media if containers are
>>> running.
>>>
>>> I have attached the log of the container start process with debugging
>>> and where you can see it is increasing the super block active counts
>>> for "ubifs".
>
> Not sure if I understand the problem correctly, isn't this just a matter of
> mount point propagation?
> See MS_PRIVATE.
The problem is that whenever a container is launched the namespace is
cloned and which clones the whole tree
of the host. Because of that the superblock counts on the mountpoint
is increased and because of that actual
unmount fails(deactivate_super in fs/super.c). umount command returns
success but it does not call the filesystem
specific hooks(kill_sb) to unmount the filesystem. So, in case of UBI,
ubidetach fails. The same applies to other storage
media with ext filesystem.
By default the mounts are MS_PRIVATE so I was not expecting that there
will be any propagation from cloning
but I was wrong. It could be that this has been fixed in upstream
kernel(I could not find specific commit(s)) as I am using 4.1.8
kernel.
>
> --
> Thanks,
> //richard



-- 
Ronak A Desai
Sr. Software Engineer
Airborne Information Solutions / RC Linux Platform Software
MS 131-100, C Ave NE, Cedar Rapids, IA, 52498, USA
Ronak.Desai@rockwellcollins.com
https://www.rockwellcollins.com/
