Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeBKPza (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 10:55:30 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:46983 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 10:55:29 -0500
X-Google-Smtp-Source: AH8x226y4Ukavw0xKrc3xCcv5vCBNaokGBGIeC0Ly0gK+rEckKRd8y1A6rd6R6pEO1d8l2T4khP9m5Iw72sa4cO5674=
MIME-Version: 1.0
In-Reply-To: <20180211154746.j33vipgepv75dw3r@node.shutemov.name>
References: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
 <151835937752.185602.5640977700089242532.stgit@buzz> <20180211151433.xvza2mugfybyocoi@node.shutemov.name>
 <CALYGNiMjuW4BM2tSUOUmJUu7kX0HEL1EN-YFi=cvtstQi3YeHQ@mail.gmail.com> <20180211154746.j33vipgepv75dw3r@node.shutemov.name>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Sun, 11 Feb 2018 18:55:27 +0300
Message-ID: <CALYGNiMToA7CbdBjAaDqWc_EEsQg6GCusU_-R3ZuyXv8icXPMQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/huge_memory.c: reorder operations in __split_huge_page_tail()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 6:47 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Sun, Feb 11, 2018 at 06:32:10PM +0300, Konstantin Khlebnikov wrote:
>> On Sun, Feb 11, 2018 at 6:14 PM, Kirill A. Shutemov
>> <kirill@shutemov.name> wrote:
>> > On Sun, Feb 11, 2018 at 05:29:37PM +0300, Konstantin Khlebnikov wrote:
>> >> And replace page_ref_inc()/page_ref_add() with page_ref_unfreeze() which
>> >> is made especially for that and has semantic of smp_store_release().
>> >
>> > Nak on this part.
>> >
>> > page_ref_unfreeze() uses atomic_set() which neglects the situation in the
>> > comment you're removing.
>>
>> Why? look into x86 smp_store_release
>> for PPro it use same sequence smp_wb + WRITE_ONCE
>> As I see spin_unlock uses exactly this macro.
>>
>> Anyway if page_ref_unfreeze cannot handle races with
>> get_page_unless_zero() then it completely useless,
>
> Okay, fair enough.
>
> But please call it out it the commit message.

OK, I'll review this yet again and resend tomorrow.
