Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeBHDmO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 22:42:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750810AbeBHDmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 22:42:13 -0500
Subject: Re: [PATCH 2/2] trace_uprobe: Simplify probes_seq_show()
To: Kees Cook <keescook@chromium.org>, wangnan0 <wangnan0@huawei.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com>
 <CAGXu5jLT+0=eSV-o8Ogd_a1krM6nppvqQ_fqn8Rn=ArPRwq7Ow@mail.gmail.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 09:13:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLT+0=eSV-o8Ogd_a1krM6nppvqQ_fqn8Rn=ArPRwq7Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18020803-0008-0000-0000-000004CA9340
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020803-0009-0000-0000-00001E5E4538
Message-Id: <536fd857-2ee9-ef9c-4cc5-588ae1a07355@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 08:59 AM, Kees Cook wrote:
> On Tue, Feb 6, 2018 at 8:34 PM, Ravi Bangoria
> <ravi.bangoria@linux.vnet.ibm.com> wrote:
>> Simplify probes_seq_show() function. We are using %lx to display
>> the offset and we don't prepend unnecessary 0s in the offset.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> ---
>>  kernel/trace/trace_uprobe.c | 21 +++------------------
>>  1 file changed, 3 insertions(+), 18 deletions(-)
>>
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index c2c965398893..c12a3957e1ee 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -602,24 +602,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
>>         char c = is_ret_probe(tu) ? 'r' : 'p';
>>         int i;
>>
>> -       seq_printf(m, "%c:%s/%s", c, tu->tp.call.class->system,
>> -                       trace_event_name(&tu->tp.call));
>> -       seq_printf(m, " %s:", tu->filename);
>> -
>> -       /* Don't print "0x  (null)" when offset is 0 */
>> -       if (tu->offset) {
>> -               seq_printf(m, "0x%lx", tu->offset);
>> -       } else {
>> -               switch (sizeof(void *)) {
>> -               case 4:
>> -                       seq_printf(m, "0x00000000");
>> -                       break;
>> -               case 8:
>> -               default:
>> -                       seq_printf(m, "0x0000000000000000");
>> -                       break;
>> -               }
>> -       }
>> +       seq_printf(m, "%c:%s/%s %s:0x%lx", c, tu->tp.call.class->system,
>> +                       trace_event_name(&tu->tp.call), tu->filename,
>> +                       tu->offset);
> To keep the prepended zeros (and avoid the redundant 0x prefix):
>
> "...%#0*lx...", ... sizeof(void *) * 2, tu->offset);
>
> As in:
>
> +       seq_printf(m, "%c:%s/%s %s:%#0*lx", c, tu->tp.call.class->system,
> +                       trace_event_name(&tu->tp.call), tu->filename,
> +                       sizeof(void *) * 2, tu->offset);

This is useful, thanks Kees.

@Wang, Do we really need those 0s? Won't just 0x0 should
suffice? Here is the sample output...

  # echo "p:probe_a/main /tmp/a.out:0x0" > uprobe_events

Before patch:
  # cat uprobe_events
    p:probe_a/main /tmp/a.out:0x0000000000000000

After patch:
  # cat uprobe_events
    p:probe_a/main /tmp/a.out:0x0

Thanks,
Ravi

> -Kees
>
>>         for (i = 0; i < tu->tp.nr_args; i++)
>>                 seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
>> --
>> 2.13.6
>>
>
>
