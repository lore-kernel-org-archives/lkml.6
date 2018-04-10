Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeDJIif (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:38:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55628 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbeDJIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:38:33 -0400
X-Google-Smtp-Source: AIpwx4+shd9NSaBZ0jpm520wS8BJpPZQeaWbhnor3v3Ua/LUVe3EicgOP1j9zAMAUv5dTs8ZQQKlYoc5iS8yIIsXJAU=
MIME-Version: 1.0
In-Reply-To: <20180410081231.GV21835@dhcp22.suse.cz>
References: <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
 <20180409094944.6399b211@gandalf.local.home> <CAGWkznEhy7Fard=6E3X_qUezXd33RdKV9CVeONWL=6EQ1bokEw@mail.gmail.com>
 <CAGWkznEuGCZq600XjCtp3hzgN2LrCgwSAfoLwQR7jTw5p=qHoQ@mail.gmail.com>
 <20180409231230.1ab99e85@vmware.local.home> <CAGWkznG8-zmfE5iqPUVP+sztasa1zLPWE28qBiZ_tq524JznPw@mail.gmail.com>
 <20180410061447.GQ21835@dhcp22.suse.cz> <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
 <20180410074921.GU21835@dhcp22.suse.cz> <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
 <20180410081231.GV21835@dhcp22.suse.cz>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 10 Apr 2018 16:38:32 +0800
Message-ID: <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal OOM_SCORE_ADJ_MIN
To: Michal Hocko <mhocko@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 4:12 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Tue 10-04-18 16:04:40, Zhaoyang Huang wrote:
>> On Tue, Apr 10, 2018 at 3:49 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Tue 10-04-18 14:39:35, Zhaoyang Huang wrote:
>> >> On Tue, Apr 10, 2018 at 2:14 PM, Michal Hocko <mhocko@kernel.org> wrote:
> [...]
>> >> > OOM_SCORE_ADJ_MIN means "hide the process from the OOM killer completely".
>> >> > So what exactly do you want to achieve here? Because from the above it
>> >> > sounds like opposite things. /me confused...
>> >> >
>> >> Steve's patch intend to have the process be OOM's victim when it
>> >> over-allocating pages for ring buffer. I amend a patch over to protect
>> >> process with OOM_SCORE_ADJ_MIN from doing so. Because it will make
>> >> such process to be selected by current OOM's way of
>> >> selecting.(consider OOM_FLAG_ORIGIN first before the adj)
>> >
>> > I just wouldn't really care unless there is an existing and reasonable
>> > usecase for an application which updates the ring buffer size _and_ it
>> > is OOM disabled at the same time.
>> There is indeed such kind of test case on my android system, which is
>> known as CTS and Monkey etc.
>
> Does the test simulate a real workload? I mean we have two things here
>
> oom disabled task and an updater of the ftrace ring buffer to a
> potentially large size. The second can be completely isolated to a
> different context, no? So why do they run in the single user process
> context?
ok. I think there are some misunderstandings here. Let me try to
explain more by my poor English. There is just one thing here. The
updater is originally a oom disabled task with adj=OOM_SCORE_ADJ_MIN.
With Steven's patch, it will periodically become a oom killable task
by calling set_current_oom_origin() for user process which is
enlarging the ring buffer. What I am doing here is limit the user
process to the ones that adj > -1000.

>
>> Furthermore, I think we should make the
>> patch to be as safest as possible. Why do we leave a potential risk
>> here? There is no side effect for my patch.
>
> I do not have the full context. Could you point me to your patch?

here are Steven and my patches
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5f38398..1005d73 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1135,7 +1135,7 @@ static int rb_check_pages(struct
ring_buffer_per_cpu *cpu_buffer)
 static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 {
        struct buffer_page *bpage, *tmp;
-       bool user_thread = current->mm != NULL;
+       bool user_thread = (current->mm != NULL &&
current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN);    //by zhaoyang
        gfp_t mflags;
        long i;
-----------------------------------------------------------------------------------------------------
  {

  struct buffer_page *bpage, *tmp;
+ bool user_thread = current->mm != NULL;
+ gfp_t mflags;
  long i;

- /* Check if the available memory is there first */
+ /*
+ * Check if the available memory is there first.
+ * Note, si_mem_available() only gives us a rough estimate of available
+ * memory. It may not be accurate. But we don't care, we just want
+ * to prevent doing any allocation when it is obvious that it is
+ * not going to succeed.
+ */
  i = si_mem_available();
  if (i < nr_pages)
  return -ENOMEM;

+ /*
+ * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
+ * gracefully without invoking oom-killer and the system is not
+ * destabilized.
+ */
+ mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
+
+ /*
+ * If a user thread allocates too much, and si_mem_available()
+ * reports there's enough memory, even though there is not.
+ * Make sure the OOM killer kills this thread. This can happen
+ * even with RETRY_MAYFAIL because another task may be doing
+ * an allocation after this task has taken all memory.
+ * This is the task the OOM killer needs to take out during this
+ * loop, even if it was triggered by an allocation somewhere else.
+ */
+ if (user_thread)
+ set_current_oom_origin();
  for (i = 0; i < nr_pages; i++) {
  struct page *page;
- /*
- * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
- * gracefully without invoking oom-killer and the system is not
- * destabilized.
- */
+
  bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
-    GFP_KERNEL | __GFP_RETRY_MAYFAIL,
-    cpu_to_node(cpu));
+    mflags, cpu_to_node(cpu));
  if (!bpage)
  goto free_pages;

  list_add(&bpage->list, pages);

- page = alloc_pages_node(cpu_to_node(cpu),
- GFP_KERNEL | __GFP_RETRY_MAYFAIL, 0);
+ page = alloc_pages_node(cpu_to_node(cpu), mflags, 0);
  if (!page)
  goto free_pages;
  bpage->page = page_address(page);
  rb_init_page(bpage->page);
+
+ if (user_thread && fatal_signal_pending(current))
+ goto free_pages;
  }
+ if (user_thread)
+ clear_current_oom_origin();

  return 0;

@@ -1199,6 +1225,8 @@  static int __rb_allocate_pages(long nr_pages,
struct list_head *pages, int cpu)
  list_del_init(&bpage->list);
  free_buffer_page(bpage);
  }
+ if (user_thread)
+ clear_current_oom_origin();

  return -ENOMEM;
 }


> --
> Michal Hocko
> SUSE Labs
