Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeDBAww (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 20:52:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51312 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeDBAwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 20:52:50 -0400
X-Google-Smtp-Source: AIpwx48jW6kle/kLozriqWwRw1r//eVWNIwLAv524w0GuChBBOs/1SEV3/eVXb0LPYbhemQW9VErQE2usM29BtBPCXA=
MIME-Version: 1.0
In-Reply-To: <20180330174209.4cb77003@gandalf.local.home>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <20180330102038.2378925b@gandalf.local.home> <20180330205356.GA13332@bombadil.infradead.org>
 <20180330173031.257a491a@gandalf.local.home> <20180330174209.4cb77003@gandalf.local.home>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 2 Apr 2018 08:52:49 +0800
Message-ID: <CAGWkznE_ff0mf+=+5KjKXJmavw9pv2+1+d4_ktYpjsg4ugGOwA@mail.gmail.com>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 5:42 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 30 Mar 2018 17:30:31 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> I'll take a look at si_mem_available() that Joel suggested and see if
>> we can make that work.
>
> Wow, this appears to work great! Joel and Zhaoyang, can you test this?
>
> -- Steve
>
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index a2fd3893cc02..32a803626ee2 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1164,6 +1164,11 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
>         struct buffer_page *bpage, *tmp;
>         long i;
>
> +       /* Check if the available memory is there first */
> +       i = si_mem_available();
> +       if (i < nr_pages)
> +               return -ENOMEM;
> +
>         for (i = 0; i < nr_pages; i++) {
>                 struct page *page;
>                 /*
Hi Steve, It works as my previous patch does.
