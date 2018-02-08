Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBHD3R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 22:29:17 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43447 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHD3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 22:29:16 -0500
X-Google-Smtp-Source: AH8x225WsiQ7m5GMjcQJe71UrNij1SRnQPaPlFgwB0ZM5NVZqLfB5JstHquDQvnmZZCKzc7cPUbMdiowbnotrb9b6rA=
MIME-Version: 1.0
In-Reply-To: <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com>
References: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com> <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Feb 2018 14:29:14 +1100
X-Google-Sender-Auth: zFejQnKJef0PKIyTvt_GWvKgJnE
Message-ID: <CAGXu5jLT+0=eSV-o8Ogd_a1krM6nppvqQ_fqn8Rn=ArPRwq7Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] trace_uprobe: Simplify probes_seq_show()
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, wangnan0 <wangnan0@huawei.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 8:34 PM, Ravi Bangoria
<ravi.bangoria@linux.vnet.ibm.com> wrote:
> Simplify probes_seq_show() function. We are using %lx to display
> the offset and we don't prepend unnecessary 0s in the offset.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  kernel/trace/trace_uprobe.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c2c965398893..c12a3957e1ee 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -602,24 +602,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
>         char c = is_ret_probe(tu) ? 'r' : 'p';
>         int i;
>
> -       seq_printf(m, "%c:%s/%s", c, tu->tp.call.class->system,
> -                       trace_event_name(&tu->tp.call));
> -       seq_printf(m, " %s:", tu->filename);
> -
> -       /* Don't print "0x  (null)" when offset is 0 */
> -       if (tu->offset) {
> -               seq_printf(m, "0x%lx", tu->offset);
> -       } else {
> -               switch (sizeof(void *)) {
> -               case 4:
> -                       seq_printf(m, "0x00000000");
> -                       break;
> -               case 8:
> -               default:
> -                       seq_printf(m, "0x0000000000000000");
> -                       break;
> -               }
> -       }
> +       seq_printf(m, "%c:%s/%s %s:0x%lx", c, tu->tp.call.class->system,
> +                       trace_event_name(&tu->tp.call), tu->filename,
> +                       tu->offset);

To keep the prepended zeros (and avoid the redundant 0x prefix):

"...%#0*lx...", ... sizeof(void *) * 2, tu->offset);

As in:

+       seq_printf(m, "%c:%s/%s %s:%#0*lx", c, tu->tp.call.class->system,
+                       trace_event_name(&tu->tp.call), tu->filename,
+                       sizeof(void *) * 2, tu->offset);

-Kees

>
>         for (i = 0; i < tu->tp.nr_args; i++)
>                 seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
> --
> 2.13.6
>



-- 
Kees Cook
Pixel Security
