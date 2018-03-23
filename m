Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeCWJbs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:31:48 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33756 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeCWJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:31:46 -0400
X-Google-Smtp-Source: AG47ELt/XKoNHE/U4sy/VGmW8w94gaVCm43U6jHGDsjFKYMI8Dsrl2Zh7WbO/g+AbuYV79Xe39iFGsqawJLd8cJswMg=
MIME-Version: 1.0
In-Reply-To: <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn> <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 23 Mar 2018 10:31:45 +0100
Message-ID: <CAOi1vP8eLcc6u-XhpSu33+3eDygy3Mp+_tJXT7ygdwsnUs-RmQ@mail.gmail.com>
Subject: Re: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
To: =?UTF-8?B?5LqA5LqV5LuB5b+XIC8gS0FNRUnvvIxISVRPU0hJ?=
        <hitoshi.kamei.xm@hitachi.com>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>,
        "sage@redhat.com" <sage@redhat.com>,
        "elder@kernel.org" <elder@kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2N9VrhO007339

On Thu, Mar 22, 2018 at 12:57 PM, 亀井仁志 / KAMEI，HITOSHI
<hitoshi.kamei.xm@hitachi.com> wrote:
> Hi Yang,
>
>> I am not sure is this the best way for this case, what about adding an option in "rbd map -o thick rbd/test"?
>
> I will add such option to the rbd map command to manipulate image settings. So, the end-user
> do not change the settings directly via sysfs file.
>
>>       @@ -4011,6 +4012,15 @@ static void rbd_queue_workfn(struct work_struct *work)
>>                       goto err;
>>               }
>>
>>       +       /* Ignore/skip discard requests for thick-provision image */
>>
>> Just ignore? or return -EOPNOTSUPP?
>
> Thanks, I think -EOPNOTSUPP is better because user programs cannot know
> the result of requested operation when the kernel rbd driver ignores
> discard request. The result of requested operation when the kernel rbd driver
> ignores discard requests, which probably misleads the user programs.
>
>> In addition, we should not ignore the REQ_OP_WRITE_ZEROES.
>
> Relating to the above, the return code of REQ_OP_WRITE_ZEROS request
> is also -EOPNOTSUPP instead of ignoring. I think the result of
> -EOPNOTSUPP is also better for this request because the kernel
> rbd driver can expect that user programs write zero data by itself.

REQ_OP_WRITE_ZEROES should continue to work, we just need to make
sure it never issues truncates or deletes and instead writes zeroes
explicitly.

I think we should be explicit about the fact that discard is not
supported instead of accepting the discard request and failing it in
rbd_queue_workfn().  Attached patch is what I have in mind.

Thanks,

                Ilya
