Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeBKK6r (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:58:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:16511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752828AbeBKK6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:58:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,495,1511856000";
   d="scan'208";a="17270872"
Date: Sun, 11 Feb 2018 18:50:04 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/power: Don't share template for cpu_idle and
 cpu_frequency
Message-ID: <20180211105004.p55ajlt5kw36qwxi@intel.com>
References: <1518226624-8931-1-git-send-email-changbin.du@intel.com>
 <20180209214458.1ed36c3c@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209214458.1ed36c3c@vmware.local.home>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 09:44:58PM -0500, Steven Rostedt wrote:
> On Sat, 10 Feb 2018 09:37:04 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > The type of state is signed int, convert it to unsigned int looks weird.
> > (-1 become 4294967295)
> >    932.123 power:cpu_idle:state=1 cpu_id=0)
> >    932.125 power:cpu_idle:state=4294967295 cpu_id=0)
> >    932.132 power:cpu_idle:state=1 cpu_id=0)
> >    932.133 power:cpu_idle:state=4294967295 cpu_id=0)
> > 
> > Similarly for cpu_frequency as "state=%lu cpu_id=%lu". User need to read
> > the code to understand what 'state' means.
> > 
> > No functional change in this patch.
> 
> That's not true. You split a class into two TRACE_EVENTS. Each
> TRACE_EVENT adds approximately 5k of code and data. A DEFINE_EVENT()
> adds around 300 bytes. There's better ways to do this,
> 
> Please don't add this patch.
> 
> -- Steve

Steve, How abount DEFINE_EVENT_PRINT as below?

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 908977d..e71ce98 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -14,12 +14,12 @@

 DECLARE_EVENT_CLASS(cpu,

-       TP_PROTO(unsigned int state, unsigned int cpu_id),
+       TP_PROTO(int state, unsigned int cpu_id),

        TP_ARGS(state, cpu_id),

        TP_STRUCT__entry(
-               __field(        u32,            state           )
+               __field(        s32,            state           )
                __field(        u32,            cpu_id          )
        ),

@@ -28,13 +28,12 @@ DECLARE_EVENT_CLASS(cpu,
                __entry->cpu_id = cpu_id;
        ),

-       TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
-                 (unsigned long)__entry->cpu_id)
+       TP_printk("state=%d cpu_id=%u", __entry->state, __entry->cpu_id)
 );

 DEFINE_EVENT(cpu, cpu_idle,

-       TP_PROTO(unsigned int state, unsigned int cpu_id),
+       TP_PROTO(int state, unsigned int cpu_id),

        TP_ARGS(state, cpu_id)
 );
@@ -141,11 +140,13 @@ TRACE_EVENT(pstate_sample,
                { PM_EVENT_RESTORE, "restore" }, \
                { PM_EVENT_RECOVER, "recover" })

-DEFINE_EVENT(cpu, cpu_frequency,
+DEFINE_EVENT_PRINT(cpu, cpu_frequency,

-       TP_PROTO(unsigned int frequency, unsigned int cpu_id),
+       TP_PROTO(int state, unsigned int cpu_id),

-       TP_ARGS(frequency, cpu_id)
+       TP_ARGS(state, cpu_id),
+
+       TP_printk("frequency=%u cpu_id=%lu", __entry->state, __entry->cpu_id)
 );
