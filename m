Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeCORvu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:51:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53147 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeCORvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:51:48 -0400
X-Google-Smtp-Source: AG47ELvkwG9oVm6av75BWWI40Neuv8i+HuEX0wnUomWMzC915WtPDHrOBWk1CkgG4C/qfE4DWe8Jd398L2mteFwCoVw=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1OJqHEOgiHk1ZQytGW7b1c2Nam5xjSxxkfx=h2x7f_mg@mail.gmail.com>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
 <1520705944-6723-4-git-send-email-jix024@eng.ucsd.edu> <20180315045401.GB4860@magnolia>
 <CAD4SzjtHmBTisX6vQYuEnJf0fKsF==w5GHqsdks6xGv1go7Lzw@mail.gmail.com> <CAK8P3a1OJqHEOgiHk1ZQytGW7b1c2Nam5xjSxxkfx=h2x7f_mg@mail.gmail.com>
From: Andiry Xu <jix024@eng.ucsd.edu>
Date: Thu, 15 Mar 2018 10:51:46 -0700
Message-ID: <CAD4Szjt6URWFEuB_qZcnoQMqCLNwyCns0CCP==Su7iQOt=ddMw@mail.gmail.com>
Subject: Re: [RFC v2 03/83] Add super.h.
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>, coughlan@redhat.com,
        Steven Swanson <swanson@cs.ucsd.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        swhiteho@redhat.com, miklos@szeredi.hu, Jian Xu <andiry.xu@gmail.com>,
        Andiry Xu <jix024@cs.ucsd.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 2:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 15, 2018 at 7:11 AM, Andiry Xu <jix024@eng.ucsd.edu> wrote:
>> On Wed, Mar 14, 2018 at 9:54 PM, Darrick J. Wong
>> <darrick.wong@oracle.com> wrote:
>>> On Sat, Mar 10, 2018 at 10:17:44AM -0800, Andiry Xu wrote:
>
>>>> +     /* s_mtime and s_wtime should be together and their order should not be
>>>> +      * changed. we use an 8 byte write to update both of them atomically
>>>> +      */
>>>> +     __le32          s_mtime;                /* mount time */
>>>> +     __le32          s_wtime;                /* write time */
>>>
>>> Hmmm, 32-bit timestamps?  2038 isn't that far away...
>>>
>>
>> I will try fixing this in the next version.
>
> I would also recommend adding nanosecond-resolution timestamps.
> In theory, a signed 64-bit nanosecond field is sufficient for each timestamp
> (it's good for several hundred years), but the more common format uses
> 64-bit seconds and 32-bit nanoseconds in other file systems.
>
> Unfortunately it looks, you will have to come up with a more sophisticated
> update method above, even if you leave out the nanoseconds, you can't
> easily rely on a 16-byte atomic update across architectures to deal with
> the two 64-bit timestamps. For the superblock fields, you might be able
> to get away with using second resolution, and then encoding the
> timestamps as a signed 64-bit 'mkfs time' along with two unsigned
> 32-bit times added on top, which gives you a range of 136 years mount
> a file system after its creation.
>

I will take a look at other file systems.

Superblock mtime is not a big problem as it is updated rarely. 64-bit
seconds and 32-bit nanoseconds make the inode and log entry bigger,
and updating file->atime cannot be done with a single 64bit update.
That may be annoying and needs to use journaling.

Thanks,
Andiry

>       Arnd
