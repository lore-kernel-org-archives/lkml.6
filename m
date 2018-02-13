Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbeBMA3H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:29:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:12065 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932769AbeBMA3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:29:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="30256618"
Date: Tue, 13 Feb 2018 08:20:24 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Du, Changbin" <changbin.du@intel.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/power: Don't share template for cpu_idle and
 cpu_frequency
Message-ID: <20180213002024.vweatugblamznigc@intel.com>
References: <1518226624-8931-1-git-send-email-changbin.du@intel.com>
 <20180209214458.1ed36c3c@vmware.local.home>
 <20180211105004.p55ajlt5kw36qwxi@intel.com>
 <20180212120452.50abd9bf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212120452.50abd9bf@gandalf.local.home>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I will improve this change in v2. And also update related docs.

On Mon, Feb 12, 2018 at 12:04:52PM -0500, Steven Rostedt wrote:
> On Sun, 11 Feb 2018 18:50:04 +0800
> "Du, Changbin" <changbin.du@intel.com> wrote:
> 
> > Steve, How abount DEFINE_EVENT_PRINT as below?
> 
> Yes, DEFINE_EVENT_PRINT is better.
> 
> > 
> > diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> > index 908977d..e71ce98 100644
> > --- a/include/trace/events/power.h
> > +++ b/include/trace/events/power.h
> > @@ -14,12 +14,12 @@
> > 
> >  DECLARE_EVENT_CLASS(cpu,
> > 
> > -       TP_PROTO(unsigned int state, unsigned int cpu_id),
> > +       TP_PROTO(int state, unsigned int cpu_id),
> > 
> >         TP_ARGS(state, cpu_id),
> > 
> >         TP_STRUCT__entry(
> > -               __field(        u32,            state           )
> > +               __field(        s32,            state           )
> >                 __field(        u32,            cpu_id          )
> >         ),
> > 
> > @@ -28,13 +28,12 @@ DECLARE_EVENT_CLASS(cpu,
> >                 __entry->cpu_id = cpu_id;
> >         ),
> > 
> > -       TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
> > -                 (unsigned long)__entry->cpu_id)
> 
> Yous still need the type casting, because s32/u32 on 32 bit machines
> can be defined as "long".
> 
> -- Steve
> 
> > +       TP_printk("state=%d cpu_id=%u", __entry->state, __entry->cpu_id)
> >  );
> > 
> >  DEFINE_EVENT(cpu, cpu_idle,
> > 
> > -       TP_PROTO(unsigned int state, unsigned int cpu_id),
> > +       TP_PROTO(int state, unsigned int cpu_id),
> > 
> >         TP_ARGS(state, cpu_id)
> >  );
> > @@ -141,11 +140,13 @@ TRACE_EVENT(pstate_sample,
> >                 { PM_EVENT_RESTORE, "restore" }, \
> >                 { PM_EVENT_RECOVER, "recover" })
> > 
> > -DEFINE_EVENT(cpu, cpu_frequency,
> > +DEFINE_EVENT_PRINT(cpu, cpu_frequency,
> > 
> > -       TP_PROTO(unsigned int frequency, unsigned int cpu_id),
> > +       TP_PROTO(int state, unsigned int cpu_id),
> > 
> > -       TP_ARGS(frequency, cpu_id)
> > +       TP_ARGS(state, cpu_id),
> > +
> > +       TP_printk("frequency=%u cpu_id=%lu", __entry->state, __entry->cpu_id)
> >  );
> 

-- 
Thanks,
Changbin Du
