Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeDIObM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:31:12 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:37978 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeDIObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:31:10 -0400
X-Google-Smtp-Source: AIpwx48ET0IAEGaEhszy0D+kc9P7gVt8Kw1u7tBMxDXokTS0SWR7pe5dLV+3od72H6gUxomRd8fi5LKLnEISNUxT1XM=
MIME-Version: 1.0
In-Reply-To: <20180409142517.qrorcyng6puk4qed@quack2.suse.cz>
References: <d9b518a5-287a-72b3-05f1-ea89e25563ba@infradead.org>
 <20180404184517.9f2b91b856a56f71464f5f7f@linux-foundation.org>
 <5e9ea36a-6a6a-921c-81b3-bc623a9e125a@suse.com> <20180409142517.qrorcyng6puk4qed@quack2.suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 9 Apr 2018 16:30:49 +0200
Message-ID: <CACT4Y+Z62KDR+zo4V3hEYmmoET1=iBZOuMXFGa=zXb_BdJ3MAQ@mail.gmail.com>
Subject: Re: [PATCH?] reiserfs: prevent panic: don't allow %-char in journal
 dev. name
To: Jan Kara <jack@suse.cz>
Cc: Jeff Mahoney <jeffm@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 4:25 PM, Jan Kara <jack@suse.cz> wrote:
> On Wed 04-04-18 21:48:53, Jeff Mahoney wrote:
>> On 4/4/18 9:45 PM, Andrew Morton wrote:
>> > On Wed, 4 Apr 2018 18:25:16 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>> >
>> >> From: Randy Dunlap <rdunlap@infradead.org>
>> >>
>> >> If the reiserfs mount option's journal name contains a '%' character,
>> >> it can lead to a WARN_ONCE() in lib/vsprintf.c::format_decode(),
>> >> saying: "Please remove unsupported %/ in format string."
>> >> That's OK until panic_on_warn is set, at which point it's dead, Jim.
>> >>
>> >> To placate this situation, check the journal name string for a '%'
>> >> character and return an error if one is found. Also print a warning
>> >> (one that won't panic the kernel) about the invalid journal name (e.g.):
>> >>
>> >>   reiserfs: journal device name is invalid: %/file0
>> >>
>> >> (In this example, the caller app specified the journal device name as
>> >> "%/file0".)
>> >>
>> >
>> > Well, that is a valid filename and we should support it...
>> >
>> > Isn't the bug in journal_init_dev()?
>>
>> Yep.  That's exactly it.
>>
>> Acked-by: Jeff Mahoney <jeffm@suse.com>
>
> Thanks. I've picked up the patch from Andrew, added his Signed-off-by (OK,
> Andrew?), wrote a proper changelog and pushed it to my tree. The result is
> attached.

Hi Jan,

Please also add:

Reported-by: syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com

as the original reporter.
