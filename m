Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeCFUbG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 15:31:06 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33954 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeCFUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 15:31:05 -0500
X-Google-Smtp-Source: AG47ELvPz57LS43xYynO/p0GJaPA0m5lbY6I/glo2ckX5B02R7AmJ3JQ3kkf0yTPGwpfeW1kYurJ7rImH3fHsq3vzks=
MIME-Version: 1.0
In-Reply-To: <CAM_iQpVQs0YTckbo9F0zjPsSL+=ksVZvdcLO-QHTONcZc84eKg@mail.gmail.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306170011.GD25017@tassilo.jf.intel.com> <CAM_iQpUfRMW4aGfaTdFqCRwuuLXFX69Aewg+k-aa6BMUKSrhTA@mail.gmail.com>
 <20180306175320.GE25017@tassilo.jf.intel.com> <CAM_iQpVQs0YTckbo9F0zjPsSL+=ksVZvdcLO-QHTONcZc84eKg@mail.gmail.com>
From: Ilya Pronin <ipronin@twitter.com>
Date: Tue, 6 Mar 2018 12:31:03 -0800
Message-ID: <CA+Xn3kw2FZ4m1TossMT35KKJ7EsSV=ykdWKCHtjRs1oefdXWNw@mail.gmail.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking from the user's seat. An optional (not just empty) cgroup
field is fine as long it consistently appears when requested with -G
option. The problem with print_metric_csv() was that in the case of
unsupported counters 2 additional empty fields in the output are
completely unexpected and not documented anywhere.

Andi, in the output example in your commit
92a61f6412d3a09d6462252a522fa79c9290f405 stalled-cycles-backend event
has counter run time field, counter run time percentage field, empty
metric value, empty metric unit, and then 2 other empty fields. Are
they expected? If yes, what are they and why other events, e.g.
stalled-cycles-frontend, don't have them? Am I missing something here?

On Tue, Mar 6, 2018 at 11:03 AM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Tue, Mar 6, 2018 at 9:53 AM, Andi Kleen <ak@linux.intel.com> wrote:
>>> Here is the output from your own commit:
>>>
>>>       423470,,stalled-cycles-frontend,509102,100.00,65.69,frontend cycles idle
>>>       <not supported>,,stalled-cycles-backend,0,100.00,,,,
>>>
>>> so line 1 has 7 fields, line 2 has 9 fields, and this is expected?
>>
>> If you had metrics on line 1 it would be correct.
>>
>> So you just shifted it to break that case.
>>
>> If you always want to have the same number of fields
>> you need to add two empty fields to the normal output
>> when there are no metrics.
>
> The number of separators is the only way to learn the number
> of fields, therefore it must be a fixed number.
>
> Yeah, it could be the other way that supported ones have less
> separators than it should. If we look at print_metric_csv() alone,
> it should produce a same number of separators for all cases,
> otherwise hard to count.
>
> So I believe we need an additional patch, like the one attached,
> to make it complete? Note, I only spot the cgroup field here.

-- 
Ilya Pronin
