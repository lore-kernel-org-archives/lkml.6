Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeBWUek (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753918AbeBWUeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:34:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280C217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELujFI7DS6EZU76Mxg2EOcvycIr2Ej2uT05kaBTIh5vMI6L2goCA1vQmPrrYx24zv/NszM0Ar4DgM22potXfysM=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8q-9enjK=WLiB5tWvRKQu9+xh=dCqBtB6X9wazKuYiMA@mail.gmail.com>
References: <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
 <20180222014505.2l76ccrrs36y3b26@agluck-desk> <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
 <CA+55aFy0hRexJkLbN7t31LjfGr4Ae0W5g6sBMqHHJi8aYuGKeA@mail.gmail.com>
 <612E894E-62C8-4155-AED8-D53702EDC8DC@intel.com> <CA+55aFxeBaTbwvbWqx1MKYjKKzLUs=1O43Bx2=JaO8qrnY-8HA@mail.gmail.com>
 <20180222171506.wwsichkiyc5f74pr@agluck-desk> <CA+55aFyOLYAbvTX0F8WLHgBnhwAPWr7EOPbO_sEepmB5GsCBKQ@mail.gmail.com>
 <20180222175411.xzx2d2r2fahn7llo@agluck-desk> <CA+55aFwbjdLpXc4wnN5t7fQ5Zy1vbc+ysH+bsFkaJkStEBwr=A@mail.gmail.com>
 <CAKv+Gu8q-9enjK=WLiB5tWvRKQu9+xh=dCqBtB6X9wazKuYiMA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 23 Feb 2018 20:34:15 +0000
X-Gmail-Original-Message-ID: <CALCETrVrJWQNYcXFt4YQ-1EXFqMojiVTZhXR8zFoF+H0ZmfPjw@mail.gmail.com>
Message-ID: <CALCETrVrJWQNYcXFt4YQ-1EXFqMojiVTZhXR8zFoF+H0ZmfPjw@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Limit the rate for non-root to read files
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 6:08 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 22 February 2018 at 18:07, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Thu, Feb 22, 2018 at 9:54 AM, Luck, Tony <tony.luck@intel.com> wrote:
>>> With the new "while/nap" change there would still be one message
>>> per second, but the number of callbacks suppressed should be 1
>>> (unless the user has many threads doing reads).
>>>
>>> Maybe it is good to know that an application is doing something
>>> stupid and we should drop that line from the patch and let the
>>> warnings flow?
>>
>> I think the "one message per second" is fine.
>>
>> Looks good. Do I get this through the EFI tree, or should I just take
>> it directly?
>>
>
> Please take it directly if everybody is happy with it.
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I don't like this at all.  We're coming up with a bizarre ad-hoc hack
to work around the fact that we're allowing any unprivileged user can
call into firmware.  Let's just require privilege.  As I understand
it, Windows already requires privilege, and Windows is *right*.

Let's apply the original patch, not my patch.  Then, if it causes
problems with sealtotp, either users can chmod the relevant file or we
can add a gross hack in the kernel to make that particular file 0644
*and print a warning* if the file exists.  Then users can bug mjg to
fix sealtotp to use a privileged helper or systemd service or whatever
and rename the file at the same time.

But I read the sealtotp manual, and I don't see the point of using an
EFI var for sealtotp in the first place.  sealtotp supports TPM NV
storage, EFI vars, and plain old files.  I get why TPM NV makes
logical sense (sealtotp is a TPM thing), and using a plain old file
seems entirely reasonable.  I don't see why anyone would prefer an EFI
variable.

--Andy
