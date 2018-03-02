Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946401AbeCBK7V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:59:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:60592 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426672AbeCBK7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:59:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="22023769"
Date: Fri, 2 Mar 2018 18:50:18 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Du, Changbin" <changbin.du@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/power: Polish the tracepoints cpu_idle and
 cpu_frequency
Message-ID: <20180302105018.sllck7elmime6h7i@intel.com>
References: <1519809638-24248-1-git-send-email-changbin.du@intel.com>
 <CAJZ5v0jqG0pcqOuvAVoP7sNKoOe+3ByMk4X5AZASp84OPcrgPg@mail.gmail.com>
 <20180301022719.xyfcu5tpmadjxbut@intel.com>
 <CAJZ5v0j8GsaK7kJ4hyvyQYOpa6QmoP2Pc69egg0hb=tb2EwpuA@mail.gmail.com>
 <20180302094140.ncypewkdg6g6rs2g@intel.com>
 <CAJZ5v0jcTfjBsyR1NN-JjAN86xPm0rA0qr4mnOpJwiv6PSdy6Q@mail.gmail.com>
 <20180302101514.uvuhl4ve7q3ptq3n@intel.com>
 <242e7e1f-c880-31fa-2db6-c03988a183b6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <242e7e1f-c880-31fa-2db6-c03988a183b6@intel.com>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 11:39:16AM +0100, Rafael J. Wysocki wrote:
> On 3/2/2018 11:15 AM, Du, Changbin wrote:
> > On Fri, Mar 02, 2018 at 11:18:10AM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Mar 2, 2018 at 10:41 AM, Du, Changbin <changbin.du@intel.com> wrote:
> > > > > > > That rather isn't the case if negative values are ever passed to the
> > > > > > > tracepoint, right?
> > > > > > > 
> > > > > > yes.
> > > > > > > Which seems to be the reason why you want to make this change, isn't it?
> > > > > > > 
> > > > > > yes, to improve readability.
> > > > > > 
> > > > > > > So maybe fix the code using the tracepoint(s) to avoid passing
> > > > > > > negative values to it(them)?
> > > > > > For cpu_idle event, [0, CPUIDLE_STATE_MAX) are used to index the idle state arrary,
> > > > > > so I think a appropriate value for PWR_EVENT_EXIT is -1 (defined in include/trace/events/power.h).
> > > > > > Or do you have a better idea? Thanks!
> > > > > Sorry, I'm not sure what you mean.
> > > > > 
> > > > > I'm saying that the code using the CPU PM tracepoints is not expected
> > > > > to pass -1 as the CPU number to them.  IOW, neither -1 nor its UL
> > > > > representation should ever appear in the output of these tracepoints.
> > > > > If that happens, it is a problem with the code using the tracepoints
> > > > > which needs to be fixed.  Users should not see any of these values.
> > > > This patch only changed 'state' field but cpuid. For cpu_idle event, 'state' is
> > > > singned value, but for cpu_frequency it is unsinged.
> > > > The cpuid is always unsinged value. So no one passes -1 as CPU number.
> > > You are right, 'state' not 'cpuid', sorry.
> > > 
> > > Negative 'state' should not be passed to these tracepoints too, though.
> > The current situtation is that 'state' can be negative for event cpu_idle :(. This
> > is why I made this change.
> > 
> And which is why I said that IMO it would be better to change the current
> situation.
> 
> Your patch makes the results of it slightly less confusing to a human reader
> of the tracepoint output, but the situation is still unchanged after it.
> 
> And what if someone has a script built around these tracepoints that knows
> how to handle the UL representation of -1, but doesn't know how to parse
> "-1"?  They would need to update the script after your change, wouldn't
> they?  And why would it be OK to inflict that work on them just to improve
> the readability of the output for humans?
>
yeah, I can guarantee all in kernel tools updated but people's private script.
For me, I just read the raw event for debug purpose. It is fair enough that leave
code as it was considering users' private tool based on this event.

> 
> 

-- 
Thanks,
Changbin Du
