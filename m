Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbeCFWEY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:04:24 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41536 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeCFWEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:04:23 -0500
X-Google-Smtp-Source: AG47ELv565Bjcu+m9YioKyOTg3WLi8FRAyskEVgs3dZ57p3h925dl0S6GrWubCp6lLpr420zC4ynXxjCnU6kaNEBsrE=
MIME-Version: 1.0
In-Reply-To: <8b812c4f-dfd8-928e-d5dd-f65679d0a88e@linux.vnet.ibm.com>
References: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com> <CAGXu5jLT+0=eSV-o8Ogd_a1krM6nppvqQ_fqn8Rn=ArPRwq7Ow@mail.gmail.com>
 <536fd857-2ee9-ef9c-4cc5-588ae1a07355@linux.vnet.ibm.com> <8b812c4f-dfd8-928e-d5dd-f65679d0a88e@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Mar 2018 14:04:20 -0800
X-Google-Sender-Auth: mSy_moviUs010H0MUomrrK0ra7Y
Message-ID: <CAGXu5jLhTdkyeJv6v6hf-qB6U3eZBFUq0KrT9CVgfSTZa1yMmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] trace_uprobe: Simplify probes_seq_show()
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: wangnan0 <wangnan0@huawei.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 12:12 AM, Ravi Bangoria
<ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>
> On 02/08/2018 09:13 AM, Ravi Bangoria wrote:
>>
>> On 02/08/2018 08:59 AM, Kees Cook wrote:
>>> On Tue, Feb 6, 2018 at 8:34 PM, Ravi Bangoria
>>> <ravi.bangoria@linux.vnet.ibm.com> wrote:
>>>> Simplify probes_seq_show() function. We are using %lx to display
>>>> the offset and we don't prepend unnecessary 0s in the offset.
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>>>> ---
>>>>  kernel/trace/trace_uprobe.c | 21 +++------------------
>>>>  1 file changed, 3 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>>>> index c2c965398893..c12a3957e1ee 100644
>>>> --- a/kernel/trace/trace_uprobe.c
>>>> +++ b/kernel/trace/trace_uprobe.c
>>>> @@ -602,24 +602,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
>>>>         char c = is_ret_probe(tu) ? 'r' : 'p';
>>>>         int i;
>>>>
>>>> -       seq_printf(m, "%c:%s/%s", c, tu->tp.call.class->system,
>>>> -                       trace_event_name(&tu->tp.call));
>>>> -       seq_printf(m, " %s:", tu->filename);
>>>> -
>>>> -       /* Don't print "0x  (null)" when offset is 0 */
>>>> -       if (tu->offset) {
>>>> -               seq_printf(m, "0x%lx", tu->offset);
>>>> -       } else {
>>>> -               switch (sizeof(void *)) {
>>>> -               case 4:
>>>> -                       seq_printf(m, "0x00000000");
>>>> -                       break;
>>>> -               case 8:
>>>> -               default:
>>>> -                       seq_printf(m, "0x0000000000000000");
>>>> -                       break;
>>>> -               }
>>>> -       }
>>>> +       seq_printf(m, "%c:%s/%s %s:0x%lx", c, tu->tp.call.class->system,
>>>> +                       trace_event_name(&tu->tp.call), tu->filename,
>>>> +                       tu->offset);
>>> To keep the prepended zeros (and avoid the redundant 0x prefix):
>>>
>>> "...%#0*lx...", ... sizeof(void *) * 2, tu->offset);
>>>
>>> As in:
>>>
>>> +       seq_printf(m, "%c:%s/%s %s:%#0*lx", c, tu->tp.call.class->system,
>>> +                       trace_event_name(&tu->tp.call), tu->filename,
>>> +                       sizeof(void *) * 2, tu->offset);
>> This is useful, thanks Kees.
>>
>> @Wang, Do we really need those 0s? Won't just 0x0 should
>> suffice? Here is the sample output...
>>
>>   # echo "p:probe_a/main /tmp/a.out:0x0" > uprobe_events
>>
>> Before patch:
>>   # cat uprobe_events
>>     p:probe_a/main /tmp/a.out:0x0000000000000000
>>
>> After patch:
>>   # cat uprobe_events
>>     p:probe_a/main /tmp/a.out:0x0
>
> Wang, ping :)
>
> Kees, I don't hear back from Wang and no one has reported any issues with
> the patches yet. Can I have your Acked-by?

I didn't see a v2 of these patches with the output fixed?

-Kees

-- 
Kees Cook
Pixel Security
